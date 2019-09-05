#!/bin/bash 

cd ~
echo "============================="
echo "更新源相关操作"
sudo pacman-mirrors -i -c China -m rank

#sudo pacman-optimize && sync

sudo echo -e "\n[archlinuxcn]\nSigLevel = Optional TrustedOnly\nServer = https://mirrors.ustc.edu.cn/archlinuxcn/$arch" >> /etc/pacman.conf

sudo pacman -Syyu && sudo pacman -S archlinuxcn-keyring

echo "============================="
echo "解决时间同步问题"

sudo timedatectl set-ntp true

echo "============================="
echo "安装yaourt,yay,vim"
sudo pacman -S yaourt 
sudo pacman -S yay
yay --aururl "https://aur.tuna.tsinghua.edu.cn" --save
sudo pacman -S vim

echo "============================="
echo "安装输入法"
yay -S  fcitx-im fcitx-configtool fcitx-googlepinyin 
sudo vim ~/.xprofile
sudo echo -e "export GTK_IM_MODULE=fcitx\nexport QT_IM_MODULE=fcitx\nexport XMODIFIERS='@im=fcitx'" >> ~/.xprofile
sudo echo -e "export GTK_IM_MODULE=fcitx\nexport QT_IM_MODULE=fcitx\nexport XMODIFIERS='@im=fcitx'" >> ~/etc/environment

ehco "=============================="
echo "设置中文环境"
sudo echo -e "export LANG=zh_CN.UTF-8\nexport LANGUAGE=zh_CN:en_US\nexport LC_CTYPE=en_US.UTF-8\nexport LC_ALL="zh_CN.UTF-8"" >> ~/.xprofile


echo "============================="
echo "安装sublime-text"
echo "Install the GPG key"
curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
echo "Select the channel to use:stable and add the sublimetext source"
echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
echo "Update pacman and Install Sublime Test"
sudo pacman -Syu sublime-text

echo "============================="
echo "安装R语言环境和Rstudio"
yay -S microsoft-r-open
yay -S gcc-fortran
yay -S rstudio-bin

echo "============================="
echo "安装net-tools,typora,wps,网易云音乐,megasync网盘"
sudo pacman -S net-tools
sudo pacman -S typora
sudo pacman -S wps-office ttf-wps-fonts
sudo pacman -S netease-cloud-music
sudo pacman -S megasync


echo "============================="
echo "安装deepin-wine-tim，微信"
yay -S deepin-wine-tim
sudo pacman -S electronic-wechat









#echo "============================="
# echo "开始下载安装pycharm社区版2018"
# wget https://download.jetbrains.8686c.com/python/pycharm-community-2018.2.4.tar.gz
# tar -xzvf pycharm-community-2018.2.4.tar.gz
# cd pycharm-community-2018.2.4/bin/
# ./pycharm.sh

# echo "创建pycharm快捷方式"
# echo "Desktop Entry]
# Type=Application
# Name=Pycharm
# GenericName=Pycharm3
# Comment=Pycharm3:The Pychon IDE
# Exec="$HOME/pycharm-community-2018.2.4/bin/pycharm.sh" %f
# Icon="$HOME/pycharm-community-2018.2.4/bin/pycharm.png"
# Terminal=pycharm
# Categories=Pycharm;" > /usr/share/applications/pycharm.desktop
# sudo chmod u+x /usr/share/applications/pycharm.desktop


cd ~
echo "============================="
echo "安装goole-chrome"
sudo pacman -S google-chrome
# yaourt -S google-chrome

# echo "============================="
# echo "安装vscode"
# yaourt -S visual-studio-code-bin

# ....
echo "============================="
echo "Reboot now? Y/N"
 
read res
 
if [[ $res = "Y"||$res = "y" ]]
then
        reboot
elif [[ $res = "N"||$res = "n" ]]
then
        echo "============================="
        echo -e "OK!\nBut if you need,you can edit the program."

fi
