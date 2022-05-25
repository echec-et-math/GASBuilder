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
