; Grade Calculator in x86 assembly using the NASM syntax

; To change the number of grades or the grade scale, 
; simply modify the num_grades and grades data variables, 
; and update the check_grade loop accordingly.

; This code will prompt the user to enter four grades, 
; separated by newlines, and then calculate and print the average grade based on the following scale:
; 90 or above: A
; 80 or above: B
; 70 or above: C
; 60 or above: D
; Below 60: F

section .data

num_grades db 4  ; Number of grades to be entered
grades     db 0, 0, 0, 0  ; Array to store the grades

section .text

global _start

_start:
    mov ecx, num_grades  ; ECX is the loop counter

get_grades:
    mov eax, 3  ; Set up the read syscall
    mov ebx, 0  ; File descriptor (stdin)
    mov edx, 1  ; Read one character at a time
    mov esi, grades  ; Destination buffer
    mov edi, ecx  ; Offset into the buffer
    dec ecx       ; Decrement the loop counter
    int 0x80      ; Call the read syscall

    cmp al, 10   ; Check if the character is a newline
    jne get_grades  ; If not, continue getting grades

calculate_average:
    xor ebx, ebx  ; Clear the accumulator
    mov ecx, num_grades  ; ECX is the loop counter

add_grades:
    mov al, [grades + ecx - 1]  ; Load the current grade
    sub al, '0'   ; Convert from ASCII to integer
    add ebx, eax  ; Add the grade to the accumulator
    dec ecx       ; Decrement the loop counter
    jmp add_grades  ; Continue adding grades until ECX is zero

print_result:
    mov eax, 4  ; Set up the write syscall
    mov ebx, 1  ; File descriptor (stdout)
    mov edx, 1  ; Print one character at a time
    mov esi, 'A'  ; Set the base grade to 'A'
    mov ecx, num_grades  ; ECX is the loop counter

check_grade:
    cmp ebx, ecx  ; Check if the average is greater than or equal to the current grade
    jb print_char  ; If not, print the current grade and move to the next one
    dec ecx       ; Decrement the loop counter
    jmp check_grade  ; Continue checking grades until ECX is zero

print_char:
    add esi, 1    ; Increment the grade character
    mov edx, 1    ; Print one character
    int 0x80      ; Call the write syscall
    jmp check_grade  ; Continue checking grades until ECX is zero

exit:
    mov eax, 1    ; Set up the exit syscall
    xor ebx, ebx  ; Clear the exit code
    int 0x80      ; Call the exit syscall
