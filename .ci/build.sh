#!/bin/bash

export TRAVIS_TAG=8.5.1

if [ "${TRAVIS_OS_NAME}" = "linux" ]; then 
  ./gradlew check shadowJar -PVERSION=${TRAVIS_TAG};
else
  export JAVA_HOME="$(find /Library/Java/JavaVirtualMachines/ -type d -name jdk1.8.0_* | tail -n 1)/Contents/Home"
  # Skip tests that fail on osx without xvfb
  ./gradlew check shadowJar -PVERSION=${TRAVIS_TAG} -PexcludeTests="FXOMSaverUpdateImportInstructionsTest,StaticLoadTest,SkeletonBufferTest";  
fi

# Check if tag is present and run bundle script
if [ -n "${TRAVIS_TAG}" ]; then
  export VERSION=${TRAVIS_TAG};
  chmod +x .ci/${TRAVIS_OS_NAME}.sh;
  sh .ci/${TRAVIS_OS_NAME}.sh;
fi
