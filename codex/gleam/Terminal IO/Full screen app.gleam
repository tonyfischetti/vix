// gleam, terminal io, tui, full screen app, terminal user interface, shore, elm architecture, model view update, keybindings, button, text input, progress bar, background work, effects

// gleam add shore gleam_erlang

// "shore" is a TUI framework. It takes over the whole terminal, and the
// program is written the Elm way, as three things:
//
//   a Model      everything the app knows
//   `update`     the model + something that happened = the next model
//   `view`       the model, turned into what should be on the screen
//
// shore reads the keys, calls `update`, calls `view`, and redraws.
//
//  NOTE  Erlang target only, and it wants OTP 28 or newer.
//        ctrl-x gets you out

import gleam/erlang/process
import gleam/int
import gleam/option.{None, Some}
import shore
import shore/key
import shore/layout
import shore/style
import shore/ui

pub fn main() {
  // shore sends a message here when the app is quit
  let exit = process.new_subject()

  let assert Ok(_app) =
    shore.spec(
      init:,
      update:,
      view:,
      exit:,
      // ctrl-x quits, tab and shift-tab move between the fields, enter
      // presses the button that has the focus, escape lets go of it
      keybinds: shore.default_keybinds(),
      // only redraw when something changed. (or `shore.on_timer(16)`
      // for 60 times a second)
      redraw: shore.on_update(),
    )
    |> shore.start

  // the app runs in a process of its own. this one waits for it
  process.receive_forever(exit)
}

// ***** the model

type Kettle {
  Cold
  Heating(percent: Int)
  Boiled
}

type Model {
  Model(guest: String, kettle: Kettle, cups: Int)
}

// the second thing in the tuple is work to do in the background (below)
fn init() -> #(Model, List(fn() -> Msg)) {
  #(Model(guest: "Alice", kettle: Cold, cups: 0), [])
}

// ***** update

// everything that can happen
type Msg {
  GuestChanged(String)
  KettleOn
  Tick
  Pour
}

fn update(model: Model, msg: Msg) -> #(Model, List(fn() -> Msg)) {
  case msg, model.kettle {
    GuestChanged(guest), _ -> #(Model(..model, guest:), [])

    // start it heating, and ask for the first tick
    KettleOn, Cold | KettleOn, Boiled -> {
      let model = Model(..model, kettle: Heating(0))
      #(model, [tick])
    }

    // each tick heats it a bit more and asks for the next one
    Tick, Heating(percent) if percent < 100 -> {
      let model = Model(..model, kettle: Heating(percent + 5))
      #(model, [tick])
    }
    Tick, Heating(_) -> #(Model(..model, kettle: Boiled), [])

    // no tea without hot water
    Pour, Boiled -> #(Model(..model, cups: model.cups + 1), [])

    _, _ -> #(model, [])
  }
}

// a function handed back from `update` is run by shore in another
// process, so the screen never freezes while it works. whatever it
// returns arrives at `update` as the next message
fn tick() -> Msg {
  process.sleep(100)
  Tick
}

// ***** view

fn view(model: Model) -> shore.Node(Msg) {
  let kettle = case model.kettle {
    Cold -> ui.text("the kettle is cold")
    Heating(percent) -> ui.progress(style.Px(30), 100, percent, style.Yellow)
    Boiled -> ui.text_styled("the kettle has boiled", Some(style.Green), None)
  }

  ui.box(
    [
      // what's typed arrives as a GuestChanged message. (tab to get
      // into the field, escape to get out of it)
      ui.input("guest", model.guest, style.Px(20), GuestChanged),
      ui.br(),
      kettle,
      ui.br(),
      ui.text(
        "cups poured for " <> model.guest <> ": " <> int.to_string(model.cups),
      ),
      ui.br(),
      ui.text("tab: next field    ctrl-x: quit"),
      ui.br(),
      // a button is a key and the message it sends.
      // (the row goes last: text put after a row lands in the wrong place)
      ui.row([
        ui.button("k: kettle on", key.Char("k"), KettleOn),
        ui.button("p: pour", key.Char("p"), Pour),
      ]),
    ],
    Some("A Mad Tea-Party"),
  )
  |> ui.align(style.Center, _)
  |> layout.center(style.Px(50), style.Px(12))
}
