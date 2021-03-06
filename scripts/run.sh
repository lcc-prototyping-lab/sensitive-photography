#!/bin/bash

DIR1="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -z "$1" ] || [ "$1" != "nogit" ]
then
  cd $DIR1/../ && git stash && git pull origin master
fi

# Change config.
sed -i '' "s/gfoote/${USER}/g" $DIR1/../node-red/flows.json
sed -i '' "s/gfoote/${USER}/g" $DIR1/../node-red/flows_cred.json

# Restart node-red
sleep 5
cd $DIR1/../node-red && npm install
sleep 10
echo "node: `node --version`"
echo "node-red: `which node-red`"
cd $DIR1/../node-red && ./run.sh

# Images directory.
mkdir ~/Desktop/audio/

sleep 10
open http://127.0.0.1:1880/
sleep 2
open ${DIR1}/../processing/ui/application.macosx/ui.app

