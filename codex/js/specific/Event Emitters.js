/*
 * "The EventEmitter is a module that facilitates communication
 * between objects in Node. EventEmitter is at the core of Node
 * asynchronous event-driven architecture. Many of Node’s
 * built-in modules inherit from EventEmitter"
 */

class Pulsar extends EventEmitter {
  rotate() {
    setTimeout(() => {
      this.emit("pulse");
    }, 1000);
  }
}

const pulsar = new Pulsar();
pulsar.rotate();

// can register multiple times
pulsar.on('pulse', () => console.log("pulse!"));
pulsar.on('pulse', () => pulsar.rotate());