# if [ -f ~/BashScripts/.bash_easyesp ]; then
#   source ~/BashScripts/.bash_easyesp
# fi

#!---!


#If the disk image is not mounted do that first

if ! mount | grep "on /Volumes/case-sensitive" > /dev/null; then
  if [ -f /Users/afuglem/esp/case-sensitive.dmg ]; then
    hdiutil attach /Users/afuglem/esp/case-sensitive.dmg > /dev/null
    echo "case-sensitive.dmg was mounted"
  fi
fi

function run-easy-esp {
  local espPort

  echo "Choose the serial port"
  local ports=`ls /dev/tty.* | grep "usb" | cut -d"." -f 2;`
  choices=( $ports )
  local ports=`ls /dev/tty.* | grep "USB" | cut -d"." -f 2;`
  choices+=( $ports )

  oldIFS=$IFS
  IFS=$'\n'
  IFS=$oldIFS
  PS3="Port: "
  select espPort in "${choices[@]}"; do
    for item in "${choices[@]}"; do
      if [[ $item == $espPort ]]; then
        break 2
      fi
    done
  done

  #"sprintf" in bash for the actual path
  if [ $espPort ] ; then printf -v espPort '/dev/tty.%s' "$espPort" ; fi
  echo "Set serial port to $espPort"
  export ESPPORT=$espPort

  #Now select the premade configurations
  PS3='Board: '
  options=("ESP-01" "NodeMcu" "ESP32")
  select opt in "${options[@]}"
  do
      case $opt in
          "ESP-01")
              echo "Set board to ESP-01"
              export FLASH_SIZE="8"
              export HOMEKIT_SPI_FLASH_BASE_ADDR="0x7a000"
              export HOMEKIT_DEBUG="1"

              break
              ;;
          "NodeMcu")
              echo "Set board to NodeMcu"
              export FLASH_SIZE="32"
              export HOMEKIT_SPI_FLASH_BASE_ADDR="0x0"
              export HOMEKIT_DEBUG="1"
              export FLASH_MODE=dio

              break
              ;;
          "ESP32")
              echo "Set board to ESP32"

              break
              ;;
          *) echo "invalid option $REPLY";;
      esac
  done

  #And last run the sequence

  read -n 1 -s -r -p "Put Board in Flash Mode (Press any key)"
  echo ""
  make erase_flash

  read -n 1 -s -r -p "Put Board in Flash Mode (Press any key)"
  echo ""
  make flash
}


#Homekit Configuration
export SDK_PATH="~/esp/esp-open-rtos"
export PATH="/Volumes/case-sensitive/esp-open-sdk/xtensa-lx106-elf/bin:$PATH"

export PATH=$PATH:~/esp/xtensa-esp32-elf/bin
export IDF_PATH=~/esp/esp-idf
# export MDF_PATH=~/esp/esp-mdf


#Esp Utilities
alias che="ls /dev/tty.*"
alias mke="make erase_flash"
alias mk="make"
alias mkf="make flash"
alias mkm="make monitor"


alias easy="run-easy-esp"
