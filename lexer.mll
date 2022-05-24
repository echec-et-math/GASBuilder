{
    open Parser
}

let layout = [ ' ' '\t' '\n' ]

let digit = ['0'-'9']

let lc_letter = ['a'-'z']

let uc_letter = ['A'-'Z']

rule main = parse
  | layout		{ main lexbuf }
  | digit {DIGIT (int_of_string (Lexing.lexeme lexbuf))}
  | uc_letter {UC_LETTER (Lexing.lexeme lexbuf).[0]} (* Getting the first character of the string *)
  | lc_letter {LC_LETTER (Lexing.lexeme lexbuf).[0]} (* It is length one so it's just a str -> char conversion *)
  | "input symbols" {INPUT_SYMBOLS_HEADER}
  | "stack symbols" {STACK_SYMBOLS_HEADER}
  | "states" {STATES_HEADER}
  | "initial state" {INIT_STATE_HEADER}
  | "initial stack" {INIT_STACK_HEADER}
  | "transitions" {TRANSITIONS_HEADER}
  | ':' {COLON}
  | ',' {COMMA}
  | ';' {SEMICOLON}
  | '(' {LPARA}
  | ')' {RPARA}
  | eof {EOF}
  |_ {failwith "unexpected character"} 