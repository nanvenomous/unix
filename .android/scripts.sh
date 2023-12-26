#!/usr/bin/env sh

# https://wiki.archlinux.org/title/java
sudo pacman -S jdk8-openjdk

~/.android/tools/bin/sdkmanager --list | grep build-tools
~/.android/tools/bin/sdkmanager --list | grep system-images

# https://wiki.archlinux.org/title/android
sudo pacman -S android-tools
~/.android/tools/bin/sdkmanager --update
~/.android/tools/bin/sdkmanager --install tools
~/.android/tools/bin/sdkmanager --install emulator
~/.android/tools/bin/sdkmanager "platform-tools"
~/.android//tools/bin/sdkmanager "build-tools;33.0.2"
~/.android/tools/bin/sdkmanager "platforms;android-33"
~/.android/tools/bin/sdkmanager "system-images;android-33;google_apis;x86_64"

~/.android/tools/bin/avdmanager list
~/.android/tools/bin/avdmanager delete avd -n pixel
~/.android/tools/bin/avdmanager create avd -n pixel -k "system-images;android-33;google_apis;x86_64" --device "17"

~/.android/emulator/emulator -list-avds
/home/natsu/.android/emulator/emulator -gpu host -avd pixel
/home/natsu/.android/emulator/emulator -gpu host -avd pixel -no-snapshot-load
