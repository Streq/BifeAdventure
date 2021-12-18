#!/bin/bash
git checkout gh-pages || exit "$?"
git merge main --no-edit || exit "$?"
godot --export "HTML5"
git add .
git commit -m"version 0"
git push
git checkout main