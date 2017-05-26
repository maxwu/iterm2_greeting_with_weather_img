#!/bin/bash
# The scipt is developed for iTerm Bash Profil using. It will print weather forecast and randomly shows a picture from given folder as specified by $1.
# v1.0
# May 27, 2017, Max, init script and baseline v1.0. 

function print_osc() {
    if [[ $TERM == screen* ]] ; then
        printf "\033Ptmux;\033\033]"
    else
        printf "\033]"
    fi
}

function print_st() {
    if [[ $TERM == screen* ]] ; then
        printf "\a\033\\"
    else
        printf "\a"
    fi
}

function print_image() {
    print_osc
    printf '1337;File='
    printf "width=32;"

    VERSION=$(base64 --version 2>&1)
    if [[ "$VERSION" =~ fourmilab ]]; then
      BASE64ARG=-d
    elif [[ "$VERSION" =~ GNU ]]; then
      BASE64ARG=-di
    else
      BASE64ARG=-D
    fi

    printf "%s" "$3" | base64 $BASE64ARG | wc -c | awk '{printf "size=%d",$1}'
    printf ";inline=1" # always set inline=1
    printf ":"
    printf "%s" "$(base64 < "$1")"
    print_st
    printf '\n'
}

# __main__
# Greeting
echo "[31mHello $LOGNAME, make it a great day! ♘  [37;0m"
echo 
# Weather Brief
curl wttr.in/lower+hutt 2>/dev/null | head -n 17
echo 

FOLDER=$1
img_list=($(ls -d $FOLDER/* | xargs))

# seed the random generator
RANDOM=$$$(date +%s)

selected=${img_list[$RANDOM % ${#img_list[@]} ]}
# echo "img picked: $selected"
#~/.iterm2/imgcat $selected
print_image $selected
echo 
echo "Let rock it off~"
