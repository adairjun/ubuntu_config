# MAC bash profile
export PYTHONPATH=/Library/Python/2.7/site-packages
export LDFLAGS=-L/usr/local/opt/mysql@5.7/lib
export CPPFLAGS=-I/usr/local/opt/mysql@5.7/include

export GOPATH=$HOME/gopath
export GOROOT=/usr/local/Cellar/go@1.12/1.12.13/libexec
export GO111MODULE=off
export GOPRIVATE=git.cardinfolink.net/Everonet/*

export SYS_ENV=develop
export SYS_NAME=redbud
export SYS_NODE=APP01

export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH=/usr/local/opt/mysql@5.7/bin:$PATH
export PATH=/usr/local/opt/go@1.12/bin:$PATH
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

export TERM=xterm-256color
eval $(gdircolors ~/.dir_colors)

alias cls='clear'
alias ls='gls --color=auto'
alias ll='ls -lG'
alias la='ls -a'
alias vi='vim'
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias gst='git status'
alias gcom='git commit -m'
alias gps='git push'
