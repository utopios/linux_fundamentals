#!/bin/bash
#do
#       ((number++))
#       if [ $number -gt 5 ]; then
#               break;
#       fi
#       echo $number
#done

while true
do
        echo "Type something (type 'quit' to exit):"
        read input

        if [ "$input" = "quit" ]; then
                echo "Exiting the loop. Goodbye !"
                break
        fi
        echo "You typed: $input"
done
