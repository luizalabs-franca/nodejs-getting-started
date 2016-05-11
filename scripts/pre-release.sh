#! /bin/bash


if ([ $TRAVIS_BRANCH == $DEV_BRANCH ] && [ $TRAVIS_PULL_REQUEST == "false" ]); then

      # Release a prerelease version
      npm version prerelease --git-tag-version -m "Pre Release %s [ci skip]"

      git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages > /dev/null 2>&1

      # Get updated build version
      BUILD_VERSION=$(node -pe 'JSON.parse(process.argv[1]).version' "$(cat $TRAVIS_BUILD_DIR/package.json)")

      git push --quiet "https://${GITHUB_TOKEN}@github.com/${TRAVIS_REPO_SLUG}"
      git push --quiet "https://${GITHUB_TOKEN}@github.com/${TRAVIS_REPO_SLUG}" --tags

fi
