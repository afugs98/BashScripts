# if [ -f ~/BashScripts/.bash_mbedHelper ]; then
#   source ~/BashScripts/.bash_mbedHelper
# fi

#!---!

#mbed utilities
alias mbs="screen /dev/tty.usbmodem14103 115200"
alias mbc="mbed compile"
alias mbu="cp BUILD/NUCLEO*/GCC_ARM/*.bin /Volumes/NODE*"
alias mbcu="mbc && mbu"
alias mbcus="mbc && mbu && mbs"
