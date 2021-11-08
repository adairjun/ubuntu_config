# system
export TERM=xterm-256color
eval $(gdircolors ~/.dircolors)

alias ls="gls --color=auto"
alias ll="ls -lG"
alias vi="vim"
alias grep="egrep --color=auto"
alias diff="colordiff"
alias cdo="cd $HOME/gopath/src/bitbucket.org/grabpay/grablink-go/gl-online"
export PATH=/usr/local/bin:$PATH

# nodejs
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm" 
alias nvm='unalias nvm node npm && . /usr/local/opt/nvm/nvm.sh && nvm'
alias node='unalias nvm node npm && . /usr/local/opt/nvm/nvm.sh && node'
alias npm='unalias nvm node npm && . /usr/local/opt/nvm/nvm.sh && npm'

# go
export GOPATH="$HOME/gopath"
export GOROOT="/usr/local/Cellar/go@1.16/1.16.10/libexec"
export GO111MODULE=off
export GOPRIVATE="gitlab.myteksi.net,bitbucket.org/grabpay"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/src/gitlab.myteksi.net/gophers/go/scripts
export PATH="$PATH:$GOPATH/src/bitbucket.org/grabpay/grablink-go/scripts/profiling"

# redis, mysql
export REDIS_HOST="${REDIS_HOST:-localhost}"
export REDIS_CLUSTER_HOST="${REDIS_CLUSTER_HOST:-${REDIS_HOST}}"
export MYSQL_USER="${MYSQL_USER:-root}"
export MYSQL_PASSWORD="${MYSQL_PASSWORD:-123456}"
export MYSQL_HOST="${MYSQL_HOST:-localhost}"
export MYSQL_PORT="${MYSQL_PORT:-3306}"
export POSTGRES_HOST="${POSTGRES_HOST:-localhost}"
export GRABDDB_HOST="${GRABDDB_HOST:-http://localhost:8000}"
export ETCD_HOST="${ETCD_HOST:-localhost}"
export ELASTICSEARCH_HOST="${ELASTICSEARCH_HOST:-localhost}"
export SCYLLA_HOST="${SCYLLA_HOST:-localhost}"
export KAFKA_HOST="${KAFKA_HOST:-localhost}"
export PATH=/usr/local/opt/mysql@5.7/bin:$PATH

# Miscellaneous & legacy configurations
export CONF_SERVER_CONF=$GOPATH/src/bitbucket.org/grabpay/grablink-go/resources/etcd.json
export DATA_CONF=$GOPATH/src/bitbucket.org/grabpay/grablink-go/resources/data.json
export ALL_DEPRECATED_INITS_MIGRATED=true
export GOLANG_PROTOBUF_REGISTRATION_CONFLICT=warn
export GRAB_METADATA=$GOPATH/src/bitbucket.org/grabpay/grablink-go/resources/metadata.json
export TRACER_CONF=$GOPATH/src/bitbucket.org/grabpay/grablink-go/resources/tracer.json

# Grablink Online service config
export GL_ROUTE_CONF=$GOPATH/src/bitbucket.org/grabpay/grablink-go/gl-route/config-ci.json
export GL_CARDBIN_CONF=$GOPATH/src/bitbucket.org/grabpay/grablink-go/gl-cardbin/config-ci.json
export GL_RECON_CONF=$GOPATH/src/bitbucket.org/grabpay/grablink-go/gl-recon/config-ci.json
export GL_UNIQUE_CONF=$GOPATH/src/bitbucket.org/grabpay/grablink-go/gl-unique/config-ci.json
export GL_AUTH_CONF=$GOPATH/src/bitbucket.org/grabpay/grablink-go/gl-auth/config-ci.json
export GL_REPORT_CONF=$GOPATH/src/bitbucket.org/grabpay/grablink-go/gl-report/config-ci.json
export GL_PAYGW_CONF=$GOPATH/src/bitbucket.org/grabpay/grablink-go/gl-paygw/config-ci.json
export GL_SETTLE_CONF=$GOPATH/src/bitbucket.org/grabpay/grablink-go/gl-settle/config-ci.json
export GL_ONLINE_CONF=$GOPATH/src/bitbucket.org/grabpay/grablink-go/gl-online/config-ci.json
export GL_WBE_CONF=$GOPATH/src/bitbucket.org/grabpay/grablink-go/gl-wbe/config-ci.json
export GL_CONNECT_CONF=$GOPATH/src/bitbucket.org/grabpay/grablink-go/gl-connect/config-ci.json
export GL_MEX_CONF=$GOPATH/src/bitbucket.org/grabpay/grablink-go/gl-mex/config-ci.json
export GL_MIGRATE_CONF=$GOPATH/src/bitbucket.org/grabpay/grablink-go/gl-migrate/config-ci.json
export GL_NOTIFY_CONF=$GOPATH/src/bitbucket.org/grabpay/grablink-go/gl-notify/config-ci.json

export SYS_ENV=local
export SYS_NAME=gl
export HOST_NAME=localhost
