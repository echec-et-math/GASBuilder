%{
open Ast
%}

%token INPUT_SYMBOLS_HEADER STACK_SYMBOLS_HEADER STATES_HEADER INIT_STATE_HEADER INIT_STACK_HEADER TRANSITIONS_HEADER LPARA RPARA COMMA SEMICOLON EPSILON LETTRE EOF
%start<string> automate

%%

automate:
    declarations transitions  EOF {"rien"}

declarations:
    inputsymbols stacksymbols states initialstate initialstack {}

inputsymbols:
    INPUT_SYMBOLS_HEADER suitelettres_nonvide {}

stacksymbols:
    STACK_SYMBOLS_HEADER suitelettres_nonvide {}

states:
    STATES_HEADER suitelettres_nonvide {}

initialstate:
    INIT_STATE_HEADER LETTRE {}

initialstack:
    INIT_STACK_HEADER LETTRE {}

suitelettres_nonvide:
    LETTRE {}
    | LETTRE COMMA suitelettres_nonvide {}

transitions: 
    TRANSITIONS_HEADER translist {}

translist:
    EPSILON {}
    | transition translist {}

transition:
    LPARA LETTRE COMMA lettre_ou_vide COMMA LETTRE COMMA LETTRE COMMA stack RPARA {}

lettre_ou_vide:
    EPSILON {}
    | LETTRE {}

stack:
    EPSILON {}
    | nonemptystack {}

nonemptystack:
    LETTRE {}
    | LETTRE SEMICOLON nonemptystack {}