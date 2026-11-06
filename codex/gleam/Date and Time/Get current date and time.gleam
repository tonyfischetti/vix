// gleam, date and time, current time, now, timestamp, utc, local time, ISO-8601, rfc3339, YYYY-MM-DD, calendar, time zone offset

// gleam add gleam_time

import gleam/string
import gleam/time/calendar
import gleam/time/duration.{type Duration}
import gleam/time/timestamp.{type Timestamp}

pub fn main() {
  // a Timestamp is a moment in time. it has no time zone: you say which
  // offset you want when you turn it into something readable
  let now = timestamp.system_time()

  // *** UTC ***
  echo timestamp.to_rfc3339(now, calendar.utc_offset)
  // "2026-11-06T00:11:11.22765725Z"

  // *** LOCAL TIME *** (the offset of the machine this is running on)
  echo timestamp.to_rfc3339(now, calendar.local_offset())
  // "2026-11-05T19:11:11.22765725-05:00"

  echo yyyy_mm_dd(now, calendar.utc_offset)
  // "2026-11-06"
  echo yyyy_mm_dd(now, calendar.local_offset())
  // "2026-11-05"

  // as numbers
  let #(date, time) = timestamp.to_calendar(now, calendar.local_offset())
  echo date
  // Date(2026, November, 5)
  echo time
  // TimeOfDay(19, 11, 11, 227657250)
  echo calendar.day_of_week(date)
  // Thursday
}

fn yyyy_mm_dd(moment: Timestamp, offset: Duration) -> String {
  let assert Ok(#(date, _time)) =
    timestamp.to_rfc3339(moment, offset) |> string.split_once(on: "T")
  date
}
