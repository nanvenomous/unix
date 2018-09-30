grip='/usr/local/bin/grip'
file='/home/naruto/Documents/agenda.md'
port='6129'

chrome='/usr/bin/google-chrome-stable'

# kills the current process on that port
command lsof -n -i4TCP:6129 | grep LISTEN | awk '{ print $2 }' | xargs kill

# run grip to start listening on the port
command $grip $file $port &

# launch google chrome to the specific port
command $chrome --new-window http://localhost:6129/ &
