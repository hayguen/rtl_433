#!/bin/bash
V=$(git describe --dirty --always --tags)
echo git version: $V
echo writing version to ../src/git_version.h

cat - <<EOF >../src/git_version.h
#define HAVE_GIT_VER  1
#define GIT_VERSION "${V}"
EOF

echo "contents:"
cat ../src/git_version.h
