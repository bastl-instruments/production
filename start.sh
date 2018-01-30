#! /bin/bash

DATADIR='data'
LOGFILE='log'
declare -r TAB="`echo -e "\t"`"

function restart {
  ScriptLoc=$(readlink -f "$0")
  exec "$ScriptLoc"
}

function checkTools {
  if ! [[ $(command -v dialog) ]]; then
    echo "Dependency 'Dialog' cannot be found!";
    clear
    exit 1;
  fi
  if ! [[ $(command -v avrdude) ]]; then
    dialog --title 'Dependency Missing' --msgbox 'Cannot find avrdude' 0 0;
    clear
    exit 1;
  fi
}

function update() {
  errormessage=`git pull 2>&1`
  if [[ $? == 0 ]]; then
    dialog --title "Updated" --msgbox "$errormessage\n\nPress OK to restart programm" 0 0
    restart
  else
    dialog --title "Error" --msgbox "Update Failed with:\n\n$errormessage" 0 0
    main_menu
  fi
}

function main_menu {
  operation=`dialog --stdout --menu "Choose an operation" 10 30 10 "0" "Update" "1" "Run Job"`
  case $operation in
  0)
    update
    ;;
  1)
    job_menu
    ;;
  esac
}

function job_menu {
  let i=0
  W=()
  all=$(ls $DATADIR | grep .job 2>&1)
  while read -r line; do
    let i=$i+1
    W+=($i "$line")
  done < <( echo "$all" )
  selected_index=$(dialog --title "Available Jobs" --menu "Chose job to run" 30 80 25 "${W[@]}" 3>&2 2>&1 1>&3)
  selected_filename="${W[$selected_index*2-1]}"
  run_job $selected_filename
}

function run_job {
  #dialog --msgbox "Running Job '$1'" 0 0
  #$(avrdude 2>&1) | dialog --programbox 0 0
  commands=('avrdude -?' 'sleep 1' 'avrdude -c123' 'sleep 5' 'echo "abc"')
  names=("Some Flashing" "Something Else" "Will fail" "long" "last")
  length=${#commands[*]}

  for (( i = 0; i < $length ; i++ )); do
    thisCommand=${commands[$i]}
    thisName=${names[$i]}
    text="$text\n$thisName"
    dialog --title "Running $1" --no-collapse --infobox "$text" 10 50
    output=`$thisCommand > $LOGFILE 2>&1 `
    if [[ $? != 0 ]]; then
      dialog --and-widget --begin 20 30 --title "Command failed" --textbox "$LOGFILE" 10 80
      job_menu
    fi
  done

  job_menu
}

checkTools
main_menu
