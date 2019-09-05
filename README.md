# manjaro-set
My first project for manjaro-set about setup and set of manjaro.It's ok if anyone want to give a suggest.

## First,we setup the manjaro linux OS.
There are many versions of manjaro linux desktop,select one you like to download.For instance,I am using the manjaro-gnome.
Then we burn a u-disk with software rufus(windows os) as dd model.
Reboot your PC and select USB-EFI boot to setup the manjaro linux os.
Select your region and language, then boot the manjaro booting setup option.

### manual partitioning
Here is my partition plan.
My harddrive for installing manjaro is 200G, you can refer to my practise.
---
| mounting point | space                   | format |
| -------------- | ----------------------- | ------ |
| /              | 40G                     | ext4   |
| /boot          | 512M                    | ext4   |
| /linuxswap     | 8G                      |        |
| /var           | 15G                     | ext4   |
| /home          | all the remaining space | ext4   |
| /boot/efi      | 260M                    | fat32  |

---
### Modify the mirros source
Here to select your fastest mirror source.
``` shell
sudo pacman-mirrors -i -c China -m rank
```
Then you can append a mirror source in `/etc/pacman.conf`.
I have put this setting in a file [config.sh](https://github.com/fallencrasher/manjaro-set/blob/master/config.sh)
