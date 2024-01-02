        section .text
        global  alt_sum

alt_sum:
        ; ; Here I am assuming I will put variables like
        push rdi                       ; pointer to mat1
        push rdx                       ; size of array
        push r11

; ; 0-indexing on all matrices
; ; mat1[j][i] = rdi+(r9*j+i)*8
; ; GOAL - Perform matrix alternate summation of mat1, mat2 and save result in mat3

; ; TODO - Fill your code here performing the matrix alternate summation in the following order
; ; for(int i = 0; i < n; i++){for(int j = 0; j < n; j++){sum += (-1)^(i+j)*mat1[i][j];}}

; ; Lets define i,j
        push rbx
        push r13
        push r12

        xor rax, rax ; This will store our sum as this is also the register in which we return from a function
        mov r13, rdi ; temporary pointer to matrix 1

        mov r11, 0                     ; r11 is i
        mov r12, 0                     ; r12 is j
forO:
        cmp r11, rdx                   ; r9 is n
        jge endForAll
forI:
        cmp r12, rdx
        jge endForI
        
        mov rbx, [r13] ; r13 is mat1[i][j]

        xor r10, r10
        add r10, r11
        add r10, r12 ; r10 is i+j

        test r10, 1
        jz even
        jnz odd
even:   
        xor r10, r10
        add r10, 1 ; r10 is 1
        jmp cnt
odd:
        xor r10, r10
        add r10, 1
        imul r10, -1 ; r10 is -1  
cnt:
        imul rbx, r10 ; calculated (-1)^(i+j)*mat1[i][j]
        add rax, rbx ; updating the sum
        add r13, 8
        
        inc r12 ; j++
        jmp forI
endForI:
        inc r11 ; i++
        xor r12, r12
        jmp forO
endForAll:
        pop r12
        pop r13
        pop rbx
; ; End of code to be filled
        pop r11
        pop rdx
        pop rdi
        ret
