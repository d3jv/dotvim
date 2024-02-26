set autoindent expandtab tabstop=4 shiftwidth=4
set number
set backspace=indent,eol,start
syntax on
inoremap <S-Tab> <C-V><Tab>

set nocompatible
set encoding=utf-8

colorscheme gruvbox

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

set foldmethod=manual

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
"nnoremap <C-j> :m .+1<CR>==
"nnoremap <C-k> :m .-2<CR>==
"inoremap <C-j> <ESC>:m .+1<CR>==gi
"inoremap <C-k> <ESC>:m .-2<CR>==gi
"vnoremap <C-j> :m '>+1<CR>gv=gv
"vnoremap <C-k> :m '<-2<CR>gv=gv

" Better tab experience
map <leader>tn :tabnew<cr>
map <leader>tm :tabmove
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>

"""""
""""" Linting for c99
"""""
let g:ale_completion_enabled = 1
let g:ale_linters = {
\ 'c': ['gcc', 'clangtidy', 'clang-format'],
\ 'cs': ['OmniSharp']
\}
let g:ale_c_gcc_executable = 'gcc'
let g:ale_c_gcc_options = '-std=c99 -Wall -Wextra -pedantic'
let g:ale_c_clang_executable = 'gcc'
let g:ale_c_clang_options = '-std=c99 -Wall -Wextra -pedantic'
let g:ale_c_clangtidy_executable = 'clang-tidy'
let g:ale_c_clangtidy_options = '-std=c99 -Wall -Wextra -pedantic'

"""""
""""" AsciiDoctor settings copypasted from the plugin repo
"""""
" HTML
let g:asciidoctor_executable = 'asciidoctor'
"let g:asciidoctor_extensions = ['asciidoctor-diagram', 'asciidoctor-rouge']

" PDF
let g:asciidoctor_pdf_executable = 'asciidoctor-pdf'
"let g:asciidoctor_pdf_extensions = ['asciidoctor-diagram']

" folding
let g:asciidoctor_folding = 1
let g:asciidoctor_fold_options = 1

" syntax highlighting for languages in [source] blocks
let g:asciidoctor_fenced_languages = ['python', 'c', 'cs'] " TODO: add more

" Function to create buffer local mappings and add default compiler
fun! Asciidoctor()
    compiler asciidoctor2pdf
endfun

" Call AsciidoctorMappings for all `*.adoc` and `*.asciidoc` files
augroup asciidoctor
    au!
    au BufEnter *ad,*.adoc,*.asciidoc call Asciidoctor()
augroup END

"""""
""""" NERDTree configuration
"""""

nnoremap <leader>n :NERDTreeFocus<CR>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | wincmd p | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

"""""
""""" Fix bracketed paste in tmux
"""""
if &term =~ "screen"                                                   
    let &t_BE = "\e[?2004h"                                              
    let &t_BD = "\e[?2004l"                                              
    exec "set t_PS=\e[200~"                                              
    exec "set t_PE=\e[201~"                                              
endif
