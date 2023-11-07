#!/usr/bin/bash
dir1=$1
dir2=$2
if [ "$#" -eq 2 ]; then
	echo "[+] new directories:"
        diff -q $dir1 $dir2 | grep -v "\.txt$\|.js$\|.jsx$\|.ts$\|.tsx$\|.css$" | grep "Only in" | grep "$dir1" | awk '{print $4}' | GREP_COLOR="1;34" grep --color .
	echo "[+] new files:"
	diff -r -q $dir1 $dir2 | grep -v "\.txt" | grep "\.js" | grep "Only in" | grep "$dir1" | sed 's/: //' | awk '{print $3}' | GREP_COLOR="1;32" grep --color .
	echo "[+] changed files:"
	diff -r -q $dir1 $dir2 | grep -v "\.txt" | grep "\.js" | grep 'Files .*$' | awk '{print $2}' | GREP_COLOR="1;33" grep --color .
	echo "[+] deleted files:"
	diff -r -q $dir1 $dir2 | grep -v "\.txt" | grep "\.js" | grep "Only in" | grep "$dir2" | sed 's/: //' | awk '{print $3}' | GREP_COLOR="1;31" grep --color .
	echo "[+] missing directories:"
        diff -q $dir1 $dir2 | grep -v "\.txt$\|.js$\|.jsx$\|.ts$\|.tsx$\|.css$" | grep "Only in" | grep "$dir2" | awk '{print $4}' | GREP_COLOR="1;31" grep --color .
else
        printf "no arguments supplied.\r\nusage: walle_dir_diff <dir 1> <dir 2>\r\n"
fi
