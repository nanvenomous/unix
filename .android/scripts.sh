#!/usr/bin/env sh

# https://wiki.archlinux.org/title/java
sudo pacman -S jdk8-openjdk

# https://wiki.archlinux.org/title/android
~/.android/tools/bin/sdkmanager --list | grep build-tools
sudo pacman -S android-tools
~/.android/tools/bin/sdkmanager --update
~/.android/tools/bin/sdkmanager --install tools
~/.android/tools/bin/sdkmanager --install emulator
~/.android/tools/bin/sdkmanager "platform-tools"
~/.android//tools/bin/sdkmanager "build-tools;30.0.3"
~/.android/tools/bin/sdkmanager "platforms;android-34"
~/.android/tools/bin/sdkmanager "system-images;android-30;google_apis;x86"

~/.android/tools/bin/avdmanager list
~/.android/tools/bin/avdmanager delete avd -n pixel
~/.android/tools/bin/avdmanager create avd -n pixel -k "system-images;android-30;google_apis;x86" --device "17"
~/.android/tools/bin/avdmanager create avd -n pixel-c -k "system-images;android-30;google_apis;x86" --device "18"

~/.android/emulator/emulator -list-avds
~/.android/emulator/emulator -avd pixel
