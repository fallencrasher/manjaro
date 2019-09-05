最近迷上了鼓捣linux，经历了deepin，ubuntu和manjaro，最后留在了manjaro，这个东西真的棒棒，尤其是软件系统，唉，欲罢不能，哈哈，如今来记录一下自己的安装过程来备忘，如果能帮助别人那就更好了。

## 分区问题

如果你打算安装双系统，恭喜你，我就是这么做的，亲测好用。你的分区可以参考这个。（我用来装manjora的分区是200G）

| /          | 40G        | ext4 |
| ---------- | ---------- | ---- |
| /boot      | 512M       | ext4 |
| /linuxswap | 8G         |      |
| /var       | 15G        | ext4 |
| /home      | 剩下的所有 | ext4 |

*注意：必须再我们windows启动的盘符上（一般为 /dev/sd2）挂载 “/boot/efi”，否则无法启动系统*

## 修改镜像源和下载软件

### 修改镜像源

``` shell
sudo pacman-mirrors -i -c China -m rank
```

该命令是用于找出国内比较快打镜像源，会有一个可以选择的列表，直接选清华源就行了。

然后我们在配置文件 "/etc/pacman.conf" 里修改清华源

```shell
#added sources
[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch

#[antergos]
#Server = https://mirrors.tuna.tsinghua.edu.cn/antergos/$repo/#$arch
```

接着安装密钥

```shell
sudo pacman -S archlinuxcn-keyring 
```

更新软件列表

```shell
sudo pacman -Syu
```

安装 yaourt,yay

```shell
sudo pacman -S yaourt
sudo pacman -S yay


AUR 镜像使用帮助
yaourt 用户
修改 /etc/yaourtrc，去掉 # AURURL 的注释，修改为

AURURL="https://aur.tuna.tsinghua.edu.cn"
yay 用户
执行以下命令修改 aururl :

yay --aururl "https://aur.tuna.tsinghua.edu.cn" --save
修改的配置文件位于 ~/.config/yay/config.json ，还可通过以下命令查看修改过的配置：

yay -P -g
```

在 “/etc/yaourtrc” 修改，去掉 #AURURL 的注释，修改为

```shell
AURURL=”https://aur.tuna.tsinghua.edu.cn”
```

再次更新软件列表

```shell
sudo pacman -Syu
```

### 安装 net-tools ,typora,搜狗输入法,chrome,wps,网易云音乐,megasync网盘

```shell
sudo pacman -S net-tools
sudo pacman -S typora
sudo pacman -S fcitx-im fcitx-configtool fcitx-sogoupinyin
sudo pacman -S google-chrome
sudo pacman -S wps-office ttf-wps-fonts
sudo pacman -S netease-cloud-music
sudo pacman -S megasync
```

### 安装 Tim 和 微信

```shell
yaourt qq
这条命令会搜索 aur 源里的能用的 qq软件，挑一个自己能用的吧，我用的是 deepin-wine-tim
微信的话，就去清华源软件库里找 Ctrl+F 搜索，然后下载包直接用 “pacman -U 包名”来安装，亲测可用
electronic-wechat
清华源软件库镜像是：  https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/x86_64/
```

### 安装sublime-text, 从官网

## pacman

Install the GPG key:

```shell
curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
```

Select the channel to use:

- Stable

  `echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf `

- Dev

  `echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/dev/x86_64" | sudo tee -a /etc/pacman.conf `

Update pacman and install Sublime Text

```
sudo pacman -Syu sublime-text
```

### 安装R语言环境和Rstudio

```shell
sudo pacman -S microsoft-r-open
sudo pacman -S gcc-fortran
如果pacman安装不上就是尝试用 yaourt
yaourt -S microsoft-r-open
yaourt -S gcc-fortran

```



### 设置搜狗输入法的环境变量 “~/.xprofile”  “/etc/environment”

```shell
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
```

### 关于软件的下载与安装

在设置完成 清华源 和 AUR 源后，基本上我们知道软件名就可以用命令行安装了，但是尴尬的是我们不知道软件在软件库里叫什么名字，但是我们可以直接去软件库里查看，就用 Ctrl+F 来查找关键字就好

[清华源archlinuxcn](https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/x86_64/)

[官方AUR源](https://aur.archlinux.org/)



## 设置中文显示

具体可以按照 archLinux 的 wiki 来修改设置，一步一步按照他说的做就可以了

[官方中文设置wiki](https://wiki.archlinux.org/index.php/Localization/Simplified_Chinese_(简体中文)#locale.E8.AE.BE.E7.BD.AE)

## 基本中文支持

要正确显示中文，必需设置正确的locale并安装合适的中文字体。

### locale设置

### 安装中文locale

Linux中通过locale来设置程序运行的不同环境。常用的中文locale有（最直观的分别是可显示字的数量）：

```
zh_CN.GB2312
zh_CN.GBK
zh_CN.GB18030
zh_CN.UTF-8
zh_TW.BIG-5
zh_TW.UTF-8
```

推荐使用UTF-8的locale。对于glibc（>=2.3.6），需要修改`/etc/locale.gen`文件来设定系统中可以使用的locale（取消对应项前的注释符号「`#`」即可）：

```
en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
```

然后执行`locale-gen`命令，便可以在系统中使用这些locale。可以通过`locale`命令来查看当前使用的locale：亦可通过`locale -a`命令来查看目前可以使用的locale；

### 启用中文locale

Arch Linux中，通过`/etc/locale.conf`文件设置全局有效的locale：

```
LANG=en_US.UTF-8
```

**警告:** 不推荐在此设置中文locale，会导致tty乱码；在tty下亦可显示和输入中文，但需要安装cce、zhcon或[fbterm](https://github.com/felixonmars/aur3-mirror/tree/master/fbterm)；

**提示：** 如欲为内核打中文补丁，可参见[[1\]](http://blog.chinaunix.net/space.php?uid=436750&do=blog&id=2123586)；

对于特定用户，还可以在`~/.bashrc`、`~/.xinitrc`或`~/.xprofile`中设置自己的用户环境。不同之处在于：

- .bashrc: 每次**终端登录时**读取并运用里面的设置。
- .xinitrc: 每次**startx启动X界面时**读取并运用里面的设置
- .xprofile: 每次**使用gdm等图形登录时**读取并运用里面的设置

#### 单独在图形界面启用中文locale

不推荐`/etc/locale.conf`使用全局中文locale，会导致tty乱码。

如前面所说，可以在`~/.xinitrc`或`~/.xprofile`单独设置中文locale。添加如下内容到上述文件最前端注释之后（如果不确定使用哪个文件，可以都添加）：

```
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US
export LC_CTYPE=en_US.UTF-8
```

**注意:** 若欲将此三行放至`~/.xinitrc`中，请注意将其放在`exec *_example_WM_or_DE_*`行之前；此为常见错误；

**注意:** 该方法适用于slim或者无登陆管理器的用户，GDM和KDM用户可以在Gnome或KDE设置中选择语言。

#### 图形界面用户设置全面的中文

添加如下内容到文件`~/.xprofile`文件中

```
export LC_ALL="zh_CN.UTF-8"
```

**注意:** 图形界面用户使用

### 配置邮箱

授权  akubapkecpeeghbf 