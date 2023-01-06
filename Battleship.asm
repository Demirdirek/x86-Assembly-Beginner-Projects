; Initialize the game board to all zeros

	
; This code will allow the player to enter a row and column to make a guess, check if it is a hit or miss, and check if the player has won the game. 
; The game board is represented as an array, with the value 1 representing a ship, 2 representing a miss, and 3 representing a hit. 
; The game will continue until the player has successfully hit all of the ships on the board.
; ' ', '#', 'M', and 'H' to represent an empty space, a ship, a miss, and a hit, respectively.


mov cx, 9    ; cx will be used as the column counter
mov dx, 9    ; dx will be used as the row counter
mov [gameboard], 0   ; set all elements of the gameboard array to zero

outerloop:
    mov ax, 0
    innerloop:
        mov [gameboard + eax], 0
        add eax, 2
    loop innerloop

    add gameboard, 18
loop outerloop

; Display the game board
mov cx, 9    ; cx will be used as the column counter
mov dx, 9    ; dx will be used as the row counter

outerloop:
    mov ax, 0
    innerloop:
        mov bx, [gameboard + eax]
        cmp bx, 0
        je .print_0
        cmp bx, 1
        je .print_1
        cmp bx, 2
        je .print_2
        cmp bx, 3
        je .print_3
        cmp bx, 4
        je .print_4
        cmp bx, 5
        je .print_5
        cmp bx, 6
        je .print_6
        cmp bx, 7
        je .print_7
        cmp bx, 8
        je .print_8
        cmp bx, 9
        je .print_9
        jmp .done
    .print_0:
        mov ah, 0x0e
        mov al, '0'
        int 0x10
        jmp .done
    .print_1:
        mov ah, 0x0e
        mov al, '1'
        int 0x10
        jmp .done
    .print_2:
        mov ah, 0x0e
        mov al, '2'
        int 0x10
        jmp .done
    .print_3:
        mov ah, 0x0e
        mov al, '3'
        int 0x10
        jmp .done
    .print_4:
        mov ah, 0x0e
        mov al, '4'
        int 0x10
        jmp .done
    .print_5:
        mov ah, 0x0e
        mov al, '5'
        int 0x10
        jmp .done
    .print_6:
        mov ah, 0x0e
        mov al, '6'
        int 0x10
        jmp .done
    .print_7:
        mov ah, 0x0e
        mov al, '7'
        int 0x10
        jmp .done
    .print_8:
        mov ah, 0x0e
        mov al, '8'
        int 0x10
        jmp .done
    .print_9:
        mov ah, 0x0e
        mov al, '9'
        int 0x10
    .done:
        add eax, 2
    loop innerloop

    add gameboard, 18
loop outerloop

; Get the player's guess for a row and column
mov ah, 0
mov dx, 0

get_row:
    mov ah, 0x0e
    mov al, 'Enter row: '
    int 0x10
    mov ah, 0
    int 0x16
    cmp al, '1'
    je .row_1
    cmp al, '2'
    je .row_2
    cmp al, '3'
    je .row_3
    cmp al, '4'
    je .row_4
    cmp al, '5'
    je .row_5
    cmp al, '6'
    je .row_6
    cmp al, '7'
    je .row_7
    cmp al, '8'
    je .row_8
    cmp al, '9'
    je .row_9
    jmp get_row
.row_1:
    mov dx, 0
    jmp .done
.row_2:
    mov dx, 1
    jmp .done
.row_3:
    mov dx, 2
    jmp .done
.row_4:
    mov dx, 3
    jmp .done
.row_5:
    mov dx, 4
    jmp .done
.row_6:
    mov dx, 5
    jmp .done
.row_7:
    mov dx, 6
    jmp .done
.row_8:
    mov dx, 7
    jmp .done
.row_9:
    mov dx, 8
.done:

get_col:
    mov ah, 0x0e
    mov al, 'Enter column: '
    int 0x10
    mov ah, 0
    int 0x16
    cmp al, '1'
    je .col_1
    cmp al, '2'
    je .col_2
    cmp al, '3'
    je .col_3
    cmp al, '4'
    je .col_4
    cmp al, '5'
    je .col_5
    cmp al, '6'
    je .col_6
    cmp al, '7'
    je .col_7
    cmp al, '8'
    je .col_8
    cmp al, '9'
    je .col_9
    jmp get_col
.col_1:
    mov cx, 0
    jmp .done
.col_2:
    mov cx, 1
    jmp .done
.col_3:
    mov cx, 2
    jmp .done
.col_4:
    mov cx, 3
    jmp .done
.col_5:
    mov cx, 4
    jmp .done
.col_6:
    mov cx, 5
    jmp .done
.col_7:
    mov cx, 6
    jmp .done
.col_8:
    mov cx, 7
    jmp .done
.col_9:
    mov cx, 8
.done:

; Check if the player's guess is a hit or miss
mov bx, [gameboard + dx*18 + cx*2]
cmp bx, 1
je .hit
mov [gameboard + dx*18 + cx*2], 2
mov ah, 0x0e
mov al, 'M'
int 0x10
jmp .done
.hit:
    mov [gameboard + dx*18 + cx*2], 3
    mov ah, 0x0e
    mov al, 'H'
    int 0x10
.done:

; Check if the player has won
mov cx, 9
mov dx, 9

outerloop:
    mov ax, 0
    innerloop:
        mov bx, [gameboard + eax]
        cmp bx, 1
        jne .not_found
        jmp .game_over
    .not_found:
        add eax, 2
    loop innerloop

    add gameboard, 18
loop outerloop

; Continue the game
jmp get_row

; Player has won
.game_over:
    mov ah, 0x0e
    mov al, 'You win!'
    int 0x10
