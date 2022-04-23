%{
open Ast
%}

%token A B C EOF
%start<expression> input

%%

input : x= expression EOF {x}

expression :
y= abstring C z = abstring {Expr(y,'c',z)}

abstring :
A s = abstring {Concat('a',s)}
|B s= abstring {Concat('b',s)}
|s=A {Var(s)}
|s=B {Var(s)}