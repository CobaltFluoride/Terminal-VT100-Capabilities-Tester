section .data
	newline db 0x0a
	beginmsg db "VT100 Terminal Capabilities Test - In x64 Assembly", 0x0A, "Blinking text support is limited, it may not work in your terminal!", 0x0A, 0x0A
	beginmsglen equ $-beginmsg
	blinkingdesc db "Blinking text: "
	blinkingdesclen equ $-blinkingdesc
	reversebgdesc db "Reverse background: "
	reversebgdesclen equ $-reversebgdesc
	bolddesc db "Bold text: "
	bolddesclen equ $-bolddesc
	boldmsg db "Bold text example", 0x0A
	boldmsglen equ $-boldmsg
	blinkterm db 0x1B, "[5m"			;Blinking term CODE
	blinktermlen equ $-blinkterm
	blinkmsg db "Blinking text example", 0x0A
	blinkmsglen equ $-blinkmsg
	reversebgmsg db "Reverse background example", 0x0A
	reversebgmsglen equ $-reversebgmsg
	resetterm db 0x1B, "[0m"			;Reset term attribs CODE
	resettermlen equ $-resetterm
	boldterm db 0x1B, "[1m"				;Bold term CODE
	boldtermlen equ $-boldterm
	reversebgterm db 0x1B, "[7m"			;Reverse term CODE
	reversebgtermlen equ $-reversebgterm
	reset db 0x1B, "c"				;Reset term CODE
	resetlen equ $-reset

	;Typing Demo:
	typingdemomsg db "Try typing a message to display in: "
	typingdemomsglen equ $-typingdemomsg

	typingbolddesc db "bold!", 0x0a
	typingbolddesclen equ $-typingbolddesc

	typingblinkingdesc db "blinking!", 0x0a
	typingblinkingdesclen equ $-typingblinkingdesc

	typingbgreversedesc db "reverse!", 0x0a
	typingbgreversedesclen equ $-typingbgreversedesc

section .bss
	input resb 100
section .text
	global _start
_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, beginmsg
	mov rdx, beginmsglen
	syscall			;Print intro message
	call BlinkDemo
	call ReverseDemo
	call BoldDemo
	call PrintNewLine
	call TypingBoldDemo
	call PrintNewLine
	call TypingReverseBGDemo
	call PrintNewLine
	call TypingBlinkingDemo
	mov rax, 60
	mov rdi, 1
	syscall

TypingBoldDemo:
	mov rax, 1
	mov rdi, 1
	mov rsi, typingdemomsg
	mov rdx, typingdemomsglen
	syscall
	mov rax, 1
	mov rdi, 1
	mov rsi, typingbolddesc
	mov rdx, typingbolddesclen
	syscall
	call GetInput
	call BoldMode
	call PrintInput
	call ResetTerm
	ret
TypingReverseBGDemo:
	mov rax, 1
	mov rdi, 1
	mov rsi, typingdemomsg
	mov rdx, typingdemomsglen
	syscall
	mov rax, 1
	mov rdi, 1
	mov rsi, typingbgreversedesc
	mov rdx, typingbgreversedesclen
	syscall
	call GetInput
	call ReverseBGMode
	call PrintInput
	call ResetTerm
	ret
TypingBlinkingDemo:
	mov rax, 1
	mov rdi, 1
	mov rsi, typingdemomsg
	mov rdx, typingdemomsglen
	syscall
	mov rax, 1
	mov rdi, 1
	mov rsi, typingblinkingdesc
	mov rdx, typingblinkingdesclen
	syscall
	call GetInput
	call BlinkMode
	call PrintInput
	call ResetTerm
	ret
GetInput:
	mov rax, 0
	mov rdi, 0
	lea rsi, [input]
	mov rdx, 100
	syscall
	ret
PrintInput:
	mov rax, 1
	mov rdi, 1
	lea rsi, [input]
	mov rdx, 100
	syscall
	ret
BlinkDemo:
	mov rax, 1
	mov rdi, 1
	mov rsi, blinkingdesc
	mov rdx, blinkingdesclen
	syscall
	call BlinkMode
	mov rax, 1
	mov rdi, 1
	mov rsi, blinkmsg
	mov rdx, blinkmsglen
	syscall
	call ResetTerm
	ret
BoldDemo:
	mov rax, 1
	mov rdi, 1
	mov rsi, bolddesc
	mov rdx, bolddesclen
	syscall
	call BoldMode
	mov rax, 1
	mov rdi, 1
	mov rsi, boldmsg
	mov rdx, boldmsglen
	syscall
	call ResetTerm
	ret
ReverseDemo:
	mov rax, 1
	mov rdi, 1
	mov rsi, reversebgdesc
	mov rdx, reversebgdesclen
	syscall
	call ReverseBGMode
	mov rax, 1
	mov rdi, 1
	mov rsi, reversebgmsg
	mov rdx, reversebgmsglen
	syscall
	call ResetTerm
	ret
BoldMode:
	mov rax, 1
	mov rdi, 1
	mov rsi, boldterm
	mov rdx, boldtermlen
	syscall
	ret
BlinkMode:
	mov rax, 1
	mov rdi, 1
	mov rsi, blinkterm
	mov rdx, blinktermlen
	syscall
	ret
ReverseBGMode:
	mov rax, 1
	mov rdi, 1
	mov rsi, reversebgterm
	mov rdx, reversebgtermlen
	syscall
	ret
ResetTerm:
	mov rax, 1
	mov rdi, 1
	mov rsi, resetterm
	mov rdx, resettermlen
	syscall
	ret
PrintNewLine:
	mov rax, 1
	mov rdi, 1
	mov rsi, newline
	mov rdx, 1
	syscall
	ret
