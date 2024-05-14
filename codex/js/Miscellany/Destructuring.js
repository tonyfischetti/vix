const ar1 = [1, 2];
let [first, second] = ar1;
first;          // 1
second;         // 2

const ar2 = [1, 2, 3, 4, 5];
let [car, ...cdr] = ar2;
car;            // 1
cdr;            // [ 2, 3, 4, 5 ]

const obj1 = {
  'red': 'cadmium',
  'green': ['viridian', 'hookers'],
  'blue': 'phthalo',
  'black': 'lamp'
};

const { red, blue } = obj1;
red;      // cadmium
blue;     // phthalo

const { red, green } = obj1;
green;    // [ "viridian", "hookers" ]

// default values
const { black="carbon", blue="prussian", magenta="quinacridone" } = obj1;
black;        // lamp
blue;         // phthalo
magenta;      // quinacridone
