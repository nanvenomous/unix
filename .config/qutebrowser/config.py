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

c.auto_save.session = True
# c.editor.command = ["st", "-e", "nvim '{}'"]
c.editor.command = ["st", "-e", "nvim", "{}"]
c.url.default_page = "about:blank"
c.colors.tabs.even.bg = "#535454"
c.colors.tabs.odd.bg = "#7e807f"
config.load_autoconfig(False)
