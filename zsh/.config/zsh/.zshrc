#### POWERLEVEL 10K ####
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


#### keybind config ####

# use emacs mode despite setting EDITOR to vim
bindkey -e

# emulate ctrl-u in bash (ALT-k)
bindkey "^[k" backward-kill-line

# enable zsh widget to send command line to text editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^x^e" edit-command-line

###########  Config zsh completions ############################

# Update fpath, enable and initialise zsh extensions
if type brew &>/dev/null; then
  # Additional completion definitions for zsh
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  FPATH=$(brew --prefix)/share/zsh-abbr:$FPATH
fi
fpath+=$ZDOTDIR/.zfunc
autoload -Uz compinit && compinit

# disable official git completion in favour of zsh git completion
# see https://bit.ly/3QXliO8 for details
\rm -f $HOMEBREW_PREFIX/share/zsh/site-functions/_git

################################################################


#### history config #### 

export HISTFILE=$ZDOTDIR/.zsh_history

# How many commands zsh will load to memory.
export HISTSIZE=10000

# How many commands history will save on file.
export SAVEHIST=10000

# Remove command from history if prepended with a space
setopt HIST_IGNORE_SPACE

# History won't save duplicates.
setopt HIST_IGNORE_ALL_DUPS

# History won't show duplicates on search.
setopt HIST_FIND_NO_DUPS

# Read and write $HISTFILE for each command
setopt SHARE_HISTORY

#### LOAD PLUGINS & CONFIGS #### 

# Load zsh plugins
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-abbr/zsh-abbr.zsh # for expanding abbreviations in zsh


# enable antidote plugin manager
source /usr/local/opt/antidote/share/antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

# source aliases and functions
[[ -f $ZDOTDIR/.zsh_aliases ]] && source $ZDOTDIR/.zsh_aliases
[[ -f $ZDOTDIR/.zsh_functions ]] && source $ZDOTDIR/.zsh_functions

# load pyenv for managing python versions
eval "$(pyenv init -)"

# load rbenv for managing ruby versions
eval "$(rbenv init - zsh)"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# source config for fzf
source ~/.config/fzf/.fzfrc

# Set up wrapper for brew-file package
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap

  _post_brewfile_update () {
    echo "Brewfile was updated!"
  }
fi
 

# -------- custom PATH entries --------------------------------------

# Pyenv Python version manager
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# Added by n-install (see http://git.io/n-install-repo).
export N_PREFIX="$HOME/util/n"; export PATH=$N_PREFIX/bin:$PATH

export PATH="/usr/local/sbin:$PATH"

export PATH="/usr/local/opt/mongodb-community@5.0/bin:$PATH"

# Created by `pipx` on 2023-10-06 14:39:03
export PATH="$PATH:/Users/timotheos/.local/bin"
export PATH="/usr/local/opt/libarchive/bin:$PATH"
