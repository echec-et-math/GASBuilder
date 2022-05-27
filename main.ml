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
    | NonEmptyStream -> print_endline "Word non accepted : Stack emptied before full consumation of input stream."; exit 0
    | NonEmptyStack -> print_endline "Word non accepted : Stack non empty upon full consumation of input stream and no epsilon-transition available."; exit 0
    | NoSuchTransition(cur_state, read_symbol, cur_stack_top) ->
        print_endline ("Word non accepted : could not find a transition from state " ^ (string_of_int cur_state) ^ " reading character " ^ (Char.escaped read_symbol) ^ " with stack symbol " ^ (Char.escaped cur_stack_top) ^ " on top of the stack."); exit 0
    | NoSuchStateTransition(n) -> print_endline "Word non accepted : couldn't find a case for the current state."; exit 0
    | NoSuchStreamTransition(ch) -> print_endline "Word non accepted : couldn't find a case for the character read."; exit 0
    | NoSuchStackTransition(symb) -> print_endline "Word non accepted : couldn't find a case for the current stack top."; exit 0
    | WordRejection -> print_endline "Word non accepted : the automaton just rejected the word."; exit 0
    | _ -> raise e;;

let notify_user =
  try 
    let automaton = Parser.automaton Lexer.main lexbuf in
    run_automaton automaton
  with e ->
      print_endline "Unable to correctly parse your file. Please check the syntax."; exit 0
;;
