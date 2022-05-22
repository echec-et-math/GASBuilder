%{
open Ast
%}

%token A B C EOF
%start<string> input

%%

input : x=expression EOF {x}

expression :
A x=expression A {"a" ^ x ^ "a"}
| B x=expression B {"b" ^ x ^ "b"}
| C {"c"}