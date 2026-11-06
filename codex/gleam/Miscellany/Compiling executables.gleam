// gleam, compiling executables, compile, build, deploy, escript, erlang shipment, shebang, single file, bun, deno, javascript target

// There's no compiling to a native binary. A Gleam program needs the
// Erlang VM (or a JavaScript runtime) wherever it runs. These are the
// ways to pack one up.

// *** escript: one file ***
//
//   gleam export escript
//
// makes `./<project name>`, which starts with `#!/usr/bin/env escript`.
// It runs anywhere that has Erlang installed
//
//   ./my_project one two

// *** erlang shipment: one directory ***
//
//   gleam export erlang-shipment
//
// makes `build/erlang-shipment/` with your code and all the dependencies,
// compiled. Copy it to a server that has Erlang installed, and
//
//   build/erlang-shipment/entrypoint.sh run one two

// *** javascript ***
//
//   gleam build --target javascript
//
// makes ES modules, in `build/dev/javascript/<project name>/`. `main`
// doesn't get called by itself, so that takes a little entry file
//
//   // entry.mjs
//   import { main } from "./build/dev/javascript/my_project/my_project.mjs";
//   main();
//
//   node entry.mjs one two
//
// And THAT can be turned into a real single-file executable, with the
// runtime inside (they're around 60MB)
//
//   bun build --compile entry.mjs --outfile my-bun-exe
//   deno compile --allow-read --output my-deno-exe entry.mjs
//
//  NOTE  for the JavaScript target the code has to stick to packages that
//        work there (not gleam_erlang, gleam_otp, gleam_httpc...)
