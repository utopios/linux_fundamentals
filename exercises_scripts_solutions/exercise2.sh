#!/bin/bash
echo "Enter a number"
read number

if [ "$number" -gt 0 ]; then
    echo "Positive"
elif [ "$number" -lt 0]; then
    echo "Negative"
else
    echo "Zero"
fi