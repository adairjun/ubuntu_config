#!/usr/bin/env bash

# Renders a text based list of options that can be selected by the
# user using up, down and enter keys and returns the chosen option.
#
#   Arguments   : list of options, maximum of 256
#                 "opt1" "opt2" ...
#   Return value: selected index (0 for opt1, 1 for opt2 ...)

sshOptions=("11111111" \
"22222222" \
"33333333" \
#"44444444" \
#"55555555" \
#"66666666" \
#"77777777" \
#"88888888" \
#"99999999" \
#"aaaaaaaa" \
#"bbbbbbbb" \
#"cccccccc" \
#"dddddddd" \
#"eeeeeeee" \
#"ffffffff" \
#"gggggggg" \
#"hhhhhhhh" \
#"iiiiiiii" \
#"jjjjjjjj" \
#"kkkkkkkk" \
#"llllllll" \
#"mmmmmmmm" \
#"nnnnnnnn" \
#"oooooooo" \
#"pppppppp" \
#"qqqqqqqq" \
#"rrrrrrrr" \
#"ssssssss" \
#"tttttttt" \
#"uuuuuuuu" \
#"vvvvvvvv" \
#"wwwwwwww" \
#"xxxxxxxx" \
#"yyyyyyyy" \
#"zzzzzzzz" \
#"01010101" \
#"02020202" \
#"03030303" \
#"04040404" \
#"05050505" \
#"06060606" \
#"07070707" \
#"08080808" \
#"09090909" \
#"a0a0a0a0" \
#"a1a1a1a1" \
#"a2a2a2a2" \
#"a3a3a3a3" \
#"a4a4a4a4" \
#"a5a5a5a5" \
#"a6a6a6a6" \
#"a7a7a7a7" \
#"a8a8b8b8" \
#"a9a9a9a9" \
#"b0b0b0b0" \
#"b1b1b1b1" \
#"b2b2b2b2" \
#"b3b3b3b3" \
#"b4b4b4b4" \
#"b5b5b5b5" \
#"b6b6b6b6" \
#"b7b7b7b7" \
#"b8b8b8b8" \
#"b9b9b9b9" \
#"c0c0c0c0" \
#"c1c1c1c1" \
#"c2c2c2c2" \
#"c3c3c3c3" \
#"c4c4c4c4" \
#"c5c5c5c5" \
#"c6c6c6c6" \
#"c7c7c7c7" \
#"c8c8c8c8" \
#"c9c9c9c9" \
#"d0d0d0d0" \
#"d1d1d1d1" \
#"d2d2d2d2" \
#"d3d3d3d3" \
#"d4d4d4d4" \
#"d5d5d5d5" \
#"d6d6d6d6" \
#"d7d7d7d7" \
#"d8d8d8d8" \
#"d9d9d9d9" \
"--------")

function select_option {

    # little helpers for terminal print control and key input
    ESC=$( printf "\033")
    cursor_blink_on()  { printf "$ESC[?25h"; }
    cursor_blink_off() { printf "$ESC[?25l"; }
    cursor_to()        { printf "$ESC[$1;${2:-1}H"; }
    print_option()     { printf "   $1 "; }
    print_selected()   { printf "  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()   { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()        { read -s -n3 key 2>/dev/null >&2
                         if [[ $key = $ESC[A ]]; then echo up;    fi
                         if [[ $key = $ESC[B ]]; then echo down;  fi
                         if [[ $key = ""     ]]; then echo enter; fi; }

    # initially print empty new lines (scroll down if at bottom of screen)
    for op in "${sshOptions[@]}"; do printf "\n"; done

    # determine current screen position for overwriting the options
    local lastrow=`get_cursor_row`
	#echo $lastrow
    local startrow=0
    local windowlength=$(($lastrow - 3))
	# echo $windowlength
    # the position begin with 1 and end with lastrow
    if [ $windowlength -gt  ${#sshOptions[@]} ]; then
    	startrow=$(($lastrow - ${#sshOptions[@]}))
    else
    	startrow=3
    fi
	# echo $startrow
	
    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

	# backup moveFlag
	local moveFlag=0
	# echo $moveFlag
	innerArray=("${sshOptions[@]}")
    local selected=0
	# echo ${innerArray[0]}
	# innerArray[0]="111"
	# echo ${innerArray[0]}
	# echo $selected
    while true; do
        # print options by overwriting the last lines
        local idx=0
        for op in "${innerArray[@]}"; do
            cursor_to $(($startrow + $idx))
            if [ $idx -eq $selected ]; then
                print_selected "$op"
            else
                print_option "$op"
            fi
            ((idx++))
        done

       # user key control
        case `key_input` in
            enter) break;;
            up)    ((selected--));
				# 到头了，那么滚动 innerArray列表
                if [ $selected -lt 0 ]; then 
					if [ $moveFlag -gt 0 ]; then
						# 循环处理，把 innerArray 改一下
						((moveFlag--))
						local iter=0
						while [ $iter -lt $((${#sshOptions[@]} - $moveFlag)) ]
						do
							innerArray[$iter]=${sshOptions[$(($moveFlag + $iter))]}
							((iter++))
						done
					fi	
					selected=0
				fi;;
            down)  ((selected++));
				# 到尾了，也滚动 opt 列表
                if [ $selected -ge ${#innerArray[@]} ]; then 
					if [ $moveFlag -lt ${#sshOptions[@]} ]; then
						# 循环处理，把 innerArray 改一下
						((moveFlag++))
						local iter=0
						while [ $iter -lt $((${#sshOptions[@]} - $moveFlag)) ]
						do
							innerArray[$iter]=${sshOptions[$(($moveFlag + $iter))]}
							((iter++))
						done
					fi
				fi;;
        esac
    done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    return $selected
}

function select_opt {
    select_option 1>&2
    local result=$?
    echo $result
    return $result
}


#echo "oooooooooooooooooooooooooooooooooooooooooooooooo";echo ${#sshOptions[@]}

echo "Select one option using up/down keys and enter to confirm:"
echo

#case `select_opt "${sshOptions[@]}"` in
case `select_opt` in
    0) echo "0";;
    1) echo "1";;
    2) echo "2";;
esac
