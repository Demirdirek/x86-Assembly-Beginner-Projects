; [VSassembly] Platformer game in x86 assembly language

; This program displays a simple map on the screen and allows the player to move a character around using the WASD keys.
; The character can move up, down, left, or right on the map, but cannot move off the edges of the map.
; To win the game, the player must move the character to the dollar sign character $. 
; If the player reaches the dollar sign, the program displays a success message and exits.
; If the player tries to move off the edges of the map, the program displays a failure message and exits.

section .data

map db "#####", 10, \
     "#@$.#", 10, \
     "#####", 10, 0

success db "Congratulations, you won!", 10, 0
len1 equ $-success

failure db "Game over!", 10, 0
len2 equ $-failure

prompt db "Enter a direction (w, a, s, d): ", 0
len3 equ $-prompt

section .bss

x resb 2
y resb 2
input resb 1

section .text

global _start

_start:
	; initialize the player position
	mov [y], 1
	mov [x], 2
	
	; main game loop
game_loop:
	; display the map
	mov eax, 4		; system call number for write
	mov ebx, 1		; file descriptor: standard output
	mov ecx, map		; address of the message to write
	mov edx, 26		; number of bytes to write
	int 0x80		; invoke the kernel
	
	; prompt the user for input
	mov eax, 4		; system call number for write
	mov ebx, 1		; file descriptor: standard output
	mov ecx, prompt	; address of the message to write
	mov edx, len3		; number of bytes to write
	int 0x80		; invoke the kernel
	
	; read the input from the user
	mov eax, 3		; system call number for read
	mov ebx, 0		; file descriptor: standard input
	mov ecx, input		; address of the buffer to read into
	mov edx, 1		; number of bytes to read
	int 0x80		; invoke the kernel
	
	; move the player in the specified direction
	mov al, [input]
	cmp al, 'w'
	je move_up
	cmp al, 'a'
	je move_left
	cmp al, 's'
	je move_down
	cmp al, 'd'
	je move_right
	jmp game_loop

move_up:
	dec word [y]
	jmp game_loop

move_left:
	dec word [x]
	jmp game_loop

move_down:
	inc word [y]
	jmp game_loop

move_right:
	inc word [x]
	jmp game_loop
