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

---

An object has its data and metadata.
Data and metadata are objects too.
There is code. Code is data too (-> object).

Attempt at semantics:

There are semantics.
Semantics are how you look at things (viewpoint, paradigm).

There is Memory.
Memory is a continuous sequence of addressable cells.

There is Data.
Data is contained in Memory
Everything is Data.

So, we have Objects.
An Object has:
- Metadata: Type and everything else that's not its direct data
- Data: Its direct data
Objects are contained in Memory.
Objects are Data.
Everything is an Object.

Object's Type defines its Data.

There is Code.
Code is Executable Data.
Code is executed by Executors.
Example: CPU is an executor for machine code.

There are Executors.
Executors run Code.

There are Compilers.
A Compiler converts Data into Code.

There are Pure Interpreters.
A Pure Interpreter considers some Data as Code and acts on that "virtual Code".

There are Interpreters.
An Interpreter is a combination and/or permutation of semantically connected Compilers and Executors.

There are levels to everything (hierarchy).

Lingo is a collection of interconnected semantics.

Lingo has an Interpreter.
Lingo has a VM(Code + Executor).
Lingo has a Compiler for that VM.
Lingo Interpreter first compiles Objects into VM Code and then Executes it.

Lingo built-in Types:
cell (like size_t in C)
i8, i16, i32, i64, isize
u8, u16, u32, u64, usize
f32, f64
bool
list (generic)
table (generic)
set (generic)
string
symbol
keyword
pointer(cell?)
null

---

Sexp - external representation of Lisp data/code
Lingo syntax is a superset of Sexp
Lingo Interpreter converts Lingo syntax into Sexp form.

Lingo Interpreter must be able to run without Lingo Bytecode functionality (cut VM),
turning it into a Pure Interpreter.

Function
Closure

Multiple inheritance?

Identifier - valid symbol

Type is id'd by an UUID?
Type has an Identifier

Tables:
Type Sym -> UUID
UUID -> Type Sym
UUID -> Metadata

Scope:
Variable { Sym, Type(UUID), Location(Ptr) }

Function has metadata attached about used variables and generated code
Closure <-> Function distinction?

What if multiple Codes? Sexp -> Bytecode(VM) -> Native
All in Metadata then.

---


