#! /bin/bash

if [[ $GHCVER == "head" || -n "$SKIP_HADDOCK" ]]
  then
    DOCBUILD="echo 'Skipping docs...'"
  else
    DOCBUILD="$CABAL haddock"
fi

if [[ -n "$SKIP_TESTS" ]]
  then
    TESTBUILD="echo 'Skipping tests...'"
  else
    TESTBUILD="$CABAL test"
fi

$CABAL ${V1}configure --enable-tests --enable-benchmarks -v2 $CABAL_FLAGS\
  && $CABAL ${V1}build --ghc-options='-Wall -Werror -ddump-minimal-imports'\
  && $TESTBUILD\
  && $DOCBUILD\
  && $CABAL check\
  && $CABAL sdist

  # having trouble getting this to work, Cabal version mismatches etc.
  #  && packdeps `ls --color=never *.cabal`\
  #  && packunused\
