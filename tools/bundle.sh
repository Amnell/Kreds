#/bin/sh
tag=`git describe --abbrev=0 --tags`
zipPath="tools/packages/kreds-$tag.zip"
swift build -c release -Xswiftc -static-stdlib
zip "$zipPath" -j "./.build/release/kreds" "./License"
