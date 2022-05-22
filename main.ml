let lexbuf = Lexing.from_channel stdin 

let ast = Parser.automate Lexer.main lexbuf 

(*let _ = Printf.printf "Parse:\n%s\n" (Ast.as_string ast)*)