#!/bin/sh

$CABAL update
$CABAL install --enable-tests --enable-benchmarks --only-dependencies -j$NUM_CPU
