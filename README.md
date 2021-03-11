# ansihelp
Bash script help file for using ansi codes (primarily colors)

## Installation

`chmod +x ansihelp.sh`
`mv ansihelp.sh /usr/sbin/ansihelp`

(Or move wherever you like)

## Usage

`ansihelp` or `ansihelp -h`

```
ansihelp [-hadc123456]
This script is a reference for common (and less common) ANSI codes.

options:
        -h      show this help text
        -a      how to use ansi codes
        -d      text decorations (bold, underline, etc)
        -c      cursor position
        -1      colors: dark text on dark backgrounds
        -2      colors: light text on dark backgrounds
        -3      colors: dark text on light backgrounds
        -4      colors: light text on light backgrounds
        -5      colors: 8-bit (256) colors
        -6      colors: 24-bit (RGB) colors
```

`ansihelp -a`

```
┌──────────────────────────────────────────────────────────────────────────────┐
│ ANSI Codes are a sequence of an escape character, usually a left open        │
│   bracket, and a specific code. For codes with options, the options are      │
│   generally separated by semicolons.                                         │
│   <escape>[<code>   <escape>[<option>;<option>;<code>                        │
│                                                                              │
│ An escape sequence can be typed as an octal or hexidecimal                   │
│   or entered by typing Ctrl+V then Esc. Hexidecimal is rarely used.          │
│   \033  \x1b  ^[                                                             │
│                                                                              │
│ A common usage is to change text color:                                      │
│   \033[32mgreen\033[0m  ^[[32mgreen^[[0m  =>  green                          │
│                                                                              │
│ Not all ANSI codes will function on every terminal, and so they should       │
│   be used with care. For compatibility, more common ASCII escape             │
│   sequences and tput commands should be used when possible. This             │
│   script can be used to test compatibility of color and text                 │
│   decoration codes.                                                          │
└──────────────────────────────────────────────────────────────────────────────┘
```

`ansihelp -c`

```
┌────────────────────────────────────────────────────────────┐
│ Position the cursor:                                       │
│   ^[[<L>;<C>H or ^[[<L>;<C>f                               │
│   puts the cursor at line L and column C                   │
│                                                            │
│ Move cursor up N lines:     ^[[<N>A                        │
│ Move cursor down N lines:   ^[[<N>B                        │
│ Move cursor left N lines:   ^[[<N>C                        │
│ Move cursor right N lines:  ^[[<N>D                        │
│                                                            │
│ Clear the screen, move to (0,0):  ^[[H                     │
│ Erase to end of line:             ^[[K                     │
│ Save cursor position:             ^[[s                     │
│ Restore cursor position:          ^[[u                     │
│                                                            │
│ Enable scrolling for entire display:         ^[[r          │
│ Enable scrolling from row start to row end:  ^[[<S>;<E>r   │
│ Scroll down one line:                        ^[[D          │
│ Scroll up one line:                          ^[[M          │
│                                                            │
│ Linefeed:         \n  ^[[J                                 │
│   new line                                                 │
│ Carriage Return:  \r  ^[[M                                 │
│   moves the cursor to the beginning of the line            │
│ Backspace         \b  ^[[H                                 │
│   moves the cursor back one space                          │
│ Tab               \t  ^[[I                                 │
│   horizontal tab                                           │
└────────────────────────────────────────────────────────────┘
```

