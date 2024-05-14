// syntatic sugar for prototype-based OO

class Animal {
  constructor(name) {
    this.name = name;
  }
  // access computed properties (there's also `set`)
  get honorific() {
    return `SIR ${this.name.toUpperCase()}`;
  }
  toString() {
    return `An animal named ${this.name}`;
  }
  static note = 'hi!';
  static createFromFullName(fullName) {
    return new Animal(fullName.split(/, /)[1]);
  }
};

const birb = new Animal('Captain');
const raccoon = Animal.createFromFullName("Raccoon, Rocky");

birb;            // Animal { name: 'Captain' }
raccoon;         // Animal { name: 'Rocky' }
`${birb}`;       // 'An animal named Captain' (would be [object Object] without `toString`)
birb.honorific;  // SIR CAPTAIN
Animal.note;     // hi!


class LoudAnimal extends Animal {
  constructor(name, sound) {
    // CALL THE SUPERCLASS CONSTRUCTOR
    super(name);
    this.sound = sound
  }
  // override method
  toString() {
    return `An animal named ${this.name} (that says "${this.sound}")`;
  }
  speak() {
    console.log(`${this.name} says "${this.sound}"`);
  }
  toJSON() {
    return JSON.stringify({name: this.name, sound: this.sound});
  }
}

const cow = new LoudAnimal("Bessie", "moo");
cow;             // LoudAnimal { name: 'Bessie', sound: 'moo' }
`${cow}`;        // An animal named Bessie (that says "moo")
cow.honorific;   // SIR BESSIE
cow.speak();     // Bessie says "moo"
cow.toJSON();    // {"name":"Bessie","sound":"moo"}
