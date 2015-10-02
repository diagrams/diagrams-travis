#! /bin/bash

if ! [[ -z "$UBUNTU_PKGS" ]]
       then
	 echo "Installing Ubuntu packages: $UBUNTU_PKGS"
	 sudo apt-get install $UBUNTU_PKGS
     fi\
  && HEAD_BRANCH=$(python travis/scripts/head_branch.py)\
  && for DEP in $HEAD_DEPS
     do
       echo "Cloning $DEP from github..."
       git clone --quiet git://github.com/diagrams/$DEP.git
       cd $DEP
       if git branch -a |grep -x "  remotes/origin/${HEAD_BRANCH}" > /dev/null; then git checkout ${HEAD_BRANCH}; fi
       cd ..
     done

  # Uncomment whenever hackage is down --- doesn't actually work
  # because travis does its own 'cabal update' before even calling our
  # scripts =(

  # && mkdir -p ~/.cabal && cp travis/config ~/.cabal/config && $CABAL update
