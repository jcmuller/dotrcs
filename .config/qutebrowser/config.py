#!/usr/bin/env python3

# pylint: disable=C0111

c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103

PASS_COMMAND = 'spawn --userscript qute-pass --dmenu-invocation dmenu'

config.load_autoconfig()
c.bindings.commands = {
    "normal": {
        # ",o": "spawn --userscript dmenu-open",
        # ",O": "spawn --userscript dmenu-open --tab",
        # ",o": "set-cmd-text :open {url}", -- go
        # ",O": "set-cmd-text :open -t {url}", -- gO
        ',d': 'hint all delete',
        ',p': PASS_COMMAND,
        ',Pu': PASS_COMMAND + ' --username-only',
        ',Pp': PASS_COMMAND + ' --password-only',
        ',Po': PASS_COMMAND + ' --otp-only',
        ",r": "hint links spawn /home/jcmuller/go/bin/picky {hint-url}",
        ",s": "spawn --userscript searchbar-command",
        ",z": "hint links spawn /home/jcmuller/go/bin/zoom-handler {hint-url}",
        ",ym": "yank inline [{title}]({url})",  # Copy URL for markdown links
    },

    # Emacs-like keybindings for insert mode
    'insert': {
        '<Alt-Backspace>': 'fake-key <Ctrl-Backspace>',
        '<Alt-b>': 'fake-key <Ctrl-Left>',
        '<Alt-d>': 'fake-key <Ctrl-Delete>',
        '<Alt-f>': 'fake-key <Ctrl-Right>',
        '<Alt-v>': 'fake-key <PgUp>',
        '<Ctrl-/>': 'fake-key <Ctrl-z>',
        '<Ctrl-a>': 'fake-key <Home>',
        '<Ctrl-b>': 'fake-key <Left>',
        '<Ctrl-d>': 'fake-key <Delete>',
        '<Ctrl-e>': 'fake-key <End>',
        '<Ctrl-f>': 'fake-key <Right>',
        '<Ctrl-k>': 'fake-key <shift+end> ;; fake-key <delete>',
        '<Ctrl-n>': 'fake-key <Down>',
        '<Ctrl-p>': 'fake-key <Up>',
        '<Ctrl-u>': 'fake-key <shift+home> ;; fake-key <delete>',
        '<Ctrl-v>': 'fake-key <PgDown>',
        '<Ctrl-y>': 'insert-text {primary}',
    },
}

c.editor.command = [
    "alacritty",
    "-e",
    "vim",
    "-f",
    "{file}",
    "-c",
    "normal {line}G{column0}l"
]

c.tabs.position = "top"

c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "gp": "https://github.com/grnhse/greenhouse/pull/{}",
    "j": "https://greenhouseio.atlassian.net/browse/{}",
    "r": "https://www.reddit.com/r/{}"
}

c.aliases['b'] = 'buffer'

c.fonts.completion.category = "bold 9pt monospace"
c.fonts.completion.entry = "9pt monospace"
c.fonts.debug_console = "9pt monospace"
c.fonts.downloads = "9pt monospace"
c.fonts.hints = "bold 9pt monospace"
c.fonts.keyhint = "9pt monospace"
c.fonts.messages.error = "9pt monospace"
c.fonts.messages.info = "9pt monospace"
c.fonts.messages.warning = "9pt monospace"
c.fonts.monospace = '"xos4 Terminus", Terminus, Monospace, ' \
    '"DejaVu Sans Mono", Monaco, "Bitstream Vera Sans Mono", ' \
    '"Andale Mono", "Courier New", Courier, "Liberation Mono", '\
    'monospace, Fixed, Consolas, Terminal'
c.fonts.prompts = "10pt sans-serif"
c.fonts.statusbar = "9pt monospace"
c.fonts.tabs = "9pt monospace"
c.fonts.web.size.default = 14
c.fonts.web.size.default_fixed = 13

c.zoom.default = "85%"
