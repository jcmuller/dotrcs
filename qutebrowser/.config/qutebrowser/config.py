#!/usr/bin/env python3

# pylint: disable=C0111

c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103
settings = {
    'background': '#ffffcc',
    'foreground': 'black',
    'pass_command': 'spawn --userscript qute-pass --dmenu-invocation dmenu --mode gopass --password-store ~/.local/share/gopass/stores/root --username-target secret --username-pattern="(?:login|username): +(.*)"',
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
config.source('fonts.py')

c.bindings.commands = {
    "normal": {
        # ",o": "spawn --userscript dmenu-open", o
        # ",O": "spawn --userscript dmenu-open --tab", O
        # ",o": "set-cmd-text :open {url}", -- go
        # ",O": "set-cmd-text :open -t {url}", -- gO
        ',Po': settings['pass_command'] + ' --otp-only',
        ',Pp': settings['pass_command'] + ' --password-only',
        ',Pu': settings['pass_command'] + ' --username-only',
        ',o':  'spawn --userscript qute-1pass --auto-submit --cache-session fill_credentials',
        ',Ou': 'spawn --userscript qute-1pass --auto-submit --cache-session fill_username',
        ',Op': 'spawn --userscript qute-1pass --auto-submit --cache-session fill_password',
        ',Oo': 'spawn --userscript qute-1pass --auto-submit --cache-session fill_totp',
        ',d': 'hint all delete',
        ',a': 'hint --rapid all tab-bg',
        ',p': settings['pass_command'],
        ',r': 'hint links spawn picky {hint-url}',
        ',s': 'spawn --userscript searchbar-command',
        ',,': 'config-cycle tabs.show always never',
        ',ym': 'yank inline [{title}]({url})',  # Copy URL for markdown links
        ',z': 'hint links spawn zoom-handler {hint-url}',
        ',Z': 'spawn zoom-handler {url}',
        ',f': 'hint links spawn firefox {hint-url}',
        ',m': 'spawn mpv {url}',
        ',M': 'hint all spawn mpv {hint-url}',
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
c.content.blocking.whitelist = ['rollbar.com', 'api.datadoghq.com', 'app.datadoghq.com']
c.content.javascript.can_access_clipboard = True
c.content.pdfjs = True
c.content.plugins = True
c.downloads.location.directory = "~/Downloads"
c.editor.command = [
    "alacritty",
    "-e",
    "vim",
    "-f",
    "{file}",
    "-c",
    "normal {line}G{column0}l",
]
c.hints.mode = "letter"
c.session.lazy_restore = True
c.spellcheck.languages = ["en-US", "es-ES"]
c.tabs.last_close = "close"
c.tabs.mousewheel_switching = False
c.tabs.position = "left"
c.tabs.select_on_remove = "next"
c.tabs.show = "always"
#c.tabs.switch_to_open_url = True
c.tabs.show = 'switching'
c.tabs.title.format = '{audio}{current_title}'
c.tabs.title.format_pinned = '{audio}📌 {current_title}'
c.url.open_base_url = True
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "gh": "https://github.com/{}",
    "gp": "https://github.com/grnhse/greenhouse/pull/{}",
    "j": "https://greenhouseio.atlassian.net/browse/{}",
    "r": "https://www.reddit.com/r/{}",
    "rg": "https://rubygems.org/gems/{}",
}
c.content.javascript.can_access_clipboard = True
c.content.tls.certificate_errors = "ask-block-thirdparty"
