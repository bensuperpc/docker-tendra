#!/bin/bash
set -ue
OLD_IMAGE_NAME="<<IMAGE_NAME>>"
NEW_IMAGE_NAME="$1"
find . -type f -name "*" ! -path ".git" ! -path "$0" -print0 | xargs -0 sed -i "s/$OLD_IMAGE_NAME/$NEW_IMAGE_NAME/g"

if [ ! $2 -eq 0 ]
    OLD_COMPILER_NAME="<<IMAGE_COMPILER>>"
    NEW_COMPILER_NAME="$2"
    find . -type f -name "*" ! -path ".git" ! -path "$0" -print0 | xargs -0 sed -i "s/$OLD_COMPILER_NAME/$NEW_COMPILER_NAME/g"
fi

if [ ! $3 -eq 0 ]
    OLD_GIT_URL="<<GIT_URL>>"
    NEW_GIT_URL="$3"
    find . -type f -name "*" ! -path ".git" ! -path "$0" -print0 | xargs -0 sed -i "s/$OLD_GIT_URL/$NEW_GIT_URL/g"
fi