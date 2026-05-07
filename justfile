# see fastfetch system info
default:
    #!/usr/bin/env bash
    fastfetch 

# battery health statistics
battery:
    #!/usr/bin/env bash
    battery

# changes resolution in brave and foot terminal, kills all terminals
resolution:
    #!/usr/bin/env bash
    nvim ~/.config/foot/foot.ini
    nvim ~/.config/brave-flags.conf
    systemctl --user restart foot-server.socket 

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

# fuzzy search processes to kill
kill:
    #!/usr/bin/env nu
    let pids = (
      ps
      | sort-by name
      | each {|process| $"($process.pid)\t($process.name)\t($process.status)" }
      | str join "\n"
      | ^fzf -m
      | lines
      | each {|line| $line | split column "\t" pid name status | get pid.0 }
      | into int
    )

    if ($pids | is-not-empty) {
      ^kill -9 ...$pids
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
