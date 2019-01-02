outfile=~/.bash_profile
dividerString="!---!"



function InitScripts {

  for filename in .bash_*; do

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
        bashProfStandin=$(tr -d ' \t\n\r\f' <$outfile)

        #See if the text in question exists in the file
        if [[ $bashProfStandin == *"$mashOfCharactersToMatchInFile"* ]]; then
          echo "Setup of complete: $filename"
        else
          echo "File Not Contains the Initializer - Need to add the info to the file"

          for i in {1..3}; do
             echo "${arr[$i]}" >> $outfile
          done




        fi


      fi
    fi


  done
  
  #Reload the current bash profile
  source ~/.bash_profile
  echo "Reloading..."
}

InitScripts
