" General Settings

set encoding=utf-8
set nocompatible
set synmaxcol=1024                " Speed up vim, no syntax after 1024 chars.
set shellslash                    " Use / instead of \ in Windows
set wildignorecase
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.rar,*.tar.*
set hidden                        " Change buffer - without saving
set whichwrap=b,s,<,>,[,],h,l
set mouse=a
set magic

set linebreak
set colorcolumn=120

set cursorline
set showmode
set relativenumber
set number

set ignorecase
set smartcase
set hlsearch

set switchbuf=usetab
set stal=1

set splitright
set splitbelow

" default tab settings
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

set autoread

" Show invisible characters
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:+
set list

if has("gui_running")
  if has("mac")
    set macligatures
  endif
  set guioptions-=T
  set guioptions-=r
  set guioptions-=l
  set guioptions-=m
  set guioptions+=k
  set guifont=Monaspace\ Argon:h13
endif

" Some extra terminal feature support
if &term =~ '^\%(screen\|tmux\|xterm\)'
  " Italic support
  let &t_ZH= "\<Esc>[3m"
  let &t_ZR= "\<Esc>[23m"

  " Focus events
  let &t_fe = "\<Esc>[?1004h"
  let &t_fd = "\<Esc>[?1004l"
  execute "set <FocusGained>=\<Esc>[I"
  execute "set <FocusLost>=\<Esc>[O"
endif

if &term =~ '^\%(alacritty\|tmux\)'
  set ttymouse=sgr
endif

let g:mapleader = ","

" ============================================================

" Plugins managed by https://github.com/junegunn/vim-plug
call plug#begin()

Plug 'Exafunction/codeium.vim', { 'branch': 'main' }
Plug 'cespare/vim-toml'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'derekwyatt/vim-scala'
Plug 'fatih/vim-go'
Plug 'hashivim/vim-terraform'
Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/vim-lsp-settings'
Plug 'mileszs/ack.vim'
Plug 'morhetz/gruvbox'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'prabirshrestha/vim-lsp'
Plug 'projectfluent/fluent.vim'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'

call plug#end()

" ============================================================

" Themes

set background=dark
let g:gruvbox_italic=1
colorscheme gruvbox

" ============================================================

" Key mappings

" Map copy and paste with system clipboard register
map <C-y> "+y
vmap <C-y> "+y
map <C-p> "+p
vmap <C-p> "+p
nmap Y y$

" open file in same directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Cope
map <leader>co :botright cope<cr>
map <leader>cn :cn<cr>
map <leader>cp :cp<cr>
map <leader>cc :cclose<cr>

" Spell
map <leader>ss :setlocal spell!<cr>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Switch to recent buffer
noremap <leader>b :b#<cr>

" Full path to system clipboard
nmap <silent> <leader>yp :let @+ = expand("%:p")<CR>

" ============================================================

" Plugin settings

let g:ctrlp_map = 'c-0' "vim cannot map ctrl-0, just to turn off ctrl-p which is used to paste from clipboard.
let g:ctrlp_root_markers = ['TAGS', '.ctrlp', '.git', 'requirements.txt', 'package.json']
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
nnoremap <leader>p :CtrlP<cr>

let g:ackprg = 'ag --vimgrep'
nnoremap <leader>a :Ack!<space>
nnoremap <leader>; :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>

let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1
let g:terraform_fmt_on_save = 1
let g:typescript_indent_disable = 1

let g:lsp_settings = {
\  'gopls': {'disabled': v:true},
\  'golangci-lint-langserver': {'disabled': v:true}
\}

" disable diagnostics support
let g:lsp_diagnostics_enabled = 0

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gD <plug>(lsp-diagnostic)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" ============================================================

" Misc settings

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['css', 'javascript', 'json=javascript', 'xml', 'html', 'python', 'java', 'c', 'cpp', 'cs']

" Files that uses 4 space tabs
autocmd Filetype python setlocal shiftwidth=4 tabstop=4 softtabstop=4

autocmd Filetype cpp setlocal cinoptions=h1,l1,g1,t0,i4,+4,(0,w1,W4

autocmd BufNewFile,BufReadPost *.eslintrc set filetype=json

" CDC = Change to Directory of Current file
command CDC cd %:p:h

" Move backup, swap and undo files into centralized directory.
call mkdir("/tmp/vim", "p")
set backupdir=/tmp/vim//
set directory=/tmp/vim//
set undodir=/tmp/vim//

" Use // to comment protobuf files
autocmd FileType proto setlocal commentstring=//\ %s

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
