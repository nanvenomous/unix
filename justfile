# see fastfetch system info
default:
  #!/usr/bin/env bash
  fastfetch 

# battery health statistics
battery:
  #!/usr/bin/env bash
  battery

# changes resolution in brave and foot terminal font size, kills all terminals
size:
  #!/usr/bin/env nu
  let font = "JetBrainsMono Nerd Font Mono"

  mut size = 0
  loop {
      let raw = input "Font size (8-20): "
      try {
          let n = $raw | into int
          if $n >= 8 and $n <= 20 {
              $size = $n
              break
          } else {
              print "Must be a number between 8 and 20"
          }
      } catch {
          print "Must be a number between 8 and 20"
      }
  }
  let size = $size  # shadow as immutable for closure capture

  let styles = [
      [key style];
      ["font" "Bold"]
      ["font-bold" "ExtraBold"]
      ["font-italic" "Bold Italic"]
      ["font-bold-italic" "ExtraBold Italic"]
  ]

  let config = $styles | each { |row|
      $"($row.key)=($font):style=($row.style):size=($size)"
  } | str join "\n"

  $config | save --force ~/.config/foot/font.ini
  ^nvim ~/.config/brave-flags.conf
  ^pkill foot | complete
  job spawn { ^setsid foot --server out+err>/dev/null }

# show all running docker processes
docker-ps:
  #!/usr/bin/env nu
  docker ps --format json | lines | each { from json } | select Names Status Image ID

# show tracked dotfiles system to system
git-ls-tree:
  #!/usr/bin/env nu
  git --work-tree $env.HOME --git-dir $"($env.HOME)/.unx" ls-tree mainline --name-only -r

# update the operating system
update:
  #!/usr/bin/env bash
  sudo pacman -Syu --noconfirm

# list all deliberately installed packages
packages:
  #!/usr/bin/env nu
  let explicit = (^pacman -Qqett | lines | uniq)
  let base_devel = (try {
    ^pacman -Qqg base-devel e>| ignore | lines | uniq
  } catch {
      []
    })

  $explicit | where {|pkg| $pkg not-in $base_devel }

# list all custom executables tracked with the system
local-bin:
  #!/usr/bin/env nu
  cd ~/.local/bin
  ls -l | where type == "file" and mode =~ "x" | get name

# fuzzy search processes to kill (searchable by name, cmd, status, or port)
kill:
  #!/usr/bin/env nu

  let port_map = (
    ^sudo ss -tulnp
    | from ssv -m 1
    | where { |row| (($row | get -o Peer) | default "" | str contains "pid=") }
    | each {|row|
      let port = ($row.Local | split row ":" | last)
      let pid  = ($row.Peer | parse --regex 'pid=(?P<pid>\d+)' | get -o 0.pid)
      if ($pid != null) { { pid: ($pid | into int), port: $port } }
    }
    | compact
    | group-by pid
    | transpose key rows
    | each {|r| { pid: ($r.key | into int), ports: ($r.rows | get port | str join ",") }}
  )

  let pids = (
    ps
    | sort-by name
    | each {|p|
      let cmd = try {
        open $"/proc/($p.pid)/cmdline"
        | str replace --all "\u{0}" " "
        | str replace --all "\t" " "
        | str trim
        | str substring 0..60
      } catch { "" }
      $p | insert cmd $cmd
    }
    | join --left $port_map pid
    | each {|p|
      let ports = if ($p.ports == null) { "-" } else { $p.ports }
      $"($p.pid)\t($p.name)\t($p.cmd)\t($p.status)\t($ports)"
    }
    | str join "\n"
    | ^fzf -m --header $"PID\tNAME\tCMD\tSTATUS\tPORTS" --delimiter "\t"
    | lines
    | each {|line| $line | split column "\t" pid name cmd status ports | get pid.0 }
    | into int
  )

  if ($pids | is-not-empty) {
    ^sudo kill -9 ...$pids
  }

# show the current disk space used on the system
disk-space:
  #!/usr/bin/env bash
  duf --only local

# set screen brightness to any value 2-10
brightness num="10":
  #!/usr/bin/env nu
  if {{num}} not-in 2..10 {
    error make {msg: $"brightness must be 2–10, got {{num}}"}
  }
  let pct = {{num}} * 10
  ^brightnessctl s $"($pct)%"

check-dns:
  #!/usr/bin/env bash
  for r in 1.1.1.1 8.8.8.8 9.9.9.9 208.67.222.222; do
    echo "=== $r"
    dig temporal.pcfcash.com @$r +noall +answer
  done

random-secret-32:
  #!/usr/bin/env bash
  sec=$(openssl rand -base64 32)
  echo $sec | wl-copy
  echo $sec

reown:
  #!/usr/bin/env bash
  sudo chown -R tanjiro:users go/pkg/mod

pacman-update-keychain:
  #!/usr/bin/env bash
  sudo pacman -S archlinux-keyring
  sudo pacman-key --populate archlinux
  sudo pacman-key --refresh
