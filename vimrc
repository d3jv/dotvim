set autoindent expandtab tabstop=4 shiftwidth=4
set number
set backspace=indent,eol,start
filetype indent plugin on
syntax on
inoremap <S-Tab> <C-V><Tab>

set nocompatible
set encoding=utf-8

" Color 81. character in line to visualize long lines
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

set completeopt=menuone,noinsert,noselect,popuphidden
set completepopup=highlight:Pmenu,border:off

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

set updatetime=300
set signcolumn=yes

packloadall | silent! helptags ALL

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

" Replace selected text in the whole file
vnoremap <C-r> "hy:%s!<C-r>h!!g<left><left>

"""""
""""" Colours
"""""
" Use truecolor in the terminal, when it is supported
if has('termguicolors')
  set termguicolors
endif

set background=dark
colorscheme gruvbox

" Most of the following settings up to asciidoctor are from
" here: https://github.com/OmniSharp/omnisharp-vim/wiki/Example-config

"""""
""""" ALE
"""""
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_sign_info = ''
let g:ale_sign_style_error = ''
let g:ale_sign_style_warning = ''

" Use COC for LSP and completion
let g:ale_completion_enabled = 0
let g:ale_disable_lsp = 1

" let g:ale_floating_preview = 1
" let g:ale_hover_to_floating_preview = 1

let g:ale_virtualtext_cursor = 'current'

let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_linters = {
\ 'c': ['gcc', 'clangtidy', 'clang-format'],
\ 'cs': ['OmniSharp'],
\ 'rust': ['analyzer', 'cargo']
\}

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\ '*': ['trim_whitespace'],
\ 'rust': ['rustfmt']
\}

let g:ale_c_gcc_executable = 'gcc'
let g:ale_c_gcc_options = '-std=c99 -Wall -Wextra -pedantic'
let g:ale_c_clang_executable = 'gcc'
let g:ale_c_clang_options = '-std=c99 -Wall -Wextra -pedantic'
let g:ale_c_clangtidy_executable = 'clang-tidy'
let g:ale_c_clangtidy_options = '-std=c99 -Wall -Wextra -pedantic'

let g:ale_rust_analyzer_executable = 'rust-analyzer'

"""""
""""" COC
"""""
let g:coc_global_extensions = [
\ 'coc-clangd',
\ 'coc-cmake',
\ 'coc-css',
\ 'coc-docker',
\ 'coc-html',
\ 'coc-html-css-support',
\ 'coc-json',
\ 'coc-rust-analyzer',
\ 'coc-sh',
\ 'coc-tsserver',
\]

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction


" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Trigger code action for the current cursor position
nmap <leader>a  <Plug>(coc-codeaction-cursor)

" Override coc bindings with omnisharp.vim in .cs files
augroup omnisharp_commands
  autocmd!

  autocmd FileType cs nmap <silent> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> gy <Plug>(omnisharp_go_to_type_definition)
  autocmd FileType cs nmap <silent> gi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> gr <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> K  <Plug>(omnisharp_documentation)
  autocmd FileType cs xmap <silent> <leader>f <Plug>(omnisharp_code_format)
  autocmd FileType cs nmap <silent> <leader>f <Plug>(omnisharp_code_format)
  autocmd FileType cs nmap <silent> <leader>a <Plug>(omnisharp_code_actions)
  autocmd FileType cs nmap <silent> <leader>rn <Plug>(omnisharp_rename)

augroup END

nnoremap <expr> <c-d> s:scroll_cursor_popup(1) ? '<esc>' : '<c-d>'
nnoremap <expr> <c-u> s:scroll_cursor_popup(0) ? '<esc>' : '<c-u>'

function s:find_cursor_popup(...)
  let radius = get(a:000, 0, 2)
  let srow = screenrow()
  let scol = screencol()

  " it's necessary to test entire rect, as some popup might be quite small
  for r in range(srow - radius, srow + radius)
    for c in range(scol - radius, scol + radius)
      let winid = popup_locate(r, c)
      if winid != 0
        return winid
      endif
    endfor
  endfor

  return 0
endfunction

function s:scroll_cursor_popup(down)
  let winid = s:find_cursor_popup()
  if winid == 0
    return 0
  endif

  let pp = popup_getpos(winid)
  call popup_setoptions( winid,
        \ {'firstline' : pp.firstline + ( a:down ? 1 : -1 ) } )

  return 1
endfunction

"""""
""""" Asyncomplete
"""""
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0

"""""
""""" Sharpenup
"""""
let g:OmniSharp_server_use_net6 = 1

let g:sharpenup_statusline_opts = { 'Text': '%s (%p/%P)' }
let g:sharpenup_statusline_opts.Highlight = 0

augroup OmniSharpIntegrations
  autocmd!
  autocmd User OmniSharpProjectUpdated,OmniSharpReady call lightline#update()
augroup END

"""""
""""" Lightline
"""""
set laststatus=2	"Makes the line work
set noshowmode		"Don't show the mode since it's already in line

let g:lightline = {
\ 'colorscheme': 'gruvbox',
\ 'active': {
\   'right': [
\     ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],
\     ['lineinfo'], ['percent'],
\     ['fileformat', 'fileencoding', 'filetype', 'sharpenup']
\   ]
\ },
\ 'inactive': {
\   'right': [['lineinfo'], ['percent'], ['sharpenup']]
\ },
\ 'component': {
\   'sharpenup': sharpenup#statusline#Build()
\ },
\ 'component_expand': {
\   'linter_checking': 'lightline#ale#checking',
\   'linter_infos': 'lightline#ale#infos',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok'
  \  },
  \ 'component_type': {
  \   'linter_checking': 'right',
  \   'linter_infos': 'right',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'right'
\  }
\}

" Use unicode chars for ale indicators in the statusline
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "

"""""
""""" OmniSharp
"""""
let g:OmniSharp_popup_position = 'peek'
let g:OmniSharp_popup_options = {
\ 'highlight': 'Normal',
\ 'padding': [0],
\ 'border': [1],
\ 'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
\ 'borderhighlight': ['ModeMsg']
\}

let g:OmniSharp_popup_mappings = {
\ 'sigNext': '<C-n>',
\ 'sigPrev': '<C-p>',
\ 'pageDown': ['<C-f>', '<PageDown>'],
\ 'pageUp': ['<C-b>', '<PageUp>']
\}

let g:OmniSharp_highlight_groups = {
\ 'ExcludedCode': 'NonText'
\}

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
"let g:asciidoctor_folding = 1
"let g:asciidoctor_fold_options = 1

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
