#!/usr/bin/env bash
set -e

if [ "$EUID" -eq 0 ]; then
  echo "Do not run uninstall.sh with sudo."
  exit 1
fi

gnome-extensions list | xargs -r -n 1 gnome-extensions disable
rm -rf ~/.config/gtk-3.0/gtk.css ~/.config/gtk-4.0/gtk.css ~/.config/gtk-4.0/assets
rm -rf ~/.themes/Mac* ~/.local/share/themes/Mac* ~/.local/share/icons/Mac* ~/.icons/Mac*
dconf reset -f /org/gnome/

echo "Done. Log out and log back in for changes to fully apply."
