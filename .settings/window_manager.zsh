if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  startx ~/.xi3
fi
