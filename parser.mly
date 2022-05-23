%{
open Ast
%}

%token INPUT_SYMBOLS_HEADER STACK_SYMBOLS_HEADER STATES_HEADER INIT_STATE_HEADER INIT_STACK_HEADER TRANSITIONS_HEADER LPARA RPARA COMMA SEMICOLON LETTRE EOF COLON
%start<string> automate

%%

automate:
    declarations transitions EOF {"rien"}

declarations:
    inputsymbols stacksymbols states initialstate initialstack {}

inputsymbols:
    INPUT_SYMBOLS_HEADER COLON suitelettres_nonvide {}

stacksymbols:
    STACK_SYMBOLS_HEADER COLON suitelettres_nonvide {}

states:
    STATES_HEADER COLON suitelettres_nonvide {}

initialstate:
    INIT_STATE_HEADER COLON LETTRE {}

initialstack:
    INIT_STACK_HEADER COLON LETTRE {}

suitelettres_nonvide:
    LETTRE {}
    | LETTRE COMMA suitelettres_nonvide {}

transitions: 
    TRANSITIONS_HEADER COLON translist {}

translist:
     {}
    | transition translist {}

transition:
    LPARA LETTRE COMMA lettre_ou_vide COMMA LETTRE COMMA LETTRE COMMA stack RPARA {}

lettre_ou_vide:
     {}
    | LETTRE {}

stack:
      {}
    | nonemptystack {}

nonemptystack:
    LETTRE {}
    | LETTRE SEMICOLON nonemptystack {}