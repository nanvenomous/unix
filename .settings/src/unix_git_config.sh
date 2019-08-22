cd "${HOME}"
alias cfg='/usr/bin/git --git-dir=$HOME/.unx/ --work-tree=$HOME'
git clone --bare 'https://github.com/mrgarelli/unix.git' $HOME/.unx
cfg checkout
# may need to fix conflicts by moving files
cfg config --local status.showUntrackedFiles no
