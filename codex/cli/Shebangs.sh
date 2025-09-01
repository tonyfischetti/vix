# shell scripting, bash scripting, shebang, env, -S

# env uses $PATH (and environment)

#!/usr/bin/env bash

#!/usr/bin/env -S head -n 4
#
# without `-S`,
#   `env`, will treat `head -n 4` will be treated as one big argument




