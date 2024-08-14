// js, array, random shuffle, shuffle an array, fischer-yates, floor, random

// uses array destructuring to not modify supplied array
const shuffleArray = ([...anarray]) => {
  let thelength = anarray.length;
  for (let i = 0; i < thelength; i++) {
    let rn = Math.floor(Math.random() * (i+1));
    let tmp = anarray[i];
    anarray[i] = anarray[rn];
    anarray[rn] = tmp;
  }
  return anarray;
};

rainbow = [ 'red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ];
shuffleArray(rainbow);
rainbow;      // this is still unmodified
