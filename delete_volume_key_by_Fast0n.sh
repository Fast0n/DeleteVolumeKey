#!/bin/bash

clear && history -c

echo "Delete volume key by Fast0n"
sleep 0.7
echo ""


function check_devices {

  ./adb devices

  while true; do
    read -p "Il telefono è stato rilevato? [s(si)/n(no)] " sn
    case $sn in
        [Ss]* ) found break;;
		[Yy]* ) found break;;
        [Nn]* ) not_found break;;
        * )
				echo ""
				echo "Si prega di rispondere sì o no."
				echo "";;
    esac
      done

    }

function found {

  echo ""
  pull
  break

}

function not_found {

  echo ""
  check_devices

}

function pull {

  RED='\033[0;31m'
  NC='\033[0m'
  bold=$(tput bold)
  normal=$(tput sgr0)

  ./adb root
  ./adb remount
  mkdir output
  ./adb pull /system/build.prop ./output/
  echo ""
  printf "${bold}build.prop${normal} esportato nella cartella ${RED}output${NC}\n"
  printf "Modifica il file dentro la cartella ${RED}output${NC}\n"
  echo ""

  sleep 2
  check_edit

}

function check_edit {

  while true; do
    read -p "${bold}build.prop${normal} modificato? [s(si)/n(no)] " sn
    case $sn in
        [Ss]* ) edit_true break;;
		[Yy]* ) edit_true break;;
        [Nn]* ) edit_false break;;
        * )
				echo ""
				echo "Si prega di rispondere sì o no."
				echo "";;
    esac
done

    }

function edit_true {

  echo ""

  ./adb push ./output/build.prop /system/build.prop
	./adb shell chmod 644 /system/build.prop

  printf "${RED}E' necessario un riavvio${NC}\n"

  printf "${RED}E' necessario un riavvio${NC} (5sec)\n"
  sleep 1
  printf "${RED}E' necessario un riavvio${NC} (4sec)\n"
  sleep 1
  printf "${RED}E' necessario un riavvio${NC} (3sec)\n"
  sleep 1
  printf "${RED}E' necessario un riavvio${NC} (2sec)\n"
  sleep 1
  printf "${RED}E' necessario un riavvio${NC} (1sec)\n\n"

  ./adb reboot

  printf "Grazie e arrivederci\n\n"
  break

}

function edit_false {

  echo ""
  check_edit

}

check_devices
