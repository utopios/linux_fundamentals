#!/bin/bash
countdown() {
        local number=$1
        while [ "$number" -gt 1 ]; do
                echo $number
                sleep 1
                number=$(($number - 1))
        done    

}
