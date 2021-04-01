source ~/.antigen-src/antigen.zsh

antigen use oh-my-zsh

source ~/.zsh/rcs/local-bundles.zsh

antigen bundles <<EOBUNDLE
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions src
  zsh-users/zsh-syntax-highlighting

  kiurchv/asdf.plugin.zsh

  docker
  docker-compose
  docker-machine
  git
  git-extras
  golang
  kubectl
  pass
  ruby
  z

  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh git_funcs.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh aliases.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh colors.zsh
  /home/jcmuller/Development/MyStuff/custom-oh-my-zsh cargo.zsh
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

autoload -Uz compinit && compinit

xmodmap ~/.Xmodmap

autoload -U +X bashcompinit && bashcompinit

# asdf manages these:
unset GOROOT GOPATH

alias cd='HOME=${PROJECT:-$HOME} cd'
alias cdr='cd $(~/bin/cdr)'

eval "$(starship init zsh)"
eval "$(asdf exec direnv hook zsh)"

eval "$(helm completion zsh)"
eval "$(kubectl completion zsh)"
eval "$(minikube completion zsh)"
source ~/.asdf/completions/asdf.bash
source ~/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/tmux/tmux.plugin.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

complete -o nospace -C /home/jcmuller/.asdf/installs/tanka/0.11.0/bin/tk tk

complete -o nospace -C /home/jcmuller/go/bin/mc mc

if [[ ":$PATH:" != *":$HOME/.datacoral/cli/bin:"* ]];
then
  export PATH=$HOME/.datacoral/cli/bin:$PATH
fi
