#!/bin/bash
git checkout gh-pages
git merge main --no-edit
godot --export "HTML5"
git add .
git commit -m"version 0"
git push
git checkout main