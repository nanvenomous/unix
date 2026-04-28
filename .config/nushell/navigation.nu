def t [] {
  clear
  ls
  | sort-by { $in.type != "dir" } { $in.name | path parse | get extension } { $in.name | str downcase }
  | reject type
  | table --index false
}

def nav_dirs [] {
  ls -a
  | where type == dir
  | get name
  | each {|name| $name | path basename }
  | sort -i
}

def --env dn [dir?: directory] {
  if $dir == null {
    cd ~
  } else {
    cd $dir
  }

  t
}

def --env nav [start?: directory] {
  if $start != null {
    cd $start
  }

  while true {
    clear

    let current_dir = (pwd | to text)
    let dirs = (nav_dirs)
    let options = if $current_dir != "/" {
      [".."] | append $dirs
    } else {
      $dirs
    }

    if ($options | is-empty) {
      break
    }

    let result = (do { $options | str join "\n" | ^fzf --prompt $"($current_dir)/" --height 40% --layout reverse --border --exit-0 } | complete)

    if $result.exit_code != 0 {
      break
    }

    let selection = ($result.stdout | str trim)
    if $selection == "" {
      break
    }

    if $selection == ".." {
      cd ..
    } else {
      cd $selection
    }
  }

  t
}
