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

let check_conflict declarations transitions = ();; (* TODO *)

let build_automaton (declarations:declarations) (transitions:transitions) =
  let (inputsymbols, stacksymbols, states, initstate, initstack) = declarations in
  let apply_tr cur_state read_symbol cur_stack_top =
    let rec aux_apply tr_list = match tr_list with (* TODO : allow epsilon_transitions with '' as the character read *)
      | [] -> raise (NoSuchTransition(cur_state, read_symbol, cur_stack_top))
      | t::q -> match t with
        | (a, b, c, d, e) when a = cur_state && b = read_symbol && c = cur_stack_top -> (d, (List.rev e))
        (* Reversing the stack because in the file, it's written from tail to head *)
        | _ -> aux_apply q in
    aux_apply transitions in
  let rec aux_builder state stack stream = match (stream, stack) with
    | [], [] -> ()
    | t::q, [] -> raise (NonEmptyStream)
    | [], t::q -> raise (NonEmptyStack)
    | r::s, t::q -> let (new_state, new_stack_top) = (apply_tr state r t) in aux_builder new_state (new_stack_top@q) s in
  aux_builder initstate [initstack];;

let run_automaton automaton =
  print_string "Enter a word : ";
  let word = read_line () in (* WE NEED A BLOCKING READ HERE *)
  let stream = List.init (String.length word) (String.get word) in
  try
    automaton stream
  with e -> match e with
    | NonEmptyStream -> print_endline "Word non accepted : Stack emptied before full consumation of input stream."
    | NonEmptyStack -> print_endline "Word non accepted : Stack non empty upon full consumation of input stream."
    | NoSuchTransition(cur_state, read_symbol, cur_stack_top) ->
        print_endline ("Word non accepted : could not find a transition from state " ^ (string_of_int cur_state) ^ "reading character " ^ (Char.escaped read_symbol) ^ " with stack symbol " ^ (Char.escaped cur_stack_top) ^ " on top of the stack.")
    | _ -> raise e;;