source ~/.config/nushell/def.nu
source ~/.config/nushell/navigation.nu
source ~/.config/nushell/display.nu
source ~/.config/nushell/carapace.nu
source-env ~/.config/nushell/paths.nu
source-env ~/.config/nushell/local.nu

alias hr = pwd
alias db = ^nvim -c ":DBUI" -

def --wrapped g [...args] {
  ^git --work-tree $env.HOME --git-dir $"($env.HOME)/.unx" ...$args
}

def --wrapped cg [...args] {
  ^lazygit --work-tree $env.HOME --git-dir $"($env.HOME)/.unx" ...$args
}

$env.BROWSER = "brave"
$env.EDITOR = "nvim"
$env.TERMINAL = "footclient"
$env.LANG = "en_US.UTF-8"
$env.LC_CTYPE = "en_US.UTF-8"
# $env.config.edit_mode = "vi"
$env.config.buffer_editor = "nvim"
$env.config.show_banner = false
$env.config.table.index_mode = "never"
$env.config.history = {
    file_format: "sqlite"  # Required for isolation control
    isolation: true        # false = shared across sessions; true = per-session
    sync_on_enter: true    # Writes to disk after each command
    max_size: 100000       # Maximum number of history entries
}   
$env.config.keybindings = [
  {
    name: open_in_editor
    modifier: control
    keycode: char_e
    mode: emacs
    event: { send: OpenEditor }
  },
]

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
