"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Get running OS
function! GetRunningOS()
  if has("win32")
    return "win"
  endif
  if has("unix")
    if system('uname')=~'Darwin'
      return "mac"
    else
      return "unix"
    endif
  endif
endfunction

let os=GetRunningOS()
" Remap leader
let g:mapleader = ","
" work with unicode by default
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" We are not accient
set nocompatible

" Show invisible characters
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:+
set list

" Speed up vim
set synmaxcol=1024
" Slash
"
set shellslash                    " Use / instead of \ in Windows

if v:version > 703
  set wildignorecase
endif

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.rar,*.tar.*
set hidden                        " Change buffer - without saving

set whichwrap=b,s,<,>,[,],h,l

" Mouse in all mode
set mouse=a

" magic for regex search
set magic

" keep your code clean and easy to read
set linebreak
set colorcolumn=120

if has("gui_running")
  set guioptions-=T
  set guioptions-=r
  set guioptions-=l
  set guioptions-=m

  if os=="win"
    set guifont=Consolas:h10:cDEFAULT
    set guifontwide=NSimSun:h10:cDEFAULT
    au GUIEnter * simalt ~x
  elseif os=="mac"
    set guifont=Source\ Code\ Pro:h12
    set guifontwide=Songti\ SC:h12
  else
    set guifont=DejaVu\ Sans\ Mono\ Book\ 10
    set guifontwide=DejaVu\ Sans\ Mono\ Book\ 10
  endif
endif

set background=dark

colorscheme molokai

set cursorline
set showmode
set relativenumber
set number

" tab settings
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" Searching
set ignorecase
set smartcase
set hlsearch

" Specify the behavior when switching between buffers
set switchbuf=usetab
set stal=1

set splitright
set splitbelow

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map copy and paste with system clipboard register
map <C-y> "+y
vmap <C-y> "+y
map <C-p> "+p
vmap <C-p> "+p
nmap Y y$

" open file in same directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>co :botright cope<cr>
map <leader>cn :cn<cr>
map <leader>cp :cp<cr>
map <leader>cc :cclose<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Switch to recent buffer
noremap <leader>b :b#<cr>

let g:markdown_fenced_languages = ['css', 'javascript', 'json=javascript', 'xml', 'html', 'python', 'java', 'c', 'cpp', 'cs']

let g:ctrlp_map = 'c-0' "vim cannot map ctrl-0, just to turn off ctrl-p which is used to paste from clipboard.
let g:ctrlp_root_markers = ['TAGS', '.ctrlp-root', '.git/']
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

map <leader>p :CtrlP<cr>

let g:ackprg = 'ag --vimgrep'
nnoremap <leader>a :Ack!<space>
nnoremap <leader>; :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>

let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1
let g:terraform_fmt_on_save = 1

" Full path to system clipboard
nmap <silent> <leader>yp :let @+ = expand("%:p")<CR>

" Special tab settings
autocmd Filetype go,scala,javascript,typescript,sh,proto,vim,yaml,json,html,scss,sass,liquid,cpp setlocal shiftwidth=2 tabstop=2 softtabstop=2

autocmd Filetype cpp setlocal cinoptions=h1,l1,g1,t0,i4,+4,(0,w1,W4

" Treat *.md as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Other file formats
autocmd BufNewFile,BufReadPost *.eslintrc set filetype=json

" CDC = Change to Directory of Current file
command CDC cd %:p:h

" Move backup, swap and undo files into centralized directory.
set backupdir=/tmp/vim//
set directory=/tmp/vim//
set undodir=/tmp/vim//
