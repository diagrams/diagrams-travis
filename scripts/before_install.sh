#! /bin/bash

# Use hvr's PPA of up-to-date GHC packages
sudo add-apt-repository -y ppa:hvr/ghc
sudo apt-get update
sudo apt-get install cabal-install-$CABALVER ghc-$GHCVER

if ! [[ -z "$UBUNTU_PKGS" ]]
  then
    echo "Installing Ubuntu packages: $UBUNTU_PKGS"
    sudo apt-get install $UBUNTU_PKGS
fi

for DEP in $HEAD_DEPS
do
  echo "Cloning $DEP from github..."
  git clone --quiet git://github.com/diagrams/$DEP.git
  cd $DEP
  if git branch -a |grep -x "  remotes/origin/${TRAVIS_BRANCH}" > /dev/null; then git checkout ${TRAVIS_BRANCH}; fi
  cd ..
done
