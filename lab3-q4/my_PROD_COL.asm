        section .text
        global hadarmard_prod

hadarmard_prod:
        ; ; Here I am assuming I will put variables like
        push rdi                       ; pointer to mat1
        push rdx                       ; pointer to mat2
        push r8                        ; pointer to mat3
        push r9                        ; size of arrays
        push r11


; ; 0-indexing on all matrices
; ; mat1[j][i] = rdi+(r9*j+i)*8
; ; GOAL - Perform matrix linear combination of mat1, mat2 and save result in mat3

; ; TODO - Fill your code here performing the matrix linear combination in the following order
; ; for(int i = 0; i < n; i++){for(int j = 0; j < n; j++){mat3[j][i] = s1*mat1[j][i] + s2*mat2[j][i];}}

; ; Lets define i,j
        push r12 ; since it is callee saved and I am using it
        push r13 ; since it is callee saved and I am using it
        push r14 ; since it is callee saved and I am using it
        push r15 ; since it is callee saved and I am using it
        push rbx ; since it is callee saved and I am using it
        push rbp ; since it is callee saved and I am using it

        mov rax, r9                    ; rax is n
        imul rax, 8                    ; rax is n*8
        
        mov r11, 0                     ; r11 is i
        mov r12, 0                     ; r12 is j
forO:
        cmp r11, r9                    ; r9 is n
        jge endForAll

        mov rbx, r11 ; storing i in rbx
        imul rbx, 8 ; storing i*8 in rbx

        mov r13, rdi 
        mov r14, rdx 
        mov r15, r8 
        
        add r13, rbx ; is at top of ith column
        add r14, rbx ; is at top of ith column
        add r15, rbx ; is at top of ith column
forI:
        cmp r12, r9
        jge endForI
        
        mov r10, [r13] ; r13 is mat1[i][j]
        mov rbp, [r14] ; r14 is mat2[i][j]

        imul r10, rbp ; r13 is mat1[i][j] * mat2[i][j]
        mov [r15], r10 ; storing in mat3[i][j] the value
        
        add r13, rax ; moving n elements forward to next element in column
        add r14, rax
        add r15, rax

        inc r12 ; j++
        jmp forI
endForI:
        inc r11 ; i++
        xor r12, r12
        jmp forO
endForAll:
        pop rbp
        pop rbx
        pop r15
        pop r14
        pop r13
        pop r12
; ; End of code to be filled
        pop r11
        pop r9
        pop r8
        pop rdx
        pop rdi
        ret
