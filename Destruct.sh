if [[ "$OSTYPE" == "linux-gnu" ]]; then
        echo "Destroying Linux Setup"
        outfile=~/.bashrc
elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Destroying Mac OS Setup"
        outfile=~/.bash_profile
else
        echo "Unknown OS Type :("
        exit
fi
dividerString="!---!"

### Colors Setup

RED='\033[0;31m'
GREEN='\033[0;32m'
NOCOLOR='\033[0m'

# function DestructScripts {
#
#   for filename in .bash_mb*; do
#
#     #First check the file has a valid "auto_add" feaute
#     if grep -q $dividerString "$filename"; then
#
#       #Split the file on its comments since they are always commented
#       oldIFS="$IFS"
#       IFS=$'\n#' arr=($(<"$filename"))
#       IFS="$oldIFS"
#
#       if [[ "${arr[4]}" =~ $dividerString ]]
#       then
#          #Make an array to store the concatinated string
#          mashOfCharactersToMatchInFile=""
#
#          #Compres the info needed into one string with no whitesapce
#          for i in {1..3}; do
#             currentLineNoWhiteSpace=$(echo "${arr[$i]}" | sed 's/ //g' | xargs)
#
#             #This is where it mashes the characters we want into a large string to compare later
#             printf -v mashOfCharactersToMatchInFile "%s%s" $mashOfCharactersToMatchInFile $currentLineNoWhiteSpace
#             printf "$mashOfCharactersToMatchInFile\n"
#
#         done
#
#         # echo $(sed -e "s|$mashOfCharactersToMatchInFile||g" -i $outfile)
#
#         #Gather entire bash profile into single string no whitespace
#         bashProfStandin=$(tr -d ' \t\n\r\f' <$outfile)
#
#         #See if the text in question exists in the file
#         if [[ $bashProfStandin == *"$mashOfCharactersToMatchInFile"* ]]; then
#           printf "Removing: ${RED}$filename${NOCOLOR}\n"
#         else
#           printf "Removal Complete for ${GREEN}$filename${NOCOLOR}\n"
#
#           # for i in {1..3}; do
#           #    echo "${arr[$i]}" >> $outfile
#           # done
#         fi
#       fi
#     fi
#   done

  # > $outfile
  # source $outfile
  # echo "Reloading..."
  # exec bash
  # source $outfile

  function DestructScripts {
    #
    # for filename in .bash_mb*; do
    #
    #   #First check the file has a valid "auto_add" feaute
    #   if grep -q $dividerString "$filename"; then
    #
    #     #Split the file on its comments since they are always commented
    #     oldIFS="$IFS"
    #     IFS=$'\n#' arr=($(<"$filename"))
    #     IFS="$oldIFS"
    #
    #     if [[ "${arr[4]}" =~ $dividerString ]]
    #     then
    #        #Make an array to store the concatinated string
    #        mashOfCharactersToMatchInFile=""
    #
    #        #Compres the info needed into one string with no whitesapce
    #        for i in {1..3}; do
    #           currentLineNoWhiteSpace=$(echo "${arr[$i]}" | sed 's/ //g' | xargs)
    #
    #           #This is where it mashes the characters we want into a large string to compare later
    #           printf -v mashOfCharactersToMatchInFile "%s%s" $mashOfCharactersToMatchInFile $currentLineNoWhiteSpace
    #           printf "$mashOfCharactersToMatchInFile\n"
    #
    #       done
    #
    #       # echo $(sed -e "s|$mashOfCharactersToMatchInFile||g" -i $outfile)
    #
    #       #Gather entire bash profile into single string no whitespace
    #       bashProfStandin=$(tr -d ' \t\n\r\f' <$outfile)
    #
    #       #See if the text in question exists in the file
    #       if [[ $bashProfStandin == *"$mashOfCharactersToMatchInFile"* ]]; then
    #         printf "Removing: ${RED}$filename${NOCOLOR}\n"
    #       else
    #         printf "Removal Complete for ${GREEN}$filename${NOCOLOR}\n"
    #
    #         # for i in {1..3}; do
    #         #    echo "${arr[$i]}" >> $outfile
    #         # done
    #       fi
    #     fi
    #   fi


    # So the destruct needs to do a few things

    # First it needs to delete the line from the bash bash_profile
    sed -i -e '/BashScripts/d' $outfile

    # Then it needs to delete the gitDownloadScripts folder

    # Then it needs to git files I have downloaded


}

DestructScripts

#Must be startedt with <<. ./Destruct.sh>> from the command line!!! If not autoreload does not work
