#!/usr/bin/env bash
set -e

# Make dnf faster appending two lines to the end of the config file
sudo echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf
sudo echo "fastestmirror=True" >> /etc/dnf/dnf.conf

echo "Actualizando sistema"
sudo dnf update

echo "Instalando software inicial"
sudo dnf install -y zsh neovim stow copr ImageMagick gnome-shell-extension-pop-shell xprop curl wget util-linux-user fzf fd-find pandoc g++ timeshift python3-pip gnome-tweaks zoxide ulauncher

echo "Instalando soporte para H264"
sudo dnf config-manager --set-enabled fedora-cisco-openh264
sudo dnf install -y gstreamer1-plugin-openh264 mozilla-openh264

# Install TinyTex
echo "Instalando TinyTex para conversión pandoc-pdf"
wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sh

# Add Flathub repo
echo "Instalando repositorio Flathub"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Obsidian & Zotero
echo "Instalando software desde Flathub"
flatpak install -y flathub md.obsidian.Obsidian org.zotero.Zotero com.spotify.Client app.zen_browser.zen org.gnome.Extensions

# Set adwaita-dark theme for Zotero
sudo flatpak override --env=GTK_THEME=Adwaita-dark org.zotero.Zotero

# Download Hack Nerd Font
echo "Instalando tipografía: Hack Nerd Font"
mkdir ~/.local/share/fonts/Hack/
cd ~/.local/share/fonts/Hack/
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/Hack.zip 
sudo unzip ~/.local/share/fonts/Hack.zip
ls -la ~/.local/share/fonts/
#sudo rm ~/.local/share/fonts/Hack.zip

# Download iAWriterDuo
echo "Instalando tipografía: iA Writer Duo"
mkdir -p ~/.local/share/fonts/iAWriterDuo/
cd ~/.local/share/fonts/iAWriterDuo/
wget https://github.com/iaolo/iA-Fonts/raw/master/iA%20Writer%20Duo/Variable/iAWriterDuoV.ttf
wget https://github.com/iaolo/iA-Fonts/raw/master/iA%20Writer%20Duo/Variable/iAWriterDuoV-Italic.ttf

echo "Instalando tipografía: Inter"
mkdir -p ~/.local/share/fonts/Inter/
cd ~/.local/share/fonts/Inter/
wget https://github.com/rsms/inter/releases/download/v3.19/Inter-3.19.zip
sudo unzip ~/.local/share/fonts/Inter/Inter-3.19.zip

cd ~
# add zsh as a login shell
echo "Configurando zsh como shell principal"
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER
chsh -s $(which zsh)

# Install zsh manager
echo "Instalando zsh manager"
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

# Install dotfiles
echo "Configurando dotfiles"
git clone git@github.com:abrahambahez/.dotfiles.git "$HOME/.dotfiles"
echo "Corriendo script link..."
cd "$HOME/.dotfiles"
chmod +x ./link.sh
./link.sh
echo "Terminado"

echo "Instalando manejadores de Javascript"
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
nvm install npm
echo "Instalando ConventionalCommit"
sudo npm i -g semantic-git-commit-cli

echo "Instalando UV Python"
curl -LsSf https://astral.sh/uv/install.sh | sh

echo "Instalando TERMINAL Ghostty COPR"
dnf copr enable pgdev/ghostty
dnf install ghostty

echo "Instalando Espanso desde COPR"
sudo dnf copr enable eclipseo/espanso
sudo dnf install espanso espanso-wayland

echo "INTERCAMBIANDO teclas Alt y Ctrl izquierda"
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swap_lalt_lctl']"

echo "Proceso terminado.\n\nConfigura últimos retoques vía GUI: Gnome Tweaks + Shell extensions\n\nSe cerrará la sesión..."

gnome-session-quit --logout

