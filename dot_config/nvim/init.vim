set encoding=utf-8
set termencoding=utf-8

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

set background=dark
call plug#begin('~/.config/nvim/plugged')

" Start with sensible vim configuration
Plug 'tpope/vim-sensible'

" Show the registers on " or @
Plug 'junegunn/vim-peekaboo'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" VCS stuff
Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/vcscommand.vim'

" Scala stuff
Plug 'derekwyatt/vim-scala'
Plug 'derekwyatt/vim-sbt'
"Plug 'ensime/ensime-vim'
"Plug 'ktvoelker/sbt-vim'

" CoffeeScript
"Plug 'kchmck/vim-coffee-script'

" Status line
"Plug 'itchyny/lightline.vim'
let g:airline_powerline_fonts = 1
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Tags
Plug 'majutsushi/tagbar'

" Files
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'

Plug 'm-kat/aws-vim'
"Plug 'mileszs/ack.vim'
Plug 'vim-scripts/EnhCommentify.vim'
Plug 'vim-scripts/a.vim'
Plug 'flazz/vim-colorschemes'
Plug 'leafgarland/typescript-vim'
Plug 'fatih/vim-go'

Plug 'powerman/vim-plugin-AnsiEsc'

"Plug 'ctrlpvim/ctrlp.vim'
Plug 'qualiabyte/vim-colorstepper'
Plug 'jremmen/vim-ripgrep'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
"Plug 'autozimu/LanguageClient-neovim', {
   "\ 'branch': 'next',
   "\ 'do': 'bash install.sh'
   "\ }

call plug#end()

" Color settings
set t_Co=256
set t_ut=  "solves background color rendering problems in 256-color themes
set termguicolors
let g:solarized_termcolors = 256
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_bold=1
set background=dark
"colorscheme CandyPaper
"colorscheme jellybeans
"colorscheme solarized
"colorscheme xoria256
"colorscheme Tomorrow-Night-Bright
colorscheme gruvbox
let g:airline_theme='base16_twilight'
let g:airline_extensions=['tabline', 'branch']

"let g:lightline = {
"                \ 'colorscheme': 'jellybeans',
"                \ 'active': {
"                \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
"                \ },
"                \ 'component_function': {
"                \   'fugitive': 'MyFugitive',
"                \   'filename': 'MyFilename'
"                \ },
"                \ 'separator': { 'left': '', 'right': '' },
"                \ 'subseparator': { 'left': '', 'right': '' }
"                \ }
"        function! MyModified()
"                return &ft =~ 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
"        endfunction
"        function! MyReadonly()
"                return &ft !~? 'help\|vimfiler' && &readonly ? 'R' : ''
"        endfunction
"        function! MyFilename()
"                return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
"                \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
"                \  &ft == 'unite' ? unite#get_status_string() :
"                \  &ft == 'vimshell' ? vimshell#get_status_string() :
"                \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
"                \ ('' != MyModified() ? ' ' . MyModified() : '')
"        endfunction
"        function! MyFugitive()
"                if &ft !~? 'vimfiler' && exists("*fugitive#head")
"                        let _ = fugitive#head()
"                        return strlen(_) ? ' '._ : ''
"                endif
"                return ''
"        endfunction


" Highlight current cursor line
"set cursorline

set modeline

" backup
set writebackup
set nobackup

" Be quiet: visual bell, no real bell
set vb

" Search
set incsearch
set hlsearch

" By default, yank to system clipboard
set clipboard=unnamedplus

" Find tags everywhere
set tags=./tags;,./TAGS;,tags;,TAGS;,./.tags;,.tags;

nmap <F8> :TagbarToggle<CR>
nmap <F5> :NERDTreeToggle<CR>
nnoremap <tab>   <C-W>w

" ctrlp settings
"let g:ctrlp_working_path_mode='rwa'
"let g:ctrlp_use_caching=0
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
"let g:ctrlp_extensions=['tag']

" Preferred tabbing experience
set sw=4 expandtab smarttab

" Define what a "word" is in motion commands
set iskeyword=@,48-57,_,192-255

" force proper syntax highlighting in all cases
syntax sync fromstart

" Go-specific setup
autocmd BufRead,BufNewFile *.go setlocal sw=8 noexpandtab nofoldenable
autocmd FileType go nmap <Leader>b <Plug>(go-build)
autocmd FileType go nmap <Leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>a <Plug>(go-alternate-vertical)
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_info_mode="gopls"
let g:go_def_mode="gopls"

" markdown-specific setup
autocmd BufRead,BufNewFile *.md setlocal tw=78
" asciidoc-specific setup
autocmd BufRead,BufNewFile *.adoc setlocal tw=78

" yaml-specific setup
autocmd BufRead,BufNewFile *.yml setlocal sw=2 expandtab

" scala-specific setup
let g:scala_sort_across_groups=1
let g:scala_first_party_namespaces='\(com\.klarrio\|kstreams\|controllers\|views\|models\)'
let g:scala_use_builtin_tagbar_defs = 0

" make vertical window separators look nice
set fillchars+=vert:│


" map ctrl-p to the fzf :Files command
nmap <c-p> :GFiles<CR>
nmap <c-p>p :GFiles<CR>
nmap <c-p><c-p> :GFiles<CR>
nmap <c-p>f :Files<CR>
nmap <c-p>g :GFiles<CR>
nmap <c-p>t :Tags<CR>
command! -bang -nargs=* Rgf
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" easier window navigation
nmap <m-h> <c-w>h
nmap <m-j> <c-w>j
nmap <m-k> <c-w>k
nmap <m-l> <c-w>l
nmap <m-left> <c-w>h
nmap <m-down> <c-w>j
nmap <m-up> <c-w>k
nmap <m-right> <c-w>l
tmap <m-h> <c-\><c-n><c-w>h
tmap <m-j> <c-\><c-n><c-w>j
tmap <m-k> <c-\><c-n><c-w>k
tmap <m-l> <c-\><c-n><c-w>l
tmap <m-left> <c-\><c-n><c-w>h
tmap <m-down> <c-\><c-n><c-w>j
tmap <m-up> <c-\><c-n><c-w>k
tmap <m-right> <c-\><c-n><c-w>l
" easier escape from terminal mode
tmap <esc><esc> <c-\><c-n>




" make language servers work nicely
"set hidden
"let g:LanguageClient_serverCommands = {
"    \ 'go': ['go-langserver'],
"    \ }
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=no

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
