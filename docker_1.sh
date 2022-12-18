#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

./docker_create_image.sh
./docker_push.sh
./docker_restart.sh

