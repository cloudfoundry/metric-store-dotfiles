#!/bin/bash

DIR=$(dirname $0)
TARGET=$HOME/workspace
REPOS=`cat $DIR/assets/repo-list`
OSS_REPOS=`cat $DIR/assets/oss-repo-list`

ssh -o StrictHostKeyChecking=false -T git@github.com;
SSH_STATUS=$?;

if [[ $SSH_STATUS != 1 ]]; then
    echo "Please check that you have correctly loaded your GitHub SSH key";
    return $SSH_STATUS;
fi;

mkdir -p $TARGET;

for r in $REPOS
do
  REPO=${r#*/}
  test -d $TARGET/$REPO || git clone --recursive git@github.com:$r.git $TARGET/$REPO
done;

TARGET=$HOME/workspace/oss
mkdir -p $TARGET;
for r in $OSS_REPOS
do
  REPO=${r#*/}
  test -d $TARGET/$REPO || git clone --recursive git@github.com:$r.git $TARGET/$REPO
done;
