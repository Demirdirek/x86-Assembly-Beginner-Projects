; B2D converter in x86 assembly

; NASM syntax
; This code will prompt the user to enter a binary number and then convert it to decimal form.
; The input is expected to be a null-terminated string of '0' and '1' characters.

section .data

input db "Enter a binary number: ", 0  ; Prompt for input

section .text

global _start

_start:
    mov eax, 4  ; Set up the write syscall
    mov ebx, 1  ; File descriptor (stdout)
    mov ecx, input  ; String to print
    mov edx, 19    ; Length of the string
    int 0x80       ; Call the write syscall

    xor edx, edx   ; Clear the accumulator
    mov ecx, 0     ; ECX is the loop counter

convert_loop:
    mov eax, 3  ; Set up the read syscall
    mov ebx, 0  ; File descriptor (stdin)
    mov edi, 1  ; Read one character at a time
    mov esi, ecx  ; Offset into the input buffer
    dec ecx       ; Decrement the loop counter
    int 0x80      ; Call the read syscall

    cmp al, 48   ; Check if the character is '0'
    je skip       ; If so, skip the conversion
    cmp al, 49   ; Check if the character is '1'
    jne exit      ; If not, exit with an error

    mov eax, 1   ; Set the value to be added to the accumulator
    mov ebx, 1   ; EBX is the current power of two

shift_loop:
    cmp ecx, 0   ; Check if we have reached the end of the input
    je print_result  ; If so, jump to the print result block
    dec ecx       ; Decrement the loop counter
    shl ebx, 1   ; Multiply the current power of two by 2
    jmp shift_loop  ; Continue shifting until we reach the end of the input

skip:
    cmp ecx, 0   ; Check if we have reached the end of the input
    je print_result  ; If so, jump to the print result block
    dec ecx       ; Decrement the loop counter
    jmp convert_loop  ; Continue converting until we reach the end of the input

print_result:
    mov eax, 4  ; Set up the write syscall
    mov ebx, 1  ; File descriptor (stdout)
    mov ecx, edx  ; Value to print
    mov edx, 1    ; Print one character at a time
    int 0x80      ; Call the write syscall

exit:
    mov eax, 1    ; Set up the exit syscall
    xor ebx, ebx  ; Clear the exit code
    int 0x80      ; Call the exit syscall
