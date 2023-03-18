BROWSER=/home/jcmuller/go/bin/picky; export BROWSER
GOPRIVATE=github.com/grnhse; export GOPRIVATE
MANPAGER='nvim -n +Man!'; export MANPAGER
NVIM_LISTEN_ADDRESS="/tmp/neovim.sock"; export NVIM_LISTEN_ADDRESS
QT_QPA_PLATFORMTHEME=gtk3; export QT_QPA_PLATFORMTHEME
REPORTTIME=5; export REPORTTIME
TF_PLUGIN_CACHE_DIR=~/.terraform/terraform-plugin-dir; export TF_PLUGIN_CACHE_DIR
TIMEFMT="'$fg[green]%J$reset_color' time: $fg[yellow]%*Es$reset_color, cpu: $fg[yellow]%P$reset_color, mem: $fg[yellow]%M$reset_color"; export TIMEFMT
_Z_CMD=j; export _Z_CMD

# GPG
GPG_TTY=$(tty); export GPG_TTY

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
)

fpath=(
  $HOME/go/share/zsh
  /home/jcmuller/.local/share/zsh/functions
  $fpath
)

set noclobber

source ~/.zsh/zprofile.d/zprofile.zsh
