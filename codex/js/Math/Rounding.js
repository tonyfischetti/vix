// js, math, round, ceiling, floor, mathematical constants

Math.round(Math.PI);    // 3
Math.round(Math.E);     // 3

Math.ceil
Math.floor

const roundTo = (num, places) => {
  return +(Math.round(num + "e+" + places)  + "e-" + places);
}
roundTo(2/3, 2)         // 0.67
roundTo(2/3, 4)         // 0.6667

