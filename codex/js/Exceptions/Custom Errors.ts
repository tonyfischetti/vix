// js, exceptions, throw, raise, catch, extends, Error

class TonyError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "Tony Error";
  }
}

const divide10ByX = (x: number) => {
  if (x==0)
    throw new TonyError("can't divide by zero");
  return 10/x;
};

divide10ByX(5); // 2

divide10ByX(0);
/**
Uncaught Tony Error: can't divide by zero
  at divide10ByX (<anonymous>:2:21)
  at <anonymous>:1:22
  </anonymous>
**/
