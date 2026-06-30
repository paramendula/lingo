# Lingo

## Draft for Lingo v0.1.0

---

## About

Paradigms:

- General-purpose
- Simplicity with depth
- Transparency (meta, homoiconic)
- Both high-level and low-level (meta)
- OOP
- FP
- Modularity
- Mutability

---

## Atoms

Byte is 8 bits

Cell is the basic operational unit

- measured in bytes
- host-dependent
- constant sized
- mostly 8 or 4 bytes wide

Host is either little-endian or big-endian

- mostly little-endian

---

## Semantics

Interpreter (vaguely):

1. READ (get raw data from any source)
2. PARSE (convert raw data into intermediate form, e.g. tokenization, lexing)
3. TRANSPILE (convert intermediate form into something executable)
4. RUN (run the executable format)

In most cases, interpreters don't care about step 1 (READ), they receive data directly in form of an argument to some kind of function. Step 2 (PARSE) may be divided into several sub-steps, like normalization->tokenization->AST. Step 3 (TRANSPILE) may be merged with step 4 (RUN), skipping the need of specifying or storing some kind of executable form. In the end, everything, semantics included, depends on a program's needs and a developer's convenience.

Compiler may be though of as of a part of an interpreter, taking charge of the step 3 (TRANSPILE).

In Lingo, there is an interpreter and multiple compilers. The interpreter reads an UTF-8 source code in form of a C-string, Lingo string, stream or whatsoever (step 1, READ). Then it parses the source code into an AST, that is expressed with Lingo's built-in datatypes, such as List or Table (step 2, PARSE; homoiconicity - code is data). Then it transpiles/compiles the parsed data/code into an executable form - most likely Lingo VM bytecode form (step 3, TRANSPILE). Then the executable form is run by Lingo VM or any other VM/CPU (step 4, RUN). It is worth mentioning that Lingo VM's bytecode executor may be thought of as of an interpreter itself, because it reads the executable code, parses it (checks for integrity and so on) and runs it. Though the step 3 (TRANSPILE) is mostly omitted for that virtual interpreter, the process of semantic conversion of a bytecode instruction using bytecode->native function mapping may be though of as of a form of a transpilation. A host's CPU is a similar executor too.

Thus, we distinguish three separate terms for code-related mechanisms: interpreter, compiler and executor. They are interconnected and semantically adjacent.

---

Everything is an Object.
Any Object has a Type.

Integer
Real
List (single-linked)
Table (hash map)
String

Executor
Compiler
Pure Interpreter
Interpreter

Types table? Type referenced by UUID?

One Class, Multiple Interfaces

Iterable - can produce an iterator
Iterator
Stream(Iterator or Iterable) ?

Lingo interpreter
