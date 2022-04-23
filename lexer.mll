{
    open Parser
}

rule main = parse
  |'a' {A}
  |'b' {B}
  |'c' {C}
  | eof {EOF}
  |_ {failwith "unexpected charcater"} 