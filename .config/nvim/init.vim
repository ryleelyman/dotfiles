" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'ludovicchabant/vim-gutentags'
Plug 'vim-airline/vim-airline'
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'} 
Plug 'tidalcycles/vim-tidal'
Plug 'w0rp/ale'
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
Plug 'shougo/neosnippet'
Plug 'shougo/neosnippet-snippets'
Plug 'vimwiki/vimwiki'
Plug '/tpope/vim-liquid'
call plug#end()

set relativenumber
set number

" Vimwiki Options
" Use Markdown instead of Wiki formatting
" Enable folding
let g:vimwiki_folding = 'list'
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown'}]
:map <Leader><Space> <Plug>VimwikiToggleListItem

" maplocalleader is mostly used in vim-tex
let maplocalleader="\\"
imap ,/ </<C-X><C-O>
" Italics?
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" Deoplete Options
let g:deoplete#enable_at_startup = 1
let g:deoplete#options#auto_complete_delay = 1000
call deoplete#custom#var('omni', 'input_patterns', {
			\ 'tex': g:vimtex#re#deoplete
			\})
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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

" Mutt Options
augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile *mutt-*              setfiletype mail
augroup END
