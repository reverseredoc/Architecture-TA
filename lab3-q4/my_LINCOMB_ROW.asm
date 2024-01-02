        section .text
        global lin_comb
        ; extern write_64

lin_comb:
        ; ; Here I am assuming I will put variables like
        push rdi                       ; pointer to mat1
        push rsi                       ; scaler 1
        push rdx                       ; pointer to mat2
        push rcx                       ; scaler 2
        push r8                        ; pointer to mat3
        push r9                        ; size of arrays
        push r11

; ; 0-indexing on all matrices
; ; mat1[j][i] = rdi+(r9*j+i)*8
; ; GOAL - Perform matrix linear combination of mat1, mat2 and save result in mat3

; ; TODO - Fill your code here performing the matrix linear combination in the following order
; ; for(int i = 0; i < n; i++){for(int j = 0; j < n; j++){mat3[i][j] = s1*mat1[i][j] + s2*mat2[i][j];}}

; ; Lets define i,j
        push r12
        push r13
        push r14 ; since it is callee saved and I am using it
        push r15
        push rbx

        mov r13, rdi ; temporary pointers to arrays, 1
        mov r14, rdx ; 2
        mov r15, r8 ; 3

        mov r11, 0                     ; r11 is i
        mov r12, 0                     ; r12 is j
forO:
        cmp r11, r9                    ; r9 is n
        jge endForAll
        ; mov rax, r11
        ; call read_64
forI:
        cmp r12, r9
        jge endForI
        
        mov rbx, [r13] ; r13 is mat1[i][j]
        mov rax, [r14] ; r14 is mat2[i][j]

        imul rbx, rsi ; r13 is mat1[i][j]*s1
        imul rax, rcx ; r14 is mat2[i][j]*s2

        add rbx, rax ; r13 is mat1[i][j]*s1 + mat2[i][j]*s2
        mov [r15], rbx ; storing in mat3[i][j] the value
        
        add r13, 8
        add r14, 8
        add r15, 8
        
        inc r12 ; j++
        jmp forI
endForI:
        inc r11 ; i++
        xor r12, r12
        jmp forO
endForAll:
        pop rbx
        pop r15
        pop r14
        pop r13
        pop r12
; ; End of code to be filled
        pop r11
        pop r9
        pop r8
        pop rcx
        pop rdx
        pop rsi
        pop rdi
        ret
