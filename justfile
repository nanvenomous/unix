default:
    nmcli c 

random-secret-32:
    #!/usr/bin/env bash
    sec=$(openssl rand -base64 32)
    echo $sec | wl-copy
    echo $sec

reown:
    sudo chown -R tanjiro:users go/pkg/mod

docker-ps:
    #!/usr/bin/env nu
    docker ps --format json | lines | each { from json } | select Names Status Image ID

git-ls-tree:
    #!/usr/bin/env nu
    git --work-tree $env.HOME --git-dir $"($env.HOME)/.unx" ls-tree mainline --name-only -r

update:
    #!/usr/bin/env bash
    sudo pacman -Syu --noconfirm

packages:
    #!/usr/bin/env nu
    let explicit = (^pacman -Qqett | lines | uniq)
    let base_devel = (try {
      ^pacman -Qqg base-devel e>| ignore | lines | uniq
    } catch {
      []
    })

    $explicit | where {|pkg| $pkg not-in $base_devel }

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

check-dns:
    #!/usr/bin/env bash
    for r in 1.1.1.1 8.8.8.8 9.9.9.9 208.67.222.222; do
        echo "=== $r"
        dig temporal.pcfcash.com @$r +noall +answer
    done

disk-space:
    #!/usr/bin/env bash
    duf --only local
