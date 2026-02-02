#!/bin/bash

# المسارات
SCREENSHOTS_DIR="$HOME/Pictures/Screenshots"
VIDEOS_DIR="$HOME/Videos/Recordings"

# إنشاء المجلدات
mkdir -p "$SCREENSHOTS_DIR"
mkdir -p "$VIDEOS_DIR"

# الوقت
timestamp=$(date +%Y-%m-%d_%H-%M-%S)

case $1 in
    --shot)
        filename="$SCREENSHOTS_DIR/Shot_$timestamp.png"
        # استخدام slurp لتحديد المنطقة و grim للالتقاط
        geometry=$(slurp)
        if [ -z "$geometry" ]; then exit 1; fi
        
        grim -g "$geometry" "$filename"
        # إشعار مع معاينة الصورة
        notify-send "📸 تم التقاط الصورة" "حُفظت في Pictures/Screenshots" -i "$filename"
        # نسخ الصورة للحافظة أيضاً (اختياري)
        cat "$filename" | wl-copy
        ;;

    --video)
        filename="$VIDEOS_DIR/Rec_$timestamp.mp4"
        geometry=$(slurp)
        if [ -z "$geometry" ]; then exit 1; fi
        
        notify-send "󰑋 بدأ التسجيل" "اضغط Super+Shift+R للإيقاف" -t 2000
        # تسجيل الفيديو
        gpu-screen-recorder -w "$geometry" -f 60 -a "default_output" -o "$filename" &
        echo $! > /tmp/recording_pid
        ;;

    --stop)
        if [ -f /tmp/recording_pid ]; then
            kill -SIGINT $(cat /tmp/recording_pid)
            rm /tmp/recording_pid
            notify-send "󰕧 تم حفظ الفيديو" "الموقع: Videos/Recordings" -i video-x-generic
        fi
        ;;
esac
