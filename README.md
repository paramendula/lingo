# lingo

Quasi-compiled general-purpose programming language inspired by Lisp.

Version 0.1.0 - work in progress.

---

Planned to be:
- Portable
- Homoiconic (data = code)
- Lightweight (under 1MiB limit for now)
- Highly performant (in par with C/Rust)
- Consistent (not 'read-only' like Forth or some quirky Lisps)
- Not overly complex (too simple isn't good neither)
- Quasi-compiled
- Reflective (meta, meaning an instance can see everything about itself)
- Written in Zig (initially, self-written is a goal)

'Quasi-compiled' in context of Lingo means built-in:
- JIT compilation
- Interpreter and compiler used by the language being accessable with an API (programmable)
- Lingo instance is a compiler instance

Contribution rules:
- Fully LLM-orchestrated commits/pull requests aren't allowed (AI slop bye-bye).
