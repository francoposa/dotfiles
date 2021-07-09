"nnoremap <SPACE> <Nop>
let mapleader = ","

"
" file & directory navigation
"

" netrw
" https://stackoverflow.com/questions/4170887/vimrc-setting-to-ignore-file-types-in-netrw
let g:netrw_list_hide= '.*\.DS_Store,.*\.idea\/,.*\.mypy_cache\/,*__pycache__\/,.*\.pyc,.*\.pytest_cache\/,.*\.vscode\/'
" https://stackoverflow.com/questions/14665170/netrw-open-files-into-tabs-in-opposite-vertical-window
" tree listing by default
let g:netrw_liststyle=3
" remap leader-enter to fire up the sidebar
"nnoremap <silent> <leader><CR> :leftabove 40vs<CR>:e .<CR>

" NERDTree
let g:NERDTreeWinSize=40
let NERDTreeIgnore=['\.pyc$', '__pycache__$']

" Start NERDTree, unless a file or session is specified, eg. vim -S session_file.vim.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

" Mirror the NERDTree before showing it. This makes it the same on all tabs.
nnoremap <silent> <leader><CR> :NERDTreeMirror<CR>:NERDTreeFocus<CR>

" https://stackoverflow.com/questions/8793489/nerdtree-reload-new-files
autocmd BufEnter NERD_tree_* | execute 'normal R'

" visual autocomplete for command menu
set wildmenu " https://dougblack.io/words/a-good-vimrc.html

"
" text input stuff
"
set spell
setlocal spell

set backspace=indent,eol,start  " https://stackoverflow.com/questions/11560201/backspace-key-not-working-in-vim-vi
set ts=4 sw=4 expandtab smarttab " https://vi.stackexchange.com/questions/4244/what-is-softtabstop-used-for
set updatetime=1000
set completeopt=menuone

filetype plugin indent on

" copy and paste
set clipboard=unnamed " https://stackoverflow.com/questions/11489428/how-to-make-vim-paste-from-and-copy-to-systems-clipboard

"
" syntax and view stuff
"
set number
set cursorline

syntax on
au BufRead,BufNewFile  match BadWhitespace /\s\+$/

set background=dark

" not using solarized currently, but this makes it work in iTerm2
let g:solarized_termcolors=256
let g:solarized_termtrans=1

" gruvbox
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_invert_selection = 0

colorscheme gruvbox

"
" split settings, management & navigation
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
" tab settings, management, & navigation
"

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>


"
" Vim-Markdown
"
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1


"
" Vim Markdown Preview
"
let vim_markdown_preview_github = 1

"
" Vim-Go
"
au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl
au BufRead,BufNewFile *.gohtml set syntax=gohtmltmpl

let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

"
" Rust-Vim
"
let g:rustfmt_autosave = 1


"
" vim-plug
"

" Specify a directory for plugins
call plug#begin('~/.vim/vim-plug')

Plug 'preservim/nerdtree'

Plug 'inkarkat/vim-ReplaceWithRegister'

Plug 'morhetz/gruvbox'

Plug 'tomasiser/vim-code-dark'

Plug 'Raimondi/delimitMate'

Plug 'airblade/vim-gitgutter'

Plug 'sheerun/vim-polyglot'

Plug 'preservim/nerdcommenter'

Plug 'plasticboy/vim-markdown'

Plug 'JamshedVesuna/vim-markdown-preview'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"Plug 'vim-syntastic/syntastic'

"Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

Plug 'rust-lang/rust.vim'

" Initialize plugin system
call plug#end()
