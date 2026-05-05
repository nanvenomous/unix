source ~/.config/nushell/navigation.nu
source ~/.config/nushell/display.nu
source-env ~/.config/nushell/paths.nu
source-env ~/.local.nu

alias lg = lazygit
alias weather = ^curl "wttr.in/Chicago?m"
alias clk = ^date "+%I:%M %p"
alias db = ^nvim -c ":DBUI" -
alias dps = ^docker ps --format json | lines | each { from json } | select Names Status Image ID
alias gdiff = ^nvim -c ":DiffviewOpen" -
alias space = ^duf --only local
alias hr = pwd

def --wrapped g [...args] {
  ^git --work-tree $env.HOME --git-dir $"($env.HOME)/.unx" ...$args
}

def --wrapped cg [...args] {
  ^lazygit --work-tree $env.HOME --git-dir $"($env.HOME)/.unx" ...$args
}

def x [] {
  ^nvim ~/.config/kitty/kitty.conf
  ^nvim ~/.config/brave-flags.conf
}

def git_changed_files [...args] {
  let diff_result = (do { ^git diff --name-only ...$args } | complete)

  if $diff_result.exit_code == 0 {
    $diff_result.stdout | lines | compact --empty | uniq
  } else {
    []
  }
}

def select_gopass_entry [] {
  ^gopass list -f | ^fzf | str trim
}

def review [] {
  let files = (git_changed_files HEAD HEAD~1)

  if ($files | is-not-empty) {
    ^nvim -p ...$files
  }
}

def resolve [] {
  let files = (git_changed_files)

  if ($files | is-not-empty) {
    ^nvim -p ...$files
  }
}

def packages [] {
  let explicit = (^pacman -Qqett | lines | uniq)
  let base_devel = (try {
    ^pacman -Qqg base-devel e>| ignore | lines | uniq
  } catch {
    []
  })

  $explicit | where {|pkg| $pkg not-in $base_devel }
}

def fzf-kill [] {
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
}

def fzf-rg [...query] {
  ^rg --color=always --line-number --no-heading --smart-case ...$query
  | ^fzf --ansi --delimiter ":" --preview "bat --color=always {1} --highlight-line {2}" --preview-window "up,60%,border-bottom,+{2}+3/3,~3"
}

def ss [] {
  let area = (^slurp | str trim)

  if $area != "" {
    ^grim -g $area
  }
}

def gp [] {
  let entry = (select_gopass_entry)

  if $entry != "" {
    ^gopass edit $entry
  }
}

def gpp [] {
  let entry = (select_gopass_entry)

  if $entry != "" {
    let password = (^gopass show --password $entry)
    do { print -n $password } | ^wl-copy
  }
}

def release [] {
  let describe_result = (do { ^git describe --tags --abbrev=0 "@^" } | complete)
  let last_tag = if $describe_result.exit_code == 0 {
    $describe_result.stdout | str trim
  } else {
    ""
  }

  if $last_tag != "" {
    ^git log $"($last_tag)..@"
  }
}

def keychain [] {
  ^sudo pacman -S archlinux-keyring
  ^sudo pacman-key --populate archlinux
  ^sudo pacman-key --refresh
}

def random_ssh_port [] {
  random int 1024..32766
}

def bye [] {
  ^systemctl suspend
  ^lock
}

def prompt_path [] {
  let cwd = (pwd | to text)
  let home = ($env.HOME | to text)

  if $cwd == $home {
    "~"
  } else if ($cwd | str starts-with $"($home)/") {
    $cwd | str replace $home "~"
  } else {
    $cwd
  }
}

def prompt_status [indicator: string] {
  let exit_code = ($env.LAST_EXIT_CODE? | default 0)
  let status_color = if $exit_code == 0 { ansi green } else { ansi red }

  $"($status_color)($exit_code)(ansi blue) ($indicator)(ansi reset)"
}

let carapace_completer = {|spans|
  let results = (do { ^carapace $spans.0 nushell ...$spans } | complete)

  if $results.exit_code == 0 and ($results.stdout | str trim) != "" {
    $results.stdout | from json
  } else {
    null
  }
}

$env.TERM = "xterm-256color"
$env.config.edit_mode = "vi"
$env.config.buffer_editor = "nvim"
$env.config.show_banner = false
$env.config.completions.external = {
  enable: true
  max_results: 100
  completer: $carapace_completer
}
$env.PROMPT_COMMAND = {
  let user = ($env.USER? | default $env.LOGNAME? | default "unknown")
  let host = (sys host | get hostname)
  let path = (prompt_path)

  $"(ansi blue)($path)(ansi reset) (ansi magenta){(ansi yellow)($user)(ansi reset)(ansi magenta)@(ansi yellow)($host)(ansi magenta)}(ansi reset)\n"
}
$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_INDICATOR = {|| prompt_status "> " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| prompt_status "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| prompt_status ": " }
