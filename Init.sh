if [[ "$OSTYPE" == "linux-gnu" ]]; then
        echo "Set OS to Linux"
        bashProfileOrRc=~/.bashrc
elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Set OS to MAC OS"
        bashProfileOrRc=~/.bash_profile
else
        echo "Unknown OS Type :("
        exit
fi

dividerString="!---!"
collectiveBashFile=~/BashScripts/.bash_loader

### Colors Setup

RED='\033[0;31m'
GREEN='\033[0;32m'
NOCOLOR='\033[0m'

function InitScripts {

  for filename in .bash_[^l]*; do
    # Does this regex to ignore sourcing the collective file

    #First check the file has a valid "auto_add" feaute
    if grep -q $dividerString "$filename"; then

      #Split the file on its comments since they are always commented
      oldIFS="$IFS"
      IFS=$'\n#' arr=($(<"$filename"))
      IFS="$oldIFS"

      if [[ "${arr[4]}" =~ $dividerString ]]
      then

         #Make an array to store the concatinated string
         mashOfCharactersToMatchInFile=""

         #Compres the info needed into one string with no whitesapce
         for i in {1..3}; do
            currentLineNoWhiteSpace=$(echo "${arr[$i]}" | sed 's/ //g' | xargs)
            printf -v mashOfCharactersToMatchInFile "%s%s" $mashOfCharactersToMatchInFile $currentLineNoWhiteSpace
        done

        #Gather entire bash profile into single string no whitespace
        bashProfStandin=$(tr -d ' \t\n\r\f' <$collectiveBashFile)

        #See if the text in question exists in the file
        if [[ $bashProfStandin == *"$mashOfCharactersToMatchInFile"* ]]; then
          printf "Setup complete: ${GREEN}$filename${NOCOLOR}\n"
        else
          printf "File Not Initilized - Adding ${RED}$filename${NOCOLOR}\n"

          for i in {1..3}; do
             echo "${arr[$i]}" >> $collectiveBashFile
          done
        fi
      fi
    fi
  done

  echo "source $collectiveBashFile" >> $bashProfileOrRc

  . $bashProfileOrRc
  echo "Reloading..."

  echo "Downloading git repos..."

  # This calls the script that generates the terminal windows to download git
  # repos into the folder I want them
  if [ -f ~/BashScripts/.bash_download ]; then
    source ~/BashScripts/.bash_download
  fi
}

InitScripts

#Must be startedt eith <<. ./Init.sh>> from the command line!!! If not autoreload does not work
