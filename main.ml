open Ast

let lexbuf = Lexing.from_channel stdin

let run_automaton automaton =
  try
    let word_pipe = open_in "word_pipe" in
    let word = input_line word_pipe in
    print_endline (if word = "&" then "Testing empty word." else "Testing word : " ^ word);
    let stream = if word = "&" then [] else List.init (String.length word) (String.get word) in
    automaton stream;
    print_endline "Word accepted !"
  with e -> match e with
    | NonEmptyStream -> print_endline "Word non accepted : Stack emptied before full consumation of input stream."
    | NonEmptyStack -> print_endline "Word non accepted : Stack non empty upon full consumation of input stream and no epsilon-transition available."
    | UndeterministicConflict(trans1,trans2) -> let s1 = (match trans1 with
      |(a,b,c,d,e) -> "Automaton is not deterministic : on state "^(string_of_int a)^" with stacksymbol "^(String.make 1 c)^" both switches to state "^(string_of_int d)^" reading "^(String.make 1 b)) in
      let s2 = match trans2 with
      |(f,g,h,i,j) -> " and state "^(string_of_int i)^" reading "^(String.make 1 g)^" are allowed." in print_endline (s1^s2)
    | WrongInitialState(s) -> print_endline ((string_of_int s)^" is not part of the states list.")
    | WrongInitialStack(s) -> print_endline ((String.make 1 s)^"is not part of the stack symbols list.")
    | NoSuchTransition(cur_state, read_symbol, cur_stack_top) ->
        print_endline ("Word non accepted : could not find a transition from state " ^ (string_of_int cur_state) ^ "reading character " ^ (Char.escaped read_symbol) ^ " with stack symbol " ^ (Char.escaped cur_stack_top) ^ " on top of the stack.")
    | _ -> raise e;;

let notify_user =
  try 
    let automaton = Parser.automaton Lexer.main lexbuf in
    run_automaton automaton
  with e ->
    let msg = Printexc.to_string e
    and stack = Printexc.get_backtrace () in
      Printf.eprintf "there was an error: %s%s\\n" msg stack;
      raise e
;;
