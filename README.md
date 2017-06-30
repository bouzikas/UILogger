### Build Framework

You need a machine running MacOSX and [XCode] installed in order to build the Framework.

```sh
$ git clone PATH_TO_REPO UILogger
$ cd UILogger
```
```
$ xcodebuild -target "UILogger" ONLY_ACTIVE_ARCH=NO -configuration Debug -sdk iphoneos BUILD_DIR="build" BUILD_ROOT=pwd clean build
```
```
$ xcodebuild -target "UILogger" ONLY_ACTIVE_ARCH=NO -configuration Debug -sdk iphonesimulator -arch i386 BUILD_DIR="build" BUILD_ROOT=pwd clean build
```
```
$ mv "build/Debug-iphonesimulator/UILogger.framework" "build/Debug-iphonesimulator/i386_UILogger.framework"
```
```
$ xcodebuild -target "UILogger" ONLY_ACTIVE_ARCH=NO -configuration Debug -sdk iphonesimulator -arch x86_64 BUILD_DIR="build" BUILD_ROOT=pwd clean build
```
```
$ mv "build/Debug-iphonesimulator/UILogger.framework" "build/Debug-iphonesimulator/x86_64_UILogger.framework"
$ mkdir build/Debug-universal
$ cp -R "build/Debug-iphoneos/UILogger.framework" "build/Debug-universal/UILogger.framework"
```
```
$ lipo -create -output "build/Debug-universal/UILogger.framework/UILogger" "build/Debug-iphonesimulator/i386_UILogger.framework/UILogger" "build/Debug-iphonesimulator/x86_64_UILogger.framework/UILogger" "build/Debug-iphoneos/UILogger.framework/UILogger"
```