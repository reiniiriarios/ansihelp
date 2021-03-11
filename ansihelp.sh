#!/bin/bash
#author		:Emma Litwa-Vulcu
#version	:1.2
#date		:20190429
#updated	:20210310
#notes		:light backgrounds not always supported

usage="$(basename "$0") [-hadc123456]
This script is a reference for common (and less common) ANSI codes.

options:
	-h	show this help text
	-a	how to use ansi codes
	-d	text decorations (bold, underline, etc)
	-c	cursor position
	-1	colors: dark text on dark backgrounds
	-2	colors: light text on dark backgrounds
	-3	colors: dark text on light backgrounds
	-4	colors: light text on light backgrounds
	-5	colors: 8-bit (256) colors
	-6	colors: 24-bit (RGB) colors
	
Author: Emma Litwa-Vulcu
Version: 1.2"

boxtop() {
	printf "\\u250c"
	line $1
	printf "\\u2510\n"
}
boxbottom() {
	printf "\\u2514"
	line $1
	printf "\\u2518\n"
}
line() {
	c=0
	while [[ $c -lt $1 ]]
	do
		printf "\\u2500"
		let ++c
	done
}
boxline() {
	width=$1
	str="${@:2}"

	strlen=${#str}
	padding=$((width - strlen))
	if [[ $padding -lt 0 ]]; then
		padding=0
	fi
	spaces="$(printf '%*s' $padding)"

	printf "\\u2502$str$spaces\\u2502\n"
}

text_color=(30 31 32 33 34 35 36 37)
text_bg=(41 42 43 44 45 46 47)
text_color_bright=(90 91 92 93 94 95 96 97)
text_bg_bright=(100 101 102 103 104 105 106 107)

colors_1() {
	printf " \033[35mDark Colors on Dark Backgrounds\033[0m\n"
	boxtop 56
	boxline 83 "   \033[36mUsage:\033[0m \033[34m^[\033[0m[\033[33m<color>\033[0mm "
	boxline 56
	for i in "${text_color[@]}"; do
		printf "\\u2502"
		printf "\033[%sm %4s \033[0m" $i $i
		for n in "${text_bg[@]}"
		do
			printf "\033[%s;%sm %2s;%s \033[0m" $n $i $n $i
		done
		printf " \\u2502\n"
	done
	
	printf "\\u2502%56s\\u2502\n"
	
	printf "\\u2502 \033[90m  30 "
	for i in {1..7}; do
		printf " 3%s;4%s " $i $i
	done
	printf "\033[0m \\u2502\n"
	printf "\u2502  \033[90m   \033[0m "
	for i in {1..7}; do
		printf "\033[3%s;4%sm 3%s;4%s \033[0m" $i $i $i $i
	done
	printf " \\u2502\n"
	boxbottom 56
}

colors_2() {
	printf " \033[35mLight Colors on Dark Backgrounds\033[0m\n"
	
	boxtop 56
	boxline 83 "   \033[36mUsage:\033[0m \033[34m^[\033[0m[\033[33m<color>\033[0mm "
	boxline 56
	for i in "${text_color_bright[@]}"; do
		printf "\\u2502"
		printf "\033[%sm %4s \033[0m" $i $i
		for n in "${text_bg[@]}"; do
			printf "\033[%s;%sm %s;%s \033[0m" $i $n $i $n
		done
		printf " \\u2502\n"
	done
	boxbottom 56
}

colors_3() {
	printf " \033[35mDark Colors on Light Backgrounds\033[0m\n"
	
	boxtop 66
	boxline 93 "   \033[36mUsage:\033[0m \033[34m^[\033[0m[\033[33m<color>\033[0mm "
	boxline 66
	for i in "${text_color[@]}"; do
		printf "\\u2502 "
		for n in "${text_bg_bright[@]}"; do
			printf "\033[%s;%sm %s;%s \033[0m" $i $n $i $n
		done
		printf " \\u2502\n"
	done
	boxbottom 66
}

colors_4() {
	printf " \033[35mLight Colors on Light Backgrounds\033[0m\n"
	
	boxtop 66
	boxline 93 "   \033[36mUsage:\033[0m \033[34m^[\033[0m[\033[33m<color>\033[0mm "
	boxline 66
	for i in "${text_color_bright[@]}"; do
		printf "\\u2502 "
		for n in "${text_bg_bright[@]}"; do
			printf "\033[%s;%sm %s;%s \033[0m" $i $n $i $n
		done
		printf " \\u2502\n"
	done
	
	printf "\\u2502%66s\\u2502\n"
	
	printf "\\u2502 \033[90m"
	for i in {0..7}; do
		printf " 9%s;10%s " $i $i 
	done
	printf "\033[0m \\u2502\n"
	printf "\\u2502 "
	for i in {0..7}; do
		printf "\033[9%s;10%sm 9%s;10%s \033[0m" $i $i $i $i
	done
	printf " \\u2502\n"
	boxbottom 66
}

eightbit1=({16..33} {52..69} {88..105} {124..141} {160..177} {196..213})
eightbit2=({34..51} {70..87} {106..123} {142..159} {178..195} {214..231})
eightbit3=({232..243})
eightbit4=({244..255})

colors_5() {
	printf " \033[35m8-bit (256) Colors\033[0m\n"

	boxtop 92
	ground=([38]="Foreground" [48]="Background")
	for g in "${!ground[@]}"; do
		printf "\\u2502  \033[38;5;38m${ground[$g]}:\033[0m \033[34m^[\033[0m[$g;5;\033[33m<N>\033[0mm where \033[33mN\033[0m is a color below %39s \\u2502\n"
		printf "\\u2502 %90s \\u2502"
		printf "\n\\u2502 "
		printf "     \033[$g;5;0m   0 \033[0m"
		for i in {1..15}; do
			printf "\033[30;$g;5;%sm %3s \033[0m" $i $i
		done
		printf "      \\u2502"
		for i in "${eightbit1[@]}"; do
			row=$((i - 16))
			if ! ((row % 18)); then
				printf "\n\\u2502 "
			fi
			printf "\033[$g;5;%sm %3s \033[0m" $i $i
			row=$((row + 1))
			if ! ((row % 18)); then
				printf " \\u2502"
			fi
		done
		for i in "${eightbit2[@]}"; do
			row=$((i - 16))
			if ! ((row % 18)); then
				printf "\n\\u2502 "
			fi
			printf "\033[30;$g;5;%sm %3s \033[0m" $i $i
			row=$((row + 1))
			if ! ((row % 18)); then
				printf " \\u2502"
			fi
		done
		printf "\n\\u2502 %15s"
		for i in "${eightbit3[@]}"; do
			printf "\033[$g;5;%sm %s \033[0m" $i $i
		done
		printf "%15s \\u2502\n\\u2502 %15s"
		for i in "${eightbit4[@]}"; do
			printf "\033[30;$g;5;%sm %s \033[0m" $i $i
		done
		printf "%15s \\u2502\n"

		printf "\\u2502 %90s \\u2502\n"
	done
	printf "\\u2502  \033[38;5;38mCombine:\033[0m Foreground and background may be combined as so:  38;5;\033[33m<FG>\033[0m;48;5;\033[33m<BG>\033[0m %10s \\u2502\n"
	printf "\\u2502 %9s where \033[33mFG\033[0m and \033[33mBG\033[0m are color codes above. %10s e.g. \033[38;5;117;48;5;23m 38;5;117;48;5;23 \033[0m %6s \\u2502\n"

	boxbottom 92
}

colors_6() {
	printf " \033[35m24-bit (RGB) Colors\033[0m\n"

	boxtop 50
	printf "\\u2502  The full RGB spectrum is available using: %5s \\u2502\n"
	printf "\\u2502    \033[38;2;66;206;244mForeground:\033[0m  \033[34m^[\033[0m[38;2;\033[33m<R>\033[0m;\033[33m<G>\033[0m;\033[33m<B>\033[0mm %11s \\u2502\n"
	printf "\\u2502    \033[38;2;66;206;244mBackground:\033[0m  \033[34m^[\033[0m[48;2;\033[33m<R>\033[0m;\033[33m<G>\033[0m;\033[33m<B>\033[0mm %11s \\u2502\n"
	printf "\\u2502    where \033[33mR\033[0m, \033[33mG\033[0m, and \033[33mB\033[0m are decimal values (0-255)  \\u2502\n"
	printf "\\u2502    e.g.  \033[38;2;191;75;209m 32;2;75;209 \033[0m \033[48;2;3;51;96m 48;2;3;51;96 \033[0m %10s \\u2502\n"
	printf "\\u2502  The two may be combined as so: %16s \\u2502\n"
	printf "\\u2502    \033[34m^[\033[0m[38;2;\033[33m<R>\033[0m;\033[33m<G>\033[0m;\033[33m<B>\033[0m;48;2;\033[33m<R>\033[0m;\033[33m<G>\033[0m;\033[33m<B>\033[0mm %7s \\u2502\n"
	printf "\\u2502    e.g.  \033[38;2;191;75;209;48;2;3;51;96m 32;2;75;209;48;2;3;51;96 \033[0m %12s \\u2502\n"
	boxbottom 50
}

text_deco() {
	printf " \033[35mText Decorations\033[0m\n"

	deco=([1]="bold/bright" [2]="dim" [3]="italic" [4]="underline" [5]="slow blink" [6]="rapid blink" [7]="swap fg and bg colors" [8]="hidden" [9]="strikethrough")

	boxtop 48
	boxline 75 " \033[36mUsage:\033[0m \033[34m^[\033[0m[\033[33m<N>\033[0mm"
	boxline 48
	for i in "${!deco[@]}"; do
		boxline 56 " \033[${i}m${i} : ${deco[$i]}\033[0m"
	done
	boxline 48
	boxline 48 " Decorations may be combined with color codes:"
	boxline 68 "   \033[34m^[\033[0m[4;31m  =>  \033[4;31mred underline\033[0m"
	boxbottom 48
}

cursor_position() {
	printf " \033[35mCursor Position Codes\033[0m\n"
	boxtop 60
	boxline 60 " Position the cursor:"
	boxline 114 "   \033[34m^[\033[0m[\033[33m<L>\033[0m;\033[33m<C>\033[0mH or \033[34m^[\033[0m[\033[33m<L>\033[0m;\033[33m<C>\033[0mf"
	boxline 78 "   puts the cursor at line \033[33mL\033[0m and column \033[33mC\033[0m"
	boxline 60
	boxline 87 " Move cursor up \033[33mN\033[0m lines:     \033[34m^[\033[0m[\033[33m<N>\033[0mA"
	boxline 87 " Move cursor down \033[33mN\033[0m lines:   \033[34m^[\033[0m[\033[33m<N>\033[0mB"
	boxline 87 " Move cursor left \033[33mN\033[0m lines:   \033[34m^[\033[0m[\033[33m<N>\033[0mC"
	boxline 87 " Move cursor right \033[33mN\033[0m lines:  \033[34m^[\033[0m[\033[33m<N>\033[0mD"
	boxline 60
	boxline 69 " Clear the screen, move to (0,0):  \033[34m^[\033[0m[H"
	boxline 69 " Erase to end of line:             \033[34m^[\033[0m[K"
	boxline 69 " Save cursor position:             \033[34m^[\033[0m[s"
	boxline 69 " Restore cursor position:          \033[34m^[\033[0m[u"
	boxline 60
	boxline 69 " Enable scrolling for entire display:         \033[34m^[\033[0m[r"
	boxline 105 " Enable scrolling from row \033[33mstart\033[0m to row \033[33mend\033[0m:  \033[34m^[\033[0m[\033[33m<S>\033[0m;\033[33m<E>\033[0mr "
	boxline 69 " Scroll down one line:                        \033[34m^[\033[0m[D"
	boxline 69 " Scroll up one line:                          \033[34m^[\033[0m[M"
	boxline 60
	boxline 79 " Linefeed:         \033[35m\\\n\033[0m  \033[34m^[\033[0m[J"
	boxline 60 "   new line"
	boxline 79 " Carriage Return:  \033[35m\\\r\033[0m  \033[34m^[\033[0m[M"
	boxline 60 "   moves the cursor to the beginning of the line"
	boxline 79 " Backspace         \033[35m\\\b\033[0m  \033[34m^[\033[0m[H"
	boxline 60 "   moves the cursor back one space"
	boxline 79 " Tab               \033[35m\\\t\033[0m  \033[34m^[\033[0m[I"
	boxline 60 "   horizontal tab"
	boxbottom 60
}

ansi_howto() {
	printf " \033[35mHow to use ANSI codes\033[0m\n"
	boxtop 78
	boxline 78 " ANSI Codes are a sequence of an escape character, usually a left open"
	boxline 78 "   bracket, and a specific code. For codes with options, the options are"
	boxline 78 "   generally separated by semicolons."
	boxline 132 "   \033[34m<escape>\033[0m[\033[33m<code>\033[0m   \033[34m<escape>\033[0m[\033[31m<option>\033[0m;\033[31m<option>\033[0m;\033[33m<code>\033[0m"
	boxline 78
	boxline 78 " An escape sequence can be typed as an octal or hexidecimal"
	boxline 78 "   or entered by typing Ctrl+V then Esc. Hexidecimal is rarely used."
	boxline 107 "   \033[35m\\\\033\033[0m  \033[35m\\\\x1b\033[0m  \033[34m^[\033[0m"
	boxline 78
	boxline 78 " A common usage is to change text color:"
	boxline 145 "   \033[35m\\\\033\033[33m[32m\033[0mgreen\033[35m\\\\033\033[33m[0m\033[0m  \033[34m^[\033[33m[32m\033[0mgreen\033[34m^[\033[33m[0m\033[0m  =>  \033[32mgreen\033[0m"
	boxline 78
	boxline 78 " Not all ANSI codes will function on every terminal, and so they should"
	boxline 78 "   be used with care. For compatibility, more common ASCII escape"
	boxline 78 "   sequences and tput commands should be used when possible. This"
	boxline 78 "   script can be used to test compatibility of color and text"
	boxline 78 "   decoration codes."
	boxbottom 78
}

while getopts 'hadc123456' option; do
        case "$option" in
                h)
                        echo "$usage"
                        exit ;;
                1)
                        colors_1
                        exit ;;
                2)
                        colors_2
                        exit ;;
                3)
                        colors_3
                        exit ;;
                4)
                        colors_4
                        exit ;;
		5)
			colors_5
			exit ;;
		6)
			colors_6
			exit ;;
		d)
			text_deco
			exit ;;
		c)
			cursor_position
			exit ;;
		a)
			ansi_howto
			exit ;;
                \?)
                        printf "illegal option -%s\n" "$OPTARG" >&2
                        exit 1 ;;
        esac
done
shift $((OPTIND - 1))

echo "$usage"
