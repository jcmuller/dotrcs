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

fpath=(
  $HOME/go/share/zsh
  /home/jcmuller/.local/share/zsh/functions
  "${fpath[@]}"
)

set noclobber
