#!/bin/bash

# lists relevant history to get commands
history="${HOME}/.bash_history"
toIgnore='^c$|^r$|^t$|^up$|^cd |^cd$|^exit$'
endOfFile='G'

vim -s <(echo "${endOfFile}") <(cat "${history}" | tail -70 | grep -Ev "${toIgnore}")

# | awk '{$1=""; print}')
