%{
open Ast
%}

%token INPUT_SYMBOLS_HEADER STACK_SYMBOLS_HEADER STATES_HEADER INIT_STATE_HEADER INIT_STACK_HEADER TRANSITIONS_HEADER PROGRAM_HEADER
%token CASE STATE NEXT TOP BEGIN END OF POP REJECT CHANGE PUSH
%token LPARA RPARA COMMA SEMICOLON EOF COLON
%token<int> DIGIT
%token<char> UC_LETTER LC_LETTER

%start<Ast.automaton> automaton (* Unit type if the automaton is run *)

%%

automaton:
    decl=declarations tr_list=transitions EOF {validite decl; check_conflict tr_list; build_automaton decl tr_list} (* We need to run it now *)
    | decl=declarations p=program EOF {validite decl; check_program p; build_program decl p}

declarations:
    a=inputsymbols b=stacksymbols c=states d=initialstate e=initialstack {(a, b, c, d, e)}

inputsymbols:
    INPUT_SYMBOLS_HEADER COLON input_symbs=suite_min_nonvide {input_symbs}

stacksymbols:
    STACK_SYMBOLS_HEADER COLON stack_symbs=suite_maj_nonvide {stack_symbs}

states:
    STATES_HEADER COLON state_symbs=suite_chiffres_nonvide {state_symbs}

initialstate:
    INIT_STATE_HEADER COLON x=DIGIT {x}

initialstack:
    INIT_STACK_HEADER COLON x=UC_LETTER {x}

suite_min_nonvide:
    x=LC_LETTER {[x]}
    | x=LC_LETTER COMMA y=suite_min_nonvide {x::y}

suite_maj_nonvide:
    x=UC_LETTER {[x]}
    | x=UC_LETTER COMMA y=suite_maj_nonvide {x::y}

suite_chiffres_nonvide:
    x=DIGIT {[x]}
    | x=DIGIT COMMA y=suite_chiffres_nonvide {x::y}

transitions: 
    TRANSITIONS_HEADER COLON t=translist {t}

translist:
     {[]}
    | t=transition q=translist {t::q}

transition:
    LPARA a=DIGIT COMMA b=minuscule_ou_vide COMMA c=UC_LETTER COMMA d=DIGIT COMMA e=stack RPARA {(a, b, c, d, e)}

minuscule_ou_vide:
     {'&'} (* This will be our representation for epsilon *)
    | x=LC_LETTER {x}

stack:
      {[]}
    | s=nonemptystack {s}

nonemptystack:
    x=UC_LETTER {[x]}
    | x=UC_LETTER SEMICOLON y=nonemptystack {x::y}

program:
    PROGRAM_HEADER COLON c=case_block {c}

case_block:
    CASE STATE OF x=state_cases {StateSwitch(x)}
    | CASE NEXT OF x=stream_cases {StreamSwitch(x)}
    | CASE TOP OF x=stack_cases {StackSwitch(x)}

state_cases:
    {[]}
    | x=DIGIT COLON t=op q=state_cases {(x, t)::q}

stream_cases:
    {[]}
    | x=LC_LETTER COLON t=op q=stream_cases {(x, t)::q}

stack_cases:
    {[]}
    | x=UC_LETTER COLON t=op q=stack_cases {(x, t)::q}

op:
    POP {Pop}
    | PUSH x=UC_LETTER {Push(x)}
    | REJECT {Reject}
    | CHANGE d=DIGIT {Change(d)}
    | BEGIN c=case_block END {Block(c)}

