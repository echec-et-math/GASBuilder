{
    open Parser
}

let layout = [ ' ' '\t' '\n' ]

let lettre = [0-9a-zA-Z]

rule main = parse
  | layout		{ main lexbuf }
  | lettre+ {SUITELETTRES_NONVIDE}
  | "input symbols: " {INPUTSYMBOLS}
  | "stack symbols: " {STACKSYMBOLS}
  | "states: " {STATES}
  | "initial state: " {INITIALSTATE}
  | "initial stack symbol: " {INITIALSTACK}
  | "transitions: " {TRANSITIONS}
  | '('lettre {TRANSITION}
  | eof {EOF}
  |_ {failwith "unexpected character"} 