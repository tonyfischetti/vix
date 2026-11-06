// gleam, date and time, date arithmetic, date difference, date diff, duration, add days, compare dates, relative dates, day of week, sgt peppers, revolver

// gleam add gleam_time

import gleam/order
import gleam/time/calendar.{Date, TimeOfDay}
import gleam/time/duration
import gleam/time/timestamp

pub fn main() {
  let revolver = midnight_utc(Date(1966, calendar.August, 5))
  let sgt_peppers = midnight_utc(Date(1967, calendar.May, 26))

  // the time between two timestamps is a Duration (second minus first)
  let gap = timestamp.difference(revolver, sgt_peppers)
  assert duration.to_seconds(gap) == 25_401_600.0

  // in days
  assert duration.to_seconds(gap) /. 86_400.0 == 294.0

  // roughly, for people: the biggest unit that fits
  assert duration.approximate(gap) == #(9, duration.Month)

  // moving a timestamp
  let a_day = duration.hours(24)
  let next_day = timestamp.add(revolver, a_day)
  assert timestamp.to_rfc3339(next_day, calendar.utc_offset)
    == "1966-08-06T00:00:00Z"

  let week_before = timestamp.subtract(revolver, duration.hours(24 * 7))
  assert timestamp.to_rfc3339(week_before, calendar.utc_offset)
    == "1966-07-29T00:00:00Z"

  // comparing
  assert timestamp.compare(revolver, sgt_peppers) == order.Lt
  assert timestamp.compare(sgt_peppers, revolver) == order.Gt
  assert revolver == midnight_utc(Date(1966, calendar.August, 5))

  assert calendar.day_of_week(Date(1967, calendar.May, 26)) == calendar.Friday
  assert calendar.is_leap_year(1968)
  //  NOTE  a Duration is an exact amount of time. there's no "plus one
  //        month", because months aren't all the same length
}

fn midnight_utc(date: calendar.Date) -> timestamp.Timestamp {
  timestamp.from_calendar(
    date:,
    time: TimeOfDay(0, 0, 0, 0),
    offset: calendar.utc_offset,
  )
}
