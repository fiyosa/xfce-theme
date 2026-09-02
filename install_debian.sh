#!/bin/bash
set -e

THEME_DIR="$HOME/TEMP_THEME"
EXTRACT_DIR="$THEME_DIR/xfce-theme"

# ============================================
# Prepare folder
# ============================================
mkdir -p "$THEME_DIR"
cd "$THEME_DIR"

# ============================================
# Install requirement
# ============================================
sudo apt-get install -y gtk2-engines-murrine gtk2-engines-pixbuf unzip sassc git

# ============================================
# Install Qogir theme
# ============================================
curl -Lo "$THEME_DIR/xfce-theme-assets.zip" https://github.com/fiyosa/xfce-theme/releases/download/1.0/xfce-theme-assets.zip
unzip -q "$THEME_DIR/xfce-theme-assets.zip" -d "$THEME_DIR"

git clone https://github.com/vinceliuice/Qogir-theme.git "$THEME_DIR/Qogir-theme"
cd "$THEME_DIR/Qogir-theme" && ./install.sh --tweaks round

# ============================================
# Install Qogir icon theme
# ============================================
git clone https://github.com/vinceliuice/Qogir-icon-theme.git "$THEME_DIR/Qogir-icon-theme"
cd "$THEME_DIR/Qogir-icon-theme" && ./install.sh -t default

mkdir -p ~/.icons
ln -s ~/.local/share/icons/Qogir-Dark ~/.local/share/icons/Qogir-Light ~/.icons

# ============================================
# Add font
# ============================================
mv "$EXTRACT_DIR/fonts" ~/.local/share

# ============================================
# Install xfce4-panel plugin
# ============================================
sudo apt install -y xfce4-docklike-plugin xfce4-panel-profiles

if [ -f ~/.config/gtk-3.0 ]; then
  rm ~/.config/gtk-3.0
fi
mkdir -p ~/.config/gtk-3.0
mv "$EXTRACT_DIR/whisker-menu.gtk.css.dark/gtk.css" ~/.config/gtk-3.0/

xfce4-panel -r

# ============================================
# Add wallpapers & start menu icons
# ============================================
mv "$EXTRACT_DIR/wallpaper" ~/.local/share
mv "$EXTRACT_DIR/start_menu_icons" ~/.local/share

# ============================================
# Install ulauncher
# ============================================
cp "$EXTRACT_DIR/packages/ulauncher_5.16.0_all.deb" /tmp
sudo apt install -y /tmp/ulauncher_5.16.0_all.deb

mkdir -p ~/.config/ulauncher/user-themes
mv "$EXTRACT_DIR/goxir-dark" "$EXTRACT_DIR/goxir-light" ~/.config/ulauncher/user-themes

echo ""
echo "Installation complete. Please follow the manual notes for GUI settings."