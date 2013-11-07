#!/bin/sh

$CABAL update
$CABAL install haddock -j$NUM_CPU
$CABAL install --enable-tests --enable-benchmarks --only-dependencies -j$NUM_CPU
