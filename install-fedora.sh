#!/usr/bin/env bash
# ==============================================================================
#  macOS 26 "Liquid Glass" for GNOME 50 — Engineered by xnoviq (@xnoviiq)
#  Repository: https://github.com/xnoviiq/macos-26-gnome
# ==============================================================================
set -e
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

clear
cat << "BANNER"
╔══════════════════════════════════════════════════════════════════════════╗
║                                                                          ║
║     macOS 26 "Liquid Glass" Edition  •  Architected by xnoviq           ║
║      GitHub: https://github.com/xnoviiq/macos-26-gnome                   ║
║                                                                          ║
║      • Real-Time GLSL Liquid Glass Shader Pipeline                       ║
║      • Patched D-Bus Global Menu & Self-Healing ⌘ Indicator              ║
║      • Custom Dark Launchpad, Squircle Overrides & SF Pro Typography     ║
║                                                                          ║
╚══════════════════════════════════════════════════════════════════════════╝
BANNER

echo "==> [1/7] [xnoviq Installer] Backing up current dconf & installing dependencies..."
mkdir -p ~/.config/macos26-backup
dconf dump / > ~/.config/macos26-backup/dconf-backup-$(date +%F-%H%M).txt 2>/dev/null || true

sudo dnf install -y git curl wget python3 gnome-tweaks gnome-shell-extension-manager sassc glib2-devel gtk-murrine-engine fontconfig

echo "==> [2/7] [xnoviq Installer] Installing Apple SF Pro & SF Mono Font Suite..."
mkdir -p ~/.local/share/fonts
cp -r "$REPO_DIR/fonts/"* ~/.local/share/fonts/ 2>/dev/null || true
fc-cache -fv ~/.local/share/fonts >/dev/null 2>&1 || true

echo "==> [3/7] [xnoviq Installer] Deploying MacTahoe-Dark-alt & WhiteSur-Dark Themes..."
mkdir -p ~/.themes ~/.local/share/themes ~/.config/gtk-3.0 ~/.config/gtk-4.0
cp -r "$REPO_DIR/themes/"* ~/.themes/ 2>/dev/null || true
cp -r "$REPO_DIR/themes/"* ~/.local/share/themes/ 2>/dev/null || true
rm -rf ~/.config/gtk-3.0/* ~/.config/gtk-4.0/*
cp -r "$REPO_DIR/configs/gtk-3.0/"* ~/.config/gtk-3.0/ 2>/dev/null || true
cp -r "$REPO_DIR/configs/gtk-4.0/"* ~/.config/gtk-4.0/ 2>/dev/null || true

echo "==> [4/7] [xnoviq Installer] Deploying Custom Squircle Icons, Dark Launchpad & Cursors..."
mkdir -p ~/.local/share/icons ~/.icons
cp -r "$REPO_DIR/icons/root_svgs/"* ~/.local/share/icons/ 2>/dev/null || true
for item in "$REPO_DIR/icons/"*; do
    name=$(basename "$item")
    [ "$name" = "root_svgs" ] && continue
    cp -r "$item" ~/.local/share/icons/
done
[ -d "$HOME/.local/share/icons/MacTahoe-dark" ] && cp -r "$HOME/.local/share/icons/MacTahoe-dark" ~/.icons/ 2>/dev/null || true
gtk-update-icon-cache -f -t ~/.local/share/icons/* 2>/dev/null || true

echo "==> [5/7] [xnoviq Installer] Installing Wallpapers, .desktop Mappings & Safari Firefox..."
mkdir -p ~/.local/share/backgrounds ~/.local/share/applications
cp -r "$REPO_DIR/wallpapers/"* ~/.local/share/backgrounds/ 2>/dev/null || true

for f in "$REPO_DIR/applications/"*.desktop; do
    [ -f "$f" ] || continue
    sed "s|__HOME__|$HOME|g" "$f" > "$HOME/.local/share/applications/$(basename "$f")"
done
update-desktop-database ~/.local/share/applications/ 2>/dev/null || true

for ff_dir in ~/snap/firefox/common/.mozilla/firefox ~/.mozilla/firefox; do
    if [ -d "$ff_dir" ]; then
        for PROFILE in $(find "$ff_dir" -maxdepth 2 -type d \( -name "*.default*" -o -name "*release*" \) 2>/dev/null); do
            if [ -n "$(ls -A "$REPO_DIR/firefox" 2>/dev/null)" ]; then
                mkdir -p "$PROFILE/chrome"
                cp -r "$REPO_DIR/firefox/"* "$PROFILE/chrome/" 2>/dev/null || true
                [ -f "$REPO_DIR/firefox/user.js" ] && cp "$REPO_DIR/firefox/user.js" "$PROFILE/user.js"
            elif [ -f "$REPO_DIR/tools/MacTahoe-gtk-theme/tweaks.sh" ]; then
                "$REPO_DIR/tools/MacTahoe-gtk-theme/tweaks.sh" -f 2>/dev/null || true
            fi
        done
    fi
done

echo "==> [6/7] [xnoviq Installer] Deploying Patched GNOME 50 Extensions & Shaders..."
mkdir -p ~/.local/share/gnome-shell/extensions
cp -r "$REPO_DIR/extensions/"* ~/.local/share/gnome-shell/extensions/ 2>/dev/null || true

python3 -c '
import os
home = os.path.expanduser("~")
ext_dir = os.path.join(home, ".local/share/gnome-shell/extensions")
for root, _, files in os.walk(ext_dir):
    for f in files:
        if f.endswith((".js", ".css", ".json", ".xml", ".svg", ".ui")):
            p = os.path.join(root, f)
            try:
                txt = open(p, "r", errors="ignore").read()
                if "__HOME__" in txt:
                    open(p, "w").write(txt.replace("__HOME__", home))
            except Exception:
                pass
'
for schema_dir in ~/.local/share/gnome-shell/extensions/*/schemas; do
    [ -d "$schema_dir" ] && glib-compile-schemas "$schema_dir" 2>/dev/null || true
done

echo "==> [6.5/7] Resolving Issue #3 paths..."

find ~/.config/gtk-3.0 ~/.config/d2da -type f -exec sed -i "s|__HOME__|$HOME|g" {} + 2>/dev/null || true

echo "==> [7/7] [xnoviq Installer] Applying Liquid Glass Pipeline, Terminal Alpha & Dock State..."
PRIMARY_MON=$(xrandr --listmonitors 2>/dev/null | awk 'NR==2 {print $NF}' || echo "eDP-1")
[ -z "$PRIMARY_MON" ] && PRIMARY_MON="eDP-1"

dconf load /org/gnome/desktop/interface/ < "$REPO_DIR/configs/interface.dconf"
dconf load /org/gnome/desktop/wm/preferences/ < "$REPO_DIR/configs/wm.dconf"
dconf load /org/gnome/desktop/app-folders/ < "$REPO_DIR/configs/app-folders.dconf"
sed "s|__HOME__|$HOME|g" "$REPO_DIR/configs/background.dconf" | dconf load /org/gnome/desktop/background/
sed -e "s|__HOME__|$HOME|g" -e "s|__MONITOR__|$PRIMARY_MON|g" "$REPO_DIR/configs/extensions.dconf" | dconf load /org/gnome/shell/extensions/
sed "s|__HOME__|$HOME|g" "$REPO_DIR/configs/shell-root.dconf" | dconf load /org/gnome/shell/

if fc-list | grep -qi "SF Pro"; then
    gsettings set org.gnome.desktop.interface font-name "SF Pro Display 11" 2>/dev/null || true
    gsettings set org.gnome.desktop.interface document-font-name "SF Pro Text 11" 2>/dev/null || true
    gsettings set org.gnome.desktop.wm.preferences titlebar-font "SF Pro Display Bold 11" 2>/dev/null || true
fi
if fc-list | grep -qi "SF Mono"; then
    gsettings set org.gnome.desktop.interface monospace-font-name "SF Mono Regular 11" 2>/dev/null || true
fi

[ -s "$REPO_DIR/configs/ptyxis.dconf" ] && dconf load /org/gnome/Ptyxis/ < "$REPO_DIR/configs/ptyxis.dconf" 2>/dev/null || true
[ -s "$REPO_DIR/configs/gnome-terminal.dconf" ] && dconf load /org/gnome/terminal/ < "$REPO_DIR/configs/gnome-terminal.dconf" 2>/dev/null || true
[ -s "$REPO_DIR/configs/console.dconf" ] && dconf load /org/gnome/Console/ < "$REPO_DIR/configs/console.dconf" 2>/dev/null || true

gnome-extensions disable ubuntu-dock@ubuntu.com 2>/dev/null || true
gnome-extensions disable ding@rastersoft.com 2>/dev/null || true
gnome-extensions disable tiling-assistant@ubuntu.com 2>/dev/null || true

dconf write /org/gnome/shell/disable-user-extensions false
while IFS= read -r ext; do
    [ -n "$ext" ] && gnome-extensions enable "$ext" 2>/dev/null || true
done < "$REPO_DIR/configs/enabled-extensions.txt"

echo ""
echo "╔══════════════════════════════════════════════════════════════════════════╗"
echo "║  ✅  macOS 26 by xnoviq Installed Successfully!                          ║"
echo "║  👉  Log out and log back in now to activate all shaders & extensions.   ║"
echo "╚══════════════════════════════════════════════════════════════════════════╝"
