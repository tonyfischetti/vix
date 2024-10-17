// js, functional, compose, higher-order functions

const compose = (...fns) => {
  return input => {
    return fns.reduceRight((acc, i) => {
      return i(acc);
    }, input);
  };
}

