#!/bin/bash

$CABAL update
$CABAL install haddock -j$NUM_CPU

echo "Installing HEAD dependencies: $HEAD_DEPS"
# install any dependencies checked out from git
if ! [[ -z "$HEAD_DEPS" ]]
  then
    for DEP in $HEAD_DEPS
    do
      DIRS="$DIRS $DEP/"
    done
    echo "$CABAL install $DIRS"
    $CABAL install $DIRS -j$NUM_CPU
fi

$CABAL install --only-dependencies -j$NUM_CPU
