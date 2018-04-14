#! /bin/bash

# Use hvr's PPA of up-to-date GHC packages
sudo add-apt-repository -y ppa:hvr/ghc\
  && sudo apt-get update\
  && rm -f ~/.cabal/config\
  && sudo apt-get install cabal-install-$CABALVER ghc-$GHCVER\
  && if ! [[ -z "$UBUNTU_PKGS" ]]
       then
	 echo "Installing Ubuntu packages: $UBUNTU_PKGS"
	 sudo apt-get install $UBUNTU_PKGS
     fi\
  && echo 'rm -rf /home/travis/.cabal/config' && rm -rf /home/travis/.cabal/config\
  && travis/scripts/git_deps.sh

 # Uncomment whenever hackage is down --- doesn't actually work
  # because travis does its own 'cabal update' before even calling our
  # scripts =(

  # && mkdir -p ~/.cabal && cp travis/config ~/.cabal/config && $CABAL update
