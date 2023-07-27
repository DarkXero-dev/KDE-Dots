#!/bin/bash
#set -e
echo "##########################################"
echo "Be Careful this will override your Rice!! "
echo "##########################################"
echo
echo "Removing No longer needed Packages"
echo "##################################"
sudo pacman -Rns --noconfirm latte-dock &>/dev/null; sudo pacman -Rns --noconfirm qt5-virtualkeyboard &>/dev/null; sudo pacman -Rns --noconfirm qt6-virtualkeyboard &>/dev/null
echo
sleep 2
echo "Installing Necessary Packages"
echo "#############################"
# Check if any of the specified packages are installed and install them if not present
packages="cmake extra-cmake-modules python kvantum gtk-engine-murrine gtk-engines ttf-hack-nerd ttf-fira-code yakuake neofetch ttf-terminus-nerd noto-fonts-emoji meld"

for package in $packages; do
    pacman -Qi "$package" > /dev/null 2>&1 || sudo pacman -Syy --noconfirm --needed "$package" > /dev/null 2>&1
done
echo
echo "Installing Yay"
echo "##############"
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin/ && makepkg -si --noconfirm
cd ..
echo
echo "Installing AUR Packages"
echo "#######################"
yay -S --noconfirm latte-dock-git ttf-meslo-nerd-font-powerlevel10k
sleep 2
echo
echo "Installing Icon Theme"
echo "#######################"
git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git && cd Tela-circle-icon-theme/ && ./install.sh -c purple
cd ..
sleep 2
echo
echo "Creating Backup & Applying new Rice, hold on..."
echo "###############################################"
cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S) && cp -Rf Configs/Home/. ~
sudo cp -Rf Configs/System/. / && sudo cp -Rf Configs/Home/. /root/
sleep 2
echo
echo "Applying Grub Theme...."
echo "#######################"
chmod +x Grub.sh
sudo ./Grub.sh
sudo sed -i "s/GRUB_GFXMODE=auto/GRUB_GFXMODE=1920x1080/g" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
sleep 2
echo
echo "Installing Layan Theme"
echo "######################"
echo
git clone https://github.com/vinceliuice/Layan-kde.git && cd Layan-kde/ && sh install.sh
cd ..
sleep 2
echo
echo "Installing & Applying GTK4 Theme "
echo "#################################"
git clone https://github.com/vinceliuice/Layan-gtk-theme.git && cd Layan-gtk-theme/ && sh install.sh -l -c dark
cd ..
echo
rm -rf ~/.cache/
echo
echo "Plz Reboot To Apply Settings..."
echo "###############################"
