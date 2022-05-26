# Building

Just run `make` at the root of the project and it will magically build itself.

`make clean` will remove the generated files to only keep the core source code.

# Parsing an automaton and running it on a given word

The automaton parsing and word lecture are 2-in-1 : this means that running the program will parse your automaton and ask you to a word to test (and test it) all at the same time. Note that you will be asked for a word to test no matter the validity of your automaton file.

The empty word epsilon can be passed to the program using the word `&`.

To run the parser on a file, just run :

`./run <file with path and extension>`

# Error handling

## File parsing

You will be informed of a parsing error by Menhir : if a `Parser.MenhirBasics.Error` occurs, this means that the file you passed does not follow the syntax required (which is the one of either an automaton with explicitly described transitions as in `exemples/exemple.exp`, or an automaton with program-like described transitions as in `exemples/program.exp`). Menhir will NOT give details on the location of the error.

If your file is correctly built, you may still receive errors from our program about some incoherences in the behavior of your automaton : use of undefined symbols or states, undeterministic behavior...

## Word parsing

If your automaton is correctly parsed, the word entered previously will be tested on the automaton : a detailed log will describe each step. You will receive a message if the word is accepted, and a detailed error message if the word is not, explaining what went wrong.

Note : `&` within the logs always refer to epsilon, the empty letter/word.

# Known issues

The program separates the word input to a pipe (`word_pipe`) to not mess with the program input ; but if an error occurs during the parsing, the pipe won't be emptied nor read. This can lead to :

- The tested word being concatenated to the residute left in the pipe (this can be avoided by manually clearing the pipe after an error, run the script `./pipe_fix`)

- The program blocking for someone to read the word into the pipe, when there is no one to read (the exact same solution applies)