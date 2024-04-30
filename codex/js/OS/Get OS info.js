import * as os from 'node:os';

const info = {
  cpus: os.cpus(),
  EOL: os.EOL,
  availParallel: os.availableParallelism(),
  endianness: os.endianness(),
  homedir: os.homedir(),
  hostname: os.hostname(),
  machine: os.machine(),
  platform: os.platform(),
  release: os.release(),
  tmpdir: os.tmpdir(),
  totalmem: os.totalmem(),
  ostype: os.type(),
  uptime: os.uptime(),
  osversion: os.version()
};

console.log(JSON.stringify(info, null, 2));
