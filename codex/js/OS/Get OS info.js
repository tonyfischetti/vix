import * as os from 'node:os';

const info = {
  cpus: os.cpus(),                            // (detailed object)
  EOL: os.EOL,                                // "\n"
  availParallel: os.availableParallelism(),   // 8
  endianness: os.endianness(),                // LE
  homedir: os.homedir(),
  hostname: os.hostname(),
  machine: os.machine(),                      // {"x86_64", "aarch64"}
  platform: os.platform(),                    // {'linux', 'android', 'aix', 'darwin', 'freebsd', 'openbsd', 'sunos', 'win32'}
  release: os.release(),                      // {"6.1.0-18-amd64", "5.15.123-android13-8-28577312-abS918USQS2CXCN"}
  tmpdir: os.tmpdir(),                        // "/tmp/user/1000"
  totalmem: os.totalmem(),
  ostype: os.type(),                          // "Linux"
  uptime: os.uptime(),
  osversion: os.version(),                    // "#1 SMP PREEMPT_DYNAMIC Debian 6.1.76-1 (2024-02-01)"
  userinfo: os.userInfo(),                    // (uid, gid, username, shell)
  network: os.networkInterfaces(),            // (detailed object)
  devnull: os.devNull,                        // "/dev/null"
  osconstants: os.constants                   // (priority, signal, error xwalk)
};

console.log(JSON.stringify(info, null, 2));

/*** PROCESS INFO *********************************/

const startUsage = process.cpuUsage();
const startTime = process.hrtime.bigint();        // high resolution time (nanoseconds) [seconds * 1e9]

const info = {
  arch: process.arch,                             // "x64"
  argv: process.argv,
  argv0: process.argv0,
  config: process.config,                         // (node configuration)
  constrainedmemory: process.constrainedMemory(),
  availablememory: process.availableMemory(),
  cwd: process.cwd(),
  env: process.env                                // all environment variables { eg. PATH, SHELL, ZOS, TMUX, SSH_AGENT_PID, XDG_CONFIG_HOME, HOME, LANG, TERM, TMUX_PANE, ZCONTEXT }
  execpath: process.execPath,
  execargv: process.execArgv,
  memusage: process.memoryUsage(),                // { rss, heapTotal, heapUsed, external, arrayBuffers }
  pid: process.pid,
  parentpid: process.ppid,
  platform: process.platform,                     // { 'linux', 'android', 'aix', 'darwin', 'freebsd', 'openbsd', 'sunos', 'win32' }
  release: process.release,                       // info about node release (sourceUrl, etc...)
  resourceusage: process.resourceUsage(),         // { userCPUTime, maxRSS, swappedOut, voluntaryContextSwitches, involuntaryContextSwitches, etc...) }
  title: process.title,
  uptime: process.uptime(),                       // AGE OF THE PROCESS
  nodedepsversions: process.versions,
};

info.cpuusage = process.cpuUsage(startUsage);               // { user, system }
info.time = Number(process.hrtime.bigint() - startTime);    // has to be above Number.MAX_SAFE_INTEGER

console.log(JSON.stringify(info, null, 2));
