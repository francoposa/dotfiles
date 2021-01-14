"
" text input stuff
"
set backspace=indent,eol,start  " https://stackoverflow.com/questions/11560201/backspace-key-not-working-in-vim-vi
set ts=4 sw=4 expandtab smarttab " https://vi.stackexchange.com/questions/4244/what-is-softtabstop-used-for
filetype indent on


"
" syntax and view stuff
"
set number
set cursorline

syntax on
set background=dark
colorscheme monokai
let g:solarized_termcolors=256
let g:solarized_termtrans=1

let python_highlight_all = 1

au BufRead,BufNewFile  match BadWhitespace /\s\+$/


"
"split settings, management & navigation
"

set splitbelow
set splitright

" move splits with Ctrl-key instead of Ctrl-w-key - won't work when in netrw
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" vertical resize command shortening
command! -nargs=1 Vres :vertical resize <args>


"
" YouCompleteMe
"

" YCM settings
let g:ycm_language_server =
\ [
\   {
\     'name': 'rust',
\     'cmdline': ['rust-analyzer'],
\     'filetypes': ['rust'],
\     'project_root_files': ['Cargo.toml']
\   }
\ ]

" YCM keybindings

" https://vi.stackexchange.com/questions/13674/make-youcompleteme-open-definition-in-vertical-split-even-if-buffer-is-not-saved
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" Open definition in new vertical split
map <leader>ds :vsp <CR>:exec("YcmCompleter GoToDefinitionElseDeclaration")<CR>
" Open definition in new tab
map <leader>dt :tab split<CR>:exec("YcmCompleter GoToDefinitionElseDeclaration")<CR>


let g:rustfmt_autosave = 1


"
" vim-plug
"

" Specify a directory for plugins
call plug#begin('~/.vim/vim-plug')

Plug '907th/vim-auto-save'

Plug 'https://github.com/ycm-core/YouCompleteMe.git'

Plug 'sheerun/vim-polyglot'

Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

Plug 'rust-lang/rust.vim'

" Initialize plugin system
call plug#end()
