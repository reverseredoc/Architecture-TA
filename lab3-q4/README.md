# Running Instructions For Q4 LAB 3

## To compile the assembly files

- `nasm -felf64 io.asm -o io.o`
- `nasm -felf64 matrix--testbench.asm -o matrix--testbench.o`

### For Column Major
- `nasm -felf64 my_LINCOMB_COL.asm -o my_LINCOMB_COL.o`
- `nasm -felf64 my_SUM_COL.asm -o my_SUM_COL.o`
- `nasm -felf64 my_PROD_COL.asm -o my_PROD_COL.o`

### For Row Major
- `nasm -felf64 my_LINCOMB_ROW.asm -o my_LINCOMB_ROW.o`
- `nasm -felf64 my_SUM_ROW.asm -o my_SUM_ROW.o`
- `nasm -felf64 my_PROD_ROW.asm -o my_PROD_ROW.o`

## To generate binaries
- `gcc -no-pie -g io.o my_PROD_COL.o my_SUM_COL.o my_LINCOMB_COL.o  matrix-testbench.o`
- `gcc -no-pie -g io.o my_PROD_ROW.o my_SUM_ROW.o my_LINCOMB_ROW.o  matrix-testbench.o`


