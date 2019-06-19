# if [ -f ~/BashScripts/.bash_gitHelper ]; then
#   source ~/BashScripts/.bash_gitHelper
# fi

#!---!


#Gets the branch name
function git-branch-name {
  git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3
}

#Displays the output like a printf, to be appended
function git-branch-prompt {
  local branch=`git-branch-name`
  if [ $branch ] ; then printf "::%s" $branch; fi
}
#
# if [ -f ~/.git-completion.bash ]; then
#   . ~/.git-completion.bash
# fi

#Git Stuff
alias fd="git diff"
alias fs="git status"
alias fg="git pull"
alias fa="git add"
alias fb="git branch"
alias fc="git commit -m"
alias fch="git checkout"
alias fcb="git checkout -b"
alias fe="git push"
alias fv="git branch"
alias gb="git branch"
alias subup="git submodule update --init --recursive"
alias blog="git-show-better-log"

function git-show-better-log {
  git log --pretty=format:"%ad - %h - %b" --author="Alec Fuglem" --date=format:'%Y-%m-%d %H:%M' | head
}
