set nonumber nolist showtabline=0 foldcolumn=0"
set clipboard+=unnamedplus
autocmd TermOpen * normal G
map # ^
map q :qa!<CR>
"silent write! /tmp/kitty_scrollback_buffer | te cat /tmp/kitty_scrollback_buffer -
