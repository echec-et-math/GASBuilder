
module MenhirBasics = struct
  
  exception Error
  
  type token = 
    | UC_LETTER of (
# 8 "parser.mly"
      (char)
# 11 "parser.ml"
  )
    | TRANSITIONS_HEADER
    | STATES_HEADER
    | STACK_SYMBOLS_HEADER
    | SEMICOLON
    | RPARA
    | LPARA
    | LC_LETTER of (
# 8 "parser.mly"
      (char)
# 22 "parser.ml"
  )
    | INPUT_SYMBOLS_HEADER
    | INIT_STATE_HEADER
    | INIT_STACK_HEADER
    | EOF
    | DIGIT of (
# 7 "parser.mly"
      (int)
# 31 "parser.ml"
  )
    | COMMA
    | COLON
  
end

include MenhirBasics

let _eRR =
  MenhirBasics.Error

type _menhir_env = {
  _menhir_lexer: Lexing.lexbuf -> token;
  _menhir_lexbuf: Lexing.lexbuf;
  _menhir_token: token;
  mutable _menhir_error: bool
}

and _menhir_state = 
  | MenhirState50
  | MenhirState44
  | MenhirState42
  | MenhirState32
  | MenhirState18
  | MenhirState16
  | MenhirState11
  | MenhirState9
  | MenhirState4
  | MenhirState2

# 1 "parser.mly"
  
open Ast

# 66 "parser.ml"

let rec _menhir_goto_nonemptystack : _menhir_env -> 'ttv_tail -> _menhir_state -> (Ast.stacksymbols) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState44 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (y : (Ast.stacksymbols)) = _v in
        let (_menhir_stack, _menhir_s, (x : (
# 8 "parser.mly"
      (char)
# 78 "parser.ml"
        ))) = _menhir_stack in
        let _2 = () in
        let _v : (Ast.stacksymbols) = 
# 67 "parser.mly"
                                            (x::y)
# 84 "parser.ml"
         in
        _menhir_goto_nonemptystack _menhir_env _menhir_stack _menhir_s _v
    | MenhirState42 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (s : (Ast.stacksymbols)) = _v in
        let _v : (Ast.stacksymbols) = 
# 63 "parser.mly"
                      (s)
# 94 "parser.ml"
         in
        _menhir_goto_stack _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_stack : _menhir_env -> 'ttv_tail -> _menhir_state -> (Ast.stacksymbols) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | RPARA ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((((((_menhir_stack, _menhir_s), (a : (
# 7 "parser.mly"
      (int)
# 114 "parser.ml"
        ))), (b : (Ast.inputsymbol))), (c : (
# 8 "parser.mly"
      (char)
# 118 "parser.ml"
        ))), (d : (
# 7 "parser.mly"
      (int)
# 122 "parser.ml"
        ))), _, (e : (Ast.stacksymbols))) = _menhir_stack in
        let _11 = () in
        let _9 = () in
        let _7 = () in
        let _5 = () in
        let _3 = () in
        let _1 = () in
        let _v : (Ast.transition) = 
# 55 "parser.mly"
                                                                                                ((a, b, c, d, e))
# 133 "parser.ml"
         in
        let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LPARA ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState50
        | EOF ->
            _menhir_reduce22 _menhir_env (Obj.magic _menhir_stack) MenhirState50
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState50)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run43 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 8 "parser.mly"
      (char)
# 158 "parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | SEMICOLON ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | UC_LETTER _v ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState44 _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState44)
    | RPARA ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, (x : (
# 8 "parser.mly"
      (char)
# 181 "parser.ml"
        ))) = _menhir_stack in
        let _v : (Ast.stacksymbols) = 
# 66 "parser.mly"
                ([x])
# 186 "parser.ml"
         in
        _menhir_goto_nonemptystack _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_translist : _menhir_env -> 'ttv_tail -> _menhir_state -> (Ast.transitions) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState32 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (t : (Ast.transitions)) = _v in
        let _2 = () in
        let _1 = () in
        let _v : (Ast.transitions) = 
# 48 "parser.mly"
                                         (t)
# 208 "parser.ml"
         in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EOF ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, (decl : (Ast.declarations))), (tr_list : (Ast.transitions))) = _menhir_stack in
            let _3 = () in
            let _v : (
# 10 "parser.mly"
      (Ast.automaton)
# 223 "parser.ml"
            ) = 
# 15 "parser.mly"
                                              (check_conflict tr_list; build_automaton decl tr_list)
# 227 "parser.ml"
             in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_1 : (
# 10 "parser.mly"
      (Ast.automaton)
# 234 "parser.ml"
            )) = _v in
            Obj.magic _1
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            raise _eRR)
    | MenhirState50 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (q : (Ast.transitions)) = _v in
        let (_menhir_stack, _menhir_s, (t : (Ast.transition))) = _menhir_stack in
        let _v : (Ast.transitions) = 
# 52 "parser.mly"
                               (t::q)
# 250 "parser.ml"
         in
        _menhir_goto_translist _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_goto_minuscule_ou_vide : _menhir_env -> 'ttv_tail -> (Ast.inputsymbol) -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let _menhir_stack = (_menhir_stack, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | COMMA ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | UC_LETTER _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | COMMA ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | DIGIT _v ->
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let _menhir_stack = (_menhir_stack, _v) in
                    let _menhir_env = _menhir_discard _menhir_env in
                    let _tok = _menhir_env._menhir_token in
                    (match _tok with
                    | COMMA ->
                        let _menhir_stack = Obj.magic _menhir_stack in
                        let _menhir_env = _menhir_discard _menhir_env in
                        let _tok = _menhir_env._menhir_token in
                        (match _tok with
                        | UC_LETTER _v ->
                            _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState42 _v
                        | RPARA ->
                            let _menhir_stack = Obj.magic _menhir_stack in
                            let _menhir_s = MenhirState42 in
                            let _v : (Ast.stacksymbols) = 
# 62 "parser.mly"
      ([])
# 298 "parser.ml"
                             in
                            _menhir_goto_stack _menhir_env _menhir_stack _menhir_s _v
                        | _ ->
                            assert (not _menhir_env._menhir_error);
                            _menhir_env._menhir_error <- true;
                            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState42)
                    | _ ->
                        assert (not _menhir_env._menhir_error);
                        _menhir_env._menhir_error <- true;
                        let _menhir_stack = Obj.magic _menhir_stack in
                        let (((((_menhir_stack, _menhir_s), _), _), _), _) = _menhir_stack in
                        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let ((((_menhir_stack, _menhir_s), _), _), _) = _menhir_stack in
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let ((((_menhir_stack, _menhir_s), _), _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((_menhir_stack, _menhir_s), _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_reduce22 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : (Ast.transitions) = 
# 51 "parser.mly"
     ([])
# 341 "parser.ml"
     in
    _menhir_goto_translist _menhir_env _menhir_stack _menhir_s _v

and _menhir_run33 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DIGIT _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COMMA ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LC_LETTER _v ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _menhir_stack = Obj.magic _menhir_stack in
                let (x : (
# 8 "parser.mly"
      (char)
# 369 "parser.ml"
                )) = _v in
                let _v : (Ast.inputsymbol) = 
# 59 "parser.mly"
                  (x)
# 374 "parser.ml"
                 in
                _menhir_goto_minuscule_ou_vide _menhir_env _menhir_stack _v
            | COMMA ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _v : (Ast.inputsymbol) = 
# 58 "parser.mly"
     ('&')
# 382 "parser.ml"
                 in
                _menhir_goto_minuscule_ou_vide _menhir_env _menhir_stack _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_suite_chiffres_nonvide : _menhir_env -> 'ttv_tail -> _menhir_state -> (Ast.states) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState18 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (y : (Ast.states)) = _v in
        let (_menhir_stack, _menhir_s, (x : (
# 7 "parser.mly"
      (int)
# 414 "parser.ml"
        ))) = _menhir_stack in
        let _2 = () in
        let _v : (Ast.states) = 
# 45 "parser.mly"
                                             (x::y)
# 420 "parser.ml"
         in
        _menhir_goto_suite_chiffres_nonvide _menhir_env _menhir_stack _menhir_s _v
    | MenhirState16 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (state_symbs : (Ast.states)) = _v in
        let _2 = () in
        let _1 = () in
        let _v : (Ast.states) = 
# 27 "parser.mly"
                                                           (state_symbs)
# 432 "parser.ml"
         in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | INIT_STATE_HEADER ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | COLON ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | DIGIT _v ->
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let _menhir_env = _menhir_discard _menhir_env in
                    let _menhir_stack = Obj.magic _menhir_stack in
                    let (x : (
# 7 "parser.mly"
      (int)
# 456 "parser.ml"
                    )) = _v in
                    let _2 = () in
                    let _1 = () in
                    let _v : (Ast.initstate) = 
# 30 "parser.mly"
                                    (x)
# 463 "parser.ml"
                     in
                    let _menhir_stack = (_menhir_stack, _v) in
                    let _menhir_stack = Obj.magic _menhir_stack in
                    assert (not _menhir_env._menhir_error);
                    let _tok = _menhir_env._menhir_token in
                    (match _tok with
                    | INIT_STACK_HEADER ->
                        let _menhir_stack = Obj.magic _menhir_stack in
                        let _menhir_env = _menhir_discard _menhir_env in
                        let _tok = _menhir_env._menhir_token in
                        (match _tok with
                        | COLON ->
                            let _menhir_stack = Obj.magic _menhir_stack in
                            let _menhir_env = _menhir_discard _menhir_env in
                            let _tok = _menhir_env._menhir_token in
                            (match _tok with
                            | UC_LETTER _v ->
                                let _menhir_stack = Obj.magic _menhir_stack in
                                let _menhir_env = _menhir_discard _menhir_env in
                                let _menhir_stack = Obj.magic _menhir_stack in
                                let (x : (
# 8 "parser.mly"
      (char)
# 487 "parser.ml"
                                )) = _v in
                                let _2 = () in
                                let _1 = () in
                                let _v : (Ast.initstack) = 
# 33 "parser.mly"
                                        (x)
# 494 "parser.ml"
                                 in
                                let _menhir_stack = Obj.magic _menhir_stack in
                                let _menhir_stack = Obj.magic _menhir_stack in
                                let (e : (Ast.initstack)) = _v in
                                let ((((_menhir_stack, (a : (Ast.inputsymbols))), (b : (Ast.stacksymbols))), (c : (Ast.states))), (d : (Ast.initstate))) = _menhir_stack in
                                let _v : (Ast.declarations) = 
# 18 "parser.mly"
                                                                         ((a, b, c, d, e))
# 503 "parser.ml"
                                 in
                                let _menhir_stack = (_menhir_stack, _v) in
                                let _menhir_stack = Obj.magic _menhir_stack in
                                assert (not _menhir_env._menhir_error);
                                let _tok = _menhir_env._menhir_token in
                                (match _tok with
                                | TRANSITIONS_HEADER ->
                                    let _menhir_stack = Obj.magic _menhir_stack in
                                    let _menhir_env = _menhir_discard _menhir_env in
                                    let _tok = _menhir_env._menhir_token in
                                    (match _tok with
                                    | COLON ->
                                        let _menhir_stack = Obj.magic _menhir_stack in
                                        let _menhir_env = _menhir_discard _menhir_env in
                                        let _tok = _menhir_env._menhir_token in
                                        (match _tok with
                                        | LPARA ->
                                            _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState32
                                        | EOF ->
                                            _menhir_reduce22 _menhir_env (Obj.magic _menhir_stack) MenhirState32
                                        | _ ->
                                            assert (not _menhir_env._menhir_error);
                                            _menhir_env._menhir_error <- true;
                                            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState32)
                                    | _ ->
                                        assert (not _menhir_env._menhir_error);
                                        _menhir_env._menhir_error <- true;
                                        let _menhir_stack = Obj.magic _menhir_stack in
                                        raise _eRR)
                                | _ ->
                                    assert (not _menhir_env._menhir_error);
                                    _menhir_env._menhir_error <- true;
                                    let _menhir_stack = Obj.magic _menhir_stack in
                                    raise _eRR)
                            | _ ->
                                assert (not _menhir_env._menhir_error);
                                _menhir_env._menhir_error <- true;
                                let _menhir_stack = Obj.magic _menhir_stack in
                                raise _eRR)
                        | _ ->
                            assert (not _menhir_env._menhir_error);
                            _menhir_env._menhir_error <- true;
                            let _menhir_stack = Obj.magic _menhir_stack in
                            raise _eRR)
                    | _ ->
                        assert (not _menhir_env._menhir_error);
                        _menhir_env._menhir_error <- true;
                        let _menhir_stack = Obj.magic _menhir_stack in
                        raise _eRR)
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    let _menhir_stack = Obj.magic _menhir_stack in
                    raise _eRR)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                raise _eRR)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            raise _eRR)
    | _ ->
        _menhir_fail ()

and _menhir_run17 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 7 "parser.mly"
      (int)
# 574 "parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | COMMA ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DIGIT _v ->
            _menhir_run17 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState18)
    | INIT_STATE_HEADER ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, (x : (
# 7 "parser.mly"
      (int)
# 597 "parser.ml"
        ))) = _menhir_stack in
        let _v : (Ast.states) = 
# 44 "parser.mly"
            ([x])
# 602 "parser.ml"
         in
        _menhir_goto_suite_chiffres_nonvide _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_suite_maj_nonvide : _menhir_env -> 'ttv_tail -> _menhir_state -> (Ast.stacksymbols) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState11 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (y : (Ast.stacksymbols)) = _v in
        let (_menhir_stack, _menhir_s, (x : (
# 8 "parser.mly"
      (char)
# 622 "parser.ml"
        ))) = _menhir_stack in
        let _2 = () in
        let _v : (Ast.stacksymbols) = 
# 41 "parser.mly"
                                            (x::y)
# 628 "parser.ml"
         in
        _menhir_goto_suite_maj_nonvide _menhir_env _menhir_stack _menhir_s _v
    | MenhirState9 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (stack_symbs : (Ast.stacksymbols)) = _v in
        let _2 = () in
        let _1 = () in
        let _v : (Ast.stacksymbols) = 
# 24 "parser.mly"
                                                             (stack_symbs)
# 640 "parser.ml"
         in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | STATES_HEADER ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | COLON ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | DIGIT _v ->
                    _menhir_run17 _menhir_env (Obj.magic _menhir_stack) MenhirState16 _v
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState16)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                raise _eRR)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            raise _eRR)
    | _ ->
        _menhir_fail ()

and _menhir_fail : unit -> 'a =
  fun () ->
    Printf.fprintf stderr "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

and _menhir_run10 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 8 "parser.mly"
      (char)
# 684 "parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | COMMA ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | UC_LETTER _v ->
            _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState11 _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState11)
    | STATES_HEADER ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, (x : (
# 8 "parser.mly"
      (char)
# 707 "parser.ml"
        ))) = _menhir_stack in
        let _v : (Ast.stacksymbols) = 
# 40 "parser.mly"
                ([x])
# 712 "parser.ml"
         in
        _menhir_goto_suite_maj_nonvide _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_goto_suite_min_nonvide : _menhir_env -> 'ttv_tail -> _menhir_state -> (Ast.inputsymbols) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState4 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (y : (Ast.inputsymbols)) = _v in
        let (_menhir_stack, _menhir_s, (x : (
# 8 "parser.mly"
      (char)
# 732 "parser.ml"
        ))) = _menhir_stack in
        let _2 = () in
        let _v : (Ast.inputsymbols) = 
# 37 "parser.mly"
                                            (x::y)
# 738 "parser.ml"
         in
        _menhir_goto_suite_min_nonvide _menhir_env _menhir_stack _menhir_s _v
    | MenhirState2 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (input_symbs : (Ast.inputsymbols)) = _v in
        let _2 = () in
        let _1 = () in
        let _v : (Ast.inputsymbols) = 
# 21 "parser.mly"
                                                             (input_symbs)
# 750 "parser.ml"
         in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | STACK_SYMBOLS_HEADER ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | COLON ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | UC_LETTER _v ->
                    _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState9 _v
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState9)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                raise _eRR)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            raise _eRR)
    | _ ->
        _menhir_fail ()

and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState50 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState44 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState42 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((((_menhir_stack, _menhir_s), _), _), _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState32 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR
    | MenhirState18 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState16 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR
    | MenhirState11 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState9 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR
    | MenhirState4 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState2 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR

and _menhir_run3 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 8 "parser.mly"
      (char)
# 829 "parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | COMMA ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | LC_LETTER _v ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState4 _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState4)
    | STACK_SYMBOLS_HEADER ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, (x : (
# 8 "parser.mly"
      (char)
# 852 "parser.ml"
        ))) = _menhir_stack in
        let _v : (Ast.inputsymbols) = 
# 36 "parser.mly"
                ([x])
# 857 "parser.ml"
         in
        _menhir_goto_suite_min_nonvide _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_discard : _menhir_env -> _menhir_env =
  fun _menhir_env ->
    let lexer = _menhir_env._menhir_lexer in
    let lexbuf = _menhir_env._menhir_lexbuf in
    let _tok = lexer lexbuf in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_error = false;
    }

and automaton : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (
# 10 "parser.mly"
      (Ast.automaton)
# 882 "parser.ml"
) =
  fun lexer lexbuf ->
    let _menhir_env = let _tok = Obj.magic () in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_error = false;
    } in
    Obj.magic (let _menhir_stack = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | INPUT_SYMBOLS_HEADER ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | LC_LETTER _v ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState2)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            raise _eRR)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR)

# 269 "<standard.mly>"
  

# 926 "parser.ml"
