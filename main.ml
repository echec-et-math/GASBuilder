let lexbuf = Lexing.from_channel stdin 

(*let ast = Parser.automate Lexer.main lexbuf*)

(*let _ = Printf.printf "Parse:\n%s\n" (Ast.as_string ast)*)

let notify_user =
  try 
   Parser.automate Lexer.main lexbuf 
  with e ->
    let msg = Printexc.to_string e
    and stack = Printexc.get_backtrace () in
      Printf.eprintf "there was an error: %s%s\\n" msg stack;
      raise e
;;
