# System Git Configuration

![arch system image](./.rdm/arch_config.png)

### Pulling Unix files (for mac or linux), onto your machine

```
cd "${HOME}"

alias cg="git --git-dir=${HOME}/.unx/ --work-tree=${HOME}"

git clone --bare 'https://github.com/nanvenomous/unix.git' "${HOME}/.unx"

cg checkout

# may need to fix conflicts by moving files, then re-run previous command

cg config --local status.showUntrackedFiles no
```

you can then optionally add a permanent alias to your login script
```
# ~/.bashrc, ~/.zshrc, ~/.xonshrc, ...
alias cg="git --work-tree=${HOME} --git-dir=${HOME}/.unx"
```



- [In-depth Guide to tracking dotfiles](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)


- edit `/etc/default/grub`
```
GRUB_TIMEOUT=0
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3"
```
then run `grub-mkconfig -o /boot/grub/grub.cfg`

# To Automate
- [ ] [google chrome](https://aur.archlinux.org/packages/google-chrome/)
- [ ] [gtk tokyo night](https://github.com/stronk-dev/Tokyo-Night-Linux)
- [ ] [pcmanfm](https://archlinux.org/packages/community/x86_64/pcmanfm/) -> files
- [ ] [vim-plug](https://aur.archlinux.org/packages/vim-plug/)
- [ ] [pavucontrol](https://archlinux.org/packages/extra/x86_64/pavucontrol/) -> sound
- [ ] [lazy git](https://archlinux.org/packages/community/x86_64/lazygit/)
- [ ] [zsh system clipboard](https://github.com/kutsan/zsh-system-clipboard)
- [ ] [st](https://github.com/siduck76/st)
  - [jetbrains mono nerdfont](https://archlinux.org/packages/community/any/ttf-jetbrains-mono-nerd/)
- [ ] [dns with systemd-resolvd](https://wiki.archlinux.org/title/NetworkManager#systemd-resolved)
- [ ] [AMDGPU](https://wiki.archlinux.org/title/AMDGPU)
- [ ] firefox 
  - [firefox markdown](https://github.com/KeithLRobertson/markdown-viewer#support-for-local-files-on-linux)
  - nav to [configuration page](about:config) `browser.fullscreen.autohide`
  - [ ] firefox shortcuts
```
map tj nextTab
map tk previousTab
map tn removeTab
map to createTab
map th moveTabLeft
map tl moveTabRight
map tp openCopiedUrlInNewTab

map gb goBack
map gj scrollPageDown
map gk scrollPageUp

map u restoreTab
```

# Devices
- [xps 13 9310](https://wiki.archlinux.org/title/Dell_XPS_13_(9310))
- [Framework_Laptop_13](https://wiki.archlinux.org/title/Framework_Laptop_13)
    - [framework-system](https://archlinux.org/packages/extra/x86_64/framework-system/)
    - [docs](https://github.com/FrameworkComputer/linux-docs/tree/main/framework12)

# Core Sway packages
sudo pacman -S sway swaylock swayidle swaybg
# Wayland equivalents for common tools
sudo pacman -S waybar          # Status bar (alternative to i3status/i3bar)
sudo pacman -S grim slurp      # Screenshots (alternative to maim/scrot)
sudo pacman -S wl-clipboard    # Clipboard (alternative to xclip/xsel)
sudo pacman -S wofi            # App launcher (alternative to dmenu/rofi)
# Optional but recommended
sudo pacman -S xorg-xwayland   # Run X11 apps on Wayland
sudo pacman -S polkit-kde-agent # For authentication dialogs
Copy your i3 config
mkdir -p ~/.config/sway
cp ~/.config/i3/config ~/.config/sway/config
Edit the Sway config
Open ~/.config/sway/config and make these minimal changes:
1. Replace your app launcher (find the dmenu/rofi line):
      # Change from: bindsym $mod+d exec dmenu_run
   bindsym $mod+d exec wofi --show drun

### for screenshare
```bash
sudo pacman -S xdg-desktop-portal xdg-desktop-portal-wlr # screen share
systemctl --user start xdg-desktop-portal.service
systemctl --user enable xdg-desktop-portal.service
systemctl --user start xdg-desktop-portal-wlr.service
systemctl --user enable xdg-desktop-portal-wlr.service
```

### for screen rotation
```bash
yay -S rot8
```


Create a config file at `~/.config/rot8/rot8.toml`:
```ini
[laptop]
display = "eDP-1"
touchscreen = "eDP-1"
threshold = 0.5
```
then `rot8 &`


