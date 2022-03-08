# .bashrc

# aliases
alias ls='ls --color=auto --group-directories-first'
alias la="ls -alh"
alias ll="ls -lh"
alias c="clear"
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias tree="tree -C --dirsfirst"
alias k="kubectl"
alias grep="grep --colour=always"

alias pt="pipenv run pytest tests"
alias pu="python -m unittest discover tests"

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\W\[\033[m\]\$ "
