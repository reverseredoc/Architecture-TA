.data
newline: .asciiz "\n"

.text

.globl merge

merge:

    # dont change s0, s2, s3, s4, s5, fp
    # sp if changed bring it back

    # merge logic

    # s3 for left_start     l
    # s4 for mid            m
    # s5 for right_end      r

    sub $t0, $s4, $s3
    addi $t0, $t0, 1 # t0 = n1

    sub $t1, $s5,  $s4 # t1 = n2

    sll $s6, $t0, 2 # amount of space to be created
    sub $s6, $s1, $s6 # s6 is L array starting point

    sll $s7, $t1, 2 # amount of space to be created
    sub $s7, $s6, $s7 # s7 is R array starting point

    add $t2, $zero, $zero # t2 = i (counter)

    for1:
        bge $t2, $t0, for1D
        add $t3, $s3, $t2
        sll $t3, $t3, 2 # space to be created

        add $t4, $s1, $t3
        lw $t3, 0($t4)

        # t4 free t3 occupied
        sll $t4, $t2, 2
        add $t4, $t4, $s6
        sw $t3, 0($t4)

        addi $t2, $t2, 1
        j for1 # looping back

    for1D:
        # t2, t3, t4 are free again



    add $t2, $zero, $zero # t2 = i (counter)

    for2:
        bge $t2, $t1, for2D
        add $t3, $s4, $t2
        addi $t3, $t3, 1
        sll $t3, $t3, 2 # space to be created

        add $t4, $s1, $t3
        lw $t3, 0($t4)

        # t4 free t3 occupied
        sll $t4, $t2, 2
        add $t4, $t4, $s7
        sw $t3, 0($t4)

        addi $t2, $t2, 1
        j for2 # looping back

    for2D:
        # t2, t3, t4 are free again

    # initialisations
    add $t2, $zero, $zero # t2 = i
    add $t3, $zero, $zero # t3 = j
    add $t4, $s3, $zero # t4 = k

    while1:
        bge $t2, $t0, while1D # i<n1
        bge $t3, $t1, while1D # j<n2

        sll $t5, $t2, 2
        add $t5, $s6, $t5
        lw $t5, 0($t5) # t5 = L[i]

        sll $t8, $t3, 2
        add $t8, $s7, $t8
        lw $t8, 0($t8) # t8 = R[j]

        bgt $t5, $t8, else1 # if L[i] > R[j]
        sll $t9, $t4, 2
        add $t9, $s1, $t9
        sw $t5,0($t9) # arr[k] = L[i]

        addi $t2, $t2, 1

        b if1D

        else1:
            sll $t9, $t4, 2
            add $t9, $s1, $t9
            sw $t8,0($t9) # arr[k] = R[j]
            addi $t3, $t3, 1

        if1D:

        addi $t4, $t4, 1
        b while1

    while1D:

    # t5, t8, t9 free again

    while2:
        bge $t2, $t0, while2D

        sll $t5, $t2, 2
        add $t5, $s6, $t5
        lw $t5, 0($t5) # t5 = L[i]

        sll $t9, $t4, 2
        add $t9, $s1, $t9
        sw $t5, 0($t9) # arr[k] = L[i]

        addi $t2, $t2, 1
        addi $t4, $t4, 1

        b while2

    while2D:

    while3:
        bge $t3, $t1, while3D

        sll $t5, $t3, 2
        add $t5, $s7, $t5
        lw $t5, 0($t5) # t5 = R[j]

        sll $t9, $t4, 2
        add $t9, $s1, $t9
        sw $t5, 0($t9) # arr[k] = R[j]

        addi $t3, $t3, 1
        addi $t4, $t4, 1

        b while3

    while3D:

    b mergedone


.globl leftloop
leftloop:
    # going back once
    sub $t0, $s0, 1 # n-1 in t0
    bge $s3, $t0, leftdone # if condition failed jump back

    # LOOP BODY

    # s4 for mid
    # s5 for right_end

    # setting s4
    add $t1, $s2, $s3
    sub $t1, $t1, 1

    blt $t1, $t0, summin
        move $s4, $t0
        b minn

    summin:
        move $s4, $t1
    minn:

    # setting s5
    sll $t1, $s2, 1
    add $t1, $s3, $t1
    sub $t1, $t1, 1

    # min found

    blt $t1, $t0, summinn
        move $s5, $t0
        b minf

    summinn:
        move $s5, $t1
    minf:

    b merge

    mergedone:

    # LOOP LOGIC ENDS


    # incrementing left start
    sll $t0, $s2, 1
    add $s3, $s3, $t0

    # looping
    b leftloop


.globl mergesort

mergesort:
    # ONLY RESTRICTIONS : dont change s0, fp,
    # sp if changed, bring it back

    # s2 for curr_size
    # s3 for left_start
    bge $s2, $s0, sorted

    # LOOP BODY
    # initialising left_start
    move $s3, $zero
    b leftloop

    # Inside loop finished
    leftdone:

    # incrementing
    sll $s2, $s2 , 1

    # looping
    b mergesort


.globl binsearch

binsearch:
    sub $s5, $zero, 1 # result = -1

    add $t0, $zero, $zero # t0 = l = 0
    sub $t1, $s0, 1 # t1 = r = n-1

    bin2:
        bgt $t0, $t1, bin2D

        add $t2, $zero, $t0
        sub $t3, $t1, $t0
        addi $t4, $zero, 2
        div $t3, $t4
        mflo $t3
        add $t2, $t2, $t3  # t2 = m = l + (r - l) / 2

        # t3 and t4 are free again
        add $t3, $zero, $t2
        sll $t3, $t3, 2
        add $t3, $t3, $s1
        lw $t3, 0($t3) # t3 = arr[m]

        beq $t3, $s4, equalfound
        bgt $t3, $s4, greaterfound

        # a[m] < x
        addi $t0, $t2, 1
        b bincompdone

        equalfound:
            move $s5, $t2
            b binsearchdone

        greaterfound:
            sub $t1, $t2, 1
            b bincompdone

        bincompdone:

        b bin2

    bin2D:

        b binsearchdone

main:

    # preamble
    addiu $sp,$sp,-4
    sw  $fp,4($sp)
    move $fp,$sp

    # get the input for number of elements in array
    li $v0, 5
    syscall

    move $s0, $v0 # input size

    addi $t0, $v0, 1 # 1 extra space for index

    sll $t0, $t0, 2 # variable which stores how much space is to be created for array

    sub $sp,$sp, $t0 # created space for array

    sw $zero, 0($sp)
    b L2 # unconditional jump to L2

L3:
    # get the input from file
    li $v0, 5
    syscall

    # computing index where to store from index
    addi $t0, $t0, 1
    sll $t0, $t0, 2
    add $sp, $sp, $t0 # this is where new element needs to be stored
    sw $v0, 0($sp)

    # decreasing stack pointer returning to where it was
    sub $sp, $sp, $t0

    lw $t0, 0($sp)
    addi $t0, $t0, 1
    sw $t0, 0($sp) #  incrementing index by 1


L2: # i=0, if i < n then read input
    lw $t0, 0($sp) # t0 now stores the index
    blt $t0, $s0, L3 # $t0 right now contains index

    # Setting parameters for mergesort is NOT REQ IG


    # move $a0, $sp # array starting index
    # move $a1, #s0 # number of elements in array

    addi $s2, $zero, 1 # initialising curr_size

    # s1 for array starting point
    addi $s1, $sp, 4
    b mergesort # unconditional jump to mergesort

    # jumping back after sorting is done
    sorted:


# OUTPUTING

# ########## OUTPUTTING REMOVED

# move $s1, $zero # initialising index to be printed with zero

# b L4 # unconditional jump to L4

# L5:
 #   # computing index where to store from index
  #  addi $t0, $s1, 1
   # sll $t0, $t0, 2
#    add $sp, $sp, $t0 # this is where new element needs to be stored
 #   lw $s2, 0($sp) # the number is stored in s2

    # decreasing stack    sw $v0, 0($sp) pointer returning to where it was
  #  sub $sp, $sp, $t0

   # addi $s1, $s1, 1 # incrementing index to be printed

    # Printing to output file
   # li $v0, 1 # outputing the variable
   # move $a0, $s2
   # syscall

    # li $v0, 4
#    la $a0, newline # outputing a new line
#    syscall

# L4: # i=0, if i < n then output
 #   blt $s1, $s0, L5 # $s1 right now contains index


# ########## OUTPUTTING REMOVED

# AFTER SORTING NOW BINARY SEARCH

# s1 for sorted array starting point
addi $s1, $sp, 4
li $v0, 5
syscall # number of queries in v0

move $s2, $v0 # s2 = number of queries

# initialised to 0
add $s3, $zero, $zero # s3 couonter for number of queries

bin1:
    bge $s3, $s2, bin1D

    li $v0, 5
    syscall # query in v0
    move $s4, $v0 # s4 = to_search

    b binsearch

    binsearchdone:

    # Printing to output file
    li $v0, 1 # outputing the variable
    move $a0, $s5
    syscall

    li $v0, 4
    la $a0, newline # outputing a new line
    syscall

    add $s3, $s3, 1
    b bin1

bin1D:


# tailer
move $2,$0
move $sp,$fp
lw $fp,4($sp)
addiu $sp,$sp,4
jr $ra
nop
