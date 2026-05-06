def unique-paths [entries: list<string>] {
  $entries | reduce -f [] {|entry, acc|
    if $entry in $acc {
      $acc
    } else {
      $acc | append $entry
    }
  }
}

def --env prepend-path [entry: string] {
  if not ($env.PATH | any {|path_entry| $path_entry == $entry }) {
    $env.PATH = ([$entry] | append $env.PATH)
  }
}

def --env add-path [entry: string] {
  if not ($env.PATH | any {|path_entry| $path_entry == $entry }) {
    $env.PATH = ($env.PATH | append $entry)
  }
}

$env.PATH = (unique-paths $env.PATH)

prepend-path $"($env.HOME)/.local/share/mise/shims"
add-path $"($env.HOME)/.local/bin"

# $env.CRUSH_DISABLE_PROVIDER_AUTO_UPDATE = "1"

if $nu.os-info.name == "linux" {
  $env.JAVA_HOME = "/usr/lib/jvm/default"
  $env.ANDROID_HOME = $"($env.HOME)/.android"
  $env.ANDROID_SDK_ROOT = $env.ANDROID_HOME
  $env.GOROOT = "/usr/lib/go"
  $env.GOPATH = $"($env.HOME)/go"
  $env.CARGO_HOME = $"($env.HOME)/.cargo"
  $env.DOTNET_ROOT = $"($env.HOME)/.dotnet"

  let extra_paths = [
    $"($env.ANDROID_HOME)/cmdline-tools/latest/bin"
    $"($env.ANDROID_HOME)/emulator"
    $"($env.ANDROID_HOME)/platform-tools"
    $"($env.ANDROID_HOME)/build-tools/33.0.2"
    $"($env.ANDROID_HOME)/tools"
    $"($env.ANDROID_HOME)/tools/bin"
    $"($env.GOROOT)/bin"
    $"($env.GOPATH)/bin"
    $"($env.HOME)/.cargo/bin"
    $"($env.HOME)/.dotnet/tools"
    $"($env.HOME)/csharp/netcoredbg"
    "/opt/cisco/secureclient/bin"
    "/opt/microsoft/microsoft-azurevpnclient"
  ]

  for entry in $extra_paths {
    add-path $entry
  }
}
