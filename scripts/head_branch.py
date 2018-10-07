import json
import sys
import urllib
import os

if os.environ['TRAVIS_PULL_REQUEST']=='false':
    # For non-pull-request commits, Travis knows the branch name
    print(os.environ['TRAVIS_BRANCH'])
else:
    # If this is a pull request, get the name of the HEAD (source)
    # branch from github
    url = "https://api.github.com/repos/{0}/pulls/{1}".format(
        os.environ['TRAVIS_REPO_SLUG'],
        os.environ['TRAVIS_PULL_REQUEST'] )
    req = urllib.urlopen(url)
    if req.getcode() < 200 or req.getcode() >= 300:
        raise Exception(
            "pull request lookup error: code {}: body {}".format(
                req.getcode(), req.read()))
    j = json.load(req)
    # should we check here that the head is actually from the same
    # repo, not a fork?
    print(j['head']['ref'])
