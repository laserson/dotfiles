call plug#begin('~/.config/nvim/plugged/')

" General utilities
Plug 'tpope/vim-unimpaired'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'jiangmiao/auto-pairs'

" Appearance/themes
Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Search
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'

" Code
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
" Plug 'dense-analysis/ale'

" Code completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Other dev plugins
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
" bc of https://github.com/psf/black/issues/1293
" need to specify version
Plug 'psf/black', { 'tag': '19.10b0' }

call plug#end()

" set autochdir                       " Set working directory to that of the active buffer
set autoindent
set autoread                        " Reload files when changed on disk
set backspace=indent,eol,start      " Make backspace behave as it does in other editors
set clipboard=unnamed               " Use sytem clipboard (prefer '+' register)
set cursorline                      " Highlight current line
set directory-=.                    " Don't store swapfiles in the current directory
set encoding=utf-8
set hidden                          " Allow a buffer to be hidden even if changes have not been written
set ignorecase                      " Ignore case when searching
set incsearch                       " Search as you type
set laststatus=2                    " Always show status line
set list                            " Show invisible characters
set listchars=tab:▸\ ,trail:▫       " Use arrows for tab and boxes for trailing spaces
set nocompatible                    " Don't bother with Vi compatibility
set noswapfile
set nowrap                          " Don't wrap by default
set number                          " Show line numbers
set pastetoggle=<F8>                " F8 to toggle paste mode
set scrolloff=3                     " Show content above/below cursorline
set showcmd
set smartcase                       " Don't ignore case if the pattern has capital letters
set wildignore=*.pyc,*.rbc,*.tmp
set wildmenu
set wildmode=list:longest

" Defaults for tabs
set expandtab                       " Expand tabs to spaces (overridden for Golang)
set shiftwidth=4                    " Use two spaces for normal mode indentation
set softtabstop=4                   " Insert mode tab and backspace use 2 spaces
set tabstop=4                       " Actual tabs use 2 characters

set background=dark
colorscheme jellybeans

syntax enable
filetype plugin indent on

let mapleader=","
nnoremap \ ,

" Use par to format on gq (use gw to format with Vim's internal formatter)
" if executable('par')
"   set formatprg=par\ -w80
" endif

" Allow different vim cursors in normal and insert mode while running in a
" tmux session
" if exists('$TMUX')
"   let &t_SI="\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"   let &t_EI="\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
" else
"   let &t_SI="\<Esc>]50;CursorShape=1\x7"
"   let &t_EI="\<Esc>]50;CursorShape=0\x7"
" endif

if has("autocmd")
  " Automatically open (but do not go) to the quickfix if there are errors and
  " close it when it is empty
  autocmd QuickFixCmdPost [^l]* nested cwindow

  " Golang
  autocmd FileType go setl noexpandtab shiftwidth=4 softtabstop=4 tabstop=4
  autocmd FileType go setl makeprg=go\ run\ %

  " Markdown--hard wrap text
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
  autocmd FileType markdown setl textwidth=80

  " Python
  autocmd FileType python setl colorcolumn=80 expandtab shiftwidth=4 softtabstop=4 tabstop=4
  autocmd FileType python setl makeprg=python\ %  " python-mode also runs with <leader>r

  " Ruby
  autocmd FileType ruby setl colorcolumn=99 expandtab shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType ruby setl makeprg=ruby\ %
  autocmd BufWritePre FileType ruby :RuboCop  " Run RuboCop on write

  " Scala
  autocmd FileType scala setl colorcolumn=99 expandtab shiftwidth=2 softtabstop=2 tabstop=2
  autocmd FileType scala setl makeprg=scala\ %
end

" Have %% expand to the directory of the currently open buffer in the
" command line
cnoremap %% <C-R>=fnameescape(expand('%:h')) . '/'<CR>
" Edit files in the directory of the currently open buffer
map <leader>ew :e %%        " Edit in the same window
map <leader>es :sp %%       " Edit in a horizontal split
map <leader>ev :vsp %%      " Edit in a vertical split
map <leader>et :tabe %%     " Edit in a new tab

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

map <leader>w :set wrap!<CR>

" Plugin configuration

" NERDTree
map <leader>n :NERDTreeToggle<CR>

" Use ag for Ctrl-P and grep if it's available
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ackprg='ag --vimgrep'
  let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching=1
endif

" Ale
" let g:ale_set_loclist = 0                  " Quickfix intead of location list
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" let g:ale_linters = {'python': ['flake8']} g:ale_lint_on_enter = 0 " Don't lint on file opening

" Ctrl-P
let g:ctrlp_map='<leader>a'       " ,a to bring up window
" let g:ctrlp_by_filename=1         " Search by filename by default
let g:ctrlp_match_window='order:ttb,max:20'

" " python-mode
" let g:pymode_rope=0
" let g:pymode_folding=0
" " let g:pymode_lint_checkers=['pyflakes', 'pep8', 'mccabe']
" let g:pymode_rope_completion=0
" let g:pymode_rope_complete_on_dot=0
" let g:pymode_options_max_line_length=99
" let g:pymode_lint_options_pyflakes = { 'builtins': '_' }
" let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
" let g:pymode_lint_options_pylint = {'max-line-length': g:pymode_options_max_line_length}

" Deoplete
let g:deoplete#enable_at_startup = 1

" Neoformat
" let g:neoformat_enabled_python = ['autopep8', 'yapf']
" let g:neoformat_run_all_formatters = 1

" vim-airline
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
let g:airline_theme='jellybeans'

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup=0
