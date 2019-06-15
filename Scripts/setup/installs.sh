# All installs that we have the repos for
sudo apt-get install chromium-browser
sudo apt-get install vim
sudo apt-get install vim-gnome
sudo apt-get install tree
sudo apt-get install konsole
sudo apt-get install unclutter
sudo apt-get install xsel

# Add all repositories!!
sudo add-apt-repository ppa:deadsnakes/ppa

# Run the installer update
sudo apt update

# Now run the installs
sudo apt install python3.7

# Removals :(
sudo apt purge gnome-shell-extension-desktop-icons

# Python and SysPy
curl https://bootstrap.pypa.io/get-pip.py -o "${HOME}/Downloads/get-pip.py"
sudo apt-get install python3-distutils
sudo python3.7 "${HOME}/Downloads/get-pip.py"
sudo python3.7 -m pip install -i https://test.pypi.org/simple/ syspy
