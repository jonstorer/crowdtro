#!/usr/bin/env sh

find features -type f -name '*.feature' | xargs node ./node_modules/.bin/cucumber.js -t ~@wip
