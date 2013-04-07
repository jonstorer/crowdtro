#!/bin/sh

if [ ! "$(which parallel)" ]; then
  echo "ERROR: You need to install parallel (brew install parallel)"
  exit 1
fi

ErrorHandler () {
  (( errcount++ ))
}

trap ErrorHandler ERR

find features -type f -name '*.feature' | parallel --gnu "echo '\033[1;31mFeature: {}\033[m'; PORT=931{#} node ./node_modules/.bin/cucumber.js {} -t ~@wip"

exit $errcount
