
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'


augroup ProjectDrawer
	autocmd!
	autocmd VimEnter * :Vexplore
augroup END

" vimux
map <Leader>xp :VimuxPromptCommand<CR>
map <Leader>xr :VimuxRunLastCommand<CR>

" buffer
nmap <leader>nb :bnext<CR>
nmap <leader>pb :bprevious<CR>
" close the current buffer and move to the previous one
nmap <leader>qb :bp <BAR> bd #<CR>
" show all open buffers and their status
nmap <leader>lb :ls<CR>

nmap <F8> :TagbarToggle<CR>
imap <F4> <Esc>:browse tabnew<CR> 
map <F4> <Esc>:browse tabnew<CR>
imap <F5> <Esc> :tabprev <CR>i
map <F5> :tabprev <CR>
map <C-g> :GoDeclsDir <CR>

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>i <Plug>(go-install)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <leader>ds <Plug>(go-def-split)
au FileType go nmap <leader>dv <Plug>(go-def-vertical)
au FileType go nmap <leader>dt <Plug>(go-def-tab)
au FileType go nmap <leader>gd <Plug>(go-doc)
au FileType go nmap <leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>s <Plug>(go-implements)
au FileType go nmap <leader>i <Plug>(go-info)
au FileType go nmap <leader>e <Plug>(go-rename)

let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_browse_split=1
let g:netrw_winsize=10

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_def_mode = 'guru' " 'godef'
let g:go_auto_type_info = 1 " auto-show type info at statusline
" let g:go_auto_sameids = 1 " auto-show all same pieces of code

let g:neocomplete#enable_at_startup=1
let g:go_fmt_command='goimports'
let g:go_highlight_functions=1
let g:go_highlight_methods=1
let g:go_highlight_fields=1
let g:go_highlight_types=1
let g:go_highlight_operators=1
let g:go_highlight_build_constraints=1

call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'ctrlpvim/ctrlp.vim', {}
Plug 'majutsushi/tagbar', {}
Plug 'Shougo/neocomplete', {}
Plug 'garyburd/go-explorer', {}
Plug 'vim-airline/vim-airline', {}
Plug 'vim-airline/vim-airline-themes', {}
Plug 'sjl/badwolf', {}
Plug 'benmills/vimux', {}
call plug#end()

" custom colorscheme
syntax enable
set syntax=whitespace
set background=dark
set term=screen-256color
set t_Co=256
colorscheme badwolf

"scriptencoding utf-8
"set encoding=utf-8
"set list
"set listchars=tab:>-,trail:·,nbsp:·

set updatetime=200 " statusline update period
set modeline
set modelines=2
set number " linenumber show
set colorcolumn=80 " verital separate line = 80 symbols 
set tabstop=4 " tab width
set softtabstop=4 " tab width in case using spaces instead
set laststatus=2   " always show statusline
set statusline=%f%m%r%h%w\ %y\ enc:%{&enc}\ ff:%{&ff}\ fenc:%{&fenc}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%
