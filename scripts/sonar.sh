#! /bin/bash

set -euo pipefail

function installSonnarScanner {
  mkdir ~/sonar-scanner
  curl -sSL https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-2.6.1.zip | tar -xvf- --strip-components 1 -C ~/sonar-scanner

}


function sonar {
  ~/sonar-scanner/bin/sonar-scanner \
          -Dsonar.github.pullRequest=$TRAVIS_PULL_REQUEST \
          -Dsonar.github.repository=$TRAVIS_REPO_SLUG \
          -Dsonar.github.oauth=$GITHUB_TOKEN \
          -Dsonar.host.url=$SONAR_HOST_URL \
          -Dsonar.login=$SONAR_TOKEN \
          -Dsonar.projectKey=$TRAVIS_REPO_SLUG \
          -Dsonar.projectName=$(node -pe 'JSON.parse(process.argv[1]).name' "$(cat $TRAVIS_BUILD_DIR/package.json)") \
          -Dsonar.projectVersion=$(node -pe 'JSON.parse(process.argv[1]).version' "$(cat $TRAVIS_BUILD_DIR/package.json)")
}


if ([[ $TRAVIS_PULL_REQUEST != "false" ]]);
then
  installSonnarScanner
  sonar
fi
