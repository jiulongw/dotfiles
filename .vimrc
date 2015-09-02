execute pathogen#infect()

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

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" Speed up vim
" set lazyredraw
set synmaxcol=1024
" Slash
set shellslash                    " Use / instead of \ in Windows

if v:version > 703
  set wildignorecase
endif

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.rar,*.tar.*
set hidden                        " Change buffer - without saving
" Set backspace config
set backspace=eol,start,indent
set whichwrap=b,s,<,>,[,],h,l
" Mouse in all mode
set mouse=a

" magic for regex search
set magic

" indentation
set autoindent
set smartindent

" keep your code clean and easy to read
set linebreak
" textwidth will force insert EOL. prefer to use a guide line instead (colorcolumn)
" set textwidth=120
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
    set guifont=Monaco:h11
    set guifontwide=Songti\ SC:h12
  else
    set guifont=Droid\ Sans\ Mono\ 10
    set guifontwide=Droid\ Sans\ Mono\ 10
  endif
endif

set background=dark
" colorscheme solarized
colorscheme molokai

set cursorline
set showmode
set number

" tab settings
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
autocmd FileType xml :setlocal sw=2 ts=2 sts=2

" Searching
set ignorecase
set smartcase
set hlsearch

" Specify the behavior when switching between buffers
set switchbuf=usetab
set stal=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" W to save as root
" cnoremap W w !sudo tee % > /dev/null
" Map copy and paste with system clipboard register
map <C-y> "+y
vmap <C-y> "+y
map <C-p> "+p
vmap <C-p> "+p

" Map to enter ; end of line
inoremap <leader>; <esc>A;
nnoremap <leader>; A;<esc>
" open file in same directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>co :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>
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
" Ctrl+N => open new window with current directory.
map <C-n> :Vexplore!<cr>
" Ctrl+S => save file
map <C-s> :w<cr>
imap <C-s> <C-o>:w<cr>
vmap <C-s> :<C-w>:w<cr>

" Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" No search highlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

