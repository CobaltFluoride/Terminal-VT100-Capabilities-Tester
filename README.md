# Terminal-VT100-Capabilities-Tester
Testing various vt100 special functions.

Building:
nasm -f elf64 tui.s -o tui.o
ld tui.o -o tui

Running:
./tui
