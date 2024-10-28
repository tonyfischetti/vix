// os, signals, catching signals, sigint, sighup, sigterm

process.on('SIGINT', () => {
  console.log("shutting down gracefully");
  process.exit(0);
});

process.on('exit', () => {
  console.log("finally exiting");
});

/*
 * ::control-c::
 * shutting down gracefully
 * finally exiting
 */

const shutdownFn = (retcode) => {
  return () => {
    DB.close()
    process.exit(retcode);
  };
};

process.on('SIGINT',  shutdownFn(1));
process.on('SIGHUP',  shutdownFn(2));
process.on('SIGTERM', shutdownFn(3));

