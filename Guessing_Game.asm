; Number guessing game in x86 assembly language
; Player has to guess a number between 1 and 10

; This program displays a welcome message, prompts the user to enter a number between 1 and 10,
; reads the entered number, and checks if it is equal to 5 (the number the player has to guess).
; If the entered number is equal to 5, it displays a win message and goes back to the start of the program.
; If the entered number is not equal to 5, it displays a lose message and goes back to the start of the program.
; Note that this program does not generate a truly random number. Instead, it always compares the entered number to 5.
; In a real game, you would need to use a random number generator!


section .data

prompt1 db "Welcome to the number guessing game", 10, 0
len1 equ $-prompt1

prompt2 db "Enter a number between 1 and 10: ", 0
len2 equ $-prompt2

win db "You win!", 10, 0
len3 equ $-win

lose db "You lose!", 10, 0
len4 equ $-lose

section .bss

guess resb 2

section .text

global _start

_start:
	; display the welcome message
	mov eax, 4		; system call number for write
	mov ebx, 1		; file descriptor: standard output
	mov ecx, prompt1	; address of the message to write
	mov edx, len1		; number of bytes to write
	int 0x80		; invoke the kernel

	; generate a random number between 1 and 10
	mov eax, 4		; system call number for write
	mov ebx, 1		; file descriptor: standard output
	mov ecx, prompt2	; address of the message to write
	mov edx, len2		; number of bytes to write
	int 0x80		; invoke the kernel
	mov eax, 3		; system call number for read
	mov ebx, 0		; file descriptor: standard input
	mov ecx, guess		; address of the buffer to read into
	mov edx, 2		; number of bytes to read
	int 0x80		; invoke the kernel
	mov eax, guess
	cmp eax, 5
	jne lose
	
	; display the win message
	mov eax, 4		; system call number for write
	mov ebx, 1		; file descriptor: standard output
	mov ecx, win		; address of the message to write
	mov edx, len3		; number of bytes to write
	int 0x80		; invoke the kernel
	
	jmp _start
	
lose:
	; display the lose message
	mov eax, 4		; system call number for write
	mov ebx, 1		; file descriptor: standard output
	mov ecx, lose		; address of the message to write
	mov edx, len4		; number of bytes to write
	int 0x80		; invoke the kernel
	
	jmp _start
