set number relativenumber

set mouse=a

" makes the local clipboard the global clipboard
set clipboard=unnamedplus

" saves clipboard when exiting vim (has xsel as dependency)
autocmd VimLeave * call system("xsel -ib", getreg('+'))
