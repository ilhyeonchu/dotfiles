if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting history-substring-search rbenv)

source $ZSH/oh-my-zsh.sh
export PATH=$HOME/.local/bin:$PATH
export PATH=/usr/local/cuda-12.8/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12.8/lib64:$LD_LIBRARY_PATH
# export PATH=/usr/local/cuda-12.5/bin${PATH:+:${PATH}}
# export LD_LIBRARY_PATH=/usr/local/cuda-12.5/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export MyGit=~/Documents/GitHub
export PATH="$HOME/.rbenv/bin:$PATH"
export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$PATH:$HOME/.dotnet:$HOME/.dotnet/tools"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export OBSIDIAN_VAULT="/home/ilhyeonchu/Documents/GitHub/obsidian"

# 단축어 모음
typeset -A shortcuts
shortcuts=(
    nv "nvim/.config/nvim/"
    tm "tmux"
    wez "wezterm"
    ip "Image-Processing"
    dc "Data-Communication"
    upl "UPL25"
    blog "ilhyeon-study-log.github.io"
)
_get_target_dir() {
    local shortcut=$1
    # 단축어 모음(shortcuts) 에 있으면 변환
    echo "${shortcuts[$shortcut]:-$shortcut}"
}
alias rc='nv ~/.zshrc'
alias svenv='source .venv/bin/activate'
alias share='cd /mnt/window_share'
alias cdgit='cd $MyGit'
alias nv='nvim'
alias progc='cd "$MyGit/Practice-C"'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias woldesktop='wakeonlan 74:56:3c:62:0f:65'
alias wolgpu='wakeonlan 10:ff:e0:bf:f7:33 & wakeonlan 6c:1f:f7:26:c7:2a'
alias tm='tmux'
alias wez='wezterm'
alias cdh='cd ~/'
alias pdf='~/termpdf.py/termpdf.py'
alias leaktest='ASAN_OPTIONS=detect_leaks=1 ./test'
alias makejson='bear -- make'

# go to dotfiles directory
cdinit() {
    local target_dir=$(_get_target_dir "$1")
    cd ~/dotfiles/$target_dir
}

# go to git directory
cdg() {
    local target_dir=$(_get_target_dir "$1")
    cd $MyGit/$target_dir
}

gccp() {
	gcc -o $* $*.c
	./$*
}

gcom() {
  git add .
	git commit -m "$*"
	git push
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#. "$HOME/.local/bin/env"
export VCPKG_NUM_CPUS=$(nproc)
eval "$(rbenv init - zsh)"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Created by `pipx` on 2025-09-18 13:12:56
export PATH="$PATH:/home/ilhyeonchu/.local/bin"
export PATH="$HOME/.local/share/gem/ruby/3.1.0/bin:$PATH"
