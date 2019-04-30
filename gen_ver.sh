#!/bin/sh

# Input parameters
version="$1"

rm -rf ${version}
mkdir -p ${version}
cp -r libuuu uuu CMakeLists.txt LICENSE README.md ${version}

# Generate version string
mkdir -p ${version}/libuuu/gen
echo "#define GIT_VERSION \"lib$version\"" > ${version}/libuuu/gen/gitversion.h

COPYFILE_DISABLE=true tar -czvf ${version}.tar.gz ${version}
rm -rf ${version}
