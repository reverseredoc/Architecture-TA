        global main

        extern exit
        extern alt_sum, lin_comb, hadarmard_prod, read_64, write_64

        section .text

; matrix_init:
;         push rax
;         push rdx
;         push rcx
;         push r10

;         mov rcx, [r3]
;         mov rax, [c3]
;         mul rcx
;         mov rcx, rax
;         shl rcx, 3
;         mov rdx, [a3]
;         add rcx, rdx
; mat3_init_loop:
;         xor rax, rax
;         mov [rdx], rax
;         add rdx, 8
;         cmp rdx, rcx
;         jne mat3_init_loop

;         pop r10
;         pop rcx
;         pop rdx
;         pop rax
;         ret

main:
        push rbp

; INPUT - r1\nc1\nr2\nc2\n
; Matrices are 0-indiced !!

        call read_64
        mov [r1], rax

        call read_64
        mov [s1], rax
        call read_64
        mov [s2], rax
        call read_64
        mov [s3], rax
        call read_64
        mov [s4], rax

        ; call read_64
        ; mov [c1], rax                  ; rax = c1
        mov rax, [r1]                  ; rax = c1
        mov rcx, [r1]                  ; rcx = r1

; ; TODO - Fill code for allocating the matrix into memory, you may use either the stack or heap for this purpose
; ; Start of your code

        xor rdi, rdi

        mul rcx
        mov rsi, rax
        shl rsi, 3

        mov rdx, 3

        mov r10, 34

        mov r8, -1

        mov r9, 0

        mov rax, 9
        syscall
        mov [a1], rax
        
; ; End of your code

        ; call read_64
        ; mov [r2], rax
        ; call read_64
        ; mov [c2], rax                  ; rax = c2
        ; mov rcx, [r2]                  ; rcx = r2
        mov rcx, [r1]
        mov rax, [r1]

        ; ; We already have the same size for all the matrices

; ; TODO - Fill code for allocating the matrix into memory, you may use either the stack or heap for this purpose
; ; Start of your code
        xor rdi, rdi

        mov r10, 34

        mul rcx
        mov rsi, rax
        shl rsi, 3

        mov r9, 0
        
        mov rdx, 3

        mov r8, -1

        mov rax, 9

        syscall

        mov [a2], rax
        
; ; End of your code

        ; mov rax, [c1]                  ; Validity check if matrices can be multiplied
        ; cmp rax, [r2]
        ; jne end
        mov rcx, [r1]
        mov rax, [r1]

; ; ; ; ; ;  ; ; ; ; ; ; ;  ;
; ; TODO - Fill code for allocating the matrix into memory, you may use either the stack or heap for this purpose
; ; Start of your code
        xor rdi, rdi

        mov r10, 34

        mul rcx
        mov rsi, rax
        shl rsi, 3

        mov r9, 0
        
        mov rdx, 3

        mov r8, -1

        mov rax, 9

        syscall

        mov [a3], rax
        
; ; End of your code
        mov rcx, [r1]
        mov rax, [r1]
; ; TODO - Fill code for allocating the matrix into memory, you may use either the stack or heap for this purpose
; ; Start of your code
        xor rdi, rdi

        mov r10, 34

        mul rcx
        mov rsi, rax
        shl rsi, 3

        mov r9, 0
        
        mov rdx, 3

        mov r8, -1

        mov rax, 9

        syscall

        mov [a4], rax
        
; ; End of your code
        mov rcx, [r1]
        mov rax, [r1]
; ; TODO - Fill code for allocating the matrix into memory, you may use either the stack or heap for this purpose
; ; Start of your code
        xor rdi, rdi

        mov r10, 34

        mul rcx
        mov rsi, rax
        shl rsi, 3

        mov r9, 0
        
        mov rdx, 3

        mov r8, -1

        mov rax, 9

        syscall

        mov [b1], rax
        
; ; End of your code
        mov rcx, [r1]
        mov rax, [r1]
; ; TODO - Fill code for allocating the matrix into memory, you may use either the stack or heap for this purpose
; ; Start of your code
        xor rdi, rdi

        mov r10, 34

        mul rcx
        mov rsi, rax
        shl rsi, 3

        mov r9, 0
        
        mov rdx, 3

        mov r8, -1

        mov rax, 9

        syscall

        mov [b2], rax
        
; ; End of your code
        mov rcx, [r1]
        mov rax, [r1]
; ; TODO - Fill code for allocating the matrix into memory, you may use either the stack or heap for this purpose
; ; Start of your code
        xor rdi, rdi

        mov r10, 34

        mul rcx
        mov rsi, rax
        shl rsi, 3

        mov r9, 0
        
        mov rdx, 3

        mov r8, -1

        mov rax, 9

        syscall

        mov [f1], rax
        
; ; End of your code
; ; ; ; ; ; ; ; ; 

; Matrix Input format - row major one number at a time for mat1 followed by mat2 !!
; Use the testcase_gen.py script to generate testcases to validate your code

        mov rcx, [r1]
        mov rax, [r1]
        mul rcx
        mov rcx, rax
        shl rcx, 3
        mov rdx, [a1]
        add rcx, rdx
mat1_read_loop:
        push rdx
        push rdx
        call read_64
        pop rdx
        pop rdx
        mov [rdx], rax
        add rdx, 8
        cmp rdx, rcx
        jne mat1_read_loop

        mov rcx, [r1]
        mov rax, [r1]
        mul rcx
        mov rcx, rax
        shl rcx, 3
        mov rdx, [a2]
        add rcx, rdx
mat2_read_loop:
        push rdx
        push rdx
        call read_64
        pop rdx
        pop rdx
        mov [rdx], rax
        add rdx, 8
        cmp rdx, rcx
        jne mat2_read_loop

        mov rcx, [r1]
        mov rax, [r1]
        mul rcx
        mov rcx, rax
        shl rcx, 3
        mov rdx, [a3]
        add rcx, rdx
mat3_read_loop:
        push rdx
        push rdx
        call read_64
        pop rdx
        pop rdx
        mov [rdx], rax
        add rdx, 8
        cmp rdx, rcx
        jne mat3_read_loop

        mov rcx, [r1]
        mov rax, [r1]
        mul rcx
        mov rcx, rax
        shl rcx, 3
        mov rdx, [a4]
        add rcx, rdx
mat4_read_loop:
        push rdx
        push rdx
        call read_64
        pop rdx
        pop rdx
        mov [rdx], rax
        add rdx, 8
        cmp rdx, rcx
        jne mat4_read_loop

processing_code:
        lfence
        rdtsc
        shl rdx, 32
        or rdx, rax
        mov r12, rdx
        lfence
        
        mov rdi, [a1]
        mov rsi, [s1]
        mov rdx, [a2]
        mov rcx, [s2]
        mov r8, [b1]
        mov r9, [r1]
        mov r11, 0
test_loop1:
        ; call matrix_init
        call lin_comb
        add r11, 1
        cmp r11, 10
        jne test_loop1

;         mov rcx, [r1]
;         mov rax, [r1]
;         mul rcx
;         mov rcx, rax
;         shl rcx, 3
;         mov rdx, [b1]
;         add rcx, rdx
; mat3_print_loop:
;         mov rax, [rdx]
;         push rdx
;         push rcx
;         call write_64
;         pop rcx
;         pop rdx
;         add rdx, 8
;         cmp rdx, rcx
;         jne mat3_print_loop


        mov rdi, [a3]
        mov rsi, [s3]
        mov rdx, [a4]
        mov rcx, [s4]
        mov r8, [b2]
        mov r9, [r1]
        mov r11, 0
test_loop2:
        ; call matrix_init
        call lin_comb
        add r11, 1
        cmp r11, 10
        jne test_loop2

;         mov rcx, [r1]
;         mov rax, [r1]
;         mul rcx
;         mov rcx, rax
;         shl rcx, 3
;         mov rdx, [b2]
;         add rcx, rdx
; mat33_print_loop:
;         mov rax, [rdx]
;         push rdx
;         push rcx
;         call write_64
;         pop rcx
;         pop rdx
;         add rdx, 8
;         cmp rdx, rcx
;         jne mat33_print_loop

        mov rdi, [b1]
        mov rdx, [b2]
        mov r8, [f1]
        mov r9, [r1]
        mov r11, 0

test_loop3:
        ; call matrix_init
        call hadarmard_prod
        add r11, 1
        cmp r11, 10
        jne test_loop3

;         mov rcx, [r1]
;         mov rax, [r1]
;         mul rcx
;         mov rcx, rax
;         shl rcx, 3
;         mov rdx, [f1]
;         add rcx, rdx
; mat333_print_loop:
;         mov rax, [rdx]
;         push rdx
;         push rcx
;         call write_64
;         pop rcx
;         pop rdx
;         add rdx, 8
;         cmp rdx, rcx
;         jne mat333_print_loop

        mov rdi, [f1]
        mov rdx, [r1]
        mov r11, 0

final_loop:
        ; call matrix_init
        call alt_sum
        add r11, 1
        cmp r11, 10
        jne final_loop

        call write_64 ;; ;; ;; ;; 

        lfence
        rdtsc
        shl rdx, 32
        or rdx, rax
        sub rdx, r12
        mov rax, rdx
        xor rdx, rdx
        mov rcx, 10
        div rcx
        call write_64
        lfence

code_end:
        jmp end

end:
        xor rdi, rdi
        call exit

        section .bss

        wordsize equ 8
        tempsize equ 10

s1:
        resb wordsize                  ; scaler for matrix 1
s2:
        resb wordsize                  ; scaler for matrix 2
s3:
        resb wordsize                  ; scaler for matrix 3
s4:
        resb wordsize                  ; scaler for matrix 4

r1:
        resb wordsize                  ; size of matrices

a1:
        resb wordsize                  ; pointer to mat1
a2:
        resb wordsize                  ; pointer to mat2
a3:
        resb wordsize                  ; pointer to mat 3
a4:
        resb wordsize                  ; pointer to mat 4
b1:
        resb wordsize                  ; pointer to interim matrix 1
b2:
        resb wordsize                  ; pointer to interim matrix 2
f1:
        resb wordsize                  ; pointer to final matrix


