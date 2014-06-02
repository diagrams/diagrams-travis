#!/bin/bash

INSTALL_CMD="$CABAL install --enable-tests --enable-benchmarks --only-dependencies $CABAL_FLAGS $CABAL_CONSTRAINTS -j$NUM_CPU"

./travis/scripts/install-deps.sh\
  # && echo "============================================================"\
  # && $CABAL install $CABAL_FLAGS $CABAL_CONSTRAINTS -j$NUM_CPU packunused packdeps\
  # && echo "============================================================"\
  && echo "Installing test dependencies"\
  && echo $INSTALL_CMD\
  && $INSTALL_CMD --dry-run -v3\
  && $INSTALL_CMD
