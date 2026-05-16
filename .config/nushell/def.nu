def retry [interval: duration, ...cmd: string] {
    let args = $cmd | skip 1
    while (do -i { run-external $cmd.0 ...$args } | complete | tee { print $in } | get exit_code) != 0 {
        sleep $interval
    }
}

def screenshot [output?: string] {
  let area = (^slurp | str trim)

  if $area != "" {
    if $output != null {
      ^grim -g $area $output
    } else {
      ^grim -g $area
    }
  }
}

def select_gopass_entry [] {
  ^gopass list -f | ^fzf | str trim
}

def gp [] {
  let entry = (select_gopass_entry)

  if $entry != "" {
    ^gopass edit $entry
  }
}

def random_ssh_port [] {
  random int 1024..32766
}

alias e = nvim
