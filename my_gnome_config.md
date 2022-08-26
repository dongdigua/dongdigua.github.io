# my gnome configuration

icon: Numix-Circle<br>
```shell
doas dnf install numix-icon-theme-circle
```

sound: Ubuntu Yaru<br>
```shell
doas dnf install yaru-sound-theme
doas mv /usr/share/sounds/Yaru/stereo/desktop-login.oga ~/
```

## cursor: oxygen
```shell
doas dnf install oxygen-cursor-themes
```

## background: fedora 33 (最开始入坑fedora时自带的, 感觉特别好看)
```shell
doas dnf install f33-backgrounds-gnome
```

gnome-terminal: Solarized

## login manager: lightdm
```shell
don't forget to install lightdm-settings
doas dnf install lightdm-settings
```

extensions:
- user theme
- dash to panel
- clipboard indicator(我之前一直是用文本编辑器当作临时剪切板🤣)

dir name
```shell
export LANG=en_US
xdg-user-dirs-gtk-update
export LANG=zh_CN.UTF-8
```

## remove "gnome-classic"
```shell
doas dnf remove gnome-classic-session
```

## use Geary as a replacement of Thunderbird




