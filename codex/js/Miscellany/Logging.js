import pino from 'pino';

let pinoConf = {
  /* this will show INFO or more severe */
  level: (process.env.PINO_LEVEL ?? "info"),
  formatters: {
    bindings: (bindings) => {
      return {
        pid: bindings.pid,
        // you can include other things, globally, here
        // node_ver: process.version
      };
    },
  },
};

const pinoTransport = pino.transport({
  targets: [
    {
      target: 'pino/file',
      options: { destination: `${__dirname}/app.log` },
    },
    {
      // stdout by default
      target: 'pino/file',
    },
  ]
});

if (process.env.NODE_ENV === "dev") {
  // you can do other specific things in here
  pinoConf.level = "trace";
}

// this do logging on a worker thread
// const log = pino(pinoConf, pinoTransport);

// this will do logging on the main thread
// const log = pino(pinoConf, pino.destination="pp.log");

// "The best performance for logging directly to stdout is
// usually achieved by using the default configuration:"
const log = pino(pinoConf);


process.on('uncaughtException', (err) => {
  logger.fatal(err);
  process.exit(1);
});

process.on('unhandledRejection', (err) => {
  logger.fatal(err);
  process.exit(1);
});

log.trace("::alice glass:: HI!");
log.debug("this is debug output");
log.info("this is info output");
log.warn("this is warn output");
log.error("this is error output");
log.fatal("this is fatal output");

log.info({PATH: process.env?.PATH, NODE_ENV: process.env?.NODE_ENV},
          "this is some info from process.env");

// demonstration of child logger
const sub = (someID) => {
  const slog = log.child({someID});
  slog.info(`sub invoked`);
  setTimeout(() => slog.info("sub finished"), 1000);
};

sub(850);
log.info("end of file");

/*
 * There are [specific directions](https://getpino.io/#/docs/web?id=pino-with-express)
 * for using pino with express, etc...
 */
