#!/usr/bin/env sh

curl -O https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
unzip commandlinetools-linux-11076708_latest.zip
rm commandlinetools-linux-11076708_latest.zip
# had to move into "latest" directory

# https://wiki.archlinux.org/title/java
sudo pacman -S jdk-openjdk
sudo pacman -S android-tools

~/.android/tools/bin/sdkmanager --list | grep build-tools
~/.android/tools/bin/sdkmanager --list | grep system-images

# https://wiki.archlinux.org/title/android
sdkmanager --update
sdkmanager --install tools
sdkmanager --install emulator
sdkmanager "platform-tools"
sdkmanager "build-tools;33.0.2"
sdkmanager "platforms;android-33"
sdkmanager "system-images;android-33;google_apis;x86_64"

~/.android/tools/bin/avdmanager list
~/.android/tools/bin/avdmanager delete avd -n pixel
~/.android/tools/bin/avdmanager create avd -n pixel -k "system-images;android-33;google_apis;x86_64" --device "17"

~/.android/emulator/emulator -list-avds
/home/natsu/.android/emulator/emulator -gpu host -avd pixel
/home/natsu/.android/emulator/emulator -gpu host -avd pixel -no-snapshot-load
