" A vim config made for use on multiple machines.
"
" Maintainer:	Michael Jablecki
" Last change:	2010 Dec 28
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  " Map f4 to toggle
    nnoremap <F4> :set hlsearch!<CR>
endif

" Remap :W to :w (train the rifle, instead of the cowboy)
command W :w
" Remap :Q to :q (train the rifle, instead of the cowboy)
command Q :q

" Tab cycyling
nnoremap th :tabprev<CR>
nnoremap tl :tabnext<CR>
nnoremap te :tabedit<CR>
nnoremap tn :tabedit<CR>
nnoremap tq :tabclose<CR>

" For ctags
    set tags=tags;/

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
" set background=dark

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  set textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
else
"  set autoindent		" always set autoindenting on
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" My Editor/Codestyle Settings
set tabstop=4
set shiftwidth=4
set expandtab
"set smartindent
set number
let autoread=1
"set ignorecase
let mapleader = ","

" Simple colorscheme for a fallback default with 8 color term
set t_Co=8
colorscheme ir_black
" nice alternatives: dante, desert, ekvoli, ir_black, ironman, oceandeep

"-----------------------------------------------------------------------------
"" Fuf Plugin Settings
"-----------------------------------------------------------------------------
nmap <C-f> :FufCoverageFile<CR>

"-----------------------------------------------------------------------------
"" TagList Plugin Settings
"-----------------------------------------------------------------------------
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Use_Right_Window=1 
let Tlist_Enable_Fold_Column=0 
let Tlist_Show_One_File=1   " especially with this one 
let Tlist_Compact_Format=1 
set updatetime=1000 

"-----------------------------------------------------------------------------
"" NERD Tree Plugin Settings
"-----------------------------------------------------------------------------
"" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

" Show the bookmarks table on startup
 let NERDTreeShowBookmarks=1

" Don't display these kinds of files
 let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
             \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
             \ '\.embed\.manifest$', '\.embed\.manifest.res$',
             \ '\.intermediate\.manifest$',
             \ '^mt.dep$', '\.git', '\~$', 
             \ 'jseditor', 'imagenes', 'images', 'fliqz', 'do_not_delete', 
             \ 'campaigns', 'attachments', 'backgroundProcess', 'nbproject', 
             \ 'phpmailer', 'plesk-stat', 'scopbin', 'videoegg', 'vote', 
             \ 'themes', 'sitemaps', 'summary', 'picture_library', 'tests', 
             \ 'error', 'errorpages', 'branches', 'w3c', 
             \ 'warnings', 'partner_keys', 'fonts', '^help$', 'bids',
             \ '^post$', 'feeds', 'configuration', '\.pyc$' ]

" :autocmd BufWinEnter * call matchadd('ErrorMsg', '\%>' . &l:textwidth . 'v.\+', -1)

"----------------------------------------------------------------------------
"" git.vim Plugin Settings
"----------------------------------------------------------------------------
" set laststatus=2
" set statusline=%{GitBranch()}

" My Abbreviations
iab phpdef <?php <CR><CR>?><Up>
iab phpequal <?= ?><Left><Left><Left>
iab mssg Messages::get('')<Left><Left> 
iab brh (BaseRequestHandler)

" Put a file 'vimrc_local' in home directory
" add things such as:
" set t_Co=256 " set t_Co=16
" colorscheme lucuis
" And custom abbreviations
if filereadable($HOME.'/vimrc_local')
    source $HOME/vimrc_local
endif

filetype plugin on
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
command Sudow :w !sudo tee %
