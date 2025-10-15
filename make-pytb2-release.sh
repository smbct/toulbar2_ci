#!/bin/bash

echo -n "pytoulbar2 version:"
read ver

echo -n "Release Message:"
read mes
git pull --rebase

if output=$(git status --porcelain) && [ -z "$output" ]; then
    sed -i "s/version=.*/version=\"$ver\", # hash $(git rev-parse HEAD) /" setup.py
    git add setup.py
    git commit -m "[pytoulbar2 release] Update pytoulbar2 version for release $ver"
    git tag -a pytb2-v$ver -m"$mes"
    git push --no-verify
    git push --tags --no-verify
else
    echo "Git status is not clean. Will not tag!"
    exit 1
fi