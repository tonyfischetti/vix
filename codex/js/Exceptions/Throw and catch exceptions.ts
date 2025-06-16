// js, exceptions, throw, raise, catch

const divide10ByX = (x: number) => {
  if (x==0)
    throw new Error("can't divide by zero");
  return 10/x;
};

divide10ByX(5); // 2

try {
  divide10ByX(0);
} catch (error) {
  console.log("nope");
}

