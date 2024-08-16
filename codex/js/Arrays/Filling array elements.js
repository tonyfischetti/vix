// js, arrays, array methods, filling array elements, fill, array indexing, multiple indices

const rainbow2 = [...rainbow];
rainbow2.fill("BLACK", 4, 7);     // red, orange, yellow, green, BLACK, BLACK, BLACK
rainbow2                          // modifies array in place
rainbow2.fill("BLACK", 1, 2);     // red, BLACK,  yellow, green, BLACK, BLACK, BLACK
rainbow2.fill("BLACK", 0, 1);     // BLACK, BLACK, yellow, green, BLACK, BLACK, BLACK
rainbow2.fill("BLACK", 2, 4);     // BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, BLACK

