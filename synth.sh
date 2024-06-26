#!/bin/bash

tempo=100
loop=false 

while getopts "t:l" flag
do
    case "${flag}" in
        t) tempo=${OPTARG} ;;
        l) loop=true ;;
        *) echo "Usage: $0 [-t tempo] [-l] [melody]"; exit 1 ;;
    esac
done

shift $((OPTIND-1))

time_per_note=$(echo "60 / $tempo" | bc -l)
melody=$1 
melody_length=${#melody}

i=0

while true
do 
    substring=${melody:$i:3}
    
    if [[ $substring =~ ^[A-G]b[0-8]$ ]]; then
        note=$substring
        step=3
    elif [[ $substring =~ ^[A-G]#[0-8]$ ]]; then 
        case "${substring:0:1}" in 
            "A")
                note="Bb" ;;
            "B")
                note="C" ;;
            "C")
                note="Db" ;;
            "D")
                note="Eb" ;;
            "E")
                note="F" ;;
            "F") 
                note="Gb" ;;
            "G")
                note="Ab"
                octave=$((${substring:2:1} + 1)) ;;
        esac
        if [[ -z "$octave" ]]; then
            octave=${substring:2:1}
        fi
        note+="$octave"
        step=3
    elif [[ $substring =~ ^[A-G][0-8].?$ ]]; then
        note=${substring:0:2}
        step=2
    elif [[ $substring =~ ^_.?.?$ ]]; then 
        note="_"
        step=1
    else 
        echo "Invalid note at position $i: $substring"
        exit 1
    fi

    echo $note
    ((i+= step))

    if [[ "$note" = "_" ]]; then 
        sleep $time_per_note
    else
        if [[ ! -z "$!" ]]; then
            kill $!
        fi
        ffplay -v 0 -autoexit -nodisp ./sounds/$note.mp3 > /dev/null &
    fi

    if [[ $i -ge melody_length ]]; then
        if [[ $loop = true ]]; then 
            i=0
        else
            break
        fi
    fi
done