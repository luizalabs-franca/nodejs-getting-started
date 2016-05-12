#! /bin/bash


if ( [[ $TRAVIS_TEST_RESULT = 0 ]] && [[ $TRAVIS_PULL_REQUEST = "false" ]]);
then

      git config --global user.email "travis@luizalabs.com"
      git config --global user.name "Travis CI"

      # Release a prerelease version
      if ( [[ $TRAVIS_BRANCH = $PRE_RELEASE_BRANCH ]] );
      then
        npm version prerelease --git-tag-version -m "Pre Release %s [ci skip]" -f
      fi
      # Release a version
      if ( [[ $TRAVIS_BRANCH = $RELEASE_BRANCH ]] );
      then
        npm version patch --git-tag-version -m "Release %s [ci skip]" -f
      fi

      # Get updated build version
      BUILD_VERSION=$(node -pe 'JSON.parse(process.argv[1]).version' "$(cat $TRAVIS_BUILD_DIR/package.json)")

      # Build
      grunt build
      tar -zcvf nodejs-getting-started-$BUILD_VERSION.tar.gz dist

      export BUILD_VERSION

fi
