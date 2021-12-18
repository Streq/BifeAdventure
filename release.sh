#!/bin/bash
#get parameters
./increment_version.sh "$@"
godot --export "HTML5"
git add .
git stash
git checkout gh-pages || exit "$?"
git checkout stash -- .
git commit -m"release"
git push
git checkout main