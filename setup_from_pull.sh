#!/bin/bash

set -e

SOURCE=${BASH_SOURCE[0]}

# Handles symbolic links
# From: https://stackoverflow.com/a/246128
while [ -L "$SOURCE" ]; do
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE 
done

DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

# This script updates the repository before running.

git fetch
git pull

$DIR/setup_from_clone.sh
