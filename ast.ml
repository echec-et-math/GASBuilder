type abstring =
  |Var of 'a'
  |Var of 'b'
  |Concat of abstring*abstring

type expression = Expr of abstring * string * abstring