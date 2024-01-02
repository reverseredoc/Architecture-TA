#!/bin/bash

ALL_FOLDER="crib"
TEMP_FOLDER="temp3"
MARKS_FILE="marks.txt"
ERROR_FILE="error.txt"
INPUT_FILE="./input1.txt"
REQUIRED_FILE="./output1.txt"

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

    SECOND_LEVEL_FOLDER=$(unzip -qql "$SECOND_LEVEL_ZIP" | head -n1 | awk '{print $4}')
    unzip -q "$SECOND_LEVEL_ZIP" -d "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER"

    # Find the queryProcessing.s executable in the dynamically named folder
    QUERY_PROCESSING_EXECUTABLE=$(find "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER" -name "queryProcessing.s" -type f)

    if [ -n "$QUERY_PROCESSING_EXECUTABLE" ]; then
        # Run queryProcessing.s on input1.txt and redirect output to out1.txt
        # echo "$FILENAME_NO_EXT found" >> "$MARKS_FILE"
        # echo "$QUERY_PROCESSING_EXECUTABLE"
        # echo "spim -f $TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER/queryProcessing.s"



        score=0
        for ((i=1; i<=5; i++)); do
            {
            timeout 6s ./spim -exception_file exceptions.s -f "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER/queryProcessing.s" < "./input$i.txt"  > "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER/out$i.txt"

            # timeout 6s spim -f "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER/queryProcessing.s" < "./input$i.txt"  > "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER/out$i.txt"
            } || {
                continue
            }
            # # Strip the first 5 lines and remove empty lines from the output file
            # tail -n +6 "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER/out.txt" | grep -v '^$' > "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER/out.txt"
            tail -n +6 "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER/out$i.txt" > "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER/out1$i.txt"

            FILE1="$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER/out1$i.txt"
            # FILE2="out1.txt"

            # Function to strip leading and trailing spaces and tabs from each line
            strip_lines() {
                awk '{$1=$1};1' "$1"
            }

            # Strip lines from both files
            strip_lines "$FILE1" > "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER/out2$i.txt"
            # strip_lines "$FILE2" > "stripped_$FILE2"

            # Remove empty lines
            grep -v '^$' "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER/out2$i.txt" > "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER/out3$i.txt"


            # grep -v '^$' "stripped_$FILE2" > "cleaned_$FILE2"
            # Compare the output with required.txt and store the result in marks.txt
            diff "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER/$SECOND_LEVEL_FOLDER/out3$i.txt" "./output$i.txt" > /dev/null
            if [ $? -eq 0 ]; then
                # SCORE="100"  # Output matches required.txt
                score=$((score + 10))
                # SCORE="0"    # Output does not match required.txt
            fi
        done

        # # Store the result in marks.txt
        echo "$FILENAME_NO_EXT - $score" >> "$MARKS_FILE"

    else
        echo "$FILENAME_NO_EXT wrong directory structure/queryProcessing.s not found" >> "$ERROR_FILE"
        echo "$FILENAME_NO_EXT - 0" >> "$MARKS_FILE"
    fi

    # Clean up temp folders for the next iteration
    rm -rf "$TEMP_FOLDER/$FIRST_LEVEL_FOLDER"
done
