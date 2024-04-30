/*
 * Both deno and bun support compiling single-file executables
 */

/* deno */
// deno compile --allow-net --allow-read --allow-env --allow-run --output my-deno-exe exe.js

/*
 * With deno, you can embed script arguments
 * AND, you can compile for other platforms:
 *   - x86_64-unknown-linux-gnu
 *   - x86_64-pc-windows-msvc
 *   - x86_64-apple-darwin
 *   - aarch64-apple-darwin
 */

/* bun */
// bun build --compile --minify --sourcemap exe.js --outfile my-bun-exe