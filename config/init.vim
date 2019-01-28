"------------------------------------------------------------------------------
" GENERAL
"------------------------------------------------------------------------------
set encoding=utf-8            " Ensure encoding is UTF-8
set nocompatible              " Disable Vi compatability
set mouse=a                   " Enable mouse in all modes
set hidden                    " Allow unwritten buffers

"-----------------------------------------------------------------------------
" VUNDLE PLUGIN MANAGEMENT
"-----------------------------------------------------------------------------
call plug#begin()                  " Initialize vim-plug
Plug 'ctrlpvim/ctrlp.vim'          " Quick file navigation
Plug 'tpope/vim-commentary'        " Quickly comment lines out and in
Plug 'tpope/vim-fugitive'          " Help formatting commit messages
Plug 'tpope/vim-dispatch'          " Allow background builds
Plug 'tpope/vim-unimpaired'        " Add normal mode aliases for commonly used ex commands
Plug 'tpope/vim-abolish'           " easily search for, substitute, and abbreviate multiple variants of a word
Plug 'fatih/vim-go'                " Helpful plugin for Golang dev
Plug 'AndrewRadev/splitjoin.vim'   " Enable vim-go to split structs into multi lines
Plug 'vim-scripts/bufkill.vim'     " Kill buffers and leave windows intact
Plug 'ervandew/supertab'           " Perform all completions with Tab
Plug 'scrooloose/nerdtree'         " Directory tree explorer
Plug 'gaving/vim-textobj-argument' " Function arguments as text objects
Plug 'vim-airline/vim-airline'     " Status line improvements
Plug 'vim-scripts/regreplop.vim'   " Replace with a specified register
Plug 'zchee/hybrid.nvim'           " Hybrid colorscheme
Plug 'rking/ag.vim'                " Find text in project
Plug 'airblade/vim-gitgutter'      " Show changed hunks
Plug 'kana/vim-textobj-user'       " Dependency for the following textobj plugins
Plug 'pianohacker/vim-textobj-variable-segment' " Change parts of a variable name
Plug 'pianohacker/vim-indented-paragraph' " Change a single indented paragraph
Plug 'tpope/vim-repeat'            " properly repeat plugin commands
Plug 'w0rp/ale'                    " asynchronous linting

call plug#end()                    " Complete vim-plug initialization

" detect file type, turn on that type's plugins and indent preferences
filetype plugin indent on

"-----------------------------------------------------------------------------
" VIM-GO CONFIG
"-----------------------------------------------------------------------------
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"

" highlight go-vim
highlight goSameId term=bold cterm=bold ctermbg=250 ctermfg=239
set updatetime=100 " updates :GoInfo faster

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

function! s:toggle_coverage()
    call go#coverage#BufferToggle(!g:go_jump_to_error)
    highlight ColorColumn ctermbg=235
    highlight NonText ctermfg=239
    highlight SpecialKey ctermfg=239
    highlight goSameId term=bold cterm=bold ctermbg=250 ctermfg=239
endfunction

" This will add new commands, called :A, :AV, :AS and :AT. Here :A works just
" like :GoAlternate, it replaces the current buffer with the alternate file.
" :AV will open a new vertical split with the alternate file. :AS will open
" the alternate file in a new split view and :AT in a new tab.
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

"-----------------------------------------------------------------------------
" RUBY CONFIG
"-----------------------------------------------------------------------------
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2

"-----------------------------------------------------------------------------
" TEXT CONFIG
"-----------------------------------------------------------------------------
autocmd FileType markdown setlocal formatoptions+=t

"----------------------------------------------------------------------------
" CTRL-P CONFIG
"-----------------------------------------------------------------------------
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn|vagrant)|node_modules)$',
  \ 'file': '\v\.(swp|zip|exe|so|dll|a)$',
  \ }
" stop setting git repo as root path
let g:ctrlp_working_path_mode = ''

"-----------------------------------------------------------------------------
" nerd tree config
"-----------------------------------------------------------------------------
map <C-n> :NERDTreeToggle<CR>
map \ :NERDTreeToggle<CR>
map \| :NERDTreeFind<CR>

"-----------------------------------------------------------------------------
" ALE config
"-----------------------------------------------------------------------------

let g:ale_linters = {
\ "go": ["gofmt", "govet"],
\ }
let g:ale_go_govet_options = '-lostcancel=false -methods=false'
let g:ale_lint_on_text_changed = 'never'

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:ale_open_list = 1

"-----------------------------------------------------------------------------
" Search
"-----------------------------------------------------------------------------
if executable('rg')
  " Use Ripgrep over Grep
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m

  let g:ctrlp_user_command = 'rg --hidden -i --files %s'
  let g:ackprg = 'rg --vimgrep'
elseif executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ".git" --ignore ".DS_Store" --hidden -g ""'
  let g:ackprg = 'ag --vimgrep'
endif

function! AgGrep()
  let command = g:ackprg.' -i '.expand('<cword>')
  cexpr system(command)
  cw
endfunction

function! AgVisual()
  normal gv"xy
  let command = g:ackprg.' -i '.@x
  cexpr system(command)
  cw
endfunction

"------------------------------------------------------------------------------
" APPEARANCE
"------------------------------------------------------------------------------
syntax on               " enable syntax highlighting
set number              " show line numbers
set ruler               " show lines in lower right
set nowrap              " don't wrap lines eva!

colorscheme hybrid      " color scheme

set cursorline          " highlight current line
let loaded_matchparen = 1

set t_Co=256            " set 256 color
set colorcolumn=80      " highlight col 80
highlight ColorColumn ctermbg=235
set listchars=tab:▸\ ,eol:¬,trail:· " show whitespace characters
set list                " enable display of invisible characters

" invisible character colors
highlight NonText ctermfg=239
highlight SpecialKey ctermfg=239

"------------------------------------------------------------------------------
" supertab config
"------------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

"------------------------------------------------------------------------------
" BEHAVIOR
"------------------------------------------------------------------------------
set backspace=indent,eol,start  " enable better backspacing
set noswapfile                  " disable swap files
set nowb                        " disable writing backup
set textwidth=78                " global text columns
set formatoptions+=l            " don't break long lines less they are new
set formatoptions-=t            " don't hard wrap

set hlsearch                    " highlight search results
set ignorecase                  " necessary for below to work
set smartcase                   " ignore case if lower, otherwise match case
set incsearch                   " jump to results as I search
set gdefault                    " apply /g (replace all on line) by default
set splitbelow                  " split panes on the bottom
set splitright                  " split panes to the right
set inccommand=nosplit          " show preview during find and replace operations

set history=10000               " keep a longer history

set wildmenu                    " allow for menu suggestions

set autowrite                   " automatically write file on `:make`

autocmd BufWritePre * :%s/\s\+$//e " strip trailing whitespace on save
autocmd BufLeave * silent! wall    " save on lost focus

set path+=~/workspace           " add correct base path for `gf`

" tab behavior
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" smaller indents for yaml
autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 expandtab
" Include - in word text objects, * command
autocmd Filetype yaml setlocal iskeyword+=-

"------------------------------------------------------------------------------
" LEADER MAPPINGS
"------------------------------------------------------------------------------
let mapleader = ","              " set leader

" switch between files
nnoremap <leader><leader> <c-^>

" quickly Open vimrc
nmap <silent> <leader>ev :edit $MYVIMRC<cr>
" load vimrc into memory
nmap <silent> <leader>ee :source $MYVIMRC<cr>

" clear the search buffer when hitting space
nnoremap <space> :nohlsearch<cr>

" sometimes I hold the shift too long ... just allow it
cabbrev W w
cabbrev Wa wa
cabbrev Q q
cabbrev Qa qa
cabbrev Tabe tabe

nnoremap <silent> <leader>a :call AgGrep()<CR>
vnoremap <silent> <leader>a :call AgVisual()<CR>
nnoremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <leader>f :CtrlP<CR>
nnoremap <leader>d :lclose<cr>:pclose<cr>:cclose<cr>
nnoremap <leader>h :split<CR>
nnoremap <leader>s :w<cr>
nnoremap <leader>q :x<cr>
nnoremap <leader>v :vsp<CR>

" vim-go command shortcuts
autocmd FileType go nnoremap <leader>? :GoDoc<CR>
autocmd FileType go nnoremap <leader>. :GoDeclsDir<CR>
autocmd FileType go nnoremap <leader>c :<C-u>call <SID>toggle_coverage()<CR>
autocmd FileType go nmap <leader>g <Plug>(go-generate)
autocmd FileType go nmap <leader>i <Plug>(go-info)
autocmd FileType go nnoremap <leader>l :GoMetaLinter<CR>
autocmd FileType go nmap <leader>m <Plug>(go-implements)
autocmd FileType go nmap <leader>M :GoImpl<Space>
autocmd FileType go nnoremap <leader>n :GoRename<CR>
autocmd FileType go nmap <leader>r <Plug>(go-referrers)
autocmd FileType go nnoremap <leader>t :wa<CR>:!clear;go test -v %:p:h \| perl -pe 's/\e\[?.*?[\@-~]//g'<CR>

" reselect when indenting
vnoremap < <gv
vnoremap > >gv

" clipboard fusion!
set clipboard^=unnamed clipboard^=unnamedplus

" turn folding on and open by default
set foldmethod=syntax
set foldlevel=99
set laststatus=2

" resize windows more easily
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>

" remap ) and ( to indented-paragraph motions
call textobj#user#map("indentedparagraph", {
\   "-": {
\       "move-n": ")",
\       "move-p": "(",
\   }
\})
