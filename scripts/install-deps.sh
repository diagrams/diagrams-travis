$CABAL update\
  && $CABAL install alex happy -j$NUM_CPU\
  && if ! [[ $GHCVER == "head" ]]
       then
         $CABAL install haddock -j$NUM_CPU
     fi\
  && if ! [[ -z "$EXTRA_DEPS_PRE" ]]
       then
         echo "============================================================"
         echo "Pre-installing extra dependencies: $EXTRA_DEPS_PRE"
	 EXTRA_DEPS_PRE_INSTALL="$CABAL install $EXTRA_DEPS_PRE $CABAL_CONSTRAINTS -j$NUM_CPU"
	 echo $EXTRA_DEPS_PRE_INSTALL
	 $EXTRA_DEPS_PRE_INSTALL --dry-run -v3
	 $EXTRA_DEPS_PRE_INSTALL
     fi\
  && if ! [[ -z "$HEAD_DEPS" ]]
       then
         echo "============================================================"
         echo "Installing HEAD dependencies: $HEAD_DEPS"
         for DEP in $HEAD_DEPS
         do
           DIRS="$DIRS $DEP/"
         done
         HEAD_DEPS_INSTALL="$CABAL install $DIRS $CABAL_CONSTRAINTS -j$NUM_CPU"
	 echo $HEAD_DEPS_INSTALL
	 $HEAD_DEPS_INSTALL --dry-run -v3
         $HEAD_DEPS_INSTALL
     fi\
  && if ! [[ -z "$EXTRA_DEPS" ]]
       then
         echo "============================================================"
         echo "Installing extra dependencies: $EXTRA_DEPS"
	 EXTRA_DEPS_INSTALL="$CABAL install $EXTRA_DEPS $CABAL_CONSTRAINTS -j$NUM_CPU"
	 echo $EXTRA_DEPS_INSTALL
	 $EXTRA_DEPS_INSTALL --dry-run -v3
	 $EXTRA_DEPS_INSTALL
     fi\
