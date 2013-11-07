#!/bin/bash

$CABAL update
$CABAL install haddock -j$NUM_CPU

echo "Installing HEAD dependencies: $HEAD_DEPS"
# install any dependencies checked out from git
if [[ -z "$HEAD_DEPS" ]]
  then
    echo "HEAD_DEPS is non-null"
    for DEP in $HEAD_DEPS
    do
      DIRS="$DIRS $DEP/"
    done
    echo $DIRS
    echo "$CABAL install $DIRS"
    $CABAL install $DIRS
fi

$CABAL install --enable-tests --enable-benchmarks --only-dependencies -j$NUM_CPU
