#! /bin/bash

DATADIR='data'
TEMPLATEDIR='templates'
LOGFILE='log'
declare -r TAB="`echo -e "\t"`"

function restart {
  ScriptLoc=$(readlink -f "$0")
  exec "$ScriptLoc"
}

function checkTools {
  if ! [[ $(command -v dialog) ]]; then
    echo "Dependency 'dialog' cannot be found!";
    exit 1;
  fi
  if ! [[ $(command -v avrdude) ]]; then
    dialog --title 'Dependency Missing' --msgbox 'Cannot find avrdude' 10 50;
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
  operation=`dialog --stdout --menu \
      "Choose an operation" 10 40 10 \
      "0" "Load Updates from Git"\
      "1" "Run Job"\
      "2" "Show Log of last Command"`
  if [[ $? == 0 ]]; then
    case $operation in
    0)
      update
      ;;
    1)
      job_menu
      ;;
    2)
      show_log
      ;;
    esac
  else
    clear
    exit
  fi
}

function show_log {
  dialog --title "Recent Command Log" --textbox "$LOGFILE" 30 80
  main_menu
}

function job_menu {
  let i=0
  W=()
  all=$(ls $DATADIR | grep "\.job" 2>&1)
  while read -r line; do
    let i=$i+1
    W+=($i "$line")
  done < <( echo "$all" )
  selected_index=$(dialog --title "Available Jobs" --menu "Choose job to run" 30 80 25 "${W[@]}" 3>&2 2>&1 1>&3)
  if [[ $? == 0 ]]; then
    selected_filename="${W[$selected_index*2-1]}"
    run_job $selected_filename
  else
    main_menu
  fi
}

function run_job {

  jobfile="$DATADIR/$1"
  source "$jobfile"

  text=""
  for (( i = 0; i < ${#commands[*]} ; i++ )); do
    thisCommand=${commands[$i]}
    thisName=${names[$i]}
    text="$text\n$thisName"
    dialog --title "Running $1" --infobox "$text" 10 50
    echo "COMMAND: $thisCommand" > $LOGFILE; echo "---------------" >> $LOGFILE
    output=`$thisCommand >> $LOGFILE 2>&1`
    if [[ $? != 0 ]]; then
      dialog --title "Command failed" --textbox "$LOGFILE" 30 80
      job_menu
    fi
  done

  dialog --yesno "Job Succeeded.\nRun again?" 10 30
  if [[ $? == 0 ]]; then
      run_job $1
  fi
  job_menu
}

checkTools
main_menu
