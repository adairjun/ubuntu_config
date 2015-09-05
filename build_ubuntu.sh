#!/bin/bash
# 需要sudo来执行
dir=`pwd`

function rootness {
	if [[ $EUID -ne 0 ]]
	then
		echo "Error:This script must be run as root!" 1>&2
		exit 1
	fi
}

function apt_conf {
	apt-get clean
	apt-get autoclean
	apt-get update
	apt-get -y upgrade
	apt-get -y dist-upgrade
}

function git_conf {
	apt-get -y install git
	cp $dir/gitconfig ~/.gitconfig
}

function term_conf {
	apt-get -y install terminator
	git clone https://github.com/ghuntley/terminator-solarized.git $dir
	mkdir -p ~/.config/terminator/
	cp $dir/terminator-solarized/config ~/.config/terminator
	#把默认的配色方案设置为solarized-dark
	sed -i "{/^\s*#/d; /solarized-dark/d; /solarized-light/,+5d}" ~/.config/terminator/config
	git clone https://github.com/seebi/dircolors-solarized.git
	cp $dir/dircolors-solarized/dircolors.256dark ~/.dircolors
	rm -rf $dir/terminator-solarized/
	rm -rf $dir/dircolors-solarized/
}

function vim_conf {
	cp $dir/vimrc ~/.vimrc
	mkdir ~/.vim
	cp -R $dir/doc/ ~/.vim/
}

function tmux_conf {
	apt-get -y install tmux
	cp $dir/tmux.conf ~/.tmux.conf
}

function hosts_conf {
	git clone https://github.com/racaljk/hosts.git
	cat ./hosts/hosts >> /etc/hosts
	rm -rf ./hosts/
}

function sublime_conf {
	dpkg -i $dir/sublime-text_build-3083_amd64.deb
}

function jdk_conf {
	apt-get -y autoremove openjdk
	cd /usr/local/lib
	tar -zxvf $dir/jdk-8u45-linux-x64.tar.gz
	cat > /etc/profile <<EOF
export JAVA_HOME=/usr/local/lib/jdk1.8.0_45
export JRE_HOME=\$JAVA_HOME/jre
export CLASSPATH=/usr/local/lib/jdk1.8.0_45/lib
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:.
export PATH=\$JAVA_HOME/bin:\$PATH
EOF
	source /etc/profile
	cd $dir
}

function eclipse_conf {
	cd /opt
	tar -zxvf $dir/eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz
	cd $dir
}

function chrome_conf {
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	dpkg -i google-chrome-stable_current_amd64.deb 
}

function flash_conf {
	apt-get -y install flashplugin-nonfree 
	update-flashplugin-nonfree --install 
}

function sogou_conf {
	dpkg -i $dir/sogoupinyin_1.2.0.0056_amd64.deb
}

function infinality_conf {
	add-apt-repository ppa:no1wantdthisname/ppa
	apt-get update
	apt-get -y upgrade
	apt-get -y install fontconfig-infinality
	bash /etc/fonts/infinality/infctl.sh setstyle osx2
}

function zsh_conf {
	apt-get -y install zsh
	chsh -s /bin/zsh
	git clone https://github.com/robbyrussell/oh-my-zsh.git /$HOME/.oh-my-zsh
	cp /$HOME/.oh-my-zsh/templates/zshrc.zsh-template /$HOME/.zshrc
	apt-get -y install autojump
	cat > /etc/profile <<EOF
PROMPT=$'[%{$fg[white]%}%n@%m%{$reset_color%} %~]%# '

alias ll='ls -l' 
alias vi='vim'
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias diff="colordiff"
alias javac="javac -J-Dfile.encoding=utf8"
alias java="java -ea"

export TERM=xterm-256color

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "\$(dircolors -b ~/.dircolors)" || eval "\$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

[[ -s /usr/share/autojump/autojump.zsh ]] && . /usr/share/autojump/autojump.zsh
EOF
	source /$HOME/.zshrc
}

function other_conf {
	apt-get -y install tree pstree ack-grep colordiff
	apt-get -y install unrar unzip
	# 安装几个我常用的小工具，秒杀top的htop，两款流量监控工具iftop和nethogs，很好用的下载工具aria2：
	apt-get -y install htop iftop nethogs aria2 
	# Python类工具需要：
	apt-get -y install python-dev python-greenlet python-gevent python-vte python-openssl python-crypto python-appindicator python-bs4 libnss3-tools
}

#如果用的是bcm网卡,用这个来解决网络慢的问题
#如果单独执行这个函数，最后需要重启
function bcm_conf {
	apt-get -y install bcmwl-kernel-source       
	cat >> /etc/modprobe.d/blacklist.conf <<EOF
blacklist b43
blacklist ssb
blacklist brcmsmac
EOF
}


if [ -z "$1" ]
then
	rootness
	apt_conf
	git_conf
	term_conf
	vim_conf
	tmux_conf
	hosts_conf
	sublime_conf
	jdk_conf
	eclipse_conf
	chrome_conf
	flash_conf
	sogou_conf
	infinality_conf
	zsh_conf
	other_conf

	reboot
fi

while [ -n "$1" ]
do
	case "$1" in 
	--apt)	 apt_conf ;;
	--git)   git_conf ;;
	--term)  term_conf ;;
	--vim)   vim_conf ;;
	--tmux)  tmux_conf ;;
	--hosts) hosts_conf ;;
	--sub)   sublime_conf ;;
	--jdk)   jdk_conf ;;
	--ecl)   eclipse_conf ;;
	--chr)   chrome_conf ;;
	--fla)   flash_conf ;;
	--sog)   sogou_conf ;;
	--inf)   infinality_conf ;;
	--zsh)   zsh_conf ;;
	--oth)   other_conf ;;
	--bcm)   bcm_conf ;;

	--) shift                         #使用shift将当前的参数双破折线移除
		break ;;
	*)  echo "$1 is not a option" ;;
	esac
	shift
done

count=1
for param in $@
do
	echo "para $count: $param"
	count=$[ $count+1 ]
done
