# --- 1. استيراد ألوان Pywal ---
if test -f ~/.cache/wal/sequences
    cat ~/.cache/wal/sequences
end

# جلب الألوان من ملف wal وتخزينها كمتغيرات عالمية
if test -f ~/.cache/wal/colors
    set -g wal_colors (cat ~/.cache/wal/colors)
    set -g wal_color0 $wal_colors[1]
    set -g wal_color1 $wal_colors[2]
    set -g wal_color2 $wal_colors[3]
    set -g wal_color3 $wal_colors[4]
    set -g wal_color4 $wal_colors[5]
    set -g wal_color5 $wal_colors[6]
    set -g wal_color6 $wal_colors[7]
    set -g wal_color7 $wal_colors[8]
end

# --- 2. الواجهة الترحيبية (GUI Style) ---
if status is-interactive
    clear
    # تم إزالة padding-left واستبداله بمسافات يدوية لضمان التوافق
    echo ""
    fastfetch | sed 's/^/    /' 
    echo ""
    
    # عرض الكبسولات الملونة بشكل ممتلئ
    echo -n "    "
    for col in $wal_color1 $wal_color2 $wal_color3 $wal_color4 $wal_color5 $wal_color6
        set_color $col
        echo -n ""
        set_color -b $col
        set_color black # لون الأيقونة داخل الكبسولة
        echo -n "󰏘"
        set_color normal
        set_color $col
        echo -n " "
    end
    echo -e "\n"
end

# --- 3. تصميم الـ Prompt (Bubble Bar) ---
function fish_prompt
    set -l last_status $status
    
    # التأكد من وجود ألوان وإلا استخدام ألوان افتراضية
    set -l c_usr (if set -q wal_color2; echo $wal_color2; else; echo green; end)
    set -l c_pwd (if set -q wal_color4; echo $wal_color4; else; echo blue; end)
    set -l c_git (if set -q wal_color5; echo $wal_color5; else; echo magenta; end)
    
    echo -n -s \n "  " (set_color $c_usr) "" (set_color -b $c_usr black) "   $USER " (set_color normal) (set_color $c_usr) " " \
                 (set_color $c_pwd) "" (set_color -b $c_pwd black) "   "(prompt_pwd)" " (set_color normal) (set_color $c_pwd) " " \
                 (set_color $c_git) (fish_vcs_prompt) (set_color normal) \
                 \n (set_color $c_usr) "  ╰─╼ " (set_color normal)
end

# إخفاء رسالة ترحيب Fish
set -g fish_greeting

# --- 4. الاختصارات ---
alias ff='fastfetch'
alias ls='ls --color=auto'
alias wal-random='wal -i ~/Pictures/Wallpapers/ -q && source ~/.config/fish/config.fish'
alias wal-set='wal -i $argv; cp ~/.cache/wal/colors-kitty.conf ~/.cache/wal/colors-hyprland.conf; hyprctl reload'
# أضف هذا في ~/.config/fish/config.fish
alias wal-set='wal -i $argv; echo "\$color4 = rgb("(cat ~/.cache/wal/colors | sed -n "5p" | cut -c 2-)")" > ~/.cache/wal/colors-hypr.conf; echo "\$color2 = rgb("(cat ~/.cache/wal/colors | sed -n "3p" | cut -c 2-)")" >> ~/.cache/wal/colors-hypr.conf; hyprctl reload'
# تحسين ألوان الاقتراحات
set -g fish_color_autosuggestion 555
