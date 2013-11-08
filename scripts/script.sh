#! /bin/bash

if [[ $GHCVER == "head" ]]
  then
    DOCBUILD="echo 'Skipping docs under GHC HEAD...'"
  else
    DOCBUILD="$CABAL haddock"
fi

$CABAL configure --enable-tests --enable-benchmarks -v2 $CABAL_FLAGS\
  && $CABAL build --ghc-options='-Wall -Werror'\
  && $CABAL test\
  && $DOCBUILD\
  && $CABAL check\
  && $CABAL sdist
