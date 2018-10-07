$CABAL update\
  && if ! [[ -n $SKIP_TOOLS ]]
       then
         $CABAL install alex happy cpphs -j$NUM_CPU
     fi\
  && if ! [[ $GHCVER == "head" || -n $SKIP_HADDOCK ]]
       then
         $CABAL install $CABAL_CONSTRAINTS haddock -j$NUM_CPU
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
  && $CABAL sandbox init\
  && if ! [[ -z "$HEAD_DEPS" ]]
       then
         echo "============================================================"
         echo "Registering HEAD dependencies: $HEAD_DEPS"
         ADD_SOURCE="$CABAL sandbox add-source $HEAD_DEPS"
         echo $ADD_SOURCE
         $ADD_SOURCE
     fi\
  && echo "Installing dependencies"\
  && DEPS_INSTALL="$CABAL install  --enable-tests --enable-benchmarks --only-dependencies $CABAL_FLAGS $CABAL_CONSTRAINTS -j$NUM_CPU"\
  && echo $DEPS_INSTALL\
  && $DEPS_INSTALL --dry-run -v3\
  && $DEPS_INSTALL\
  && if ! [[ -z "$EXTRA_DEPS" ]]
       then
         echo "============================================================"
         echo "Installing extra dependencies: $EXTRA_DEPS"
	 EXTRA_DEPS_INSTALL="$CABAL install $EXTRA_DEPS $CABAL_CONSTRAINTS -j$NUM_CPU"
	 echo $EXTRA_DEPS_INSTALL
	 $EXTRA_DEPS_INSTALL --dry-run -v3
	 $EXTRA_DEPS_INSTALL
     fi\
