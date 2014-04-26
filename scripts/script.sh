#! /bin/bash

if [[ $GHCVER == "head" || -n "$SKIP_HADDOCK" ]]
  then
    DOCBUILD="echo 'Skipping docs...'"
  else
    DOCBUILD="$CABAL haddock"
fi

$CABAL configure --enable-tests --enable-benchmarks -v2 $CABAL_FLAGS\
  && $CABAL build --ghc-options='-Wall -Werror -ddump-minimal-imports'\
  && $CABAL test\
  && packdeps\
  && packunused\
  && $DOCBUILD\
  && $CABAL check\
  && $CABAL sdist
