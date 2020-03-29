let uname = substitute(system('uname'), '\n', '', '')
" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-surround'
if uname == 'Darwin'
	Plug 'ludovicchabant/vim-gutentags'
endif
Plug 'kassio/neoterm'
Plug 'vim-airline/vim-airline'
Plug 'lervag/vimtex'
Plug 'ryleelyman/tex-conceal.vim', {'for': 'tex'} 
Plug 'tidalcycles/vim-tidal'
Plug 'w0rp/ale'
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
Plug 'shougo/neosnippet'
Plug 'shougo/neosnippet-snippets'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-liquid'
call plug#end()

set shiftwidth=4
set tabstop=4
set relativenumber
set number
call matchadd('ColorColumn', '\%81v', 100)

" Vimwiki Options
" Use Markdown instead of Wiki formatting
" Enable folding
let g:vimwiki_folding = 'list'
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown'}]
nmap <Leader><Space> <Plug>VimwikiToggleListItem

" maplocalleader is mostly used in Vimtex
let maplocalleader="\\"

" Italics?
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" Deoplete Options
let g:deoplete#enable_at_startup = 1
let g:deoplete#options#auto_complete_delay = 1000
call deoplete#custom#var('omni', 'input_patterns', {
			\ 'tex': g:vimtex#re#deoplete
			\})

" Neosnippet Options
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
inoremap <silent><expr> __ neosnippet#anonymous('_{${1}}${0}')
inoremap <silent><expr> ^^ neosnippet#anonymous('^{${1}}${0}')

" Hide default mode---Airline's is prettier.
set noshowmode
" Airline + AlE friendship
let g:airline#extensions#ale#enabled = 1

" Use Vimtex even when creating a new .tex file
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'skim'
if has('nvim')
  let g:vimtex_compiler_progname = 'nvr'
endif

" Allow Vimtex folding
let g:vimtex_fold_manual = 1
let g:tex_conceal = "abdgm" 
set conceallevel=2

" Improving Vimtex imaps
let g:vimtex_imaps_disabled = ['0']
call vimtex#imaps#add_map(
 \{
 \ 'lhs' : ':',
 \ 'rhs' : '\colon',
 \})
call vimtex#imaps#add_map(
 \{
 \ 'lhs' : '~',
 \ 'rhs' : '\tilde',
 \})
call vimtex#imaps#add_map(
 \{
 \ 'lhs' : '-',
 \ 'rhs' : '\bar',
 \})
call vimtex#imaps#add_map(
 \{
 \ 'lhs' : '0',
 \ 'rhs' : '\varnothing',
 \})
call vimtex#imaps#add_map(
 \{
 \ 'lhs' : '#',
 \ 'rhs' : '\sharp',
 \})
call vimtex#imaps#add_map(
 \{
 \ 'lhs' : 's',
 \ 'rhs' : 'vimtex#imaps#style_math("mathscr")',
 \ 'expr' : 1,
 \ 'leader' : '#',
 \})

" Mutt Options
augroup filetypedetect  " Mail
  autocmd BufRead,BufNewFile *mutt-*              setfiletype mail
augroup END
