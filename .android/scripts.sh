#!/usr/bin/env sh

# https://wiki.archlinux.org/title/android
sudo pacman -S android-tools
~/.android/tools/bin/sdkmanager --install tools
~/.android/tools/bin/sdkmanager --install emulator
~/.android/tools/bin/sdkmanager "platforms;android-28"
~/.android/tools/bin/sdkmanager "system-images;android-28;google_apis;x86"

~/.android/tools/bin/avdmanager list
~/.android/tools/bin/avdmanager delete avd -n pixel
~/.android/tools/bin/avdmanager create avd -n pixel -k "system-images;android-28;google_apis;x86" --device "17"
~/.android/tools/bin/avdmanager create avd -n pixel-c -k "system-images;android-28;google_apis;x86" --device "18"

~/.android/emulator/emulator -list-avds
~/.android/emulator/emulator -avd pixel
