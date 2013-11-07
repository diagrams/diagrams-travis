#!/bin/bash

$CABAL update
$CABAL install haddock -j$NUM_CPU

# install any dependencies checked out from git
if ! [[ -z "$HEAD_DEPS" ]]
  then
    echo "Installing HEAD dependencies: $HEAD_DEPS"
    for DEP in $HEAD_DEPS
    do
      DIRS="$DIRS $DEP/"
    done
    echo "$CABAL install $DIRS -j$NUM_CPU"
    $CABAL install $DIRS -j$NUM_CPU
fi

if ! [[ -z "$EXTRA_DEPS" ]]
  then
    echo "Installing extra dependencies: $EXTRA_DEPS"
    $CABAL install $EXTRA_DEPS -j$NUM_CPU
fi

$CABAL install --only-dependencies -j$NUM_CPU
