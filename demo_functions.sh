#!/bin/bash

greet(){
        echo "Hello to $1 and $2"
        echo "You passed $# arguments"
        echo "All Arguments $@"
}

sum() {
        total=0
        for arg in "$@"; do
         total=$((total+arg))
        done
        echo "Total is $total"
}

#greet
