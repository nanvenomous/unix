default:
    nmcli c 

random-secret-32:
    #!/usr/bin/env bash
    sec=$(openssl rand -base64 32)
    echo $sec | wl-copy
    echo $sec

reown:
    sudo chown -R tanjiro:users go/pkg/mod

update-linodes:
    ssh pcf-caddy 'sudo pacman -Syu --noconfirm'
    ssh pcf-portal 'sudo pacman -Syu --noconfirm'

check-dns:
    #!/usr/bin/env bash
    for r in 1.1.1.1 8.8.8.8 9.9.9.9 208.67.222.222; do
        echo "=== $r"
        dig temporal.pcfcash.com @$r +noall +answer
    done

docker-ps:
    #!/usr/bin/env nu
    docker ps --format json | lines | each { from json } | select Names Status Image ID

git-ls-tree:
    #!/usr/bin/env nu
    git --work-tree $env.HOME --git-dir $"($env.HOME)/.unx" ls-tree mainline --name-only -r
