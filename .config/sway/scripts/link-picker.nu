#!/usr/bin/env nu

const links_file = path self ../links.yaml

def normalize-entry [entry: any] {
    let entry_type = ($entry | describe)

    if $entry_type == "string" {
        { url: $entry, pre: [] }
    } else if ($entry_type | str starts-with "record") {
        let pre = ($entry | get -o pre | default [])
        let hooks = if ($pre | describe) == "string" { [$pre] } else { $pre }
        { url: ($entry | get url), pre: $hooks }
    } else {
        error make { msg: "Each link must be a URL string or a record containing 'url'" }
    }
}

def open-link [link: record] {
    for hook in $link.pre {
        ^nu --commands $hook
        let exit_code = $env.LAST_EXIT_CODE
        if $exit_code != 0 {
            print --stderr $"Pre-hook failed: ($hook)"
            exit $exit_code
        }
    }

    ^brave --new-tab $link.url
}

def main [url?: string] {
    let configured_links = (open --raw $links_file | from yaml)
    if ($configured_links | is-empty) {
        exit 0
    }

    let links = ($configured_links | each { |entry| normalize-entry $entry })

    if $url != null {
        let matches = ($links | where url == $url)
        if ($matches | is-empty) {
            error make { msg: $"URL is not configured in links.yaml: ($url)" }
        }

        open-link ($matches | first)
        return
    }

    let selection = (
        $links
        | get url
        | str join (char newline)
        | ^fzf --prompt "Open link: " --no-multi
        | complete
    )

    if $selection.exit_code == 0 {
        let selected_url = ($selection.stdout | str trim)
        if not ($selected_url | is-empty) {
            open-link ($links | where url == $selected_url | first)
        }
    }
}
