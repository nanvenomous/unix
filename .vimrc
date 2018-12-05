set number relativenumber

set mouse=a

" makes the local clipboard the global clipboard
set clipboard=unnamedplus

" saves clipboard when exiting vim (has xsel as dependency)
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" sets tab (display only) to 3 spaces
set shiftwidth=3
set tabstop=3
set softtabstop=3
