#! /bin/sh

# Use hvr's PPA of up-to-date GHC packages
sudo add-apt-repository -y ppa:hvr/ghc
sudo apt-get update
sudo apt-get install cabal-install-$CABALVER ghc-$GHCVER

for DEP in $HEAD_DEPS
do
  git clone --quiet git://github.com/diagrams/$DEP.git
  cd $DEP
  if git branch -a |grep -x "  remotes/origin/${TRAVIS_BRANCH}" > /dev/null; then git checkout ${TRAVIS_BRANCH}; fi
  cd ..
done
