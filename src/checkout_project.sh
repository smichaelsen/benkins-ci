#!/usr/bin/env sh

echo "\nChecking out ${BRANCH} branch of ${REPOSITORY_URL} to local workspace: ${LOCAL_WORKSPACE}"

# clear workspace if it is safe
case $LOCAL_WORKSPACE/ in
  $PWD/*) echo "Clearing workspace"; rm -rf $LOCAL_WORKSPACE;;
  *) echo "Local workspace is not safe to delete! Aborting."; exit 200;;
esac

# checkout project in workspace
git clone -b $BRANCH --depth 1 $REPOSITORY_URL $LOCAL_WORKSPACE
