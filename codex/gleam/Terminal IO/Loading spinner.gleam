// gleam, terminal io, loading spinner, spinner, loading animation, busy indicator, please wait, progress, frames, with_spinner

// gleam add spinner gleam_erlang gleam_community_ansi

import gleam/erlang/process
import gleam/io
import gleam_community/ansi
import spinner

pub fn main() {
  // the spinner animates in a process of its own, so this one is free
  // to get on with the work
  let loading =
    spinner.new("Putting the kettle on")
    |> spinner.with_colour(ansi.yellow)
    |> spinner.start

  // (the work)
  process.sleep(1500)

  // change what it says while it's going
  spinner.set_text(loading, "Warming the pot")
  process.sleep(1500)

  // `stop` wipes the line and gives the cursor back. say how it went
  spinner.stop(loading)
  io.println(ansi.green("✓") <> " Tea is served")

  //  WARN  it hides the cursor while it spins, so always `stop` it.
  //        and anything printed while it's going is wiped by the next
  //        frame: print after the stop

  // there are other animations: clock_frames, half_circle_frames,
  // moon_frames, negative_dots_frames, snake_frames (the default),
  // triangle_frames, walking_frames. or a list of your own
  let loading =
    spinner.new("Looking for the dormouse")
    |> spinner.with_frames(["|", "/", "-", "\\"])
    |> spinner.with_colour(ansi.cyan)
    |> spinner.start
  process.sleep(1500)
  spinner.stop(loading)

  // `with_spinner` starts it, calls the function, and stops it
  {
    use loading <- spinner.with_spinner(
      spinner.new("Moving one place on")
      |> spinner.with_frames(spinner.moon_frames),
    )
    process.sleep(1000)
    spinner.set_text(loading, "Clean cup, clean cup")
    process.sleep(1000)
  }
  //  NOTE  what the function returns doesn't come back out of
  //        `with_spinner`. to keep a result, use `start` and `stop`

  io.println("No room! No room!")
}
