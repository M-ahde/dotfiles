#!/bin/bash

DIR="$HOME/Pictures/Wallpapers"

apply_wallpaper() {
    local FULL_PATH="$1"
    
    swww img "$FULL_PATH" --transition-type any

    wal -i "$FULL_PATH" -n

    pkill waybar
    waybar &

    THEME="$HOME/.config/Vencord/themes/system24-wal.css"
    SYSTEM24_URL="https://refact0r.github.io/system24/build/system24.css"
    WAL_CSS="$HOME/.cache/wal/colors.css"

    echo "/* system24 + wal auto-generated theme */" > "$THEME"
    echo "@import url('$SYSTEM24_URL');" >> "$THEME"
    echo "" >> "$THEME"

    awk '
      BEGIN {print ":root {"}
      /--background/ || /--foreground/ || /--color[0-9]+/ {print "  " $0}
      END {print "}"}' "$WAL_CSS" >> "$THEME"

    cat >> "$THEME" <<EOL
:root {
 --bg-4: hsla(220, 15%, 10%, 0.85);
 --bg-3: color-mix(in srgb, var(--background), var(--color0) 30% / 0.8);
 --bg-2: color-mix(in srgb, var(--background), var(--color0) 50% / 0.8);
 --bg-1: var(--color0);
 --panel-blur: on;
 --blur-amount: 12px;
 --transparency-tweaks: on;
 --text-1: var(--foreground);
 --text-2: color-mix(in srgb, var(--foreground), white 10%);
 --text-3: color-mix(in srgb, var(--foreground), gray 20%);
 --text-4: color-mix(in srgb, var(--foreground), gray 40%);
 --text-5: color-mix(in srgb, var(--foreground), gray 60%);
 --purple-1: var(--color5);
 --purple-2: var(--color13);
 --purple-3: var(--color12);
 --purple-4: var(--color6);
 --purple-5: var(--color4);
 --blue-2: var(--color4);
 --green-2: var(--color2);
 --red-2: var(--color1);
 --yellow-2: var(--color3);
 --online: var(--color2);
 --idle: var(--color3);
 --dnd: var(--color1);
 --streaming: var(--color5);
}
EOL
    hyprctl reload
}

if [[ "$1" == "--random" ]]; then
    SELECTED_WALL=$(find "$DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)
    if [ -n "$SELECTED_WALL" ]; then
        apply_wallpaper "$SELECTED_WALL"
    fi
else
    entries=""
    for img in "$DIR"/*.{jpg,png,jpeg}; do
        [ ! -f "$img" ] && continue
        name=$(basename "$img")
        entries+="$name\x00icon\x1f$img\n"
    done

    WALLPAPER=$(echo -e "$entries" | rofi -show-icons -theme ~/.config/rofi/config-wallpaper.rasi -dmenu -p "Wallpaper")
    
    if [ -n "$WALLPAPER" ]; then
        apply_wallpaper "$DIR/$WALLPAPER"
    fi
fi
