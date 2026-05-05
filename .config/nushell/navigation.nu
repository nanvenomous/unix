alias core-ls = ls

def ls [
  --all (-a),         # Show hidden files
  --long (-l),        # Get all available columns for each entry
  --short-names (-s), # Only print the file names, and not the path
  --full-paths (-f),  # Display paths as absolute paths
  --du (-d),          # Display the apparent directory size for directories
  --directory (-D),   # List the specified directory itself instead of its contents
  --mime-type (-m),   # Show mime-type in the type column
  --threads (-t),     # Use multiple threads to list contents
  ...pattern: glob,   # The glob pattern to use
]: [ nothing -> table ] {
  let pattern = if ($pattern | is-empty) { [ "." ] } else { $pattern }
  (
    core-ls
      --all=$all
      --long=$long
      --short-names=$short_names
      --full-paths=$full_paths
      --du=$du
      --directory=$directory
      --mime-type=$mime_type
      --threads=$threads
      ...$pattern
  ) | sort-by { $in.type != "dir" } { $in.name | path parse | get extension } { $in.name | str downcase }
}

def nav_dirs [] {
  core-ls -a
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

  clear
  ls
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

  ls
}
