#!/bin/bash

INSTALL_CMD="$CABAL install --enable-tests --enable-benchmarks --only-dependencies -j$NUM_CPU"

$CABAL update\
  && if ! [[ $GHCVER == "head" ]]
       then
         $CABAL install haddock -j$NUM_CPU
     fi\
  && if ! [[ -z "$EXTRA_DEPS_PRE" ]]
       then
         echo "Pre-installing extra dependencies: $EXTRA_DEPS_PRE"
         $CABAL install $EXTRA_DEPS_PRE -j$NUM_CPU
     fi\
  && if ! [[ -z "$HEAD_DEPS" ]]
       then
         echo "Installing HEAD dependencies: $HEAD_DEPS"
         for DEP in $HEAD_DEPS
         do
           DIRS="$DIRS $DEP/"
         done
         echo "$CABAL install $DIRS -j$NUM_CPU"
         $CABAL install $DIRS -j$NUM_CPU
     fi\
  && if ! [[ -z "$EXTRA_DEPS" ]]
       then
         echo "Installing extra dependencies: $EXTRA_DEPS"
         $CABAL install $EXTRA_DEPS -j$NUM_CPU
     fi\
  && echo $INSTALL_CMD\
  && $INSTALL_CMD --dry-run\
  && $INSTALL_CMD
