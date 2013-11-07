#! /bin/bash

$CABAL configure --enable-tests --enable-benchmarks -v2
$CABAL build --ghc-options='-Wall -Werror'
$CABAL test
$CABAL haddock
$CABAL check
$CABAL sdist
