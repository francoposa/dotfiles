
" text input stuff
set backspace=indent,eol,start  " https://stackoverflow.com/questions/11560201/backspace-key-not-working-in-vim-vi
set ts=4 sw=4 expandtab smarttab " https://vi.stackexchange.com/questions/4244/what-is-softtabstop-used-for
filetype indent on


" syntax and view stuff
set number
set cursorline

syntax on
set background=dark
colorscheme monokai
let g:solarized_termcolors=256
let g:solarized_termtrans=1

let python_highlight_all = 1

au BufRead,BufNewFile  match BadWhitespace /\s\+$/

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"split navigations
command! -nargs=1 Vres :vertical resize <args>

set splitbelow
set splitright

map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Specify a directory for plugins
call plug#begin('~/.vim/vim-plug')

Plug 'https://github.com/ycm-core/YouCompleteMe.git'

Plug 'sheerun/vim-polyglot'

" Initialize plugin system
call plug#end()
