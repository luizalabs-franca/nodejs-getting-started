#! /bin/bash


if ([ $TRAVIS_BRANCH == $DEV_BRANCH ] && [ $TRAVIS_PULL_REQUEST == "false" ]); then


      git config --global user.email "travis@luizalabs.com"
      git config --global user.name "Travis CI"

      # Release a prerelease version
      npm version prerelease --git-tag-version -m "Pre Release %s [ci skip]" -f

      # Get updated build version
      BUILD_VERSION=$(node -pe 'JSON.parse(process.argv[1]).version' "$(cat $TRAVIS_BUILD_DIR/package.json)")

      git push --quiet "https://${GITHUB_TOKEN}@github.com/${TRAVIS_REPO_SLUG}"
      git push --quiet "https://${GITHUB_TOKEN}@github.com/${TRAVIS_REPO_SLUG}" --tags

      # Build
      grunt build
      tar -zcvf nodejs-getting-started-$BUILD_VERSION.tar.gz dist
      
      export BUILD_VERSION

fi
