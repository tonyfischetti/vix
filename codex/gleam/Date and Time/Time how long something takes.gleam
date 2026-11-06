// gleam, date and time, timing functions, elapsed time, benchmark, stopwatch, duration, monotonic time, performance

// gleam add gleam_time

import gleam/int
import gleam/io
import gleam/list
import gleam/time/duration
import gleam/time/timestamp

pub fn main() {
  let start = timestamp.system_time()
  let total = busy_work()
  let elapsed = timestamp.difference(start, timestamp.system_time())

  io.println("answer: " <> int.to_string(total))
  io.println(
    "took " <> int.to_string(duration.to_milliseconds(elapsed)) <> "ms",
  )

  // the same thing as a function you can wrap around anything
  let #(_result, took) = timed(busy_work)
  echo duration.to_seconds(took)
  //  NOTE  the system clock can be adjusted while you're measuring. for a
  //        real benchmark use a clock that only goes forwards. on Erlang
  //        that's one line (see "Externals")
  //
  //          @external(erlang, "erlang", "monotonic_time")
  //          fn monotonic_time() -> Int
}

fn timed(work: fn() -> a) -> #(a, duration.Duration) {
  let start = timestamp.system_time()
  let result = work()
  #(result, timestamp.difference(start, timestamp.system_time()))
}

fn busy_work() -> Int {
  int.range(from: 0, to: 1_000_000, with: [], run: list.prepend)
  |> list.fold(0, int.add)
}
