docker build -t knet .

#!/bin/bash
script_dir="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
$script_dir/run_docker.sh  run -i -t -p 5000:8080  -v $script_dir/workdir:/kb/module/work knet

