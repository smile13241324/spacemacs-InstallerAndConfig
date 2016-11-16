#!/bin/bash

# Commands to obtain default compile flags
# clang -v -E -x c++ -
# clang++-libc++ -v -E -x c++ -
# gcc -v -E -x c++ -

# Fetch content of compilation database
content="$(grep -F "command" "$(find . -name compilation_database.json)")"

# Split into rows
rm .clang_complete2
while IFS=',' read -ra rows; do
    for i in "${rows[@]}"; do

        # Split into columns
        while IFS=' ' read -ra columns; do
            for y in "${columns[@]}"; do

                # Remove every line not starting with - as well as all -o and -c flags
                if ( echo "$y" | grep -P '(?!-c)(?!-o)(^-)' )
                then
                    echo "$y" >> .clang_complete2
                fi
            done
        done <<< "$i"
    done
done <<< "$content"

# Remove duplicates
(sort < .clang_complete2 | uniq) > .clang_complete
