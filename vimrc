set autoindent expandtab tabstop=4 shiftwidth=4
set number
set backspace=indent,eol,start
syntax on
inoremap <S-Tab> <C-V><Tab>

set nocompatible
set encoding=utf-8

colorscheme codedark
let g:airline_theme = 'codedark'

" Color 81. character in line to visualize long lines
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

set linebreak		" Break lines at word (requires Wrap lines)
set showbreak=+++ 	" Wrap-broken line prefix
set showmatch		" Highlight matching brace
set showcmd	    	" Show last command on right
set cursorline 		" Highlight current line

set hlsearch		" Highlight all search results
set smartcase		" Enable smart-case search
set ignorecase		" Always case-insensitive
set incsearch		" Searches for strings incrementally

set cindent		" Use 'C' style program indenting
set shiftwidth=4	" Number of auto-indent spaces
set smartindent		" Enable smart-indent
set smarttab		" Enable smart-tabs
set wrap 		" Wrap lines

set ruler			" Show row and column ruler information
set undolevels=1000		" Number of undo levels

"""""
""""" Key mapping
"""""
" Move lines using Ctrl+Up/Down in normal, insert and visual modes
nnoremap <C-Up> :m-2<CR>
nnoremap <C-Down> :m+<CR>
inoremap <C-Up> <Esc>:m-2<CR>
inoremap <C-Down> <Esc>:m+<CR>
vnoremap <C-Up> :m '<-2<CR>gv=gv
vnoremap <C-Down> :m '>+1<CR>gv=gv
" or Ctrl+j/k
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Linting for c99
let g:ale_completion_enabled = 1
let g:ale_linters = {'c': ['gcc', 'clangtidy', 'clang-format']}
let g:ale_c_gcc_executable = 'gcc'
let g:ale_c_gcc_options = '-std=c99 -Wall -Wextra -pedantic'
let g:ale_c_clang_executable = 'gcc'
let g:ale_c_clang_options = '-std=c99 -Wall -Wextra -pedantic'
let g:ale_c_clangtidy_executable = 'clang-tidy'
let g:ale_c_clangtidy_options = '-std=c99 -Wall -Wextra -pedantic'
