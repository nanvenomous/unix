source ~/.config/nushell/navigation.nu

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

$env.config.edit_mode = "vi"
$env.config.buffer_editor = "nvim"
$env.config.show_banner = false
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
