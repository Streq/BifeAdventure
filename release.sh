#!/bin/bash
#get parameters
VERSION = minor
while getopts v: flag
do
  case "${flag}" in
    v) VERSION=${OPTARG};;
  esac
done
git checkout gh-pages || exit "$?"
git merge main --no-edit || exit "$?"
godot --export "HTML5"
git add .
git commit -m"release"
./increment_version.sh -v ${VERSION}
git checkout main