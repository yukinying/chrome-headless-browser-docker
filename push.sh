#!/bin/bash
set -ev

# Push Google Chrome (AMD64 only)
if [ "$TRAVIS_BRANCH" == "master" ] && [ "$VERSION0" != "$VERSION1" ] && [ "$TARGET" == "Chrome" ]; then
  echo "docker push $REPO:$VERSION1";
  docker push $REPO:latest;
  docker push $REPO:$VERSION1;
fi

export DOCKER_CLI_EXPERIMENTAL=enabled
# Debian Chromium has multiple architecture pre-built.
if [ "$TRAVIS_BRANCH" == "master" ] && [ "$VERSION0" != "$VERSION1" ] && [ "$TARGET" == "Chromium" ]; then
  echo "docker push $REPO-$ARCH:$VERSION1";
  docker push $REPO-$ARCH:latest;
  docker push $REPO-$ARCH:$VERSION1;
  echo "docker manifest create $REPO:latest";
  docker manifest create   $REPO:latest $REPO-amd64:latest $REPO-arm64:latest;
  docker manifest annotate $REPO:latest $REPO-amd64:latest --arch amd64;
  docker manifest annotate $REPO:latest $REPO-arm64:latest --arch arm64;
  docker manifest push     $REPO:latest;
fi

# Debian Chromium only: Create manifest in the end and combine the architecture.
if [ "$TRAVIS_BRANCH" == "master" ] && [ "$VERSION0" != "$VERSION1" ] && [ "$TARGET" == "Chromium" ] && [ "$ARCH" == "arm64" ]; then
  echo "docker manifest create $REPO:$VERSION1";
  docker manifest create   $REPO:$VERSION1 $REPO-amd64:$VERSION1 $REPO-arm64:$VERSION1;
  docker manifest annotate $REPO:$VERSION1 $REPO-amd64:$VERSION1 --arch amd64;
  docker manifest annotate $REPO:$VERSION1 $REPO-arm64:$VERSION1 --arch arm64;
  docker manifest push     $REPO:$VERSION1;
fi
