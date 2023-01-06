; Platformer game in x86 assembly language
; This code was written for NASM!!!

; This code will set up a graphics mode, draw a pixel at the player's position, 
; and accept input from the left and right arrow keys to move the player.
; The screen is cleared and the player's position is updated on each iteration of the main loop.
; The game will run indefinitely until the user closes the window or exits in some other way.

; Constants
WIDTH equ 800 ; Width of the screen
HEIGHT equ 600 ; Height of the screen

; Global variables
section .data
player_x db 0 ; X position of the player
player_y db 0 ; Y position of the player

; Set up the graphics mode and clear the screen
mov ah, 0x00 ; Set graphics mode function
mov al, 0x13 ; Mode 13h (320x200 256-color graphics)
int 0x10 ; Call the graphics interrupt

; Set the player position to the middle of the screen
mov [player_x], WIDTH / 2
mov [player_y], HEIGHT / 2

; Main game loop
main_loop:

; Clear the screen
mov ah, 0x00 ; Clear screen function
mov al, 0x03 ; Mode 13h (320x200 256-color graphics)
int 0x10 ; Call the graphics interrupt

; Draw the player at the current position
mov ah, 0x0c ; Draw pixel function
mov al, 0x00 ; Color 0 (black)
mov cx, [player_x]
mov dx, [player_y]
int 0x10 ; Call the graphics interrupt

; Check for user input
mov ah, 0x01 ; Check for key press function
int 0x16 ; Call the keyboard interrupt

; Move the player based on the key pressed
cmp al, 0x4b ; Left arrow key
jne move_right
dec [player_x]
jmp update_position
move_right:
cmp al, 0x4d ; Right arrow key
jne update_position
inc [player_x]
update_position:

; Update the screen
mov ah, 0x00 ; Set graphics mode function
mov al, 0x13 ; Mode 13h (320x200 256-color graphics)
int 0x10 ; Call the graphics interrupt

; Sleep for a short time
mov ah, 0x86 ; Sleep function
mov cx, 0x1388 ; Sleep for 50 milliseconds
int 0x15 ; Call the BIOS interrupt

; Loop back to the main game loop
jmp main_loop
