// gleam, concurrency, actor, otp, state, mutable state, messages, event emitter, setTimeout, send_after, pulsar, call, gen_server

// gleam add gleam_otp gleam_erlang

// An actor is a process that holds on to some state and handles messages
// one at a time. It's the closest thing there is to an object: the only
// way to read or change what's inside is to send it a message.

import gleam/erlang/process.{type Subject}
import gleam/io
import gleam/otp/actor

// the messages it understands
pub type Message {
  Pulse
  // a message that wants an answer carries the subject to send it to
  GetCount(reply_to: Subject(Int))
  Stop
}

// what it remembers between messages
type State {
  State(self: Subject(Message), count: Int)
}

// called for each message, with the current state. says what to do next,
// and what the state is from now on
fn handle_message(
  state: State,
  message: Message,
) -> actor.Next(State, Message) {
  case message {
    Pulse -> {
      io.println("pulse!")
      // rotate: send ourselves another Pulse in 100ms (the `setTimeout`)
      process.send_after(state.self, 100, Pulse)
      actor.continue(State(..state, count: state.count + 1))
    }

    GetCount(reply_to:) -> {
      process.send(reply_to, state.count)
      actor.continue(state)
    }

    Stop -> actor.stop()
  }
}

pub fn main() {
  // the initialiser runs inside the new process. it's handed the actor's
  // own subject, which goes into the state (for the self-sends) and back
  // to us (so we can talk to it)
  let assert Ok(started) =
    actor.new_with_initialiser(1000, fn(self) {
      State(self:, count: 0)
      |> actor.initialised
      |> actor.returning(self)
      |> Ok
    })
    |> actor.on_message(handle_message)
    |> actor.start
  let pulsar = started.data

  // `send`: fire and forget
  process.send(pulsar, Pulse)

  process.sleep(350)

  // `call`: send, and wait (up to 1000ms here) for the reply
  let count = process.call(pulsar, waiting: 1000, sending: GetCount)
  echo count
  // 4

  process.send(pulsar, Stop)
  process.sleep(50)
  assert !process.is_alive(started.pid)
  //  NOTE  an actor that doesn't need its own subject is simpler to start
  //
  //          actor.new(initial_state)
  //          |> actor.on_message(handle_message)
  //          |> actor.start
}
