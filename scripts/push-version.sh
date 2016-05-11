#! /bin/bash

git config --global user.email "travis@luizalabs.com"
git config --global user.name "Travis CI"
git push --quiet "https://${GITHUB_TOKEN}@github.com/${TRAVIS_REPO_SLUG}"
git push --quiet "https://${GITHUB_TOKEN}@github.com/${TRAVIS_REPO_SLUG}" --tags
