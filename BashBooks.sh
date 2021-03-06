# if [ -f ~/BashScripts/.bash_books ]; then
#   source ~/BashScripts/.bash_books
# fi

#!---!

function make-books-options {
  local books=`ls /Users/afuglem/Books;`
  bookChoices=( $books )

PS3="Book choice: "
  select bookChoice in "${bookChoices[@]}"; do
    for item in "${bookChoices[@]}"; do
      if [[ $item == $bookChoice ]]; then
        break 2
      fi
    done
  done

  open -n /Users/afuglem/Books/$bookChoice
}


alias books="make-books-options"
