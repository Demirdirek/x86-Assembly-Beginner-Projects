; ATM machine simulation program in x86 assembly language

; This program displays a welcome message, prompts the user to enter their PIN, reads the 
; entered PIN, and checks if it is correct. If the entered PIN is correct, it displays a success 
; message. If the entered PIN is incorrect, 
; it displays an error message and goes back to the start of the program.

section .data

prompt1 db "Welcome to the ATM machine", 10, 0
len1 equ $-prompt1

prompt2 db "Please enter your PIN: ", 0
len2 equ $-prompt2

incorrect db "Incorrect PIN. Please try again.", 10, 0
len3 equ $-incorrect

success db "Transaction successful.", 10, 0
len4 equ $-success

section .bss

pin resb 4

section .text

global _start

_start:
	; display the welcome message
	mov eax, 4		; system call number for write
	mov ebx, 1		; file descriptor: standard output
	mov ecx, prompt1	; address of the message to write
	mov edx, len1		; number of bytes to write
	int 0x80		; invoke the kernel

	; read the PIN from the user
	mov eax, 4		; system call number for write
	mov ebx, 1		; file descriptor: standard output
	mov ecx, prompt2	; address of the message to write
	mov edx, len2		; number of bytes to write
	int 0x80		; invoke the kernel

	mov eax, 3		; system call number for read
	mov ebx, 0		; file descriptor: standard input
	mov ecx, pin		; address of the buffer to read into
	mov edx, 4		; number of bytes to read
	int 0x80		; invoke the kernel

	; check if the entered PIN is correct
	mov eax, pin
	cmp eax, 1234		; correct PIN is 1234
	jne error		; jump to the error message if incorrect

	; display the success message
	mov eax, 4		; system call number for write
	mov ebx, 1		; file descriptor: standard output
	mov ecx, success	; address of the message to write
	mov edx, len4		; number of bytes to write
	int 0x80		; invoke the kernel

error:
	; display the error message
	mov eax, 4		; system call number for write
	mov ebx, 1		; file descriptor: standard output
	mov ecx, incorrect	; address of the message to write
	mov edx, len3		; number of bytes to write
	int 0x80		; invoke the kernel
	
	jmp _start		; jump back to the start of the program
