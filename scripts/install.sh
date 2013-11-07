#!/bin/sh

$CABAL update

# install any dependencies checked out from git
if [[ -z "$HEAD_DEPS" ]]
  then
    for DEP in $HEAD_DEPS
    do
      DIRS="$DIRS $DEP/"
    done
    $CABAL install $DIRS
fi

$CABAL install --enable-tests --enable-benchmarks --only-dependencies -j$NUM_CPU
