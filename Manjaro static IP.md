# Manjaro设置静态IP

##### 一、确认需要配置静态ip的网卡：

`ip addr`命令查看网卡



![img](https:////upload-images.jianshu.io/upload_images/6956152-4a5904f50972d464.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/433/format/webp)





此例中网卡名称为‘enp3s0’，请根据自己的实际情况进行修改。

##### 二、刷新IP配置并禁用服务

停止网卡服务：

`sudo ifcfg enp3s0 stop
 `

`sudo ip link set enp3s0 down`

`sudo ip addr flush enp3s0`
 禁用DHCP客户端后台驻留程序和网络管理器服务：

```shell
sudo systemctl stop dhcpcd
sudo systemctl disable dhcpcd
 sudo systemctl stop NetworkManager
 sudo systemctl disable NetworkManager
```

我们不需要网络管理器，因为我们将使用netctl

##### 三、创建/修改接口的配置文件

复制系统自带的示例netctl配置文件：
 `cd /etc/netctl`
 `sudo cp examples/ethernet-static ./enp3s0`

根据实际情况修改此配置文件：
 `sudo vim ./enp3s0`

```shell
Description='enp3s0'
Interface=enp3s0
Connection=ethernet
AutoWired=yes
SkipNoCarrier=yes
IP=static
Address=('192.168.1.14/24')
Gateway='192.168.1.1'
DNS=('192.168.1.11' '192.168.1.12')
```

退出vim编辑器，保存更改

##### 四、加载并启用新的配置文件

```shell
sudo netctl enable enp3s0
sudo netctl start enp3s0
```