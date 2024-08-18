#!/bin/sh

#usage: source setup.sh 

if [ ! -d $HOME/.undo_history ];then
	mkdir $HOME/.undo_history
fi

if [ ! -d $HOME/.tmux_workspace_save ];then
    mkdir -p $HOME/.tmux_workspace_save
fi

tool_path=$(pwd)

#delete old files
rm $HOME/.vimrc
rm $HOME/.vim
rm $HOME/.zshrc
rm $HOME/.oh-my-zsh
rm $HOME/xshell.sh

tar -xf .oh-my-zsh.tar
tar -xf .vim.tar

#create soft-link
ln -s $tool_path/.zshrc $HOME/
ln -s $tool_path/.oh-my-zsh $HOME/
ln -s $tool_path/.vimrc $HOME/
ln -s $tool_path/.vim $HOME/
ln -s $tool_path/xshell.sh $HOME/
ln -s $tool_path/mobaxterm.sh $HOME/

#update soft source
sudo apt-get update 

#install zsh
sudo apt-get install zsh

#clone .oh-my-zsh
# git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
# git clone https://gitee.com/mirrors/oh-my-zsh.git $HOME/.oh-my-zsh

#install zsh-autosuggestions
#作用：自动补全工具
# git clone git://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/plugins/zsh-autosuggestions
# git clone https://gitee.com/oliverck/zsh-autosuggestions.git $HOME/.oh-my-zsh/plugins/zsh-autosuggestions
# sudo apt-get install zsh-autosuggestions

#oh-my-zsh themes can download from https://github.com/robbyrussell/oh-my-zsh/wiki/themes

#install setop for zsh
sudo apt-get install setop

#install util-linux for zsh
sudo apt-get install util-linux

#install autojump for zsh
#作用：输入j [不明确的路径]，按tab就会搜索出可能的路径
sudo apt-get install autojump

#install tmux for zsh
#作用：可以在同一个终端里面进行分屏
sudo apt-get install tmux

#install cscope for vim
sudo apt-get install cscope

#install ctags for vim
sudo apt-get install exuberant-ctags

#install vim-gtk, support copy and parse with windows
sudo apt-get install vim-gtk

#install net-tools for ifconfig
sudo apt-get install net-tools

#change default shell
chsh -s /bin/zsh

#change default shell if chsh fail, need restart terminal
sudo usermod $USERNAME -s /bin/zsh

source $HOME/.zshrc

#install ssh
sudo apt-get install openssh-server

#create keygen
sudo ssh-keygen -A

#install python3 for format tool
sudo apt-get install python3 

#install svn for format tool
sudo apt-get install subversion

#install astyle for format tool
sudo apt-get install astyle

#install tig for git
sudo apt-get install tig 

#copy format tool to /usr/local/bin
sudo cp format* /usr/local/bin

