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

exception NoSuchStateTransition of state

exception NoSuchStreamTransition of inputsymbol

exception NoSuchStackTransition of stacksymbol

exception WordRejection

type op = Pop | Push of char | Reject | Change of int | Block of case_block

and state_case = (int * op) list

and stream_case = (char * op) list

and stack_case = (char * op) list

and case_block = StateSwitch of state_case | StreamSwitch of stream_case | StackSwitch of stack_case

let validite declarations = 
  try
    match declarations with
      (a,b,c,d,e) -> if (List.mem d c) then (if (List.mem e b) then () else raise (WrongInitialStack(e))) else raise (WrongInitialState(d))
  with e -> match e with
    | WrongInitialState(s) -> print_endline ("Error : initial state " ^ (string_of_int s)^" is not part of the state list.")
    | WrongInitialStack(s) -> print_endline ("Error : initial stack symbol " ^ (String.make 1 s)^" is not part of the stack symbols list.")
    | _ -> raise e;;

let rec check_conflict transitions =
  try
    match transitions with
      | [] -> ()
      | t::q -> (match q with 
          |[] -> ()
          |r::s -> (match t with 
            |(a,b,c,d,e) -> (match r with
              |(f,g,h,i,j) -> if a==f && c==h && (b==g || b=='&' || g=='&') then raise (UndeterministicConflict(t,r)) else check_conflict (t::s) ; check_conflict q)))
  with e -> match e with
    | UndeterministicConflict(trans1,trans2) -> let s1 = (match trans1 with
      |(a,b,c,d,e) -> "Automaton is not deterministic : on state "^(string_of_int a)^" with stacksymbol "^(String.make 1 c)^" both switches to state "^(string_of_int d)^" reading "^(String.make 1 b)) in
      let s2 = match trans2 with
        |(f,g,h,i,j) -> " and state "^(string_of_int i)^" reading "^(String.make 1 g)^" are allowed." in print_endline (s1^s2)
    | _ -> raise e;;

exception StateCaseRedundancy of state

exception StreamCaseRedundancy of inputsymbol

exception StackCaseRedundancy of stacksymbol

let rec check_program p =
  let rec state_check l = match l with
  | [] -> ()
  | (n1, op1)::q -> match q with
    | [] -> ()
    | (n2, op2)::s -> if n1=n2 then raise (StateCaseRedundancy n1) else state_check ((n1, op1)::s); state_check q
  and stream_check l = match l with
  | [] -> ()
  | (ch1, op1)::q -> match q with
    | [] -> ()
    | (ch2, op2)::s -> if ch1=ch2 then raise (StreamCaseRedundancy ch1) else stream_check ((ch1, op1)::s); stream_check q
  and stack_check l = match l with
  | [] -> ()
  | (symb1, op1)::q -> match q with
    | [] -> ()
    | (symb2, op2)::s -> if symb1=symb2 then raise (StackCaseRedundancy symb1) else stack_check ((symb1, op1)::s); stack_check q
  and op_check op = match op with
    | Block(b) -> check_program b
    | _ -> ()
  and block_list_check l = match l with
    | [] -> ()
    | (_, op)::q -> op_check op; block_list_check q in
  try
    match p with
      | StateSwitch(l) -> state_check l ; block_list_check l
      | StreamSwitch(l) -> stream_check l ; block_list_check l
      | StackSwitch(l) -> stack_check l ; block_list_check l
  with e -> match e with
    | StateCaseRedundancy n -> print_endline ("Error : found multiple cases under same switch statement for the state number " ^ (string_of_int n))
    | StreamCaseRedundancy ch -> print_endline ("Error : found multiple cases under same switch statement for the input symbol " ^ (Char.escaped ch))
    | StackCaseRedundancy symb -> print_endline ("Error : found multiple cases under same switch statement for the stack symbol " ^ (Char.escaped symb))
    | _ -> raise e;;

let rec stack_to_string stack = match stack with
  | [] -> ""
  | t::q -> (Char.escaped t) ^ (stack_to_string q);;

let build_automaton declarations transitions =
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

let build_program declarations p = 
  let (_, _, _, initstate, initstack) = declarations in
  let rec state_matcher state_number l = match l with
    | [] -> raise (NoSuchStateTransition state_number)
    | (n, op)::q -> if n=state_number then op else state_matcher state_number q
  and stream_matcher character l = match l with
    | [] -> raise (NoSuchStreamTransition character)
    | (ch, op)::q -> if ch=character then op else stream_matcher character q
  and stack_matcher stacksymb l = match l with
    | [] -> raise (NoSuchStackTransition stacksymb)
    | (symb, op)::q -> if symb=stacksymb then op else stack_matcher stacksymb q in
  let rec exec_prog prog cur_state stack stream =
    match (stream, stack) with
      | ([], []) -> ()
      | _ -> let get_op_aux = match prog with
              | StateSwitch(l) -> print_endline ("Testing state : current state is " ^ (string_of_int cur_state));stream, stack, (state_matcher cur_state l)
              | StreamSwitch(l) -> (match stream with 
                | [] -> raise NonEmptyStack
                | t::q -> print_endline ("Reading stream : read character is " ^ (Char.escaped t)); q, stack, (stream_matcher t l))
              | StackSwitch(l) -> match stack with 
              | [] -> raise NonEmptyStream
              | t::q -> print_endline ("Reading stack : stack top is " ^ (Char.escaped t)); stream, q, (stack_matcher t l) in
              let cur_stream, cur_stack, op = get_op_aux in
              match op with
                | Block(b) -> print_endline "Entering inner block" ; exec_prog b cur_state cur_stack cur_stream
                | Pop -> print_endline "Popping the stack" ; exec_prog p cur_state cur_stack cur_stream
                | Push(symb) -> print_endline ("Pushing " ^ (Char.escaped symb) ^ " on the stack") ; exec_prog p cur_state (symb::cur_stack) cur_stream
                | Reject -> raise WordRejection
                | Change(state_number) -> print_endline ("Changing state to " ^ (string_of_int state_number)) ; exec_prog p state_number cur_stack cur_stream in
  exec_prog p initstate [initstack];;