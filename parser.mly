%{
open Ast
%}

%token A B C EOF
%start<expression> input

%%

input : x= expression EOF {x}

expression :
y= abstring C z = abstring {Expr(y,"c",z)}

abstring :
t=A s = abstring {Concat(Var("a"),s)}
|t=B s= abstring {Concat(Var("b"),s)}
|s=A {Var("a")}
|s=B {Var("a")}