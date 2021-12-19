#!/bin/bash
./require_clean_work_tree.sh || exit "$?"
./increment_version.sh "$@"
godot --export "HTML5"
git add .
git stash
git checkout gh-pages || exit "$?"
git rm -rf .
git checkout HEAD -- .gitignore
git stash pop
git commit -m"release"
git push
git checkout main