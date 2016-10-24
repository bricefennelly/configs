"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pathogen [should be at top]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call pathogen#infect()
call pathogen#helptags()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set leader key to ','
let mapleader = ","

" Enable filetype plugins
filetype plugin indent on

" history, lines around cursor, command window height
set history=700 scrolloff=7 cmdheight=2

" Tabs, indentation and line wrapping
set expandtab smarttab shiftwidth=2 tabstop=2 autoindent smartindent wrap

" change cwd to current file's
set autochdir

" 4-space tabs for python
augroup pythonspacing
  autocmd!
  autocmd BufNewFile,BufRead *.py setlocal ts=4 sts=4 sw=4
augroup END

" Set to auto read when a file is changed from the outside
set autoread

" No backup files
set noswapfile nowritebackup nobackup

" Don't save options or cwd in session
set ssop-=options ssop-=curdir ssop-=buffers

" yank to system clipboard
if has('unnamedplus')
    set clipboard=unnamedplus
endif

" timeouts for key codes and sequence key-bindings 
set timeout ttimeout timeoutlen=400 ttimeoutlen=10

" Set utf8 as standard encoding, en_US the standard language, and unix filetype
set encoding=utf8 fileformats=unix,dos,mac

" wildmenu
set wildmenu wildmode=longest,full wildignore=*.o,*~,*.pyc

" Allow backspacing over newlines, indentation and the beginning of lines
set backspace=eol,start,indent

" Always show the status line and tabline, hide buffer when abandoned
set laststatus=2 showtabline=2 hidden

" Don't reopen already open buffers, even if in other tab. open new tab
" for quickfix commands that display errors
set switchbuf=useopen,usetab,newtab

" Ignore case unless case is specified, highlight results like a browser
set ignorecase smartcase hlsearch incsearch

" faster macros 
set lazyredraw

" visually jump to matching brackets for 2ms when inserting
set showmatch matchtime=2

" No bell or visual bell
set noeb novb t_vb= 

" colorscheme settings
syntax enable " Enable syntax highlighting
set t_Co=256 t_ut= " Enable full color, tmux support
set bg=dark colorcolumn=80 " Dark background with bar at 80 columns
colorscheme mustang

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keybindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Faster command mode
nnoremap ; :

" Switch between buffers quickly
nnoremap <C-n> :bprevious<cr>
nnoremap <C-m> :bnext<cr>

" Still use j and k to move up and down when line-wrapping is happening
onoremap j gj
onoremap k gk

" Fast saving
nnoremap <space> :w!<cr>

" Disable highlight when <leader>n is pressed
nnoremap <leader>n :noh<cr>

" Escape insert mode by pressing "jk"
inoremap jk <esc>
cnoremap jk <esc> 

" help to unlearn using esc key
inoremap <esc> <nop>
" cnoremap <esc> <nop>  (this breaks with remote connections)

" 0 jumps to first non-blank character
noremap 0 ^

" Toggle paste mode
nnoremap <leader>pp :setlocal paste!<cr>

" Open vimrc in new buffer
nnoremap <leader>ev :n $MYVIMRC<cr>

" Source vimrc 
nnoremap <leader>S :so $MYVIMRC<cr>

" Delete buffer
nnoremap <leader>d :bd<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CTRLP [plugin]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Ignore .gitignored files
" https://medium.com/a-tiny-piece-of-vim/making-ctrlp-vim-load-100x-faster-7a722fae7df6
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files -oc --exclude-standard']

" Find project root
let g:ctrlp_root_markers = ['.ctrlp', '.git']

" Use project root
let g:ctrlp_working_path_mode = 'r'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline [plugin]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CSApprox [plugin]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:CSApprox_verbose_level=0 " eliminate error message

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => pangloss/vim-javascript [plugin]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:javascript_enable_domhtmlcss = 1 " JSX highlighting

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-tmux-navigator [plugin]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fugitive [plugin]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>c :Gcommit -m ""<left>
nnoremap <leader>s :Gstatus<cr>
nnoremap <leader><cr> :Git push origin master<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => BufExplorer [plugin]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>k :BufExplorer<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-sneak [plugin]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:sneak#use_ic_scs = 1
let g:sneak#s_next = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Scripts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup returntopos
  " Return to last edit position when opening files
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END

augroup deletetrailingws
  " Delete trailing white space on save
  func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
  endfunc
  autocmd!
  autocmd BufWrite *.py :call DeleteTrailingWS()
  autocmd BufWrite *.coffee :call DeleteTrailingWS()
augroup END
