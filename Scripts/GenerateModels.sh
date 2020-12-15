#!/bin/bash

set -e

SaCurrentScriptDirPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [[ $SHELL =~ "zsh" ]]; then
	SaCurrentScriptDirPath=$(dirname $0:A)
fi

SaRooDirPath=$(cd "$(dirname "$SaCurrentScriptDirPath")"; pwd)

# See: swift-protobuf/PLUGIN.md at master · apple/swift-protobuf: https://github.com/apple/swift-protobuf/blob/master/Documentation/PLUGIN.md#generation-option-visibility---visibility-of-generated-types
protoc -I=$SaRooDirPath/Models --swift_opt=Visibility=Public --swift_out=$SaRooDirPath/Package/Sources/saModels $SaRooDirPath/Models/addressbook.proto
