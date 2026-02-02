# --- 1. استيراد ألوان Pywal ---
if [ -f ~/.cache/wal/colors-tty.sh ]; then
    source ~/.cache/wal/colors-tty.sh
fi

# --- 2. الواجهة الترحيبية (Fastfetch Integration) ---
# التأكد من تشغيل fastfetch عند الفتح بشكل منسق
if command -v fastfetch > /dev/null 2>&1; then
    # تشغيل fastfetch مع توزيع الألوان المستخرجة من pywal
    fastfetch
    echo -e ""
else
    # واجهة احتياطية في حال عدم وجود fastfetch
    echo -e "\e[38;5;4m╔════════════════════════════════════════╗\e[0m"
    echo -e "   Welcome back, \e[38;5;2m${USER}\e[0m!"
    echo -e "\e[38;5;4m╚════════════════════════════════════════╝\e[0m"
fi

# عرض باليتة الألوان بشكل "كبسولات" GUI
#echo -n "   "
#for i in {0..7}; do echo -en "\e[48;5;${i}m   \e[0m "; done; echo ""
#echo -n "   "
#for i in {8..15}; do echo -en "\e[48;5;${i}m   \e[0m "; done; echo -e "\n"

# --- 3. تصميم الـ Prompt الاحترافي (GUI/Bar Style) ---
# وظيفة لإظهار فرع Git مع أيقونة
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/  \1/'
}

# إعدادات الألوان (تعتمد على متغيرات pywal)
C_Path="\[\e[38;5;4m\]"
C_User="\[\e[38;5;2m\]"
C_Git="\[\e[38;5;5m\]"
C_Reset="\[\e[0m\]"

# شكل السطر: أزرار علوية + سطر إدخال
export PS1="\n${C_User}󰊠 $USER ${C_Reset}at ${C_Path}󰉋 \w ${C_Git}\$(parse_git_branch)${C_Reset}\n${C_User}╰─╼${C_Reset} "

# --- 4. اختصارات ذكية (Aliases) ---
alias ff='fastfetch'
alias ls='ls --color=auto'
alias ll='ls -lah --group-directories-first'
alias grep='grep --color=auto'
alias ..='cd ..'
alias v='vim' # أو nvim

# اختصار لتغيير الثيم عشوائياً (إذا كان لديك مجلد صور)
alias wal-random='wal -i ~/Pictures/Wallpapers/ -q && source ~/.bashrc'

# --- 5. إعدادات السلوك الذكي ---
# إكمال تلقائي ذكي
bind "set completion-ignore-case on"
shopt -s autocd # الدخول للمجلد بكتابة اسمه فقط
shopt -s histappend # حفظ تاريخ الأوامر باستمرار

# --- 6. تأثير بصري عند إغلاق الطرفية ---
finish() {
    echo -e "\n\e[38;5;1m󰚥 Logging out...\e[0m"
}
trap finish EXIT

# Created by `pipx` on 2026-02-01 20:43:43
export PATH="$PATH:/home/mahde/.local/bin"
