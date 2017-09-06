# gentoo

form wiki or bash history!


## package manage - emerge

it will across all manager and the tourioul.


## the make.conf file

make.conf  **backup important + /etc/portage +/var/lib/world**


## parted and mount

parted -a optimal /dev/sda

number  start   end     size    file system     name    标志
 1      1049kb  3146kb  2097kb  ntfs            grub    bios<sub>grub</sub>
 2      3146kb  137mb   134mb   fat16           boot    启动, esp
 3      137mb   8000mb  7862mb  linux-swap(v1)  swap
 4      8000mb  62.0gb  54.0gb  ext4            rootfs
 5      62.0gb  1000gb  938gb   ext4            home

mklabel gpt ; rm 2; unit mib ;mkpart name 1 3;print

set 1 bios<sub>grub</sub> on
set 2 boot on

mkfs.vfat /dev/sda2;mkfs.ext4 /dev/sda3;mkswap /dev/sda3

mount *dev/sda4 /mnt/gentoo*
mkdir -p /mnt/gentoo/boot
mount &#x2026; ../boot

/etc/fstab]]

/dev/sda2		/boot/efi	vfat		noauto,noatime	0 1
/dev/sda4		/		ext4		noatime		0 1
/dev/sda3		none		swap		sw		0 0
/dev/sda5               /home		ext4		noatime		0 1
/dev/cdrom		/mnt/cdrom	auto		noauto,ro	0 0
/dev/fd0		/mnt/floppy	auto		noauto		0 0


## install stage3

1.  date
2.  dowload stage3 and check
3.  tar xvjpf stage3-\*.tar.bz2 &#x2013;xattrs


## kernel


### sound

intel al97 &#x2013;power-mode
root #euse -e alsa
root #emerge &#x2013;ask &#x2013;changed-use &#x2013;deep @world
root #emerge &#x2013;ask alsa-utils


### network


### gpu

device drivers &#x2014;>
   graphics support &#x2014;>
	  frame buffer devices &#x2014;>
		 <\*> support for frame buffer devices &#x2014;>
		 ## (disable all drivers, including vga, intel, nvidia, and ati, except efi-based framebuffer support, only if you are using uefi)

\## (further down, enable basic console support. kms uses this.)
console display driver support &#x2014;>
  <\*>  framebuffer console support

device drivers &#x2014;>
	graphics support &#x2014;>
		frame buffer devices &#x2014;>
			<\*> support for frame buffer devices &#x2014;>
			< >   nvidia framebuffer support
			< >   nvidia riva support

nvidia-xconfig
eselect opengl set nvidia
eselect opencl set nvidia


### efi

enable gpt partition label support if that was used previously when partitioning the disk:

kernel enable support for gpt
-\*- enable the block layer &#x2014;>
	&#x2026;
	partition types &#x2014;>
	[\*] advanced partition selection
	  &#x2026;
	  [\*] efi guid partition support

enable efi stub support and efi variables in the linux kernel if uefi is used to boot the system:

kernel enable support for uefi
processor type and features  &#x2014;>
	[\*] efi runtime service support 
	[\*]   efi stub support

firmware drivers  &#x2014;>
	<\*> efi variable support via sysfs


## make and install

cd /usr/src/linux
root #make menuconfig
make && make modules<sub>install</sub>
root #make install

with uefi systems, create the *boot/efi/boot* location, and then copy the kernel into this location, calling it bootx64.efi:

mount /dev/sda1 /boot\*
root #mkdir -p /boot/efi/boot
root #cp /boot/vmlinuz-\* /boot/efi/boot/bootx64.efi
grub2-install &#x2013;target=x86<sub>64</sub>-efi &#x2013;efi-directory=/boot
grub2-mkconfig -o /boot/grub/grub.cfg
emerge @module-rebuild
reboot


## desktop enviorment


### xfce4

x11-base/xorg-server x11-misc/compton x11-misc/slim x11-terms/xfce4-terminal x11-themes/gtk-engines-murrine xfce-base/xfce4-meta xfce-extra/thunar-volman xfce-extra/tumbler xfce-extra/xfce4-battery-plugin xfce-extra/xfce4-mixer xfce-extra/xfce4-notifyd xfce-extra/xfce4-power-manager

1.  slim with xdm

    file /etc/conf.d/xdm
    displaymanager="slim"
    
    root #rc-update add xdm default
    root #/etc/init.d/xdm start
    
    file /etc/env.d/90xsession
    xsession="xfce4"


### emacs

解决 emacs 下 fcitx 无法输入中文

1.  “lc<sub>ctype</sub>=zh<sub>cn.utf8</sub> emacs”
2.  media-fonts/font-misc-misc
3.  fcitx config in .bashrc .xprofile .xinitrc .xssetion
    
    export gtk<sub>im</sub><sub>module</sub>=fcitx
    export qt<sub>im</sub><sub>module</sub>=fcitx
    export xmodifiers=@im=fcitx


### terminal

zsh+git
sudo emerge &#x2013;ask dev-vcs/git
sh -c "$(wget <https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh> -o -)"

---

alias en='emacs -nw'
export term=xterm-256color


### shadowsocks

wget -o- <https://bootstrap.pypa.io/get-pip.py> | sudo python3
apt install python-m2crypto 
sudo pip install shadowsocks

-   bug:
    e .local/lib/python2.7/site-packages/shadowsocks/crypto/openssl.py
    
    evp<sub>cipher</sub><sub>ctx</sub><sub>cleanup</sub> replace "evp<sub>cipher</sub><sub>ctx</sub><sub>reset</sub>"

    {
    	"server"       : "my_server_ip",
    	"server_port"  : 8388,
    	"local_address": "127.0.0.1",
    	"local_port"   : 1080,
    	"password"     : "mypassword",
    	"timeout"      : 300,
    	"method"       : "aes-256-cfb",
    	"fast_open"    : false,
    	"workers"      : 1
    }


### dropbox

32-bit:
cd ~ && wget -o - "<https://www.dropbox.com/download?plat=lnx.x86>" | tar xzf -

64-bit:
cd ~ && wget -o - "<https://www.dropbox.com/download?plat=lnx.x86_64>" | tar xzf -

~/.dropbox-dist/dropboxd

sudo apt-get install libxslt1.1

1.  cd ~/dropnox
2.  ln -s ~/.emacs.d

~/dropbox/linux/xflux -l 30 -g 120 -k 4200
~/.ssh/config
host host.does.not.exist
connecttimeout=1


### fictx

    !#/bin/bash
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
    
    exec startxfce4
    #exec ck-launch-session dbus-launch --sh-syntax --exit-with-session awesome
    #exec fvwm-themes-start
    #exec fvwm
    export lc_ctype=zh_cn.utf-8 
    export xmodifiers="@im=fcitx"
    export qt_im_module=fcitx
    export gtk_im_module=fcitx
    
    # export xmodifiers="@im=ibus"
    # export gtk_im_module="ibus"
    # export qt_im_module="ibus"
    # ibus-daemon -d -x


## network

wpa-supplicant
rp-pppoe
ping

nano -w /etc/conf.d/hostname
emerge &#x2013;ask &#x2013;noreplace net-misc/netifrc
nano -w /etc/conf.d/net
nano -w /etc/resolv.conf ;;dns

file /etc/conf.d/netstatic ip definition
config<sub>eth0</sub>="192.168.0.2 netmask 255.255.255.0 brd 192.168.0.255"
routes<sub>eth0</sub>="default via 192.168.0.1"
to use dhcp, define config<sub>eth0</sub>:

file /etc/conf.d/netdhcp definition
config<sub>eth0</sub>="dhcp"

root #cd /etc/init.d
root #ln -s net.lo net.eth0
root #rc-update add net.eth0 default

nano -w /etc/hosts

nano -w /etc/hostname

file /etc/dhcp/dhclient.conf

file ~/.xinitrc
dbus-launch nm-applet &
for gnome-base/gnome-keyring support, add the following lines before the previous line. this will ease password management for gnupg, ssh and wifi:

eval $(gnome-keyring-daemon &#x2013;components=pkcs11,secrets,ssh,gpg)
export gnome<sub>keyring</sub><sub>pid</sub>
export gnome<sub>keyring</sub><sub>socket</sub>
export ssh<sub>auth</sub><sub>sock</sub>
export gpg<sub>agent</sub><sub>info</sub>

dnsmasq

networkmanager can be set up to use dnsmasq as a local dns server that passes the dns queries on to your provider's dns server. /etc/resolv.conf will be set to point to 127.0.0.1, where dnsmasq runs and processes the queries. this can be useful for example if an application chroots for security reasons and before doing so copies /etc/resolv.conf. then it would never be informed about changes to the dns servers as your laptop moves from wifi to wifi.

file /etc/networkmanager/networkmanager.conf
[keyfile]
hostname=your<sub>hostname</sub>

root #gpasswd -a <user<sub>name</sub>> plugdev
service
openrc

remove any existing network management services (if installed):

root #for service in $(rc-update show default | grep 'net\\.' | awk '{ print $1 }'); do rc-update del $service default; done
root #rc-update del dhcpcd default
start networkmanager:

root #/etc/init.d/networkmanager start
to start networkmanager at boot time add it the default runlevel:

root #rc-update add networkmanager default


## sync and chroot

mkdir /mnt/gentoo/etc/portage/repos.conf
root #cp *mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
cp -l /etc/resolv.conf /mnt/gentoo/etc*

root #chroot /mnt/gentoo /bin/bash
root #source /etc/profile
root #export ps1="(chroot) $ps1"

---

emerge-webrsync

root #emerge &#x2013;sync
root #emerge &#x2013;sync &#x2013;quiet


## profile and locale and timezone

zh<sub>cn.utf</sub>-8 asia/shanghai utc 
eselect profile set(list)
etc-upate


## powermanagement


### laptop-mode-tool

\## valid set
batt<sub>cpu</sub><sub>maxfreq</sub>=fastest
lm<sub>ac</sub><sub>cpu</sub><sub>maxfreq</sub>=fastest
nolm<sub>ac</sub><sub>cpu</sub><sub>maxfreq</sub>=fastest

autosuspend<sub>runtime</sub><sub>devtype</sub><sub>blacklist</sub>=""
1
autosuspend<sub>runtime</sub><sub>devtype</sub><sub>blacklist</sub>=""
更改为：

autosuspend<sub>runtime</sub><sub>devtype</sub><sub>blacklist</sub>="usbhid usb-storage"
1
autosuspend<sub>runtime</sub><sub>devtype</sub><sub>blacklist</sub>="usbhid usb-storage"

/usr/portage/distfiles


## add user and set passwd

root #emerge &#x2013;ask app-admin/sysklogd
root #rc-update add sysklogd default
emerge &#x2013;ask net-misc/dhcpcd ppp

root #exit
cdimage ~#cd
cdimage ~#umount -l /mnt/gentoo/dev{/shm,/pts,}
cdimage ~#umount /mnt/gentoo{/boot,/sys,/proc,}
cdimage ~#reboot

root #useradd -m -g users,wheel,audio -s /bin/bash larry
root #passwd larry


# SSD


## open bios ahci support

closed hibernation


## update to the newer kernel and the newer ssd firmware

sudo smartctl -a /dev/sda


## ext4 filesystem /etc/fstab for mount

jornal and notime


## trim support

sudo hdparm -i /dev/sda | grep "trim supported"

/etc/fstab add noatime

discard参数启动ssd的trim功能，可以提升性能和使用持久性。
notime参数告诉文件系统不要记录文件的最后访问（读取）时间，只记录最后修改时间。可以有效减少对磁盘的读写次数，因为访问频率相对修改来说非常多。如果发现noatime参数影响了某些应用的使用，可以修改notime为relatime，将会让文件系统将最后修改时间作为文件的最后访问时间。

/etc/cron.daily/trim

\#!/bin/sh
log=/var/log/trim.log
echo "**\*** $(date -r) **\***" >> $log
fstrim -v / >> $log
fstrim -v /home >> $log
fstrim -v /boot >> $log

if you use the encrypt you should :dm-crypt
set "discard" option in /etc/crypttab for dm-crypt.


## 4k对齐

~$ sudo sfdisk -d /dev/sda 
warning: extended partition does not start at a cylinder boundary. 
dos and linux will interpret the contents differently. 

unit: sectors 

/dev/sda1 : start=     2048, size=   497664, id=83, bootable 
/dev/sda2 : start=   501758, size=155799554, id= 5 
/dev/sda3 : start=        0, size=        0, id= 0 
/dev/sda4 : start=        0, size=        0, id= 0 
/dev/sda5 : start=   501760, size=155799552, id=83


## swap

$ sudo vim /etc/sysctl.d/99-sysctl.conf
vm.swappiness = 1
vm.vfs<sub>cache</sub><sub>pressure</sub> = 50
vm.swappiness=0


## reduction of ssd write frequency via ramdisk

use of ramdisk can stop constantly changing files from hitting on the ssd (it may hit ssd via swap). ramdisk configuration may be performed via 

set ramtmp, ramrun and ramlock to "yes" (in /etc/default/rcs or /etc/default/tmpfs since wheezy). of course, this will not improve writing to the ssd if your system (filesystem holding / or /tmp) is not located on it. 
/!\\ /etc/default/tmpfs is a sysvinit specific config file. if you are running systemd: 

sudo cp *usr/share/systemd/tmp.mount /etc/systemd/system*
sudo systemctl enable tmp.mount
/etc/fstab: line such as "tmpfs /tmp tmpfs noatime,nosuid 0 0" 
optionally, make system only flush data to the disk every 10 minutes or more: 
kernel settings like the "dirty<sub>buffer</sub><sub>ratio</sub>" etc. may only be available as non-path/mount specific global settings. 
mount option "commit=600" in /etc/fstab. see mount(8). 
or better, use pm-utils (debian bts #659260), tlp, or laptop-mode-tools (also optimizes read buffers) to configure the laptop-mode even under ac operation. 
/!\\ attention: increasing the flushing interval from the default 5 seconds (maybe even until proper shutdown) leaves your data much more vulnerable in case of lock-ups or power failures, and seems to be a global setting. 
enabling ramtmp may cause some (broken) applications to run out of temporary write disk space. in this case, setting tmpdir environment variable for those programs pointing to a writable disk space should fix their situation. it might as well cause other unwanted side effects if the disk space occupied in your /tmp is high (e.g. unexpected swapping). 

please note files in /tmp are wiped out upon reboot unless /etc/default/rcs is set to something other than tmptime=0 (if not set, 0 is the default value). 

persistent ramdisk

as an advanced option, you may consider to use persistent ramdisk (dedicated read/write ram buffer that gets synced periodically and on startup/shutdown) with anything-sync-daemon or goanysync set up: 

/home (synced to work-data-fs raid only once a day?), you only risk settings the true work in /home/\*/work-data is on a dedicated raid 
/home/\*/work-data/volatile (synced more frequently, once per hour?) 
/home/\*/downloads (synced to bulk-data-fs once a day?) 
/var completely if supported (syncing once a day? avoids spin-ups and allows to save /var also to ssd), at least set this up for 
/var/log if supported 
/var/cache/apt/archives 
configure apt to delete package files after installing, to minimize the data to sync. 
options to having logs copied into ram: 

<http://www.debian-administration.org/articles/661>
<http://www.tremende.com/ramlog>
<https://github.com/graysky2/anything-sync-daemon> (if it supports this) 
<https://github.com/wor/goanysync>
if /home is not on a persistent ramdisk, use profile-sync-daemon to have the browser database and cache copied into ram during uptime (<http://ubuntuforums.org/showthread.php?t=1921800> <https://github.com/graysky2/profile-sync-daemon>) 

/home/\*/<browser-cache-and-profiles> (synced to root-fs or home-fs) 
further improvement: patch anything-sync-daemon or goanysync to use a (copy-on-write) union filesystem mount (e.g. <http://aufs.sourceforge.net>) to keep changes in ram and only save to ssd on unmount/shutdown (aubrsync), instead of copying all data to ram and having to sync it all back. 


## io-scheduler ——noop

/etc/default/grub

grub<sub>cmdline</sub><sub>linux</sub><sub>default</sub>="elevator=noop quiet splash video-1024x768m@75m"

grub-mkconfig -o /boot/grub/grub.cfg

maurits@nuc:~$ sudo smartctl -data -a /dev/sda
smartctl 5.41 2011-06-09 r3365 [x86<sub>64</sub>-linux-3.8.0-26-generic] (local build)
copyright (c) 2002-11 by bruce allen, <http://smartmontools.sourceforge.net>

`=` start of read smart data section `=`
smart attributes data structure revision number: 18
vendor specific smart attributes with thresholds:
id# attribute<sub>name</sub>          flag     value worst thresh type      updated  when<sub>failed</sub> raw<sub>value</sub>
1   raw<sub>read</sub><sub>error</sub><sub>rate</sub>     0x0000   006   000   000    old<sub>age</sub>   offline      -       6
3   spin<sub>up</sub><sub>time</sub>            0x0000   100   100   000    old<sub>age</sub>   offline      -       0
4   start<sub>stop</sub><sub>count</sub>        0x0000   100   100   000    old<sub>age</sub>   offline      -       0
5   reallocated<sub>sector</sub><sub>ct</sub>   0x0000   100   100   000    old<sub>age</sub>   offline      -       0
9   power<sub>on</sub><sub>hours</sub>          0x0000   100   100   000    old<sub>age</sub>   offline      -       2592
12  power<sub>cycle</sub><sub>count</sub>       0x0000   100   100   000    old<sub>age</sub>   offline      -       258
232 available<sub>reservd</sub><sub>space</sub> 0x0000   100   100   000    old<sub>age</sub>   offline      -       4914564640
233 media<sub>wearout</sub><sub>indicator</sub> 0x0000   100   000   000    old<sub>age</sub>   offline      -       100


## the cache

tmpfs *home/username*.cache/google-chrome/default tmpfs noexec,defaults,noatime,nodiratime 0 0

browser.cache.disk.parent<sub>directory</sub> /tmp

operation	journal	w/o journal	percent change
git clone	367.0	353.0	3.81 %
make	207.6	199.4	3.95 %
make clean	6.45	3.73	42.17 %

make clean should be in the cache.


## tools

sys-apps/smartmontools
sudo smartctl -a *dev/sda | less
<https://www.maketecheasier.com/monitor-hard-disk-health-linux>*

> 这些数据里，我们需要注意的首先是id为ad的一项，即wear leveling count（颗粒平均擦写次数），图中显示的数据为108，即这块128g的m4的全盘p/e数为108次，因为m4使用的闪存颗粒官方标称寿命为3000次，108约为3000的3%，所以此项的current（当前）值为97，即剩余97%的寿命（亦即ca）。
> 
> 第2项要注意的就是id为aa的grown failing block count（使用中新增坏块数），此项代表ssd的闪存颗粒在使用时出现的坏块（类似于hdd的坏道）数量，此处数据为0即尚未有出现坏块，若新购买回来的m4在正常使用（不包括疯狂跑测试）下，短期内此项数据产生较大变化，那代表盘可能有问题，用户可申请售后服务。
> 
> b5即non-4k aligned access（非4kb对齐访问数）此项，可能很多用户会产生疑问，为什么我明明对齐了，这里还有数据呢？这是因为虽然我们分区对齐了，但我们写入和读取的数据不一定都是4kb或它的整数倍，因此这里就会有数据，我们不需要在意，这一项是m4的开发人员留给他们自己看的；还有c7即ultra dma crc error rate（主机到接口之间传输crc错误率）此项，若此项出现数据，并不代表磁盘有问题，这是数据线有问题或接口接触不良而引起的，一般重新接好或更换数据线后，数值就不会再增加。


## windows

1.  关闭休眠
2.  superfech,windowssearch
3.  25%的预留空间


## health

for samsung ssds, check smart attribute 177 (wear leveling count).

id # 177 wear leveling count

this attribute represents the number of media program and erase operations (the number of times a block has been erased). this value is directly related to the lifetime of the ssd. the raw value of this attribute shows the total count of p/e cycles.
source: <http://www.samsung.com/global/business/semiconductor/minisite/ssd/m2m/download/07_communicating_with_your_ssd.pdf>

the wear level indicator starts at 100 and decreases linearly down to 1 from what i can tell. at 1 the drive will have exceeded all of its rated p/e cycles, but in reality the drive's total endurance can significantly exceed that value.
source: <http://www.anandtech.com/show/7173/samsung-ssd-840-evo-review-120gb-250gb-500gb-750gb-1tb-models-tested/3>

i would suggest you take that last statement about exceeding that value with a grain of salt.


# KDE

root #/etc/init.d/xdm start
emerge &#x2013;ask kde-base/kdeplasma-addons
export kwin<sub>triple</sub><sub>buffer</sub>=1

if you get some bugs,can change the display manager to try!\*


# backup

~/.bash<sub>history</sub>]]
~/.zsh<sub>history</sub>]]
/etc/fstab]]
*etc/default/grub]]
~*.bashrc]]
~/.zshrc]]
~/.config/awesome/rc.lua]]
~/.vim/ .vimrc]]
~/.emacs.d]]


# virtualbox

gpasswd -a <user> vboxusers
gpasswd -a <user> vboxguest
file /etc/conf.d/modules
merge &#x2013;ask app-emulation/virtualbox-guest-additions
modules="vboxdrv vboxnetadp vboxnetflt

---

install extension pack at global setting enable usb 2.0 to camero


# debian nvidia

deb <http://httpredir.debian.org/debian/> jessie main contrib non-free

\## kernelmoduleblacklisting

as mentioned in the comment headers in /etc/modprobe.d/blacklist.conf adding modules there &#x2026;does not affect autoloading of modules by the kernel.; this means that to blacklist a kernel driver such as ipv6 you must do a fake install.
(re)move /etc/modprobe.conf, if present, as it supersedes anything in /etc/modprobe.d/\* (unless you add include /etc/modprobe.d).
the modules listed in /etc/initramfs-tools/modules aren't subject to blacklists so comment it first.
howto:

create a file '/etc/modprobe.d/<modulename>.conf' containing 'blacklist <modulename>'.
run 'depmod -ae' as root
recreate your initrd with 'update-initramfs -u'

-   nvidia
    option "nologo" "1"
    option "renderaccel" "1"
    option "triplebuffer" "true"
    option "migrationheuristic" "greedy"
    
    /etc/x11/xorg.conf.d/20-nvidia.conf
    
    section "device"
    identifier "my gpu"
    driver "nvidia"
    option "nologo" "1"
    option "renderaccel" "1"
    option "triplebuffer" "true"
    option "migrationheuristic" "greedy"
    endsection
    
    nouveau rcutree.rcu<sub>idle</sub><sub>gp</sub><sub>delay</sub>=1
    
    cat /etc/profile.d/tearfree<sub>kde.sh</sub>
    
    option "triplebuffer" "on" 
    
    export kwin<sub>triple</sub><sub>buffer</sub>=1
    export \_<sub>gl</sub><sub>yield</sub>="usleep"
    export clutter<sub>paint</sub>=disable-clipped-redraws:disable-culling
    export clutter<sub>vblank</sub>=true
    export kwin<sub>explicit</sub><sub>sync</sub>=0
    
    in /etc/x11/xorg.conf.d/20-nvidia.conf, add
    option "triplebuffer" "false"
    
    \`\`\`sh

\#1 add these lines (if they don't exist, else make necessary changes in them) to ~/.kde/share/config/nepomukserverrc

[basic settings]
start nepomuk=false

[service-nepomukmigration1]
autostart=false

[service-nepomukstrigiservice]
autostart=false

\#2 then add these lines (if they don't exist, else make necessary changes in them) to ~/.config/akonadi/akonadiserverrc

[qmysql]
name=akonadi
host=
user=
password=
options="unix<sub>socket</sub>=/home/manmath/.local/share/akonadi/db<sub>misc</sub>/mysql.socket"
serverpath=/usr/sbin/mysqld-akonadi
startserver=false

\#3 open ~/.kde/share/config/kdedrc and set "autoload" to false for nepomuksearchmodule

[module-nepomuksearchmodule]
autoload=false

\#4 finally, remove the file nepomukcontroller.desktop and akonaditray.desktop from *usr/share/autostart*, if they exist.

log out or restart your system to experience the lightness and speed of your sexy kde workspace.

\`\`\`

-   virtualbox

/usr/lib/virtualbox/virtualbox &#x2013;comment "win10" &#x2013;startvm "f7320602-1a86-4461-8af6-2bce9dbccdda"  

-   compelete gnome or gnome 
     aptitude purge \`dpkg &#x2013;get-selections | grep gnome | cut -f 1\`
     apt-get &#x2013;purge remove &#x2026;
     aptitude purge remove
    aptitude -f install
    aptitude purge \`dpkg &#x2013;get-selections | grep deinstall | cut -f 1\`
    aptitude -f install

-   clean
    dpkg -l |grep "<sup>rc</sup>"|awk '{print $2}' |xargs aptitude -y purge

-   apt-get install
    zsh git awesome emacs audacious google-chrome thunar lxappearance fcitx textlive-full cjk shadowsocks slim xfce4-terminal compton nvidia xserver-xorg virtualbox

-   desktop file

xdg-open gtk-launch exo-open


# grub

grub command- "quiet 3 or 5" ,init 3


# awesome wm

-   kde theme with awesome
    
    > export xdg<sub>current</sub><sub>desktop</sub>="kde"
    > 
    > export desktop<sub>session</sub>="kde"
    > export de="kde"
    > 
    > export gtk2<sub>rc</sub><sub>files</sub>="$home/.gtkrc-2.0"
    > 
    > export qt<sub>xft</sub>="true"
    > 
    > export qt<sub>select</sub>="5"
    > 
    > export qt<sub>qpa</sub><sub>platformtheme</sub>="kde"
    > 
    > \#export qt<sub>qpa</sub><sub>platformtheme</sub>="qt5ct"
    > 
    > export qt<sub>plugin</sub><sub>path</sub>=$home/.kde4/lib/kde4/plugins/:/usr/lib/kde4/plugins/
-   autostart write in xinitrc
-   70-synapatics
-   compton
-   redshift
-   synaptics
    vim /usr/share/x11/xorg.conf.d/70-syna&#x2026;
-   /etc/x11/display-manager&#x2026;..

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">left</td>
<td class="org-left">切换到上一个tag</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">right</td>
<td class="org-left">切换到下一个tag</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">1~9</td>
<td class="org-left">切换到指定tag</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">t</td>
<td class="org-left">标记当前窗口</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">ctrl</td>
<td class="org-left">+</td>
<td class="org-left">1~9</td>
<td class="org-left">把标记的窗口移动到指定桌面</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">esc</td>
<td class="org-left">切换到最后使用过的tag</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">ctrl</td>
<td class="org-left">+</td>
<td class="org-left">r</td>
<td class="org-left">重启awesome</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">ctrl</td>
<td class="org-left">+</td>
<td class="org-left">q</td>
<td class="org-left">退出awesome</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">m</td>
<td class="org-left">最大化/还原当前窗口</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">f</td>
<td class="org-left">全屏/恢复当前窗口</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">shift</td>
<td class="org-left">+c</td>
<td class="org-left">关闭当前窗口</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">j</td>
<td class="org-left">切换到下一个窗口</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">k</td>
<td class="org-left">切换到上一个窗口</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">shift</td>
<td class="org-left">+</td>
<td class="org-left">j</td>
<td class="org-left">当前窗口和前一个窗口互换位置</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">shift</td>
<td class="org-left">+</td>
<td class="org-left">k</td>
<td class="org-left">当前窗口和后一个窗口互换位置</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">ctrl</td>
<td class="org-left">+</td>
<td class="org-left">j</td>
<td class="org-left">切换到下一个屏幕</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">ctrl</td>
<td class="org-left">+</td>
<td class="org-left">k</td>
<td class="org-left">切换到前一个屏幕</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">ctrl</td>
<td class="org-left">+</td>
<td class="org-left">space</td>
<td class="org-left">切换当前窗口是否为浮动的</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">ctrl</td>
<td class="org-left">+</td>
<td class="org-left">return</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">return</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">tab</td>
<td class="org-left">切换到最后使用过的窗口</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">o</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">u</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">shift</td>
<td class="org-left">+</td>
<td class="org-left">r</td>
<td class="org-left">重绘当前窗口</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">l</td>
<td class="org-left">当前窗口的宽度减小5%</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">h</td>
<td class="org-left">当前窗口的宽度增大5%</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">shilt</td>
<td class="org-left">+</td>
<td class="org-left">h</td>
<td class="org-left">增加主区域窗口的数量</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">shift</td>
<td class="org-left">+</td>
<td class="org-left">l</td>
<td class="org-left">减少主区域窗口的数量</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">ctrl</td>
<td class="org-left">+</td>
<td class="org-left">h</td>
<td class="org-left">增加非主区域窗口的数量</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">ctrl</td>
<td class="org-left">+</td>
<td class="org-left">l</td>
<td class="org-left">减少非主区域窗口的数量</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">space</td>
<td class="org-left">切换下一布局</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">shift</td>
<td class="org-left">+</td>
<td class="org-left">space</td>
<td class="org-left">切换上一个布局</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">r</td>
<td class="org-left">运行程序</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">f4</td>
<td class="org-left">运行lua命令</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">&#xa0;</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">ctrl</td>
<td class="org-left">+</td>
<td class="org-left">i</td>
<td class="org-left">显示当前窗口的class和instance</td>
</tr>


<tr>
<td class="org-left">ctrl</td>
<td class="org-left">+</td>
<td class="org-left">alt</td>
<td class="org-left">+</td>
<td class="org-left">backspace</td>
<td class="org-left">注销当前登录</td>
</tr>


<tr>
<td class="org-left">mod4</td>
<td class="org-left">+</td>
<td class="org-left">shift</td>
<td class="org-left">+</td>
<td class="org-left">f1~f9</td>
<td class="org-left">把当前桌面和1~9桌面同时显示</td>
</tr>
</tbody>
</table>


# linux command

ln -s ls-mv-cp-rm -r -l -a -h grep find rm cp mv rename -r


## github

1.  创建ssh密钥
    ssh-keygen -t rsa -c "your<sub>email</sub>@youremail.com"
    copy .ssh/id<sub>rsa.pub</sub> to github:<https://github.com/settings/keys>
2.  链接到github
    ssh -t git@github.com
    git config &#x2013;global user.name "cnfeat"//用户名
    git config &#x2013;global user.email  "cnfeat@gmail.com"//填写自己的邮箱
3.  创建目录以及git克隆和推送——目录名字要一致
    $ mkdir tmp      //创建推送目录
    $ cd tmp         //进入推送目录    
    **$ git init       //设置该目录为推送**
    $ touch readme   //生成readme
    `git add .`
    $ git add readme //加入修改列表
    $ git commit -m 'first commit' //递交修改声明
    2790  git remote rm origin
    $ git remote add origin git@github.com:abcd/tmp.git //为远程git更名为origin
    $ git push -u origin master //推送此次修改
    
    git push -f
    git pull
    
    通过先add文件到更改再评论文件到项目中，然后就可以把项目中的文件，push到服务器上了。 这是通过commit文件来对比需要提交哪些？需要将文件链接添加到这个文件中管理！

4.  install node.js
     apt-get install curl
     sudo apt-get install nodejs-legacy nodejs
     <del>sudo curl -sl <https://deb.nodesource.com/setup_6.x> | bash -</del>
     apt-get install -y nodejs 
     node -v
    sudo npm install npm &#x2013;global

1.  install hexo
    
    `sudo npm install -g hexo-cli`
    hexo init
    hexo g(generate)
    hexo s(server) <http://localhost:4000>
    hexo clean 
    vim \_config.yml
    \`\`\`
    deploy:                                                
      type: git                                            
        repo: <https://github.com/ztao1991/ztao1991.github.io.git>                      
          branch: master 
    
    \`\`\`
    npm install hexo-deployer-git &#x2013;save
    
    hexo d(deploy)
    
    hexo clean
    
    hexo generate
    
    hexo deploy

git clone <https://github.com/iissnan/hexo-theme-next> themes/next

-   config

\## docs: <https://hexo.io/docs/deployment.html>
deploy: 
type: git
repo: git@github.com:ztao1991/ztao1991.github.io.git
branch: master

hexo g
hexo s
npm install hexo-deployer-git &#x2013;save
hexo d


# debian


## 磁盘分区

    device         start       end   sectors   size type
    /dev/sda1       2048    491519    489472   239m efi system
    /dev/sda2     491520 102053887 101562368  48.4g linux filesystem
    /dev/sda3  102053888 336429055 234375168 111.8g linux filesystem
    /dev/sda4  336429056 350490623  14061568   6.7g linux swap

    

lsblk -l:

    sda1   8:1    0   239m  0 part /boot/efi
    sda2   8:2    0  48.4g  0 part /
    sda3   8:3    0 111.8g  0 part /home
    sda4   8:4    0   6.7g  0 part [swap]

parted:

    1      1049kb  252mb   251mb   fat32                 boot, esp
    2      252mb   52.3gb  52.0gb  ext4
    3      52.3gb  172gb   120gb   ext4
    4      172gb   179gb   7200mb  linux-swap(v1)

edit /etc/fstab:

    # <file system> <mount point>   <type>  <options>       <dump>  <pass>
    # / was on /dev/sda2 during installation
    uuid=420c1b6e-2ffd-4ba8-951e-288d30f7e223 /               ext4    noatime 0       1
    # /boot/efi was on /dev/sda1 during installation
    uuid=58b3-610b  /boot/efi       vfat    umask=0077      0       1
    # /home was on /dev/sda3 during installation
    uuid=b9bd3d3a-b287-4ca1-ae92-fb18e1b85873 /home           ext4    noatime         0       2
    # swap was on /dev/sda4 during installation
    uuid=47314620-42bc-4bb0-83a3-979b694b2bab none            swap    sw              0       0
    
    tmpfs     /home/zhangtao/.cache/google-chrome/default      tmpfs   noexec,defaults,noatime,nodiratime 0       0
    tmpfs     /tmp      tmpfs   noexec,defaults,noatime,nodiratime 0       0 
    
    
    --------------------------------------
    # <file system> <mount point>   <type>  <options>       <dump>  <pass>                                                                                                    
    # / was on /dev/sda2 during installation                                                                                                                                  
    uuid=67c98dc7-979a-4ce0-a417-a7de33449b42 /               ext4    noatime,errors=remount-ro 0       1
    # /boot/efi was on /dev/sda1 during installation                                                                                                                          
    uuid=43f2-1e96  /boot/efi       vfat    umask=0077      0       1
    # /home was on /dev/sda3 during installation                                                                                                                              
    uuid=9a2e596f-7d64-4cf8-abb8-0ca18f9246bf /home           ext4    noatime         0       2
    # swap was on /dev/sda4 during installation                                                                                                                               
    uuid=a8467b42-b0b9-4a00-a677-f3181f5d8bea none            swap    sw              0       0
    /dev/sr0        /media/cdrom0   udf,iso9660 user,noauto     0       0
    
    
    tmpfs     /home/zhangtao/.cache/chromium//default      tmpfs   noexec,defaults,noatime,nodiratime 0       0
    
    tmpfs     /home/zhangtao/.cache/mozilla/firefox      tmpfs   noexec,defaults,noatime,nodiratime 0       0
    #tmpfs     /home/zhangtao/.cache/google-chrome/default      tmpfs   noexec,defaults,noatime,nodiratime 0       0                                                          
    tmpfs     /tmp      tmpfs   noexec,defaults,noatime,nodiratime 0       0


## 硬件类型

lspci:

    00:00.0 host bridge: intel corporation 3rd gen core processor dram controller (rev 09)
    00:01.0 pci bridge: intel corporation xeon e3-1200 v2/3rd gen core processor pci express root port (rev 09)
    00:14.0 usb controller: intel corporation 7 series/c210 series chipset family usb xhci host controller (rev 04)
    00:16.0 communication controller: intel corporation 7 series/c210 series chipset family mei controller #1 (rev 04)
    00:1a.0 usb controller: intel corporation 7 series/c210 series chipset family usb enhanced host controller #2 (rev 04)
    00:1b.0 audio device: intel corporation 7 series/c210 series chipset family high definition audio controller (rev 04)
    00:1c.0 pci bridge: intel corporation 7 series/c210 series chipset family pci express root port 1 (rev c4)
    00:1c.1 pci bridge: intel corporation 7 series/c210 series chipset family pci express root port 2 (rev c4)
    00:1c.3 pci bridge: intel corporation 7 series/c210 series chipset family pci express root port 4 (rev c4)
    00:1d.0 usb controller: intel corporation 7 series/c210 series chipset family usb enhanced host controller #1 (rev 04)
    00:1f.0 isa bridge: intel corporation hm76 express chipset lpc controller (rev 04)
    00:1f.2 sata controller: intel corporation 7 series chipset family 6-port sata controller [ahci mode] (rev 04)
    00:1f.3 smbus: intel corporation 7 series/c210 series chipset family smbus controller (rev 04)
    *01:00.0 vga compatible controller: nvidia corporation gk107m [geforce gt 650m] (rev a1)*
    01:00.1 audio device: nvidia corporation gk107 hdmi audio controller (rev a1)
    *02:00.0 ethernet controller: qualcomm atheros ar8161 gigabit ethernet (rev 10)*
    *03:00.0 network controller: broadcom corporation bcm4313 802.11bgn wireless network adapter (rev 01)*
    04:00.0 system peripheral: jmicron technology corp. sd/mmc host controller (rev 30)
    04:00.2 sd host controller: jmicron technology corp. standard sd host controller (rev 30)
    04:00.3 system peripheral: jmicron technology corp. ms host controller (rev 30)
    04:00.4 system peripheral: jmicron technology corp. xd host controller (rev 30)


## 网络连接

use networkmanager.

-   有线
    apt-get install pppoe dhcp-client

-   无线
    apt-get install linux-headers-$(uname -r|sed 's,[^-]\*-[^-]\*-,,') broadcom-sta-dkms
    
    modprobe -r b44 b43 b43legacy ssb brcmsmac
    
    modprobe wl
    
    apt-get install wpasupplicant
    
    wpa<sub>passphrase</sub> myssid my<sub>very</sub><sub>secret</sub><sub>passphrase</sub>
    
    wpa-conf /etc/wpa<sub>supplicant</sub>/wpa<sub>supplicant.conf</sub>
-   配置网卡
    
    ifconfig
    
    ifup/ifdown wlan0/eth0
    
    chmod 0600 /etc/network/interfaces
    
    edit /etc/network/interfaces
    
        source /etc/network/interfaces.d/*
        
        # the loopback network interface
        auto lo
        iface lo inet loopback
        
        # auto eth0
        # iface eth0 inet dhcp
        # iface eth0 inet static
        # address 192.168.1.156
        # netmask 255.
        # iface eth0 inet static
        # address 192.168.1.156
        # netmask 255.255.255.0
        # gateway 192.168.1.1
        wpa-ssid a-12	
        wpa-psk 463b73516245f5a6f96f8a109c90bf208f883b3524395adf973ea03973249829


## 显卡驱动

aptitude -r install linux-headers-$(uname -r|sed 's,[^-]\*-[^-]\*-,,') nvidia-kernel-dkms
nvdia-xconfig
option "nologo" "1"

一些问题：
eidt /etc/default/grub

    grub_cmdline_linux_default="elevator=noop quiet nouveau rcutree.rcu_idle_gp_delay=1"

grub-mkconfig -o /boot/grub/grub.cfg

option "nologo" "1"


## 安装软件

aptitude install xserver-xorg-core awesome fcitx-rime xfce4-terminal google-chrome audacious smplayer vlc slim thunar emacs virtualbox lxappearance git zsh alsa-utils gimp pcmanfm networkmanager-gnome redshift

sudo apt-get install thunar thunar-archive-plugin thunar-gtkhash thunar-volman thunar-media-tags-plugin thunar-vcs-plugin


## dekstop

kde-standar+awesome


### firewall install gufw

> 安装方法
>  sudo apt-get install ufw
> 当然，这是有图形界面的(比较简陋)，在新立得里搜索gufw试试……
> 使用方法
> 1 启用
>  sudo ufw enable
>  sudo ufw default deny 
> 作用：开启了防火墙并随系统启动同时关闭所有外部对本机的访问（本机访问外部正常）。
> 2 关闭
>  sudo ufw disable 
> 2 查看防火墙状态
>  sudo ufw status 
> 3 开启/禁用相应端口或服务举例
>  sudo ufw allow 80 允许外部访问80端口
>  sudo ufw delete allow 80 禁止外部访问80 端口
>  sudo ufw allow from 192.168.1.1 允许此ip访问所有的本机端口
>  sudo ufw deny smtp 禁止外部访问smtp服务
>  sudo ufw delete allow smtp 删除上面建立的某条规则
>  sudo ufw deny proto tcp from 10.0.0.0/8 to 192.168.0.1 port 22 要拒绝所有的tcp流量从10.0.0.0/8 到192.168.0.1地址的22端口
>  可以允许所有rfc1918网络（局域网/无线局域网的）访问这个主机（/8,/16,/12是一种网络分级）：
> sudo ufw allow from 10.0.0.0/8
> sudo ufw allow from 172.16.0.0/12
> sudo ufw allow from 192.168.0.0/16
> 推荐设置
>  sudo apt-get install ufw
>  sudo ufw enable
>  sudo ufw default deny 
> 这样设置已经很安全，如果有特殊需要，可以使用sudo ufw allow开启相应服务。


## 软件配置


### awesome wm

mkdir -p .config/awesome/

cp *xdg/awesome/rc.lua ~*.config/awesome


### fonts

vi /etc/apt/sources.list

deb <http://ppa.launchpad.net/no1wantdthisname/ppa/ubuntu> trusty main
deb-src <http://ppa.launchpad.net/no1wantdthisname/ppa/ubuntu> trusty main

import the public pgp key of this ppa to verify package integrity during the installation process：
apt-key adv &#x2013;keyserver keyserver.ubuntu.com &#x2013;recv-keys e985b27b

apt-get update
apt-get install fontconfig-infinality

configure font rendering:
sudo bash /etc/fonts/infinality/infctl.sh setstyle


## others

deb extract: ar -vx @debian 


# enconding

enca filename
enconv -l zh<sub>cn</sub> -x utf-8 filename
iconv -f encoding -t encoding inputfile
iconv -f gbk -t utf-8 file1 -o file2


# emacs

`code` `code` `like` *like* **bold**


## emacs with windows

hkcu\software\wow6432node\gnu\emacs\home

1.  click start -> run

2.  type: regedit, and click ok

3.  go to: hkey<sub>local</sub><sub>machine</sub> -> system -> currentcontrolset -> control -> keyboard layout

note: keyboard layout, and not keyboard layouts

1.  right-click: keyboard layout, and select new -> binary value

2.  rename: new value #1 -> scancode map

3.  right click: scancode map -> modify
    0000  00 00 00 00 00 00 00 00       
    0008  03 00 00 00 1d 00 3a 00
    0010  3a 00 1d 00 00 00 00 00
    0018

1.  close regedit and restart your computer

procedure

-   go to start > type in regedit and start it
-   navigate to hkey<sub>current</sub><sub>user</sub>/control panel/input method/hot keys
-   select the key named:
    -   00000070 for the chinese (traditional) ime - ime/nonime toggle hotkey
    -   00000010 for the chinese (simplified) ime - ime/nonime toggle hotkey
-   in the right sub-window, there are three subkeys.
    -   key modifiers designate alt/ctrl/shift/etc and is set to ctrl (02c00000).
    -   virtual key designates the finishing key and is set to space (20000000).
-   change the first byte in key modifiers from 02 to 00
-   change the first byte in virtual key from 20 to ff
-   log off and log back on. i don't think it's necessary to restart.
-   do not change the hot keys for input languages in control panel, unless you want to do this all over again.

notes: symptoms

each registry key (thing that looks like a folder) is for each specific hotkey setting that you would normally find in control panel > region and language > keyboards and languages > change keyboards&#x2026; > advanced key settings > hot keys for input languages. the recurring bug is the hotkey being automatically reset to ctrl+space even if changed via the gui.

i can personally confirm this for windows 7 64-bit and windows 8.1, though from my research, it looks like it may work for xp and vista as well.

<https://www.zhihu.com/question/22288432>

> when i type ctrl+space, windows switches me to other language input. what to do?
> you can disable the windows shortcut that switches you among input methods of different languages.
> 
> on microsoft windows 10:
> 
> go to control panel
> under icon “clock, language, and region”, click link “change input methods”
> click “advanced settings” on the left panel.
> change language bar hot keys.
> here's the exact instruction for windows vista.
> 
> go to 〖start ▸ control panel〗.
> choose classic view on the left.
> double click on the “regional and language options” icon, then go to “keyboards and languages” tab, click on “change keyboards…”.
> then, go to “advanced key settings” tab, then, it should list key sequences on the right column.
> select a input choice that has shortcut key, then click the button “change key sequence”.


## strike-through

c-c c-x c-f + / \*


## input c-\\


## org-mode

-   格式

like\_ **change** `change` <del>make</del> *like away*

bold\*
italic/
underlined\_
strike-through+
code~


### lord of the rings

my favorite scenes are (in this order)

1.  the attack of the rohirrim
2.  eowyn's fight with the witch king
    -   this was already my favorite scene in the book
    -   i really like miranda otto.
3.  peter jackson being shot by legolas
    
    -   on dvd only
    
    he makes a really funny face when it happens.

org-list-end-marker
   but in the end, no individual scenes matter but the film as a whole.
   important actors in this film are:

-   **elijah wood:** he plays frodo
-   **sean austin:** he plays sam, frodo's friend.  i still remember

	 him very well from his role as mikey walsh in the goonies.
org-list-end-marker

1.  this is a headline

    still outside the drawer
    
    this is inside the drawer.
    
    after the drawer.
    c-c c-x d


### 4.4.2 列表/标题快捷键

折叠
快捷键	说明
s-tab	循环切换整个文档的大纲状态（折叠、打开下一级、打开全部）
tab	循环切换光标所在的大纲状态

快捷键	说明
c-c c-n/p	移动到下上一个标题（不断标题是哪一级）
c-c c-f/b	移动到同一级别的下/上标题
c-c c-u	跳到上一级标题
c-c c-j	切换到大纲预览状态
基于大纲/标题的编辑
快捷键	说明
m-ret	插入一个同级别的标题
m-s-ret	插入一个同级别的todo标题
m-left/right	将当前标题升/降级
m-s-left/right	将子树升/降级
m-s-up/down	将子树上/下移动
c-c \*	将本行设为标题或者正文
c-c c-w	将子树或者区域移动到另一个标题处（跨缓冲区）
c-c c-x b	在新缓冲区显示当前分支
c-c /	只列出包含搜索结果的大纲，并高亮，支持多种搜索方式


### 元数据


### 4.7.3 内部连接

内部链接就类似于html的锚点（实际上export成html文件后就变成了锚点），可以实现在一个文档内部的跳转。如下命令定义了一个名为target的跳转目标：
<a id="org37d4374"></a> [12.4.4](#org37d4374)
\\#<a id="org6ca1871"></a> (这里我把锚点设置到\*连接\*这一部分开始处，大家可以点击下面效果中两个连接试试效果)
如下方式可以设置到target的链接：
target]] 或 [猛击锚点](#org6ca1871)
效果为： target 或 猛击锚点


### 4.7.4 其他常用的连接命令

c-c l 可以在光标所在处创建一个跳转目标点，在需要跳转至该目标的位置输入命令c-c c-l可以建立到目标的链接当输入c-c c-l命令，光标若处在已经存在的一个链接上的时候，可以编辑改链接。命令c-c %可以记录当前光标所在位置，当光标移到其他地方后，可以用c-c &跳转回来。这里的位置记录类似一个 kill-ring，重复输入c-c %可以记录多个位置，重复输入c-c &可以连续跳转到之前记录的对应位置上。


### 4.8 注脚

在 org mode中，你可以为你的文章添加注脚（footnote）。注脚的格式有两种，一是方括号+数字，二是方括号+fn+名字。比如下面有两个例子：在 org mode 的正文中写下这两句话：
the org homepage1 now looks a lot better than it used to. the org homepage2 now looks a lot better than it used to.
插入脚注：c-c c-x f 接下俩你可以写一些其他东西，然后在文章的末尾写上下面两句话（注意：必须要顶格写）：
[1] the link is: <http://orgmode.org>


### 4.9 分割线

五条短线或以上显示为分隔线。

---


### 书签

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-left">c-x r m bookmark</td>
<td class="org-left">bookmark-set</td>
<td class="org-left">设置一个名为 bookmark 的书签。</td>
</tr>


<tr>
<td class="org-left">c-x r l</td>
<td class="org-left">bookmarks-bmenu-list</td>
<td class="org-left">列出所有已保存的书签。</td>
</tr>


<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">bookmark-delete</td>
<td class="org-left">删除一个书签。</td>
</tr>


<tr>
<td class="org-left">c-x r b bookmark</td>
<td class="org-left">bookmark-jump</td>
<td class="org-left">跳转至名为 bookmark 的书签中所设置的位置。</td>
</tr>


<tr>
<td class="org-left">未定义</td>
<td class="org-left">bookmark-save</td>
<td class="org-left">将所有的书签保存到书签文件 ~/.emac.bmk 中。</td>
</tr>
</tbody>
</table>

必須用「一個中文字＝ 兩個英文字」寬度的字體
例如文泉驛正黒、微米黒

    (set-default-font "consolas")
    (set-fontset-font "fontset-default" 'chinese-gbk "微软雅黑")
    (setq face-font-rescale-alist '(("宋体" . 1.2)
    				("微软雅黑" . 1.1)
    				))
    ;;;中文与英文字体设置
    ;; setting english font
    (set-face-attribute
    'default nil :font "monaco 14")
    ;; chinese font
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
    charset
    (font-spec :family "wenquanyi micro hei mono" :size 16)))

baidu <sup><a id="fnr.1" class="footref" href="#fn.1">1</a></sup>

\(e=mc^2\)和\[\]作为行内公式和行间公式标志

[1] a plain numeric footnote marker. compatible with footnote.el, but not recommended
because something like ‘[1]’ could easily be part of a code snippet.

name | phone | age |

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-right" />

<col  class="org-right" />
</colgroup>
<tbody>
<tr>
<td class="org-left">peter</td>
<td class="org-right">1234</td>
<td class="org-right">17</td>
</tr>


<tr>
<td class="org-left">anna</td>
<td class="org-right">4321</td>
<td class="org-right">25</td>
</tr>
</tbody>
</table>

calc- mode


### help

c-h t
c-h k


### 模板的使用

yassniet
yas/new-sss
c-c c-c 
c-c c-t
.emacs.d\snieet\\。。。&#x2026;


### helm 搜索


### ido

c-s c-r
c-x c-d


### something


### 正则表达


### 加密


### 字体

　{"dejavu sans mono 10" 与 "wenquanyi micro hei mono 12"}　{"consolas
11"  与 "microsoft  yahei  16"}　{"liberation mono  12" 与  "wenquanyi
micro hei mono 15"}


### 插入日期: c-c .


### 窗口管理和缓存管理：frame + buffer


### cua-mode

lt+x string-insert-rectange 是块插入
alt+s clear-rectange            是块删除
m-x rectange-mark-mode

emacs以c-x r开头的命令来进行矩形操作。先用c-space或者c-@设一个mark，移动光标到另一点，用以下命令进行列操作：

c-x r k 剪切一个矩形块
c-x r y 粘贴一个矩形块
c-x r o 插入一个矩形块
c-x r c 清除一个矩形块(使其变成空白)
c-x r t 在选定区域的所有列前插入样的字符


### open with the file with oyher app in emacs

openwith.el
<http://emacs.stackexchange.com/questions/3105/how-to-use-an-external-program-as-the-default-way-to-open-pdfs-from-emacs>


### export

    ;;; 下面一段是 feng shu 的
    (defun eh-org-clean-space (text backend info)
      "在export为html时,删除中文之间不必要的空格"
      (when (org-export-derived-backend-p backend 'html)
    	(let ((regexp "[[:multibyte:]]")
    		  (string text))
    	  ;; org默认将一个换行符转换为空格,但中文不需要这个空格,删除.
    	  (setq string
    			(replace-regexp-in-string
    			 (format "\\(%s\\) *\n *\\(%s\\)" regexp regexp)
    			 "\\1\\2" string))
    	  ;; 删除粗体之前的空格
    	  (setq string
    			(replace-regexp-in-string
    			 (format "\\(%s\\) +\\(<\\)" regexp)
    			 "\\1\\2" string))
    	  ;; 删除粗体之后的空格
    	  (setq string
    			(replace-regexp-in-string
    			 (format "\\(>\\) +\\(%s\\)" regexp)
    			 "\\1\\2" string))
    	  string)))
    (add-to-list 'org-export-filter-paragraph-functions
    			 'eh-org-clean-space)
    
    
    ;;; 下面一段是 zwz 的, 作者声明只适应 org-mode 8.0 以及以上版本
    (defun clear-single-linebreak-in-cjk-string (string)
      "clear single line-break between cjk characters that is usually soft line-breaks"
      (let* ((regexp "\\([\u4e00-\u9fa5]\\)\n\\([\u4e00-\u9fa5]\\)")
    		 (start (string-match regexp string)))
    	(while start
    	  (setq string (replace-match "\\1\\2" nil nil string)
    			start (string-match regexp string start))))
      string)
    
    (defun ox-html-clear-single-linebreak-for-cjk (string backend info)
      (when (org-export-derived-backend-p backend 'html)
    	(clear-single-linebreak-in-cjk-string string)))
    
    (add-to-list 'org-export-filter-final-output-functions
    			 'ox-html-clear-single-linebreak-for-cjk)


### 1. c-c c-x c-i”开始计时，在需要结束计时时按”c-c c-x c-o

1.  c-c [ ]
2.  org-agneda c-c a
3.  c-c /


## 大小写

从光标位置开始，处理单词后半部分
capitalize-word (m-c) ;; 单词首字母转为大写
upcase-word (m-u)     ;; 整个单词转为大写
downcase-word (m-l)   ;; 整个单词转为小写（注意，这里是 meta － l(\* 小写字母 l)）
从光标位置开始，处理单词前半部分
negtive-argument; capitalize-word (m&#x2013; m-c) ;; 单词首字母转为大写
negtive-argument; upcase-word (m&#x2013; m-u)     ;; 整个单词转为大写
negtive-argument; downcase-word (m&#x2013; m-l)   ;; 整个单词转为小写
改变选定区域的大小写

downcase-region (c-x c-l) ;; 选定区域全部改为小写
upcase-region (c-x c-u)   ;; 选定区域全部改为大写


## movingthectrlkey

on debian and derivatives (ubuntu, mint etc.)
to make caps lock another ctrl key, edit the file /etc/default/keyboard and change the line which reads

xkboptions="ctrl:nocaps"		# some people prefer "ctrl:swapcaps"
xkboptions="caps:swapescape"
sudo dpkg-reconfigure -phigh console-setup


## emacsclient -c

emacs -damenon

    # alias emacs
    alias emacsd='emacs --daemon'
    alias e='emacsclient -t'
    alias ec='emacsclient -c'
    
    # run emacs daemon
    [[ -z $(ps -c 'emacs --daemon' -o pid=) ]] && emacsd
    
    # add kill emacs function
    function kill-emacs(){
    	emacsclient -e "(kill-emacs)"
    	emacs_pid=$( ps -c 'emacs --daemon' -o pid= )
    	if [[ -n "${emacs_pid}" ]];then
    		kill -9 "${emacs_pid}"
    	fi
    
    }


## lisp

1.  lisp-interaction-mode
2.  c-j or c-x c-e the end!


## offlineimap+mu4e+emacs+gmail

<http://www.djcbsoftware.nl/code/mu/mu4e/index.html>

1.  install mu4e offilineimap
2.  mu index &#x2013;maildir=~/mail

[general]
accounts = gmail
nmaxsyncaccounts = 1
pythonfile = ~/.offlineimap.py

[account gmail]
:qlocalrepository = local
remoterepository = remote

[repository local]
type = maildir
localfolders = ~/maildir

[repository remote]
type = gmail
remoteuser = ztao1991@gmail.com
remotepasseval = get<sub>password</sub><sub>emacs</sub>("imap.gmail.com", "ztao1991@gmail.com", "993")
realdelete = yes

folderfilter = lambda foldername: foldername not in ['[gmail]/spam', '[gmail]/all mail', '[gmail]/starred', '[gmail]/important']

holdconnectionopen = true
keepalive = 60
sslcacertfile = /etc/ssl/certs/ca-certificates.crt

[general]
accounts = gmail
nmaxsyncaccounts = 1
pythonfile = ~/.offlineimap.py

[account gmail]
localrepository = local
remoterepository = remote

[repository local]
type = maildir
localfolders = ~/maildir

[repository remote]
type = gmail
remoteuser = ztao1991@gmail.com
remotepasseval = get<sub>pass</sub>()
realdelete = yes

holdconnectionopen = true
keepalive = 60
sslcacertfile = /etc/ssl/certs/ca-certificates.crt

\#! /usr/bin/env python2
from subprocess import check<sub>output</sub>

def get<sub>pass</sub>():
    return check<sub>output</sub>("gpg -dq ~/.offlineimappass.gpg", 
    shell=true).strip("\n") ##this file is password

---

\#!/usr/bin/python
import re, os

def get<sub>password</sub><sub>emacs</sub>(machine, login, port):
	s = "machine %s login %s port %s password ([^ ]\*)\n" % (machine, login, port)
	p = re.compile(s)
	authinfo = os.popen("gpg2 -q &#x2013;no-tty -d ~/.authinfo.gpg").read()
	return p.search(authinfo).group(1)

machine imap.gmail.com login ztao1991@gmail.com port 993 password 
machine smtp.gmail.com login ztao1991@gmail.com port 587 password 

m-x epa-encrypt-file (generate ~/.authinfo.gpg and remove original).set <del>ztao1991</del>

apt install mu4e offlineimap gpgv12 

then offlinemap & mu index &#x2013;maildir=~/mail

    #!/bin/bash
    _fname=$(mktemp)
    echo "<html>" > ${_fname}
    cat - >> ${_fname}
    echo "</html>" >> ${_fname}
    /usr/bin/firefox --new-window ${_fname}

(require 'mu4e)

;; default
(setq mu4e-maildir (expand-file-name "~/maildir"))

(setq mu4e-drafts-folder "*[gmail].drafts")
(setq mu4e-sent-folder   "*[gmail].sent mail")
(setq mu4e-trash-folder  "/[gmail].trash")

;; don't save message to sent messages, gmail/imap will take care of this
(setq mu4e-sent-messages-behavior 'delete)

;; setup some handy shortcuts
(setq mu4e-maildir-shortcuts
	  '(("*inbox"             . ?i)
		("*[gmail].sent mail" . ?s)
		("/[gmail].trash"     . ?t)))

;; allow for updating mail using 'u' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; something about ourselves
;; i don't use a signature&#x2026;
(setq
 user-mail-address "ztao1991@gmail.com"
 user-full-name  "张陶"
 ;; message-signature
 ;;  (concat
 ;;    "foo x. bar\n"
 ;;    "<http://www.example.com\n>")
)

;; sending mail &#x2013; replace username with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in debian/ubuntu, 'gnutls' in archlinux.

(require 'smtpmail)

(setq message-send-mail-function 'smtpmail-send-it
	  starttls-use-gnutls t
	  smtpmail-starttls-credentials
	  '(("smtp.gmail.com" 587 nil nil))
	  smtpmail-auth-credentials
	  (expand-file-name "~/.authinfo.gpg")
	  smtpmail-default-smtp-server "smtp.gmail.com"
	  smtpmail-smtp-server "smtp.gmail.com"
	  smtpmail-smtp-service 587
	  smtpmail-debug-info t)

c-x m mail-mode
c-c c-c   send the message and exit the message buffer
c-c c-a   add an attachment
c-c c-k   cancel the message
c-c c-d  postpone the message
c-c c-s  send the message but don't exit the message buffer
c-c c-b  go to the start of the message
c-c c-z  kill text from point until end of buffer
key          description
&#x2014;          ------&#x2013;&#x2014;
c-c c-c      send message
c-c c-d      save to drafts and leave
c-c c-k      kill the message buffer (the message remains in the draft folder)
c-c c-a      attach a file (pro-tip: drag & drop works as well)

(mu4e-specific)
c-s-u        update mail & reindex


## gpg+gpg-agent

<file://~/.profile> 
<file://~/.gunpg/gpg-agent.conf>
<http://tech.memoryimprintstudio.com/the-ultimate-emailing-agent-with-mu4e-and-emacs/>


## emacs tur

    <title>the emacs tip</title>
    <h1>1.move</h1>
    m-/ 补全
    c-x h 全选
    c-j 下一行
    <h1>2.setting</h1>
    <h1>3.plugin</h1>
    <h1>4.make yours emacs</h1>
    1. your habit
    2. elisp


## emacs plugin


### ace-jump-mode

if you use the default configuration, which binds to “c-c spc”.
“c-c spc” ⇒ ace-jump-word-mode
enter first char of a word, select the highlight key to move to.
“c-u c-c spc” ⇒ ace-jump-char-mode
enter a char for query, select the highlight key to move to.
“c-u c-u c-c spc” ⇒ ace-jump-line-mode
each non-empty line will be marked, select the highlight key to move to.


### avy


### emacs server

    (defun frame-setting ()
    	(set-frame-font "文泉驿等宽微米黑 8")
    	(set-fontset-font "fontset-default"
    			  'gb18030 '("文泉驿等宽微米黑" . "unicode-bmp")))
     
    (if (and (fboundp 'daemonp) (daemonp))
    	(add-hook 'after-make-frame-functions
    		  (lambda (frame)
    		(with-selected-frame frame
    		  (frame-setting))))
      (frame-setting))
    
    
    
    ----------------------------------------------------------------
    
    
    
    
    (setq window-system-default-frame-alist
    	  '(
    		;; if frame created on x display
    		(x
    	 (menu-bar-lines . 1)
    	 (tool-bar-lines . nil)
    	 ;; mouse
    	 (mouse-wheel-mode . 1)
    	 (mouse-wheel-follow-mouse . t)
    	 (mouse-avoidance-mode . 'exile)
    	 ;; face
    	 (font . "文泉驿等宽微米黑 8")
    	 )
    		;; if on term
    		(nil
    	 (menu-bar-lines . 0) (tool-bar-lines . 0)
    	 ;; (background-color . "black")
    	 ;; (foreground-color . "white")
    	 )
    	)
    	  )


### evil

basic: i x :wq dd p hjkl :help
insert: a o o cw 
move:0 ^ $ g\_ / ng gg g w e
copy:yy p
undo:u redo:c-r
save:s w x bn bp :saves 

    ;-------------------------------------------------------------------------------------------------------------------------
    ;evil-mode
    ;-------------------------------------------------------------------------------------------------------------------------
    ;; (add-to-list 'load-path "~/.emacs.d/elpa/evil-20160608.229/")
    ;; (require 'evil) 
    ;; (evil-mode 1) 
    
    ;;(setq evil-default-state 'emacs)
    ;;(define-key evil-emacs-state-map (kbd "c-o") 'evil-execute-in-normal-state)
    ;;(define-key evil-normal-state-map "m-x" 'execute-extended-command)
    ;;(define-key evil-motion-state-map ";" 'smex)
    ;;(define-key evil-motion-state-map ":" 'evil-ex)
    ;;(global-set-key (kbd "c-s") 'evil-write)
    
    ;;(evil-set-initial-state 'ibuffer-mode 'normal)
    
    ;; esc quits
    ;; (defun minibuffer-keyboard-quit ()
    ;;   "abort recursive edit.
    ;; in delete selection mode, if the mark is active, just deactivate it;
    ;; then it takes a second \\[keyboard-quit] to abort the minibuffer."
    ;;   (interactive)
    ;;   (if (and delete-selection-mode transient-mark-mode mark-active)
    ;;       (setq deactivate-mark  t)
    ;;     (when (get-buffer "*completions*") (delete-windows-on "*completions*"))
    ;;     (abort-recursive-edit)))
    ;; (define-key evil-normal-state-map [escape] 'keyboard-quit)
    ;; (define-key evil-visual-state-map [escape] 'keyboard-quit)
    ;; (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
    ;; (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
    ;; (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
    ;; (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
    ;; (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
    ;; (global-set-key [escape] 'evil-exit-emacs-state)
    
    ;; change mode-line color by evil state
    ;; (lexical-let ((default-color (cons (face-background 'mode-line)
    ;;                                    (face-foreground 'mode-line))))
    ;;   (add-hook 'post-command-hook
    ;;     (lambda ()
    ;;       (let ((color (cond ((minibufferp) default-color)
    ;;                          ((evil-insert-state-p) '("#e80000" . "#ffffff"))
    ;;                          ((evil-emacs-state-p)  '("#af00d7" . "#ffffff"))
    ;;                          ((buffer-modified-p)   '("#006fa0" . "#ffffff"))
    ;;                          (t default-color))))
    ;;         (set-face-background 'mode-line (car color))
    ;;         (set-face-foreground 'mode-line (cdr color))))))
    
    ;; (defun evil-toggle-input-method ()
    ;;   "when toggle on input method, switch to evil-insert-state if possible.
    ;;     when toggle off input method, switch to evil-normal-state if current state is evil-insert-state"
    ;;       (interactive)
    ;;       (if (not current-input-method)
    ;;           (if (not (string= evil-state "insert"))
    ;;               (evil-insert-state))
    ;;         (if (string= evil-state "insert")
    ;;             (evil-normal-state)
    ;;           ))
    ;;       (toggle-input-method))
    	
    ;; (global-set-key (kbd "c-\\") 'evil-toggle-input-method)
    
    ;; (define-key evil-normal-state-map (kbd "c-h") 'evil-window-left)
    ;; (define-key evil-normal-state-map (kbd "c-j") 'evil-window-down)
    ;; (define-key evil-normal-state-map (kbd "c-k") 'evil-window-up)
    ;; (define-key evil-normal-state-map (kbd "c-l") 'evil-window-right)
    
    
    ;; ;;evil-leader
    ;; (require 'evil-leader)
    ;; (global-evil-leader-mode)
    ;; (evil-leader/set-leader ";")
    ;; (setq evil-leader/in-all-states 1)
    
    
    
    ;; (evil-leader/set-key "e" 'evil-ace-jump-word-mode) ; ,e for ace jump (word)
    ;; (evil-leader/set-key "l" 'evil-ace-jump-line-mode) ; ,l for ace jump (line)
    ;; (evil-leader/set-key "x" 'evil-ace-jump-char-mode) ; ,x for ace jump (char)
    
    ;; (setq-default tab-width 4 indent-tabs-mode nil)
    ;; (define-key global-map (kbd "ret") 'newline-and-indent)
    ;; (setq evil-move-cursor-back nil)
    
    
    ;; (require 'evil-surround)
    ;; (global-evil-surround-mode 1)
    
    
    ;;-----------------------------------------------------------------------------------------------------------------------------------

-   cmatrix
-   xeyes
-   zenthura


## bug


### dependency problems

sudo apt-get purge emacsen-common emacs24-common emacs24-bin-common emacs24 xemacs21-mule xemacs21 xemacs21-support gettext-el emacs xemacs21-bin

sudo apt-get update
sudo apt-get autoremove
sudo apt-get autoclean
please post any errors.


## magit-mode

m-x magit-status .c c. c-c c-c. m-x magit-push master orig.. s uncharge file $ staus


## latex

sudo apt-get install okular texlive-full auctex
paragraphs are separated by at least one empty line. if you need to enforce a line break within a paragraph, use ‘\\\\’ at the end of a line.

    ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; ;;;;;;;;;;;;;;;;        latex         ;;;;;;;;;;;;;;;;;
    ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;; ##### run emacs in server mode in order to be able to use
    ;; ##### emacsclient in okular. don't forget to configure
    ;; ##### okular to use emacs in
    ;; ##### "configuration/configure okular/editor"
    ;; ##### => editor => emacsclient. (you should see
    ;; ##### emacsclient -a emacs --no-wait +%l %f
    ;; ##### in the field "command".
    (server-start)
    
    (setq tex-pdf-mode t) ;; use pdflatex instead of latex
    
    (setq-default tex-master nil)
    ;; ##### enable synctex correlation. from okular just press
    ;; ##### shift + left click to go to the good line.
    (setq tex-source-correlate-method 'synctex)
    ;; ##### enable synctex generation. even though the command shows
    ;; ##### as "latex" pdflatex is actually called
    (custom-set-variables '(latex-command "latex -synctex=1") )
    
    ;; ##### use okular to open your document at the good
    ;; ##### point. it can detect the master file.
    (add-hook 'latex-mode-hook '(lambda ()
                      (add-to-list 'tex-expand-list
                           '("%u" okular-make-url))))
    
    (defun okular-make-url () (concat
                   "file://"
                   (expand-file-name (funcall file (tex-output-extension) t)
                             (file-name-directory (tex-master-file)))
                   "#src:"
                   (tex-current-line)
                   (expand-file-name (tex-master-directory))
                   "./"
                   (tex-current-file-name-master-relative)))
    
    ;; ## use these lines if you want a confirmation of the
    ;; ## command line to run...
    ;; (setq tex-view-program-selection '((output-pdf "okular")))
    ;; (setq tex-view-program-list '(("okular" "okular --unique %u")))
    ;; ## and theses if you don't want any confirmation.
    (eval-after-load "tex"
      '(add-to-list 'tex-command-list 
    		'("view" "okular --unique %u" tex-run-discard-or-function nil t :help "view file")))


## emacs init

some time color should #&#x2026;. 


# vim

    ## edit 
    - ctrl-p
            <leader>-f模糊搜索最近打开的文件(mru)
            <leader>-p模糊搜索当前目录及其子目录下的所有文件
    
            ctrl + j/k 进行上下选择
    
            ctrl + x 在当前窗口水平分屏打开文件
    
            ctrl + v 同上, 垂直分屏
    
            ctrl + t 在tab中打开
    ----------------------------------------------------------------------
            press <f5> to purge the cache for the current directory to get new files, remove deleted files and apply new ignore options.
            press <c-f> and <c-b> to cycle between modes.
            press <c-d> to switch to filename only search instead of full path.
            press <c-r> to switch to regexp mode.
            use <c-j>, <c-k> or the arrow keys to navigate the result list.
            use <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new split.
            use <c-n>, <c-p> to select the next/previous string in the prompt's history.
            use <c-y> to create a new file and its parent directories.
            use <c-z> to mark/unmark multiple files and <c-o> to open them.
    
    - ag+grep
            :vim[grep][!] /{pattern}/[g][j] {file} ...
            :ag [options] {pattern} [{directory}]
    
    ## writer
    
    
    ## splitline
    
    ```vim
    set fillchars=stl:―,stlnc:—,vert:│,fold:۰,diff:·
    
    highlight folded       cterm=bold ctermbg=none ctermfg=5
    highlight vertsplit    cterm=none ctermbg=none ctermfg=9
    highlight statusline   cterm=none ctermbg=none ctermfg=9
    highlight statuslinenc cterm=none ctermbg=none ctermfg=9
    highlight specialkey   cterm=none ctermbg=none ctermfg=1
    highlight matchparen   cterm=none ctermbg=none ctermfg=5
    highlight wildmenu     cterm=bold ctermbg=none ctermfg=3
    highlight visual       cterm=bold ctermbg=7    ctermfg=none
    highlight user1        cterm=none ctermbg=none ctermfg=3
    
    set statusline=
    set statusline+=%1*%f%*
    set statusline+=%(\ [%{fugitive#head()}%y%r%w%m]%)
    set statusline+=%=
    set statusline+=[%(%l,%c%v%)]
    set statusline+=\ %1*%p%*
    ```


# windows 10


## windows下开发环境配置


### python environment install

python 3 version.

把默认使用的python版本路径加到 path 环境变量中，避免每次使用时都要冗余地写全python 解释器路径。假设安装路径是 c:\python27\\, 将这段加入到 path 中:
c:\python27\\;c:\python27\scripts\\

或在 powershell 中运行:
[environment]::setenvironmentvariable("path", "$env:path;c:\python27\\;c:\python27\scripts\\", "user")

**the user name should be english.and install pip install foo.whl or jupyter**

<del>pip install foo.whl</del>

-   editor
    -   atom
    -   sublime text
    -   vscode


### c environment install

mingw gcc gcc++

1、在path里加入c:\mingw\bin，记得，如果里面还有其他的变量，记得要加个分号啊，分号得在英文输入模式下输入的。
2、新建library<sub>path变量</sub>，如果有的话，在值中加入c:\mingw\lib，这是标准库的位置。
3、新建c<sub>includede</sub><sub>path变量</sub>，值设为c:\mingw\include。
4、新建cplus<sub>include</sub><sub>path变量</sub>，值为c:\mingw\include\c++\\3.4.5;c:\mingw\include\c++\\3.4.5;c:\mingw\include\c++\\3.4.5\backward;c:\mingw\include


### latex

texlive


### vmware


# colors

\#32cd32 lime green
\\#fffff0 color hex ivory

<http://www.color-hex.com/color/32cd32>


# matlab

sudo mkdir /media/matlab  
sudo mount -o loop [path]mathworks<sub>r2014a.iso</sub> /media/matlab  
cd /media/matlab  
sudo ./install
cp libmwservices.so /usr/local/matlab/r2014a/bin/glnxa64
sudo apt-get install matlab-support
sudo chown username -r ~/.matlab
ln -s /usr/local/matlab/r2014b/bin/matlab /usr/bin

-   java gui displayp in awesome wm
    sudo apt-get install suckless-tools
    wmname lg3d


# build and compile emacs

1.  apt-get install build-enseential lib&#x2026;-dev
2.  apt-get build-deb emacs vim

./configure &#x2013;with-features=huge \\
            &#x2013;enable-multibyte \\
            &#x2013;enable-rubyinterp=yes \\
            &#x2013;enable-pythoninterp=yes \\
            &#x2013;with-python-config-dir=/usr/lib/python2.7/config \\
            &#x2013;enable-python3interp=yes \\
            &#x2013;with-python3-config-dir=/usr/lib/python3.5/config \\
            &#x2013;enable-perlinterp=yes \\
            &#x2013;enable-luainterp=yes \\
            &#x2013;enable-gui=gtk2 &#x2013;enable-cscope &#x2013;prefix=/usr

1.  ./configure
2.  make
3.  make install
4.  make uninstall

5.  xwidget

sudo apt-get remove libwxgtk3.0-dev
./autogen.sh 
./configure &#x2013;with-xwidgets &#x2013;with-cairo &#x2013;with-modules

$ cd /where/you/unpacked/or/branched/emacs
$ ./autogen.sh    # not needed when installing from tarball
$ ./configure
$ make
$ make install


# latex<sub>auctex</sub>


## latex

> from: carsten dominik <carsten.dominik <at> gmail.com>
> subject: re: re: latex export of images
> newsgroups: gmane.emacs.orgmode
> date: tuesday 20th october 2009 10:18:21 utc (over 7 years ago)
> on oct 13, 2009, at 12:03 pm, francesco pizzolante wrote:
> 
> > hi carsten,
> >
> > sorry for my late reply on this subject.
> >
> >> ok, i have now modified image placement in latex.
> >>
> >> 1. image in text
> >>
> >>   ![img](./img/x.png)
> >>
> >> 2. floating image with caption and modified size and placement
> >>
> >>   #+caption: my caption
> >>   #+attr<sub>latex</sub>: placement=[h] width=0.6\textwidth
> >>   ![img](./img/x.png)
> >>
> >> 3. wrapping text around the image
> >>
> >>   #+attr<sub>latex</sub>: wrap
> >>   #+attr<sub>html</sub>: align="left"
> >>   ![img](./img/x.png)
> >>
> >> 4. wrapping text around the image with modified size and wrapfigure  
> >> placement
> >>
> >>   #+attr<sub>latex</sub>: wrap width=0.38\textwidth placement={r}{0.4\textwidth
> >>   #+attr<sub>html</sub>: align="right" width="250"
> >>   ![img](./img/x.png)
> >>
> >> even if there is a caption, wrap will work and force the
> >> image to be non-floating with text wrapped around.
> >>
> >> comments?
> >
> > i did not test the wrap option yet, but the rest is perfect (images  
> > in text,
> > placements, width, captions, labels).
> >
> > i still miss one single option: "float" in order to force the  
> > centered figure
> > environment if if no caption/label is present.
> >
> > i would add something like
> >
> > #+attr<sub>latex</sub>: float
> 
> have you actually tried?  the following works for me.
> 
> ![img](./blue_1.png)
> this is text
> 
> -   carsten
> 
> >
> > or
> >
> > #+attr<sub>latex</sub>: float=t
> >
> > is this feasible?
> >
> > thanks a lot!
> >
> > francesco
> 
> -   carsten
> 
> <span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline">\_</span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span>
> emacs-orgmode mailing list
> remember: use \`reply all' to send replies to the list.
> emacs-orgmode@gnu.org
> <http://lists.gnu.org/mailman/listinfo/emacs-orgmode>


## keybinding

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-left">c<sub>c</sub> c-e</td>
<td class="org-left">environment</td>
</tr>


<tr>
<td class="org-left">c<sub>c</sub> c-m</td>
<td class="org-left">top matter</td>
</tr>


<tr>
<td class="org-left">c<sub>c</sub> c-c v</td>
<td class="org-left">compile</td>
</tr>


<tr>
<td class="org-left">c<sub>c</sub> c<sub>s</sub></td>
<td class="org-left">sectioning</td>
</tr>
</tbody>
</table>


## ctex

    #+latex_class: ctexart
    #+latex_class_options: [nofonts]
    #+latex_header: \usepackage{mylinuxfonts}
    
    #+latex_header: \documentclass[nofonts]{ctexart}
    #+latex_header: \setmainfont{times new roman}
    #+latex_header: \setsansfont{helvetica}
    #+latex_header: \setmonofont{courier new}
    
    #+latex_header: \setcjkmainfont{simsun} 
    #+latex_header: \setcjksansfont{microsoft yahei} 
    #+latex_header: \setcjkmonofont{fzlantinghei} 
    
    ctexart , ctexrep , ctexbook 分别对应于 article , report , book 三个类


# didplay

关闭指定显示器：xrandr &#x2013;output vga-0 &#x2013;off
设置指定显示器的分辨率：xrandr &#x2013;output dvi-i-1 &#x2013;mode 1680x1050
让指定显示器自动选择分辨率与屏幕位置：xrandr &#x2013;output dvi-i-1 &#x2013;auto
使用扩展模式
设置指定显示器为主屏幕：xrandr &#x2013;output dvi-i-1 &#x2013;primary
设置多个显示器之间的相对位置：xrandr &#x2013;output dvi-i-1 &#x2013;left-of vga-0
使用同步显示模式：xrandr &#x2013;output dvi-i-1 &#x2013;same-as vga-0
以上不同选项是可以组合在一起一次完成设定的。例如：

xrandr &#x2013;output vga-0 &#x2013;mode 1280x1024 &#x2013;output dvi-i-1 &#x2013;mode 1920x1080 &#x2013;primary &#x2013;right-of vga-0


# python


## cal with gpu \_ cuda


# flash

tar -zxvf flash<sub>player</sub><sub>ppapi</sub><sub>linux.x86</sub><sub>64</sub>\\ .tar.gz 
sudo cp libpepflashplayer.so /usr/lib/chromium/plugins

sudo vim /etc/chromium.d/default： chromium<sub>flags</sub>="&#x2013;ppapi-flash-path=/usr/lib/chromium/plugins/libpepflashplayer.so &#x2013;ppapi-flash-version=24.0.0.189" 

sudo cp libflashplayer.so *usr/lib/mozilla/plugins*


## chrome with linux

mkdir .config/google-chrome/pepperflash
sudo vim /usr/share/applications/google-chrome.desktop

exec=/usr/bin/google-chrome-stable %u &#x2013;ppapi-flash-path=/home/zhangtao/.config/google-chrome/pepperflash/libpepflashplayer.so


# windows ISO under linux

fdisk /dev/sdb n a p w set to /dev/sdb1
Add boot "a"
sudo mkfs -t ntfs /dev/sdb1
sudo dd  if=/home/peter/downloads/windowstechnicalpreview-x64-zh-cn.iso of=/dev/sdb1 bs=4m iflag=direct​
sudo apt-get install lilo
sudo lilo -m /dev/sdb mbr


# Debian 9 Bug Report


## USB 3.0 Can't Mount

-   Note taken on <span class="timestamp-wrapper"><span class="timestamp">[2017-08-15 二 11:18] </span></span>   
    edit /etc/modeprobe.d/usb-storage.conf 
    Add "options usb-storage quirks=vid:pid:u" for example "options usb-storage quirks=0951:1666:u"
    lsusb -v
    Then sudo update-initramfs -u

> This worked for me on one machine, live (just had to unplug and re-plug the USB HDD):
> 
> rmmod uas usb-storage
> modprobe usb-storage quirks=0bc2:ab21:u
> 
> And so did this, on another where usb-storage was still in use by other devices:
> echo -n quirks=0bc2:ab21:u | sudo tee /sys/modules/usb<sub>storage</sub>/params/quirks
> 
> Of course you still want to put it into /etc/modprobe.d and regenerate initrd so that it automatically applies on the next boot.
> (This USB ID is for a Seagate Backup Plus Slim USB 3.0 Portable.
> Whew, that's a long name.)

CLOSED: <span class="timestamp-wrapper"><span class="timestamp">[2017-08-15 二 11:14]</span></span>


## sddm blank screen cause by nvidia-driver so use debian sources nvidia driver to solve.


## texlive bug that tex-common can't setting:first remove all texlive-full and tex-common .install texlive-base form unstable.


## nvidia install:

-   first blacklist: blacklist nouveau in .modeprobe.d/
-   sudo apt-get install linux-headers-$(uname -r|sed 's,[^-]\*-[^-]\*-,,')
-   ./nv&#x2026;..
-   add grub:


## sometimes some problem maybe should  remove and reinstall to solve


## sometimes should solve some dependency(new or older vesion) with dpkg install.


## Konsole Not Dispaly Bold Font

Maybe Config Font Config But This Is Bug For QT..


# web and internet

更新和升级+网页设计+服务框架+硬件配置+代码托管+维护和管理+域名和地址
![img](/home/zhangtao/dropbox/picture/web_internet.png)

sudo apt-get install vim-youcompleteme
vam install youcompleteme


# c programming


## boost lib

sudo apt-get install libboost-all-dev
sudo apt-get install libgnuplot-iostream-dev
sudo apt-get install libmgl-dev mathgl


## random


## config gnuplot lib

<http://gnuplot.sourceforge.net/demo/>

> 
> 
>     #include<iostream>
>     #include<cstdlib>
>     #include<ctime>
>     #define random(a,b) (rand()%(b-a+1)+a)
>     using namespace std;
>     int main()
>     {
>         srand((unsigned)time(null));
>         for(int i=0;i<10;i++)
>         cout<<random(1,100)<<' ';
>         return 0;
>     }
> 
> 取得(0,x)的随机整数：rand()%x；
> 取得(a,b)的随机整数：rand()%(b-a)；
> 取得[a,b)的随机整数：rand()%(b-a)+a；
> 取得[a,b]的随机整数：rand()%(b-a+1)+a；
> 取得(a,b]的随机整数：rand()%(b-a)+a+1；
> 取得0-1之间的浮点数：rand()/double(rand<sub>max</sub>)。


## segmentation fault ulimit for shell


# markdown + html + css

apt-get install markdown

-   [ ] todo wirte the css with html for pdf and ppt
-   links

<div style="text-align:left"><font size="2" face="helvetica"><a href="<https://github.com/ztao1991/networks/blob/master/exercise/net2_ex1/sandpile-model_version0.2.cpp>">sandpile-model.cpp<b></b></a></font></div>

-   img

<div style="text-align:center"><img src="figure<sub>1</sub>-2.png"/><p><font size="4" face="helvetica"><b>sandpile-model</b></font></p></div>

-   pdf and ppt tool with markdown and html

markdown to chrome or pandoc to pdf or ppt


# fonts redering with monaco

> xft.antialias: 1
> 
> xft.autohint: 0
> 
> xft.dpi: 144
> 
> xft.hinting: 1
> 
> xft.hintstyle: hintmedium
> 
> xft.lcdfilter: lcddefault
> 
> xft.rgba: rgb
> 
> emacs.fontbackend: xft
> emacs.font: monaco-10
> 
> urxvt.font:xft:monaco for powerline:size=9:antialias=true,xft:文泉驿等宽微米黑:size=10
> rxvt.scrollbar:false
> rxvt.scrollbar<sub>right</sub>:true
> rxvt.scrollbar<sub>floating</sub>: false
> rxvt.scrollstyle:plain
> 
> urxvt\*cursorcolor: red
> 
> ! colors
> urxvt\*background: black
> urxvt\*foreground: white
> 
> !!urxvt.keysym.shift-control-v: perl:clipboard:paste
> !!urxvt.iso14755: false
> !!urxvt.perl-ext-common: default,clipboard
> !!
> !!
> !!!!source <http://github.com/altercation/solarized>
> !!
> !!\*background: #002b36
> !!\*foreground: #657b83
> !!!!\*fading: 40
> !!\*fadecolor: #002b36
> !!\*cursorcolor: #93a1a1
> !!\*pointercolorbackground: #586e75
> !!\*pointercolorforeground: #93a1a1
> !!
> !!!! black dark/light
> !!\*color0: #073642
> !!\*color8: #002b36
> !!
> !!!! red dark/light
> !!\*color1: #dc322f
> !!\*color9: #cb4b16
> !!
> !!!! green dark/light
> !!\*color2: #859900
> !!\*color10: #586e75
> !!
> !!!! yellow dark/light
> !!\*color3: #b58900
> !!\*color11: #657b83
> !!
> !!!! blue dark/light
> !!\*color4: #268bd2
> !!\*color12: #839496
> !!
> !!!! magenta dark/light
> !!\*color5: #d33682
> !!\*color13: #6c71c4
> !!
> !!!! cyan dark/light
> !!\*color6: #2aa198
> !!\*color14: #93a1a1
> !!
> !!!! white dark/light
> !!\*color7: #eee8d5
> !!\*color15: #fdf6e3

sources: <https://www.emacswiki.org/emacs/xftgnuemacs#toc17>

> 
> 
> <?xml version="1.0"?>
> <!doctype fontconfig system "fonts.dtd">
> <fontconfig>
>   <match target="font">
>     <edit name="embeddedbitmap" mode="assign">
>       <bool>false</bool>
>     </edit>
>   </match>
> </fontconfig>

sources: <https://wiki.archlinux.org/index.php/font_configuration#disable_bitmap_fonts>

xserver<sub>arguments</sub>   -nolisten tcp vt07 -dpi 96


# dpi

1.  sddm
    vim /etc/sddm.conf

> [autologin]
> relogin=false
> session=
> user=
> 
> [general]
> haltcommand=
> rebootcommand=
> 
> [theme]
> current=breeze
> cursortheme=breeze<sub>snow</sub>
> 
> [users]
> maximumuid=65000
> minimumuid=1000
> 
> [x11]
> serverarguments=-nolisten tcp -dpi 144

1.  xresource
    
    > xft.antialias: 1
    > 
    > xft.autohint: 0
    > 
    > xft.dpi: 144
    > 
    > xft.hinting: 1
    > 
    > xft.hintstyle: hintfull
    > 
    > xft.lcdfilter: lcddefault
    > 
    > xft.rgba: rgb

> 4.smaller - 100% = 96 dpi(pixels/dots per inch) 
> 5.medium - 125% = 120 dpi (pixels/dots per inch)
> 6.larger - 150% = 144 dpi (pixels/dots per inch). 


## dell xps 13

> enabling
> 
> note: in most cases, this should be enabled automatically during debian installation.
> 
> install the cpufrequtils package:
> 
> aptitude install cpufrequtils
> configuration
> 
> specify the governor to use at boot
> edit /etc/default/cpufrequtils (you might need to create it if it doesn't exist). specify the governor with the governor variable:
> 
> governor="conservative"
> keeping the governor settings between boots
> install sysfsutils:
> 
> aptitude install sysfsutils
> the sysfs values will be configured in /etc/sysfs.conf.
> 
> here are some examples for the conservative governor:
> 
> mode devices/system/cpu/cpufreq/conservative = 644
> devices/system/cpu/cpufreq/conservative/freq<sub>step</sub> = 10
> devices/system/cpu/cpufreq/conservative/up<sub>threshold</sub> = 45
> devices/system/cpu/cpufreq/conservative/ignore<sub>nice</sub><sub>load</sub> = 1
> devices/system/cpu/cpufreq/conservative/sampling<sub>down</sub><sub>factor</sub> = 10
> after you made the changes in /etc/sysfs.conf, apply them with /etc/init.d/sysfsutils start or with  service sysfsutils start.

source:<https://wiki.debian.org/howto/cpufrequencyscaling>

-----------------------------------------------------------&#x2013;&#x2014;just use
markdown format-----------------------------------------------------&#x2013;&#x2014;


# Learn HTML And CSS

<del>Important Diff With id and class</del>

-   <div id="example-id"></div> USE="#"
    \\#example { }
-   <p class="example-class"></p> USE="."
    p.example-class{ }

![img](/home/zhangtao/Pictures/Screenshot_20170703_145402.png)
![img](/home/zhangtao/Pictures/Screenshot_20170703_145419.png)

-   Style
    body - #header(id) - h1,p.. - .class


# Footnotes

<sup><a id="fn.1" href="#fnr.1">1</a></sup> www.baidu.com
