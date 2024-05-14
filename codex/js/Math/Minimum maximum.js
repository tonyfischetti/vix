const tmp = [1, 2, 3, 4, 5];

Math.max(tmp);          // NaN... BAD!
Math.max(...tmp);       // 5... GOOD!
Math.min(...tmp);       // 1
