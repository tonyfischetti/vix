// gleam, date and time, get unix time, epoch, timestamp, seconds since epoch, milliseconds

// gleam add gleam_time

import gleam/float
import gleam/time/calendar
import gleam/time/timestamp

pub fn main() {
  let now = timestamp.system_time()

  // seconds, as a Float (the fraction is the part of a second)
  echo timestamp.to_unix_seconds(now)
  // 1793923870.9454243

  // whole seconds
  echo now |> timestamp.to_unix_seconds |> float.truncate
  // 1793923870

  // or exactly, as two Ints
  let #(seconds, nanoseconds) = timestamp.to_unix_seconds_and_nanoseconds(now)

  // milliseconds (what `Date.now()` gives you)
  echo seconds * 1000 + nanoseconds / 1_000_000
  // 1793923870945

  // and back from a unix time
  let sgt_peppers = timestamp.from_unix_seconds(-82_166_400)
  assert timestamp.to_rfc3339(sgt_peppers, calendar.utc_offset)
    == "1967-05-26T00:00:00Z"
  assert timestamp.from_unix_seconds(0) == timestamp.unix_epoch
}
