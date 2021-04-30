"nnoremap <SPACE> <Nop>
let mapleader = ","

"
" file & directory navigation
"

" netrw
" https://stackoverflow.com/questions/4170887/vimrc-setting-to-ignore-file-types-in-netrw
let g:netrw_list_hide= '.*\.DS_Store,.*\.idea\/,.*\.mypy_cache\/,.*__pycache__\/,.*\.pyc,.*\.pytest_cache\/,.*\.vscode\/'
" https://stackoverflow.com/questions/14665170/netrw-open-files-into-tabs-in-opposite-vertical-window
" tree listing by default
let g:netrw_liststyle=3
" remap leader-enter to fire up the sidebar
"nnoremap <silent> <leader><CR> :leftabove 40vs<CR>:e .<CR>

" NERDTree
let g:NERDTreeWinSize=40

" Start NERDTree, unless a file or session is specified, eg. vim -S session_file.vim.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

" Mirror the NERDTree before showing it. This makes it the same on all tabs.
nnoremap <silent> <leader><CR> :NERDTreeMirror<CR>:NERDTreeFocus<CR>

" visual autocomplete for command menu
set wildmenu " https://dougblack.io/words/a-good-vimrc.html

"
" text input stuff
"
set spell

set backspace=indent,eol,start  " https://stackoverflow.com/questions/11560201/backspace-key-not-working-in-vim-vi
set ts=4 sw=4 expandtab smarttab " https://vi.stackexchange.com/questions/4244/what-is-softtabstop-used-for
set updatetime=1000
set completeopt=menuone

filetype plugin indent on

" copy and paste
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

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
" COC settings
"

hi CocUnderline cterm=underline gui=underline
hi CocErrorHighlight cterm=underline gui=underline
hi CocWarningHighlight cterm=underline gui=underline
hi CocInfoHighlight cterm=underline gui=underline
hi CocHintHighlight cterm=underline gui=underline

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

" https://vi.stackexchange.com/questions/13674/make-youcompleteme-open-definition-in-vertical-split-even-if-buffer-is-not-saved
map <leader>d <Plug>(coc-definition)
map <leader>dt :tab split<CR>:<C-u>call CocActionAsync('jumpDefinition')<CR>
map <leader>du <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rr <Plug>(coc-rename)


"
" YouCompleteMe
"

" YCM settings
"let g:ycm_language_server =
"\ [
"\   {
"\     'name': 'rust',
"\     'cmdline': ['rust-analyzer'],
"\     'filetypes': ['rust'],
"\     'project_root_files': ['Cargo.toml']
"\   }
"\ ]

" YCM keybindings

"" https://vi.stackexchange.com/questions/13674/make-youcompleteme-open-definition-in-vertical-split-even-if-buffer-is-not-saved
"map <leader>d  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"" Open definition in new vertical split
"map <leader>ds :vsp <CR>:exec("YcmCompleter GoToDefinitionElseDeclaration")<CR>
"" Open definition in new tab
"map <leader>dt :tab split<CR>:exec("YcmCompleter GoToDefinitionElseDeclaration")<CR>

"map <leader>u  :YcmCompleter GoToReferences<CR>
"" Open references in new vertical split
"map <leader>us :vsp <CR>:exec("YcmCompleter GoToReferences")<CR>
"" Open references  in new tab
"map <leader>ut :tab split<CR>:exec("YcmCompleter GoToReferences")<CR>

"
" Syntastic
"
" Recommended settings from README
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0 " Different from suggestion - very slow on open
"let g:syntastic_check_on_wq = 0

"let g:syntastic_python_checkers = ['mypy', 'pylint']



"
" PyMode
" Was using only for the linters - the debugging is broken
" Now not using at all, since it doesn't support MyPy. Switched to Syntastic
"let g:pymode_virtualenv_path = $VIRTUAL_ENV
"autocmd BufWritePost *.py PymodeLint

"
" Vim-Markdown
"
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

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

Plug 'morhetz/gruvbox'

Plug 'tomasiser/vim-code-dark'

Plug 'Raimondi/delimitMate'

Plug 'airblade/vim-gitgutter'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Plug 'https://github.com/ycm-core/YouCompleteMe.git'

Plug 'sheerun/vim-polyglot'

Plug 'preservim/nerdcommenter'

Plug 'plasticboy/vim-markdown'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"Plug 'vim-syntastic/syntastic'

"Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

Plug 'rust-lang/rust.vim'

" Initialize plugin system
call plug#end()
