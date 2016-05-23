#! /bin/bash

function installSonnarScanner {
  mkdir ~/sonar-scanner
  curl -sSL https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-2.6.1.zip > /tmp/sonar-scanner.zip
  unzip /tmp/sonar-scanner.zip -d ~/sonar-scanner/
  rm -f /tmp/sonar-scanner.zip
}


function sonar {
  ~/sonar-scanner/sonar-scanner-2.6.1/bin/sonar-scanner \
          -Dsonar.analysis.mode=preview \
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
