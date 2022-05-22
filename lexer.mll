{
    open Parser
}

let layout = [ ' ' '\t' '\n' ]

let lettre = ['0'-'9' 'a'-'z' 'A'-'Z']

rule main = parse
  | layout		{ main lexbuf }
  | lettre {LETTRE}
  | "input symbols : " {INPUT_SYMBOLS_HEADER}
  | "stack symbols : " {STACK_SYMBOLS_HEADER}
  | "states : " {STATES_HEADER}
  | "initial state : " {INIT_STATE_HEADER}
  | "initial stack symbol : " {INIT_STACK_HEADER}
  | "transitions : " {TRANSITIONS_HEADER}
  | ',' {COMMA}
  | ';' {SEMICOLON}
  | '(' {LPARA}
  | ')' {RPARA}
  | eof {EOF}
  | "" {EPSILON}
  |_ {failwith "unexpected character"} 