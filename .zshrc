BROWSER=/home/jcmuller/go/bin/picky; export BROWSER
NVIM_LISTEN_ADDRESS="/tmp/neovim.sock"; export NVIM_LISTEN_ADDRESS
QT_QPA_PLATFORMTHEME=qt5ct; export QT_QPA_PLATFORMTHEME
# Report any command running longer than 5 seconds
REPORTTIME=5; export REPORTTIME
TIMEFMT="'$fg[green]%J$reset_color' time: $fg[yellow]%*Es$reset_color, cpu: $fg[yellow]%P$reset_color, mem: $fg[yellow]%M$reset_color"; export TIMEFMT

unset SSH_AGENT_PID SSH_AUTH_SOCK

PATH_COMPONENTS=(
"$HOME/bin"
"$HOME/.cargo/bin"
"$HOME/.local/bin"
"$HOME/.yarn/bin"
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
)
PATH=${(j/:/)PATH_COMPONENTS}
export PATH

source ~/.antigen-src/antigen.zsh

antigen use oh-my-zsh

antigen theme /home/jcmuller/Development/MyStuff/custom-oh-my-zsh themes/juancmuller.zsh-theme

antigen bundles <<EOBUNDLE
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-completions src
  zsh-users/zsh-autosuggestions

  aws
  docker
  docker-compose
  docker-machine
  git
  git-extras
  go
  pass
  rbenv
  ruby
  thor
  tmux

  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh aliases.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh aws.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh colors.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh dajoku.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh directories.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh docker-pg.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh enable-edit-command-line.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh environment.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh extra.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh gh-aliases.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh git_funcs.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh goenv.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh jenkins.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh local.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh nodenv.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh nvim.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh pass.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh perl.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh plugins
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh rbenv.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh vi-mode.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh zeus.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh zsh_completions.zsh

  github/hub etc/hub.zsh_completion
EOBUNDLE

antigen apply

set noclobber

xmodmap ~/.Xmodmap
