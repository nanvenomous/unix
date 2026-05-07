source ~/.config/nushell/navigation.nu
source ~/.config/nushell/display.nu
source ~/.config/nushell/carapace.nu
source-env ~/.config/nushell/paths.nu
source-env ~/.config/nushell/local.nu

alias lg = lazygit
alias weather = ^curl "wttr.in/Chicago?m"
alias db = ^nvim -c ":DBUI" -
alias gdiff = ^nvim -c ":DiffviewOpen" -
alias hr = pwd

def --wrapped g [...args] {
  ^git --work-tree $env.HOME --git-dir $"($env.HOME)/.unx" ...$args
}

def --wrapped cg [...args] {
  ^lazygit --work-tree $env.HOME --git-dir $"($env.HOME)/.unx" ...$args
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

def keychain [] {
  ^sudo pacman -S archlinux-keyring
  ^sudo pacman-key --populate archlinux
  ^sudo pacman-key --refresh
}

def random_ssh_port [] {
  random int 1024..32766
}

$env.BROWSER = "brave"
$env.EDITOR = "nvim"
$env.TERMINAL = "footclient"
$env.LANG = "en_US.UTF-8"
$env.LC_CTYPE = "en_US.UTF-8"
$env.config.edit_mode = "vi"
$env.config.buffer_editor = "nvim"
$env.config.show_banner = false
$env.config.table.index_mode = "never"
$env.config.history = {
    file_format: "sqlite"  # Required for isolation control
    isolation: true        # false = shared across sessions; true = per-session
    sync_on_enter: true    # Writes to disk after each command
    max_size: 100000       # Maximum number of history entries
}   

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

ls
