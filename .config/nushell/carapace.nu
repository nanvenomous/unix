let carapace_completer = {|spans|
  let result = (do { ^carapace $spans.0 nushell ...$spans } | complete)

  if $result.exit_code == 0 and ($result.stdout | str trim) != "" {
    $result.stdout | from json
  } else {
    null
  }
}

$env.CARAPACE_LENIENT = "1"
$env.config.completions.algorithm = "prefix"
$env.config.completions.external = {
  enable: true
  max_results: 100
  completer: $carapace_completer
}

$env.config.menus ++= [{
  name: completion_menu
  only_buffer_difference: false
  marker: "| "
  type: {
    layout: columnar
    columns: 4
    col_width: 24
    col_padding: 2
  }
  style: {
    text: green
    selected_text: green_reverse
    description_text: yellow
  }
}]

$env.config.keybindings ++= [
  {
    name: carapace_completion_menu_ctrl_t
    modifier: control
    keycode: char_t
    mode: [vi_insert vi_normal]
    event: {
      until: [
        { send: menu name: completion_menu }
        { send: menunext }
      ]
    }
  }
  {
    # Tab opens the menu and completes an unambiguous match, but never
    # cycles through candidates on repeat presses -- keep typing to narrow.
    name: completion_menu
    modifier: none
    keycode: tab
    mode: [emacs vi_normal vi_insert]
    event: {
      until: [
        { send: menu name: completion_menu }
        { edit: complete }
      ]
    }
  }
]
