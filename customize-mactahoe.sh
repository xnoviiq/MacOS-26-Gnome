#!/usr/bin/env bash
# ==============================================================================
#  macOS 26 "Liquid Glass" Customization CLI — Curated & Patched by xnoviq
#  GitHub: https://github.com/xnoviiq
# ==============================================================================
set -e
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR/tools/MacTahoe-gtk-theme"

echo "╔══════════════════════════════════════════════════════════════════════╗"
echo "║     macOS 26 Theme Customizer  •  Engineered by xnoviq (@xnoviiq)  ║"
echo "╚══════════════════════════════════════════════════════════════════════╝"
echo "Examples:"
echo "  ./customize-mactahoe.sh -c dark -a alt -l          (xnoviq Default: 2nd-style Traffic Lights + Libadwaita)"
echo "  ./customize-mactahoe.sh -c dark -t blue -a alt -l  (Switch Accent Color to Blue)"
echo "  ./tools/MacTahoe-gtk-theme/tweaks.sh -f            (Re-apply xnoviq Safari Firefox Theme)"
echo "------------------------------------------------------------------------"

if [ $# -eq 0 ]; then
    ./install.sh --help
else
    ./install.sh "$@"
fi
