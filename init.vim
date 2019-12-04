"""" .vimrc

if &compatible
    set nocompatible
endif

augroup MyAutoCmd
    autocmd!
augroup END


"""" dein
" source ~/nvimfiles/dein.rc.vim


"""" vim-plug
source ~/nvimfiles/vim-plug.rc.vim


"""" Python provider
if has('mac')
    let g:python3_host_prog = expand('~/.nvim/pynvim/bin/python')
elseif has('win32') || has('win64')
    let g:python3_host_prog = $HOMEPATH.'\nvimenv\pynvim\Scripts\python'
endif

"""" Ruby provider
if has('mac')
    let g:ruby_host_prog = '/usr/local/bin/neovim-ruby-host'
endif

"""" Node.js provider
if has('mac')
    let g:node_host_prog = expand('~/.anyenv/envs/nodenv/versions/12.11.0/bin/neovim-node-host')
endif


"""" Common setting
filetype plugin indent on
syntax enable

set cursorline
set tabstop=4
set shiftwidth=0
set backup
set number
set autochdir
set clipboard=unnamed
set encoding=utf-8
set expandtab
set hidden
set wildmenu
set wildignorecase
set ignorecase
set smartcase
set conceallevel=0
set fileformats=unix,dos,mac
set fileencodings=utf-8,sjis
set nofoldenable
set noswapfile
set termguicolors
set winblend=15
set pumblend=15
set virtualedit+=block
set nohlsearch
set updatetime=100


set tags=.tags;~

set backupdir=~/nvimbackup
set directory=~/nvimbackup

set noundofile
if has('persistent_undo')
    set undodir=~/nvimundo
    set undofile
endif

hi clear CursorLine


"""" Key mappings
source ~/nvimfiles/mappings.rc.vim

"""" FileType settings
source ~/nvimfiles/filetype.rc.vim

"""" Define commands
command! TagsGenerate execute 'silent !ctags -R -f .tags'

"""" Define functions
function! s:execute_ctags() abort
    let tag_name = '.tags'
    let tags_path = findfile(tag_name, '.;')
    if tags_path ==# ''
        return
    endif

    let tags_dirpath = fnamemodify(tags_path, ':p:h')
    execute 'silent cd' tags_dirpath
    execute 'silent !ctags -R -f' tag_name
endfunction

"""" Autocmd
augroup ctags
    autocmd!
    autocmd BufWritePost * call s:execute_ctags()
augroup END

"""" Load local init.vim
if filereadable(expand('~/nvimfiles/local_init.vim'))
    execute 'source' expand('~/nvimfiles/local_init.vim')
endif
