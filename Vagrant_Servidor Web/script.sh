script.sh

#!/bin/bash

apt update
apt install -y nginx
service nginx restart