; Fibonacci sequence

; This code will compute the Fibonacci sequence and store the result in the EAX register.
; The number of iterations is controlled by the EDX register.
; To change the number of iterations, simply modify the value of EDX before calling the fibonacci_loop label.

section .data

section .text

global _start

_start:
    mov eax, 0    ; Initialize the first two elements of the sequence
    mov ebx, 1

fibonacci_loop:
    add eax, ebx  ; Compute the next element in the sequence
    mov ecx, eax  ; Save the current element
    mov eax, ebx  ; Rotate the elements so that the next element becomes the first one
    mov ebx, ecx
    dec edx       ; Decrement the loop counter
    jnz fibonacci_loop  ; If the loop counter is not zero, jump back to the beginning of the loop

exit:
    mov eax, 1    ; Set the exit code to 1
    xor ebx, ebx  ; Clear the second argument for exit()
    int 0x80      ; Call the exit syscall
