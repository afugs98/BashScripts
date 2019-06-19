#!/bin/bash

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

RED='\033[0;31m'
GREEN='\033[0;32m'
NOCOLOR='\033[0m'

function InitScripts {

  currentFullDirPath=$( cd "$(dirname "$0")" ; pwd -P )
  outputLoaderFile=~/BashScripts/.bash_tmp_loader

  # This is where it gets all the files that are "Bash......." to import, done this way to onyl get current dir
  bashSetupFiles=$(find $currentFullDirPath -type f -iname "Bash*.sh" -maxdepth 1)

  # Tests if the loader file exist and creates it if it doesn't
  test -e ${outputLoaderFile} || touch ${outputLoaderFile}

  for currentFile in $bashSetupFiles; do # Not recommended, will break on whitespace

    # The following code inserts this example line for all scripts into the loader
    # if [ -f /Users/afuglem/BashScripts/BashEceHw.sh ]; then
    # 	source /Users/afuglem/BashScripts/BashEceHw.sh
    # fi

    if grep -qxF 'if [ -f '$currentFile' ]; then' ${outputLoaderFile}; then

      printf "${GREEN}Setup Complete for ${NOCOLOR}""$currentFile\n"
    else
      printf "${RED}Setting up ${NOCOLOR}""$currentFile\n"
      echo 'if [ -f '$currentFile' ]; then' >> ${outputLoaderFile}
      echo -e '\tsource '$currentFile >> ${outputLoaderFile}
      echo 'fi' >> ${outputLoaderFile}

    fi
  done

  # Now that the loader is ready, add to the .bash_profile/rc

  # if grep -qxF "'source '$outputLoaderFile" ${bashProfileOrRc}; then
  #   echo "IT EXISTS"
  # fi

  if grep -Fxq "source ${outputLoaderFile}" ${bashProfileOrRc}
  then
    printf "${GREEN}Included loader${NOCOLOR}\n"
  else
    printf "${RED}Adding bash loader to profile/rc...${NOCOLOR}\n"
    echo 'source '$outputLoaderFile >> $bashProfileOrRc
  fi

  echo "Reloading..."
  . $bashProfileOrRc
  #
  # # This is where the script then calls the git downloader
  #
  # echo "Downloading git repos..."
  #
  # # This calls the script that generates the terminal windows to download git
  # # repos into the folder I want them
  # if [ -f ~/BashScripts/.bash_download ]; then
  #   source ~/BashScripts/.bash_download
  # fi
}

InitScripts

exit 1

#Must be startedt eith <<. ./Init.sh>> from the command line!!! If not autoreload does not work
