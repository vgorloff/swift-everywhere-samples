#!/bin/bash

set -e

SaCurrentScriptName="$(basename ${BASH_SOURCE[0]})"
SaCurrentScriptDirPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [[ $SHELL =~ "zsh" ]]; then
	SaCurrentScriptDirPath=$(dirname $0:A)
fi
SaRooDirPath=$(cd "$(dirname "$SaCurrentScriptDirPath")"; pwd)
SaPropertiesFilePath=$SaRooDirPath/swiftToolchain.rc

if [ ! -f $SaPropertiesFilePath ]; then
    echo "File \"$SaPropertiesFilePath\" not found! Please refer to Readme.md file."
fi

source $SaPropertiesFilePath

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -target)
    SaArchTarget="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

case $SaArchTarget in
  armv7-none-linux-androideabi)
  SaNdkArch=armeabi-v7a
  ;;
  aarch64-unknown-linux-android)
  SaNdkArch=arm64-v8a
  ;;
  i686-unknown-linux-android)
  SaNdkArch=x86
  ;;
  x86_64-unknown-linux-android)
  SaNdkArch=x86_64
  ;;
esac

SaBuildDir="$SaRooDirPath/Android/app/build/swift"
SaOutputDir="$SaRooDirPath/Android/app/src/main/jniLibs/$SaNdkArch"

function copySoFile {
  SaDestinationFilePath="$SaOutputDir/`basename "$1"`"
  if [ "$1" -nt "$SaDestinationFilePath" ]; then
    cp -f "$1" "$SaDestinationFilePath"
  fi
}

cd "$SaRooDirPath/Package"

"$SaSwiftToolchainDirPath/usr/bin/android-swift-build" -target $SaArchTarget --build-path "$SaBuildDir" "$@"
"$SaSwiftToolchainDirPath/usr/bin/android-copy-libs" -target $SaArchTarget -output $SaOutputDir
SaBinPath=$("$SaSwiftToolchainDirPath/usr/bin/android-swift-build" -target $SaArchTarget --build-path "$SaBuildDir" "$@" --show-bin-path)

for SaFilePath in `find "$SaBinPath" -type f -iname *.so -print`; do
  copySoFile "$SaFilePath"
done
