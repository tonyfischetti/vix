// gleam, basics, run a program, shebang, gleam run, gleam test, gleam build, gleam check, main function, entry point, erlang target, javascript target, node, deno, bun

// There's no shebang line, and no running a lone .gleam file. Gleam code
// lives in a project (see "Setup gleam project") and the `gleam` binary
// does everything. (The nearest thing to a script you can `chmod +x` is
// an escript: see "Compiling executables")
//
//   gleam run                       runs `main` in src/<project name>.gleam
//   gleam run -m some/module        runs `main` in src/some/module.gleam
//   gleam run -- one two            what's after `--` goes to the program
//   gleam test                      runs test/<project name>_test.gleam
//   gleam check                     type check, don't build
//   gleam build                     compile (into build/)
//   gleam format                    THE format. there are no options
//   gleam add simplifile            add a dependency
//   gleam docs build                HTML documentation from the /// comments
//   gleam shell                     an Erlang shell with the project loaded
//
// It compiles to Erlang and runs on the BEAM unless you say otherwise
//
//   gleam run --target javascript                   on node
//   gleam run --target javascript --runtime deno    or `bun`
//
// To run one of the codex examples: copy it into the src/ of any project,
// under a snake_case name, `gleam add` the packages its imports need, and
//
//   gleam run -m the_snake_case_name

import gleam/io

pub fn main() {
  io.println("Hello from main!")
}
