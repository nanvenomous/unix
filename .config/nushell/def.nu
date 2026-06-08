def retry [interval: duration, ...cmd: string] {
    let args = $cmd | skip 1
    while (do -i { run-external $cmd.0 ...$args } | complete | tee { print $in } | get exit_code) != 0 {
        sleep $interval
    }
}


def dns-check [domain: string] {
  ["1.1.1.1" "8.8.8.8" "9.9.9.9" "208.67.222.222"]
    | each { |res|
        ^dig $domain $"@($res)" +noall +answer
          | lines
          | where { |l| ($l | str trim) != "" }
          | each { |line| { resolver: $res, answer: $line } }
      }
    | flatten
}

def reown [dir: string] {
  ^sudo chown -R $"($env.USER):users" $"($dir)"
}

def random-secret-openssl-32 [] {
  ^openssl rand -base64 32
}

def random-ssh-port [] {
  random int 1024..65535
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

alias e = nvim
