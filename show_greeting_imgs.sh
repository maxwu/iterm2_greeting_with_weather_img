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

function print_help_msg(){
    echo "$0 [-c city_name_plus_as_space]|[-p picture_folder][-w picture_width]|[-q]|[-h]"
    echo " -c: city name, \"lower+hutt\" for Lower Hutt city in Wellington"
    echo "     In noraml cases, wttr can detect location from IP"
    echo "     So it is default to none and wttr automatically look up GeoIP DB."
    echo "     Specify city name only if the GeoIP location is not expected."
    echo " -p: folder to pick up picture, default to ~/Pictures"
    echo " -w: picture width in cols, default to 32"
    echo " -q: quiet mode weather forecast, just for the day, not for every 6hrs"
    echo "     If current terminal window width is less than 100 cols, "
    echo "     This mode will automatically activate."
    echo " -h: show this message and exit."
}

# __main__
QUIET=""
CITY=""
FOLDER=~/Pictures
WIDTH="32"
# Parse with getopts
while getopts ":c:p:w:qh" opt; do
    case $opt in
      c)
	# echo "city is ${OPTARG}"
	CITY=$OPTARG	
	;;
      p) 
	# echo "pic folder is ${OPTARG}"
	FOLDER=$OPTARG	
	;;
      w) 
	# echo "width is ${OPTARG}"
	WIDTH=$OPTARG
	;;
      q)
	# echo "quiet mode wttr"
	QUIET="1"
	;;
      h | \?)
	print_help_msg
	exit 0
	;;
    esac
done

# Show greeting
echo 
echo "[31mHello $LOGNAME, make it a great day! ♘  [37;0m"
echo 

# Weather Brief
# GeoIP DB might run an incorrect IP range for Wellington Vodafone landlines, here city name is specified.
# For a general using, just curl wttr.in 2>/dev/null | head -n 17 will be fine.
# opt_city="lower+hutt"

term_width=$(tput cols)
if [ "$term_width" -lt "100" ]; then
    # In narrow terminal windows, just show a day forecast
    QUIET="1"
fi

if [ -n "$QUIET" ]; then
    shown_lines=7
else
    # Including wttr forecast for different times in day
    shown_lines=17
fi

# Another way to specify quiet mode with wttr
# curl wttr.in/lower+hutt?q?0

curl wttr.in/$CITY 2>/dev/null | head -n $shown_lines

echo 

img_list=($(ls -d $FOLDER/* | xargs))

# seed the random generator
RANDOM=$$$(date +%s)

selected=${img_list[$RANDOM % ${#img_list[@]} ]}
# echo "img picked: $selected"
if [ -n "$selected" ]; then
    print_image $selected
fi 
echo 
echo "Let rock it off~"
echo "✐ + ⌛" 
