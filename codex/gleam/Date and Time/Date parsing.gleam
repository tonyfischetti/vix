// gleam, date and time, parse dates, date parsing, UTC, ISO-8601, rfc3339, http date, local time, from_calendar, YYYY-MM-DD, validate a date

// gleam add gleam_time

import gleam/int
import gleam/result
import gleam/string
import gleam/time/calendar.{Date, TimeOfDay}
import gleam/time/duration
import gleam/time/timestamp

pub fn main() {
  // from the pieces. months are names, not numbers (nothing is 0-indexed)
  let release_day = Date(year: 1967, month: calendar.May, day: 26)
  let midnight = TimeOfDay(hours: 0, minutes: 0, seconds: 0, nanoseconds: 0)

  // you have to say where that midnight was. in UTC...
  let sgt_peppers =
    timestamp.from_calendar(
      date: release_day,
      time: midnight,
      offset: calendar.utc_offset,
    )
  assert timestamp.to_unix_seconds(sgt_peppers) == -82_166_400.0

  // ...or five hours behind it
  let in_new_york =
    timestamp.from_calendar(
      date: release_day,
      time: midnight,
      offset: duration.hours(-5),
    )
  assert timestamp.to_unix_seconds(in_new_york) == -82_148_400.0
  // (for "wherever this machine is", the offset is `calendar.local_offset()`)

  // from a string, the one format understood is RFC 3339: the full
  // ISO-8601 date, time and offset
  assert timestamp.parse_rfc3339("1967-05-26T00:00:00Z") == Ok(sgt_peppers)
  assert timestamp.parse_rfc3339("1967-05-25T19:00:00-05:00") == Ok(sgt_peppers)
  assert timestamp.parse_rfc3339("1967-05-26") == Error(Nil)
  assert timestamp.parse_rfc3339("May 26, 1967") == Error(Nil)

  // (and the kind of date that's in HTTP headers)
  assert timestamp.parse_http_date("Fri, 26 May 1967 00:00:00 GMT")
    == Ok(sgt_peppers)

  // from unix seconds
  assert timestamp.from_unix_seconds(-82_166_400) == sgt_peppers

  // a bare date is easy enough to do by hand
  assert parse_date("1967-05-26") == Ok(release_day)
  assert parse_date("1967-02-30") == Error(Nil)
  assert parse_date("May 26, 1967") == Error(Nil)
  //  NOTE  there are no format strings ("LLLL dd, yyyy") in gleam_time.
  //        packages like `gtempo` and `birl` do those
}

fn parse_date(input: String) -> Result(calendar.Date, Nil) {
  case string.split(input, on: "-") {
    [year, month, day] -> {
      use year <- result.try(int.parse(year))
      use month <- result.try(int.parse(month))
      use month <- result.try(calendar.month_from_int(month))
      use day <- result.try(int.parse(day))
      let date = Date(year:, month:, day:)
      case calendar.is_valid_date(date) {
        True -> Ok(date)
        False -> Error(Nil)
      }
    }
    _ -> Error(Nil)
  }
}
