#!/bin/sh

set -e

docker run -v $HOME/.gitconfig:/root/.gitconfig -v $PWD:/work -w /work --rm -ti obolibrary/odkfull:v1.2.27 /tools/odk.py seed "$@"
