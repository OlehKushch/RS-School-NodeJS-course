#!/usr/bin/env bash

USER_DB_PATH="./users.db"

if [[ -z $1 || $1 == "help" ]]; then
  echo $'Available commands:\n\tadd - to add user\n\tlist - print list fo users\n\tfind - prin serash results'
fi


addUser() {
  read -p "Enter user name: " userName
  read -p "Enter user rol: " userRole
  
  echo "$userName, $userRole" >> $USER_DB_PATH
}

listUsers() {
  n=1
  cat $USER_DB_PATH | while read line; do
    echo "$n. $line"
    n=$((n+1))
  done
}

findUser() {
  read -p "Enter user name: " userName
  result=($(grep  $userName $USER_DB_PATH))
  if [[ ${#result[@]} > 0 ]]; then
    grep $userName $USER_DB_PATH
  else
    echo "User not found"
  fi
}

backup() {  
  cat USER_DB_PATH > "$(date +%F\|%T)-users.db.backup"
}

restore() {
  lastBcp=$(ls *-users.db.backup | tail -1)
  cat lastBcp > USER_DB_PATH
}


case $1 in

  add)
    addUser
    ;;
  list)
    listUsers
    ;;
  find) 
    findUser
    ;;
  backup)
    backup
    ;;
  restore)
    restore
    ;;
  *)
    echo "Unknown command. Use 'help' to learn acceptable commands"
    ;;
esac
