"--------------------
"startup
"--------------------
set shortmess=atI
set t_Co=256 
filetype on
filetype indent on  
set fo-=r 
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
highlight Cursor guifg=white guibg=red
"set paste
"cd ~/Dropbox/
syntax enable
"set relativenumber
"set number
"set guifont=Consolas\ 12
"set guifont=Inconsolata\ 12
"set guifont=DejaVu\ Sans\ Mono\ 11
set guifont=Monaco\ 11
set guifontwide=WenQuanYi\ Zen\ Hei\ Mono\ 12
"set guifontwide=PingFang\ SC\ 12
filetype plugin indent on 

"Window Menu
set guioptions-=m 
set guioptions-=T

map <silent> <F1> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>

set mouse-=a
set guioptions-=l 
set guioptions-=L 
set guioptions-=r 
set guioptions-=R

"set modelines=-1

"set lines=30 columns=65
"set showtabline=2 
"set linespace=-1
"set foldcolumn=5
"set foldenable      
"set foldmethod=manual
set nocompatible
set foldmethod=manual

"set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)
"set laststatus=2
set noshowmode
"set ruler
"set number
"set cursorline 
"set cursorcolumn
set hlsearch
set ignorecase 
"set nowrap
set incsearch
set smartcase

set encoding=utf-8

"------------------
"Key-Binding
"------------------
"Up or Down diable
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

"FullScreen
function! ToggleFullScreen()
	    call system("wmctrl -r :ACTIVE: -b toggle,fullscreen")
    endfunction
    map <silent> <F11> :call ToggleFullScreen()<CR>

set shell=/bin/zsh


"------------------
"vbundle
"------------------
set nocompatible              " be iMproved, required
filetype plugin indent on
"filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
"call vundle#begin('~/some/path/here')
"--------------------------------------------------------
Plugin 'VundleVim/Vundle.vim'
"Plugin 'shougo/unite.vim'
Plugin 'mattn/emmet-vim'
Plugin 'hail2u/vim-css3-syntax'     
Plugin 'pangloss/vim-javascript'
Plugin 'godlygeek/tabular'
Plugin 'vim-latex/vim-latex' 
Plugin 'plasticboy/vim-markdown'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
"Plugin 'jceb/vim-orgmode'
Plugin 'junegunn/vim-easy-align'
Plugin 'scrooloose/nerdtree'
"Plugin 'mbbill/undotree'
Plugin 'mileszs/ack.vim'
"Plugin 'Lokaltog/vim-powerline'
Plugin 'SuperTab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'honza/vim-snippets'
Plugin 'sirver/ultisnips'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'Tagbar'
Plugin 'junegunn/goyo.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'
Plugin 'tpope/vim-fugitive'
Plugin 'Voom'
"Plugin 'Yggdroot/indentLine'
"Plugin 'Shougo/vimshell.vim'
"Plugin 'Shougo/vimproc.vim'
"Plugin 'altercation/vim-colors-solarized'
"Plugin 'endel/vim-github-colorscheme'
Plugin 'terryma/vim-expand-region'
Plugin 'molokai'
"--------------------------------------------------------------
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"------------------
"colors themes
"------------------
"colorscheme zenburn 
"colorscheme desert

"colorscheme solarized
"let g:solarized_termcolors=256
"set background=dark
"syntax on
highlight Cursor guifg=white guibg=red
"highlight iCursor guifg=white guibg=steelblue

"------------------
"markdown
"------------------
let g:vim_markdown_folding_disabled= 0
"let g:vim_markdown_no_default_key_mappings=1
"set [no]foldenable
set foldenable
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1

let vim_markdown_preview_browser='google-chrome'
let g:vim_markdown_toc_autofit = 1
let vim_markdown_preview_temp_file=1
au BufRead,BufNewFile *.mk,*.md,*.txt set filetype=markdown
"let vim_markdown_preview_toggle=2

autocmd BufEnter *.txt exe 'noremap <F5> :!/usr/bin/google-chrome %:p<CR>'

"------------------
"nerdtree
"------------------
"autocmd vimenter * NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'

"--------------------
"vim-airline
"--------------------
"let g:airline_theme = 'powerlineish'
"let g:airline_theme = 'pencil'
"set t_Co=256  
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline_powerline_fonts = 1

"CtrlP
"let g:ctrlp_map = '<leader>p'
"let g:ctrlp_cmd = 'CtrlP'
"map <leader>f :CtrlPMRU<CR>
"let g:ctrlp_custom_ignore = {
"    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
"    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
"    \ 
"}
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
"let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
"let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"let g:ctrlp_use_caching = 0

"--------------------
"ycm+ulti
"--------------------
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"-------------------
"tab
"-------------------
"au BufNewFile,BufRead *.py
set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
"
hi BadWhitespace guifg=gray guibg=red ctermfg=gray ctermbg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/


"----------------python

let python_highlight_all=1

"----------------Html/Css/Js
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstal
"----------------
"Ack+Ag
"----------------
let g:ackprg = 'ag --nogroup --nocolor --column'

"---------------
"backup
"---------------
set autoread
set nobackup
set autowrite
"set backup
"set backupext=.bak
set backupdir=~/Dropbox/.backup//
set directory=~/Dropbox/.backup//
set undodir=~/Dropbox/.backup//

" save automatically when text is changed
set updatetime=1
au CursorHold * silent! update

"Voom-----------------
let g:voom_ft_modes = {'markdown': 'markdown', 'c': 'fmr2', 'cpp': 'fmr2'}
nmap <silent><F8> :VoomToggle<cr>

"-------------------
"Keybinding+Leader
"-------------------
"let mapleader=";"
"let mapleader = "\<Space>"
let mapleader = ","
"let g:EasyMotion_leader_key='<Space>'

nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>

"nnoremap <CR> G
"nnoremap <BS> gg

noremap gV `[v`]
 	
imap jk <Esc>
map q: :q

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

nmap <Leader><Leader> V


vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"nnoremap <CR> G
"nnoremap <BS> gg

vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" vp doesn't replace paste buffer
function! RestoreRegister()
	let @" = s:restore_reg
	return ''
endfunction
function! s:Repl()
	let s:restore_reg = @"
	return "p@=RestoreRegister()<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

noremap gV `[v`]`]`

let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

"nnoremap <F5> :UndotreeToggle<cr>

"----------------
"Custom The Themes
"----------------

"set colorcolumn=80

"set fillchars=vert:\ ,stl:\ ,stlnc:\ ,
"set fillchars="vert:|,fold:-"
"set fillchars=vert:┃,diff:⎼,fold:⎼
"set fillchars=stl:-,stlnc:-,vert:│
set fillchars=vert:│
"set fillchars=stl:―,stlnc:—,vert:│,fold:۰,diff:·
"highlight vertsplit cterm=bold,underline ctermbg=none ctermfg=Gray gui=none guifg=yellow


"status
set laststatus=2
"set statusline+=%7*\[%n]   
"set statusline+=%1*\ %<%F\
set statusline=
"set statusline+=%1*
"set statusline=[%n]%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)

set statusline=[%n]%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

hi Normal guifg=White guibg=Black
"hi Search ctermfg=Black ctermbg=226_Yellow1 cterm=bold

hi VertSplit ctermbg=250 ctermfg=white guibg=white guifg=red 
hi StatusLine ctermbg=black ctermfg=white guibg=white guifg=red
hi StatusLineNC ctermbg=black ctermfg=white guibg=white guifg=red
"hi StatusLine ctermbg=Green ctermfg=Black guibg=white guifg=red
"hi StatusLineNC ctermbg=Green ctermfg=black guibg=white guifg=red
"hi VertSplit ctermbg=242 ctermfg=black guibg=white guifg=red 
"hi VertSplit ctermbg=Green ctermfg=black guibg=white guifg=red 
"hi VertSplit term=reverse cterm=reverse gui=bold,reverse guifg=gray40
"hi SpellBad ctermfg=white ctermbg=white guifg=#yyyyyy guibg=#zzzzzz
"hi SpellCap ctermfg=white ctermbg=white guifg=#yyyyyy guibg=#zzzzzz
"highlight SyntasticError ctermfg=red ctermbg=white guifg=red guibg=white
hi SignColumn ctermbg=white ctermfg=white guibg=white guifg=white

"highlight Visual cterm=NONE ctermbg=Blue ctermfg=black guibg=grey40

":redir =>a |exe "sil sign place buffer=".bufnr('')|redir end
":let signlist=split(a, '\n')
":let width=winwidth(-1) - ((&number||&relativenumber) ? &numberwidth : 0) - &foldcolumn - (len(signlist) > 2 ? 2 : 0)


let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='⚠'

let g:syntastic_check_on_open=0
"let g:syntastic_check_on_wq=1

" for ycm
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <F4> :YcmDiags<CR>
