#!/bin/sh
if [[ "$TRAVIS_PULL_REQUEST" != "false" ]]; then
  exit 0
fi
if [[ "$TRAVIS_BRANCH" != "develop" ]]; then
  exit 0
fi

rm -rf ./build/*
xcodebuild -workspace Fezaar.xcworkspace -scheme Fezaar -sdk iphoneos -configuration Release CODE_SIGN_IDENTITY='iPhone Distribution: Tomohiro Matsumura' archive -archivePath ./build/Fezaar.xcarchive
xcodebuild -exportArchive -exportFormat IPA -archivePath ./build/Fezaar.xcarchive -exportPath ./build/Fezaar.ipa -exportProvisioningProfile 'FezaarAdHoc'
