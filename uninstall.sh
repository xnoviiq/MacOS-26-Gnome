#!/usr/bin/env bash
# macOS 26 Liquid Glass — Safe GNOME settings rollback
# Engineered by xnoviq (@xnoviiq)

set -e

echo "=========================================="
echo " macOS 26 Liquid Glass — Rollback"
echo "=========================================="

shopt -s nullglob
BACKUPS=("$HOME"/.config/macos26-backup/dconf-backup-*.txt)

if [ ${#BACKUPS[@]} -eq 0 ]; then
    echo "WARNING: No GNOME settings backup found."
    echo "Nothing was restored."
else
    LATEST_BAK=$(ls -t "${BACKUPS[@]}" | head -n 1)
    dconf load / < "$LATEST_BAK"
    echo "Restored GNOME settings from:"
    echo "$LATEST_BAK"
fi

echo
echo "Note: Installed theme, icon, font and GTK files"
echo "are not automatically removed by this rollback."
echo "Log out and log back in to apply restored settings."
echo "Rollback finished."
