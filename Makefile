MENHIR=menhir
OCAMLC=ocamlc
OCAMLLEX=ocamllex

SOURCES = ast.ml parser.ml lexer.ml main.ml

OBJECTS = $(SOURCES:.ml=.cmo)

.PHONY: clean all 

all: parser
	test -p word_pipe || mkfifo word_pipe

parser: ast.cmo parser.cmi parser.cmo lexer.cmo main.cmo 
	$(OCAMLC) -o $@ $(OBJECTS)

%.cmo: %.ml
	$(OCAMLC) -c $< -o $@

%.cmi: %.mli
	$(OCAMLC) -c $< -o $@

%.ml %.mli: %.mly
	rm -f $(<:.mly=.conflicts)
	$(MENHIR) -v --infer --canonical $<

%.ml: %.mll
	$(OCAMLLEX) $<

parser.mly: ast.ml

lexer.mll: parser.ml

clean:
	./pipe_fix
	rm -fr parser.mli parser.ml lexer.ml *.cmo parser *.cmi *~ *.automaton *.conflicts word_pipe

parser.cmo: ast.cmo parser.cmi
lexer.cmo: parser.cmo
main.cmo: parser.cmo lexer.cmo
