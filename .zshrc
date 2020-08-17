BROWSER=/home/jcmuller/go/bin/picky; export BROWSER
GOPRIVATE=github.com/grnhse; export GOPRIVATE
NVIM_LISTEN_ADDRESS="/tmp/neovim.sock"; export NVIM_LISTEN_ADDRESS
QT_QPA_PLATFORMTHEME=qt5ct; export QT_QPA_PLATFORMTHEME
# Report any command running longer than 5 seconds
REPORTTIME=5; export REPORTTIME
TIMEFMT="'$fg[green]%J$reset_color' time: $fg[yellow]%*Es$reset_color, cpu: $fg[yellow]%P$reset_color, mem: $fg[yellow]%M$reset_color"; export TIMEFMT
TF_PLUGIN_CACHE_DIR=~/.terraform/terraform-plugin-dir; export TF_PLUGIN_CACHE_DIR
_Z_CMD=j; export _Z_CMD

unset SSH_AGENT_PID SSH_AUTH_SOCK

path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "/usr/local/sbin"
  "/usr/local/bin"
  "/usr/sbin"
  "/usr/bin"
  "/sbin"
  "/bin"
  "/usr/games"
  "/usr/local/games"
  "/usr/local/openresty/bin"
  "/usr/local/openresty/nginx/sbin"
  "$HOME/Development/Greenhouse/infrastructure/bin"
)

autoload -Uz compinit && compinit

source ~/.antigen-src/antigen.zsh

antigen use oh-my-zsh

antigen theme /home/jcmuller/Development/MyStuff/custom-oh-my-zsh themes/juancmuller.zsh-theme

source ~/.zsh/rcs/local-bundles.zsh

antigen bundles <<EOBUNDLE
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions src
  zsh-users/zsh-syntax-highlighting

  docker
  docker-compose
  docker-machine
  git
  git-extras
  golang
  kubectl
  pass
  ruby
  thor
  tmux
  z

  github/hub etc/hub.zsh_completion

  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh git_funcs.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh aliases.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh asdf.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh colors.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh cargo.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh completions.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh dajoku.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh dbus.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh directories.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh enable-edit-command-line.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh environment.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh extra.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh gh-aliases.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh go.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh kubectl.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh pass.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh perl.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh tk.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh vi-mode.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh yarn.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh zsh_completions.zsh
EOBUNDLE

antigen apply

set noclobber

xmodmap ~/.Xmodmap

fpath=(
  $HOME/go/share/zsh
  /home/jcmuller/.local/share/zsh/functions
  "${fpath[@]}"
)

. ~/.zsh/rcs/post

autoload -U +X bashcompinit && bashcompinit

# asdf manages these:
unset GOROOT GOPATH

# This... has to be here. Doesn't seem to work as a plugin
. $HOME/.fzf.zsh
