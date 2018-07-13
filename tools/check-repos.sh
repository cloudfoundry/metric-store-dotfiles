#!/bin/bash

TOP_DIR=~/workspace

for metadir in $(find $TOP_DIR -name .git); do
    (
        cd ${metadir%.git}
        git diff-index --quiet HEAD --
        if [[ $? -ne 0 ]]; then
            echo "${metadir%.git} has uncommitted changes"
            echo
        fi
    )
done

