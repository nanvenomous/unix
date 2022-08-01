set ignorecase
set clipboard+=unnamedplus   " using system clipboard
call plug#begin()
Plug 'raimondi/delimitmate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
call plug#end()
noremap <silent>gj :+10<CR>
noremap <silent>gk :-10<CR>
noremap <silent>gb <Cmd>call VSCodeNotify('workbench.action.navigateBack')<CR>
noremap <silent>gf <Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>
noremap <silent>gu <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
noremap <silent>gr <Cmd>call VSCodeNotify('editor.action.rename')<CR>
noremap <silent>sf <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>
noremap <silent>tj  <Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>
noremap <silent>tk  <Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>
noremap <silent>to  <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
noremap <silent>tn  <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
noremap <silent>th  <Cmd>call VSCodeNotify('workbench.action.moveEditorLeftInGroup')<CR>
noremap <silent>tl  <Cmd>call VSCodeNotify('workbench.action.moveEditorRightInGroup')<CR>
noremap % <Cmd>call VSCodeNotify('editor.action.jumpToBracket')<CR>
map <esc> :noh<CR>
nnoremap * :keepjumps normal! mi*`i<CR>
