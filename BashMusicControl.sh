# if [ -f ~/BashScripts/.bash_musicControl ]; then
#   source ~/BashScripts/.bash_musicControl
# fi

#!---!

musicModeActive=false

#Spotiofy Utilities
alias gi="osascript ~/BashScripts/AppleScripts/GetSongInfoV2.scpt"
alias plp="osascript -e 'tell app \"Spotify\" to playpause' && gi"
alias nx="handle-next-song"
alias nxHandlerNo="osascript -e 'tell app \"Spotify\" to next track'"
alias nxHandlerGi="osascript -e 'tell app \"Spotify\" to next track' && gi"
alias pv="osascript -e 'tell app \"Spotify\" to previous track' && gi"

function music {
  if [ "$musicModeActive" = false ] ; then
      musicModeActive=true
      PS1="\[\033[0;36m\]\w\[\033[0;32m\]\$(git-branch-prompt)\[\033[0;31m\]\$(put-song-in-ps)\[\033[0m\]$ "
else
      musicModeActive=false
      PS1="\[\033[0;36m\]\w\[\033[0;32m\]\$(git-branch-prompt)\[\033[0m\]$ "
  fi
}
#called below to auto init the shell with PS1 settings
music

function get-song-info {
  osascript ~/BashScripts/AppleScripts/GetSongInfoV2.scpt 2>/dev/null | cut -d":" -f 2
}

function put-song-in-ps {
  local info=`get-song-info`
  if [ "$info" ] ; then printf "::%s" "$info"; fi
}

function handle-next-song {
  if [ "$musicModeActive" = false ] ; then
    nxHandlerNo
  else
    nxHandlerGi
  fi
}
