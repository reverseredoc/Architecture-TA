#!/bin/bash

ALL_FOLDER="ALL"
TEMP_FOLDER="temp"
MARKS_FILE="marks.txt"
ERROR_FILE="error.txt"

mkdir -p "$TEMP_FOLDER"

for FIRST_LEVEL_ZIP in "$ALL_FOLDER"/*.zip; do
    FILENAME=$(basename -- "$FIRST_LEVEL_ZIP")
    FILENAME_NO_EXT="${FILENAME%.*}"

    # First unzip
    FIRST_LEVEL_FOLDER=$(unzip -qql "$FIRST_LEVEL_ZIP" | head -n1 | awk '{print $4}')
    unzip -q "$FIRST_LEVEL_ZIP" -d "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER"

    # Second unzip
    SECOND_LEVEL_ZIP=$(find "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER" -name "*.zip" -type f)

    if [ -z "$SECOND_LEVEL_ZIP" ]; then
        echo "$FILENAME_NO_EXT wrong directory structure/*.zip not found" >> "$ERROR_FILE"
        rm -rf "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER"
        echo "$FILENAME_NO_EXT - 0" >> "$MARKS_FILE"
        continue
    fi

    # echo "$SECOND_LEVEL_ZIP"

    SECOND_LEVEL_FOLDER=$(unzip -qql "$SECOND_LEVEL_ZIP" | head -n1 | awk '{print $4}')
    unzip -q "$SECOND_LEVEL_ZIP" -d "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER"

    # echo "$SECOND_LEVEL_FOLDER"

    # Find the queryProcessing.s executable in the dynamically named folder
    # QUERY_PROCESSING_EXECUTABLE=$(find "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER" -name "queryProcessing.s" -type f)

    #!/bin/bash

    # List of file names
    file_list=("matrix-testbench.asm" "io.asm" "my_LINCOMB_COL.asm" "my_SUM_COL.asm" "my_PROD_COL.asm" "my_LINCOMB_ROW.asm" "my_SUM_ROW.asm" "my_PROD_ROW.asm")

    flag=0

    # Iterate over the file list
    for file in "${file_list[@]}"; do
        # check_file_existence "$file"

        file_name=$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER/$file
        if [ ! -e "$file_name" ]; then
            flag = 1
            break
        fi
    done

    if [ $flag -eq 1 ]; then
        echo "$FILENAME_NO_EXT wrong directory structure/*.zip not found" >> "$ERROR_FILE"
        rm -rf "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER"
        echo "$FILENAME_NO_EXT - 0" >> "$MARKS_FILE"
        continue
    fi


    # if [ -n "$QUERY_PROCESSING_EXECUTABLE" ]; then
    # Run queryProcessing.s on input1.txt and redirect output to out1.txt
    # echo "$FILENAME_NO_EXT found" >> "$MARKS_FILE"
    # echo "$QUERY_PROCESSING_EXECUTABLE"
    # echo "spim -f $TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER/queryProcessing.s"

    score=0
    tt="$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER"
    {
    nasm -felf64 "$tt/io.asm" -o "$tt/io.o"
    nasm -felf64 "$tt/matrix-testbench.asm" -o "$tt/matrix-testbench.o"
    nasm -felf64 "$tt/my_LINCOMB_COL.asm" -o "$tt/my_LINCOMB_COL.o"
    nasm -felf64 "$tt/my_SUM_COL.asm" -o "$tt/my_SUM_COL.o"
    nasm -felf64 "$tt/my_PROD_COL.asm" -o "$tt/my_PROD_COL.o"
    nasm -felf64 "$tt/my_LINCOMB_ROW.asm" -o "$tt/my_LINCOMB_ROW.o"
    nasm -felf64 "$tt/my_SUM_ROW.asm" -o "$tt/my_SUM_ROW.o"
    nasm -felf64 "$tt/my_PROD_ROW.asm" -o "$tt/my_PROD_ROW.o"

    gcc -no-pie -g -o "$tt/col.out" "$tt/io.o" "$tt/my_PROD_COL.o" "$tt/my_SUM_COL.o" "$tt/my_LINCOMB_COL.o" "$tt/matrix-testbench.o"
    gcc -no-pie -g -o "$tt/row.out" "$tt/io.o" "$tt/my_PROD_ROW.o" "$tt/my_SUM_ROW.o" "$tt/my_LINCOMB_ROW.o" "$tt/matrix-testbench.o"
    } || {
        echo "$FILENAME_NO_EXT - $score" >> "$MARKS_FILE"
        echo "$FILENAME_NO_EXT - Error: Compilation failed" >> "$ERROR_FILE"
        continue
    }

    for ((i=1; i<=5; i++)); do
        {
        timeout 5s "$tt/col.out" < "./input$i.txt"  > "$tt/out_col$i.txt"
        timeout 5s "$tt/row.out" < "./input$i.txt"  > "$tt/out_row$i.txt"
        } || {
            continue
        }

        # COLUMN

        # Assuming the file name is "your_file.txt"
        file_name="$tt/out_col$i.txt"

        # Check if the file exists
        if [ ! -e "$file_name" ]; then
            echo "Error: File not found."
            continue
        fi

        # Read the numbers from the file and store them in variables

        o_col=$(head -n 1 "$file_name") || {
            echo "Error: Unable to read the first line."
            continue
        }

        col_time=$(tail -n 1 "$file_name") || {
            echo "Error: Unable to read the second line."
            continue
        }


        # Print the values for verification
        # echo "o_col: $o_col"
        # echo "col_time: $col_time"


        # ROW

        # Assuming the file name is "your_file.txt"
        file_name="$tt/out_row$i.txt"

        # Check if the file exists
        if [ ! -e "$file_name" ]; then
            echo "Error: File not found."
            continue
        fi

        o_row=$(head -n 1 "$file_name") || {
            echo "Error: Unable to read the first line."
            continue
        }

        row_time=$(tail -n 1 "$file_name") || {
            echo "Error: Unable to read the second line."
            continue
        }

        # Reading the correct output
        file_name="./output$i.txt"

        # Check if the file exists
        if [ ! -e "$file_name" ]; then
            echo "Error: File not found."
            continue
        fi

        correct_output=$(head -n 1 "$file_name") || {
            echo "Error: Unable to read the first line."
            continue
        }

        # NOW CHECKING
        if [ "$o_row" != "$o_col" ] || [ "$o_row" != "$correct_output" ]; then
            continue
        fi

        # Check if col_time is at least double of row_time
        if [ "$col_time" -lt $((3 * row_time / 2)) ]; then
            continue
        fi

        score=$((score + 10))

    done

    # Store the result in marks.txt
    echo "$FILENAME_NO_EXT - $score" >> "$MARKS_FILE"

    # Clean up temp folders for the next iteration
    # rm -rf "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER"
done
