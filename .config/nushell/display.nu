def work [] {
    wlr-randr --output DP-3 --mode 1920x1080 --on
    wlr-randr --output eDP-1 --off
}

def home [] {
    wlr-randr --output DP-3 --mode 3840x2160 --on
    wlr-randr --output eDP-1 --off
}

def mobile [] {
    wlr-randr --output eDP-1 --mode 1920x1200 --on
    for output in [DP-1 DP-2 DP-3 DP-4] {
        try { wlr-randr --output $output --off }
    }
}
