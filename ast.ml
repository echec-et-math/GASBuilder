type abstring =
  |Var of string
  |Concat of abstring*abstring

type expression = Expr of abstring * string * abstring