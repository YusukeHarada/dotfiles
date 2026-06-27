# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# ARM GCC toolchain (auto-detects latest installed version)
_arm_gcc=(/Applications/ArmGNUToolchain/*/arm-none-eabi/bin(N[-1]))
[[ -n "$_arm_gcc" ]] && export PATH="$_arm_gcc:$PATH"
unset _arm_gcc

# History
HISTSIZE=50000
SAVEHIST=50000
HISTFILE="$HOME/.zsh_history"
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS

# Completion (キャッシュを使い24時間ごとにのみ再生成)
autoload -Uz compinit
if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Prompt (simple, no external deps)
autoload -Uz vcs_info add-zsh-hook
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST
PROMPT='%F{cyan}%~%f%F{yellow}${vcs_info_msg_0_}%f %# '

# zsh plugins (Homebrew)
[[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf
[[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]] && \
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
[[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]] && \
  source /opt/homebrew/opt/fzf/shell/completion.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview "bat --color=always --style=numbers {} 2>/dev/null || eza --icons {}" --preview-window=right:50%:wrap'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# zoxide (smart cd)
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# gh completion
command -v gh &>/dev/null && eval "$(gh completion -s zsh)"

# Aliases — filesystem
alias ls='eza --icons'
alias ll='eza -laF --icons --git'
alias la='eza -aF --icons'
alias lt='eza --tree --icons'
alias ..='cd ..'
alias ...='cd ../..'

# Aliases — search & view
alias cat='bat --paging=never'
alias grep='rg --color=auto'
alias find='fd'

# Aliases — git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias glog='git log --oneline --graph --decorate --all'
alias gst='git stash'
alias gstp='git stash pop'

# Aliases — misc
alias reload='source ~/.zshrc'

# zsh-syntax-highlighting (must be last)
[[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(rbenv init - zsh)"
