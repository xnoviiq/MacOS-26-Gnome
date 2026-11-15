#!/usr/bin/env bash
# ==============================================================================
#  macOS 26 "Liquid Glass" Uninstaller — Engineered by xnoviq (@xnoviiq)
# ==============================================================================
set -e
echo "╔══════════════════════════════════════════════════════════════════════╗"
echo "║     macOS 26 'Liquid Glass' Rollback  •  by xnoviq (@xnoviiq)       ║"
echo "╚══════════════════════════════════════════════════════════════════════╝"
LATEST_BAK=$(ls -t ~/.config/macos26-backup/dconf-backup-*.txt 2>/dev/null | head -n 1)
if [ -n "$LATEST_BAK" ]; then
    dconf load / < "$LATEST_BAK"
    echo "✅ Restored pre-install dconf backup: $LATEST_BAK"
else
    echo "⚠️ No automatic backup found in ~/.config/macos26-backup/."
fi
gnome-extensions enable ubuntu-dock@ubuntu.com 2>/dev/null || true
gnome-extensions enable ding@rastersoft.com 2>/dev/null || true
echo "✅ Rollback complete! Log out and log back in."
