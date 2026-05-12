#!/usr/bin/env nu

let my_pid = $nu.pid
ps
| where name == "nu"
| where pid != $my_pid
| each {|p|
    let cmd = (open $"/proc/($p.pid)/cmdline" | str replace --all "\u{0}" " " | str trim)
    if $cmd =~ "focus-dismiss" {
        ^kill $p.pid
    }
  }

swaymsg -t subscribe --monitor '["window"]' | lines | each { |line|
    let e = ($line | from json)
    let app_id = ($e.container | get -o app_id)
    if $e.change == "focus" and $app_id != "fling" {
        try { run-external "swaymsg" '[app_id="fling"] kill' }
    }
} | ignore
