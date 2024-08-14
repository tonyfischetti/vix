// js, math, special numbers, Infinity, NaN, limits, parseInt, division by zero

1/0;    // Infinity
0/1;    // 0
0/0;    // NaN

parseInt("pp");   // NaN

Number.NaN;                // NaN
Number.NEGATIVE_INFINITY;  // Infinity
Number.POSITIVE_INFINITY;  // -Infinity

Number.isNaN(Number.NaN);                   // true
Number.isFinite(10);                        // true
Number.isFinite(Number.POSITIVE_INFINITY);  // false
