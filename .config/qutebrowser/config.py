#!/usr/bin/env python3

# pylint: disable=C0111

c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103
settings = {
    'background': '#ffffcc',
    'foreground': 'black',
    'pass_command': 'spawn --userscript qute-pass --dmenu-invocation dmenu --username-target secret --username-pattern="(?:login|username): +(.*)"',
    'base_keybindings': {
        '<Alt-Backspace>': 'fake-key <Ctrl-Backspace>',
        '<Alt-b>': 'fake-key <Ctrl-Left>',
        '<Alt-d>': 'fake-key <Ctrl-Delete>',
        '<Alt-f>': 'fake-key <Ctrl-Right>',
        '<Ctrl-a>': 'fake-key <Home>',
        '<Ctrl-b>': 'fake-key <Left>',
        '<Ctrl-d>': 'fake-key <Delete>',
        '<Ctrl-e>': 'fake-key <End>',
        '<Ctrl-/>': 'fake-key <Ctrl-z>',
        '<Ctrl-f>': 'fake-key <Right>',
        '<Ctrl-k>': 'fake-key <shift+end> ;; fake-key <delete>',
        '<Ctrl-n>': 'fake-key <Down>',
        '<Ctrl-p>': 'fake-key <Up>',
        '<Ctrl-u>': 'fake-key <shift+home> ;; fake-key <delete>',
        '<Ctrl-y>': 'insert-text {primary}',
    }
}

config.load_autoconfig()

c.bindings.commands = {
    "normal": {
        # ",o": "spawn --userscript dmenu-open", o
        # ",O": "spawn --userscript dmenu-open --tab", O
        # ",o": "set-cmd-text :open {url}", -- go
        # ",O": "set-cmd-text :open -t {url}", -- gO
        ',Po': settings['pass_command'] + ' --otp-only',
        ',Pp': settings['pass_command'] + ' --password-only',
        ',Pu': settings['pass_command'] + ' --username-only',
        ',d': 'hint all delete',
        ',a': 'hint --rapid all tab-bg',
        ',p': settings['pass_command'],
        ',r': 'hint links spawn /home/jcmuller/go/bin/picky {hint-url}',
        ',s': 'spawn --userscript searchbar-command',
        ',,': 'config-cycle tabs.show always never',
        ',ym': 'yank inline [{title}]({url})',  # Copy URL for markdown links
        ',z': 'hint links spawn /home/jcmuller/go/bin/zoom-handler {hint-url}',
        ',f': 'hint links spawn firefox {hint-url}',
    },

    # Emacs-like keybindings for insert mode
    'insert': settings['base_keybindings'],
    "passthrough": settings['base_keybindings'],
}

c.aliases['b'] = 'buffer'
c.auto_save.session = True
c.colors.tabs.pinned.selected.even.bg = settings['background']
c.colors.tabs.pinned.selected.even.fg = settings['foreground']
c.colors.tabs.pinned.selected.odd.bg = settings['background']
c.colors.tabs.pinned.selected.odd.fg = settings['foreground']
c.colors.tabs.selected.even.bg = settings['background']
c.colors.tabs.selected.even.fg = settings['foreground']
c.colors.tabs.selected.odd.bg = settings['background']
c.colors.tabs.selected.odd.fg = settings['foreground']
c.content.host_blocking.whitelist = ['rollbar.com']
c.content.pdfjs = True
c.content.plugins = True
c.downloads.location.directory = "/home/jcmuller/Downloads"
c.editor.command = [
    "alacritty",
    "-e",
    "vim",
    "-f",
    "{file}",
    "-c",
    "normal {line}G{column0}l",
]
c.fonts.completion.category = "bold 9pt monospace"
c.fonts.completion.entry = "9pt monospace"
c.fonts.debug_console = "9pt monospace"
c.fonts.downloads = "9pt monospace"
c.fonts.hints = "bold 9pt monospace"
c.fonts.keyhint = "9pt monospace"
c.fonts.messages.error = "9pt monospace"
c.fonts.messages.info = "9pt monospace"
c.fonts.messages.warning = "9pt monospace"
c.fonts.monospace = '"xos4 Terminus", Terminus'
c.fonts.prompts = "10pt sans-serif"
c.fonts.statusbar = "9pt monospace"
c.fonts.tabs = "9pt monospace"
c.fonts.web.size.default = 14
c.fonts.web.size.default_fixed = 13
c.hints.mode = "letter"
c.session.lazy_restore = True
c.tabs.last_close = "close"
c.tabs.mousewheel_switching = False
c.tabs.position = "left"
c.tabs.select_on_remove = "next"
c.tabs.show = "never"
c.tabs.switch_to_open_url = True
c.tabs.width = 250
c.tabs.show = 'always'
c.tabs.title.format = '{audio}{current_title}'
c.tabs.title.format_pinned = '{audio}'
c.url.open_base_url = True
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "gh": "https://github.com/{}",
    "gp": "https://github.com/grnhse/greenhouse/pull/{}",
    "j": "https://greenhouseio.atlassian.net/browse/{}",
    "r": "https://www.reddit.com/r/{}",
    "rg": "https://rubygems.org/gems/{}",
}
c.zoom.default = "85%"
