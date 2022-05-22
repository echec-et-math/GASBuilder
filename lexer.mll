{
    open Parser
}

let layout = [ ' ' '\t' '\n' ]

rule main = parse
  | layout		{ main lexbuf }
  |'a' {A}
  |'b' {B}
  |'c' {C}
  | eof {EOF}
  |_ {failwith "unexpected character"} 