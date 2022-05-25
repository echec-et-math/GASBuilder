type automaton = ((char list) -> unit)

type inputsymbol = char

type inputsymbols = char list

type stacksymbol = char

type stacksymbols = char list

type state = int

type states = int list

type initstate = int

type initstack = char

type declarations = inputsymbols * stacksymbols * states * initstate * initstack

type transition = state * inputsymbol * stacksymbol * state * stacksymbols

type transitions = transition list

exception NonEmptyStream

exception NonEmptyStack

exception NoSuchState of state

exception NoSuchInputSymbol of inputsymbol

exception NoSuchStackSymbol of stacksymbol

exception NoSuchTransition of (state * inputsymbol * stacksymbol)

exception UndeterministicConflict of transition * transition

exception WrongInitialState of initstate

exception WrongInitialStack of initstack

let validite declarations = match declarations with
  |(a,b,c,d,e) -> if (List.mem d c) then (if (List.mem e b) then () else raise (WrongInitialStack(e))) else raise (WrongInitialState(d));; 

let rec check_conflict transitions = match transitions with
  | [] -> ()
  | t::q -> (match q with 
      |[] -> ()
      |r::s -> (match t with 
        |(a,b,c,d,e) -> (match r with
          |(f,g,h,i,j) -> if a==f && c==h && (b==g || b=='&' || g=='&') then raise (UndeterministicConflict(t,r)) else check_conflict (t::s) ; check_conflict q)))
;;

let rec stack_to_string stack = match stack with
  | [] -> ""
  | t::q -> (Char.escaped t) ^ (stack_to_string q);;

let build_automaton (declarations:declarations) (transitions:transitions) =
  let (inputsymbols, stacksymbols, states, initstate, initstack) = declarations in
  let apply_tr cur_state read_symbol cur_stack_top =
    let rec aux_apply tr_list = match tr_list with
      | [] -> 
        if read_symbol = '&' (* Check for epsilon *)
        then (0, []) (* Zero state and empty stack top is our code for non-existing epsilon-transition and is not an error. *)
        else raise (NoSuchTransition(cur_state, read_symbol, cur_stack_top)) (* Non-existing regular transition is still an error, though. *)
      | t::q -> match t with
        | (a, b, c, d, e) when a = cur_state && b = read_symbol && c = cur_stack_top ->
          print_endline ("CURRENT STATE : " ^ (string_of_int cur_state) ^ " READING " ^ (Char.escaped read_symbol) ^ " FROM STREAM AND " ^ (Char.escaped cur_stack_top) ^ " FROM STACK");
          print_endline ("SWITCHING TO STATE " ^ (string_of_int d) ^ " AND " ^ (match e with
            | [] -> "CONSUMING THE STACK"
            | [t] -> if t=cur_stack_top then "KEEPING STACK TOP SYMBOL " else "CHANGING STACK TOP SYMBOL TO " ^ (Char.escaped t)
            | _ -> "OVERWRITING " ^ (stack_to_string (List.rev e)) ^ " ON STACK"));
          (d, (List.rev e))
        (* Reversing the stack because in the file, it's written from tail to head *)
        | _ -> aux_apply q in
    aux_apply transitions in
  let rec aux_builder state stack stream = match (stream, stack) with
    | [], [] -> ()
    | t::q, [] -> raise (NonEmptyStream)
    | [], t::q -> (let (new_state, new_stack_top) = match (apply_tr state '&' t) with (* If the input stream is empty, only an epsilon transition can save us *)
      | (0, []) -> raise (NonEmptyStack) (* No epsilon-transition found *)
      | n_s, n_s_t -> n_s, n_s_t (* If a match is found, just keep it *) in
    aux_builder new_state (new_stack_top@q) [])
    | r::s, t::q -> let (new_state, new_stack_top) = match (apply_tr state '&' t) with (* Always try an epsilon transition first, you never know *) 
      (* Note : this means that epsilon-transitions are always prioritary, no matter what.
      Thus, checking if the automaton is deterministic is a must, since it could lead to terrible assumptions. *)
    | (0, []) -> (apply_tr state r t) (* It didn't work, try again with the actual character *)
      | n_s, n_s_t -> n_s, n_s_t (* If a match is found, just keep it *) in
    aux_builder new_state (new_stack_top@q) s in
  aux_builder initstate [initstack];;