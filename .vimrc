
" ==================================================================================
" The usual Vim setup
" ==================================================================================
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
syntax on
set backup
set showcmd
autocmd BufNewFile,BufRead *.tex setlocal spell " Turn on spell check for Latex


" ==================================================================================
" Setup tab and related options
" ==================================================================================
set autoindent 
set expandtab
set shiftwidth=2
set softtabstop=2
set wildmenu
set wildmode=list:longest,full
"set nohidden
set hidden
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop


" ==================================================================================
" Movement and other personalized keystrokes
" ==================================================================================
" change the mapleader from \ to ,
let mapleader=","
" inoremap jk <Esc>
" Jumps to next row in editor in the case of wrapped lines
nnoremap j gj
nnoremap k gk
" Clear search buffer without typing /asfasdf
nmap <silent> ,/ :nohlsearch<CR>
set list
if has('macunix')
  set listchars=tab:▸\ ,eol:¬ " Show invisible characters
elseif has('unix')
  set listchars=tab:▸\ ,eol:¬ " Show invisible characters
endif
nnoremap ; :
set undofile
set showmode
set showcmd
" Allow fast buffer movement
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>
" Wrap Latex paragraphs to make them readable, just type gqlp
map \gq ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>gq//-1<CR>
omap lp ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>//-1<CR>.<CR>:nohlsearch<CR>

" ==================================================================================
" Make searching easier
" A lot of this came from http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" ==================================================================================
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" ==================================================================================
" Setup vim-plug
" ==================================================================================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/LaTeX-Box-Team/LaTeX-Box.git'
Plug 'https://github.com/vim-scripts/LanguageTool.git'
Plug 'https://github.com/junegunn/fzf.vim.git'
Plug 'https://github.com/itchyny/lightline.vim.git'
Plug 'https://github.com/scrooloose/syntastic.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/easymotion/vim-easymotion.git'
Plug 'https://github.com/tpope/vim-sensible.git'
Plug 'https://github.com/tpope/vim-sleuth.git'
" Add plugins to &runtimepath
call plug#end()


" Setup some configurations to make the <Esc> button immediate for neovim
" This will override vim-sensible
runtime! plugin/sensible.vim
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif
set nottimeout

""""""""""""""""""""""""""""""
" Set up vim-commentary
""""""""""""""""""""""""""""""
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s


""""""""""""""""""""""""""""""
" Set up languagetool
""""""""""""""""""""""""""""""
let g:languagetool_jar = "$HOME/LanguageTool-3.1/languagetool-commandline.jar"


""""""""""""""""""""""""""""""
" Set up fzf for fuzzy file finding
""""""""""""""""""""""""""""""

let os=substitute(system('uname'), '\n', '', '')
if os == 'Darwin' || os == 'Mac'
    set rtp+=/usr/local/opt/fzf
elseif os == 'Linux'
    set rtp+=~/.fzf
endif

function! BufList()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! BufOpen(e)
  execute 'buffer '. matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader>b :call fzf#run({
\   'source':      reverse(BufList()),
\   'sink':        function('BufOpen'),
\   'options':     '+m',
\   'tmux_height': '40%'
\ })<CR>

nnoremap <silent> <Leader>p :FZF<CR>


""""""""""""""""""""""""""""""
" Set up lightline
""""""""""""""""""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'solarized',
\}




" ==================================================================================
" GUI options
" The statusline options appear under plugins since I am using powerline
" ==================================================================================

set t_Co=256
set guifont=Inconsolata\ for\ Powerline:h15
" Turn on solarized
set background=light
colorscheme solarized
if has("gui_macvim")
  colorscheme jellybeans
endif
set guioptions=ageimrLt
set showtabline=1
" set cursorline " Turn on the line shadowing indicating where the cursor is
set ttyfast " Send more characters for redraws
" Turn on relative numbers for normal mode and absolute numbers for inset mode
set relativenumber 
set number
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
"Turn off system beep
set vb t_vb=

" ==================================================================================
" Functions
" ==================================================================================


