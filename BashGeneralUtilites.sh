# if [ -f ~/BashScripts/.bash_generalUtilities ]; then
#   source ~/BashScripts/.bash_generalUtilities
# fi

#!---!

export PATH=~/Library/Python/2.7/bin:$PATH
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"

export ESP_PARTITION_TABLE_ADDR="0x8000"

#Bash Completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

#Random Other Stuff I Found Online
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels

#Various Utilities to Make Life Easier
alias ep="tr ':' '\n' <<< "$PATH""
alias chb="(cd ~ && atom .bash_profile)"
alias rlb=". ~/.bash_profile"
alias cl="clear && clear"
alias nt="open -a /Applications/Utilities/Terminal.app ."
alias lock="pmset displaysleepnow"
alias news="open -a /Applications/Utilities/Terminal.app . && exit"
alias neww="open -a /Applications/Utilities/Terminal.app ."
alias lsl="ls -al"
