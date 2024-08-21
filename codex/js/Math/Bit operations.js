// js, math, bit operations, binary, decimal to binary string


//  uses "zero-filling right shift" operator to ensure it becomes positive
const decimalToBinary = (decimal, numBytes=1) => {
  return (decimal>>>0).toString(2).padStart(8*numBytes, "0");
};

const example = 0b00001011;     // 11

example >> 0;             // 0000 1011
example >> 1;             // 0000 0101
example >> 2;             // 0000 0010
example << 1;             // 0001 0110

example >> 0;             // 0000 1011
example >> 1;             // 0000 0101
example & example >> 1;   // 0001 0001

1 << 3                    // 0000 1000
example & (1 << 3)        // true
0b1111 << 4               // 1111 0000
example | (0b1111 << 4)   // 1111 1011

