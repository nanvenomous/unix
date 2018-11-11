#!/bin/bash
HISTFILE=~/.bash_history
set -o history

endOfFile='G'

vim -s <(echo "${endOfFile}") <(history | tail -40 | awk '{$1=""; print}')
