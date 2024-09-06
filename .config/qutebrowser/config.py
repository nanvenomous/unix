c.tabs.position = "bottom"
c.url.searchengines = {
    'DEFAULT':  'https://google.com/search?q={}',
    '!d':       'https://duckduckgo.com/?ia=web&q={}',
    '!gh':      'https://github.com/search?o=desc&q={}&s=stars',
    '!r':       'https://www.reddit.com/search?q={}',
    '!tw':      'https://twitter.com/search?q={}',
    '!w':       'https://en.wikipedia.org/wiki/{}',
    '!yt':      'https://www.youtube.com/results?search_query={}'
}
config.bind('tj', 'tab-next')
config.bind('tk', 'tab-prev')
config.bind('tn', 'tab-close')
config.bind("to", "cmd-set-text :open -t ")
config.bind("th", "tab-move -")
config.bind("tl", "tab-move +")

c.auto_save.session = True
# c.editor.command = ["st", "-e", "nvim '{}'"]
c.editor.command = ["st", "-e", "nvim", "{}"]
c.url.default_page = "about:blank"
c.colors.tabs.even.bg = "#000000"
c.colors.tabs.odd.bg = "#333333"
c.colors.tabs.selected.even.bg = "#cfd0d1"
c.colors.tabs.selected.odd.bg = "#cfd0d1"
c.colors.tabs.selected.even.fg = "#000000"
c.colors.tabs.selected.odd.fg = "#000000"
config.load_autoconfig(False)
c.tabs.padding = {
    "left": 5,
    "right": 5,
    "top": 5,
    "bottom": 5,
}
c.fonts.tabs.selected = '12pt default_family'
c.fonts.tabs.unselected = '10pt default_family'
c.tabs.favicons.scale = 1.3
