#! /bin/bash

HEAD_BRANCH=$(python travis/scripts/head_branch.py)\
  && for DEP in $HEAD_DEPS
     do
       echo "Cloning $DEP from github..."
       git clone --quiet git://github.com/diagrams/$DEP.git
       cd $DEP
       if git branch -a |grep -x "  remotes/origin/${HEAD_BRANCH}" > /dev/null; then git checkout ${HEAD_BRANCH}; fi
       cd ..
     done
