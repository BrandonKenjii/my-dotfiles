#!/bin/bash
# Print TUI — pick a source (file/clipboard/path), printer, and options; send to CUPS via lp

err() {
    dialog --msgbox "$1" 0 0
    exit 0
}

# ---------- 1. What to print ----------
src_choice=$(printf '%s\n' \
    "📄  Pick a file" \
    "📋  Print clipboard" \
    "✍️   Enter a path" |
    fzf --prompt "Print what? " --height 5 --layout=reverse --header "Esc to cancel") || exit 0

file=""
case "$src_choice" in
    *Pick*)
        file=$(fd -H -t f \
                -e pdf -e ps -e txt -e md -e odt -e docx -e rtf -e png -e jpg -e jpeg \
                --max-depth 4 . ~ 2>/dev/null |
            xargs -r ls -t 2>/dev/null | head -500 |
            fzf --prompt "File to print: " --layout=reverse --height 60%) || exit 0
        ;;
    *clipboard*)
        if wl-paste -l 2>/dev/null | grep -q image; then
            wl-paste --type image/png > /tmp/clipboard-print.png 2>/dev/null
            file=/tmp/clipboard-print.png
        elif [ -n "$(wl-paste -n 2>/dev/null)" ]; then
            wl-paste -n > /tmp/clipboard-print.txt 2>/dev/null
            file=/tmp/clipboard-print.txt
        else
            err "Clipboard is empty."
        fi
        ;;
    *path*)
        path=$(dialog --stdout --inputbox "Path to file:" 0 0) || exit 0
        [ -f "$path" ] || err "Not a file: $path"
        file="$path"
        ;;
esac
[ -f "$file" ] || err "No file selected."

# ---------- 2. Printer ----------
printers=$(lpstat -e 2>/dev/null | tr ' ' '\n' | sed '/^$/d')
[ -n "$printers" ] || err "No printers found. Is CUPS running?"
default=$(lpstat -d 2>/dev/null | sed 's/.*: //')
printer=$(printf '%s\n' "$printers" |
    awk -v d="$default" '{printf "%s%s\n", $0, ($0==d ? "  ★ (default)" : "")}' |
    fzf --prompt "Printer: " --height 10 --layout=reverse --header "Esc to cancel") || exit 0
printer=${printer%  ★ (default)}

# ---------- 3. Options ----------
copies=$(printf '%s\n' 1 2 3 4 5 6 7 8 9 10 |
    fzf --prompt "Copies: " --height 10 --layout=reverse) || exit 0
duplex=$(printf '%s\n' "Off" "Long edge" "Short edge" |
    fzf --prompt "Duplex: " --height 5 --layout=reverse) || exit 0
pages=$(dialog --stdout --inputbox "Page range (empty = all):" 0 0)

sides="one-sided"
case "$duplex" in
    "Long edge")  sides="two-sided-long-edge" ;;
    "Short edge") sides="two-sided-short-edge" ;;
esac

# ---------- 4. Confirm & print ----------
short_name=$(basename "$file")
dialog --yesno "Print $copies × $short_name\non $printer?" 0 0 || exit 0

lp_opts=(-d "$printer" -n "$copies" -o "sides=$sides")
[ -n "$pages" ] && lp_opts+=(-o "page-ranges=$pages")

output=$(lp "${lp_opts[@]}" "$file" 2>&1)
if [ $? -eq 0 ]; then
    dialog --msgbox "✓ Job sent:\n$output" 0 0
else
    dialog --msgbox "✗ Print failed:\n$output" 0 0
fi
