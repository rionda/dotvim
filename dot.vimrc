" To disable a plugin, add it's bundle name to the following list
" XXX It doesn't seem to work...
"let g:pathogen_disabled = []
"call add(g:pathogen_disabled, 'vim-plugin-minbufexpl')
" This is always first because we have pathogen in bundle/
"runtime bundle/vim-pathogen/autoload/pathogen.vim

" This must be first, because it changes other options as side effect
set nocompatible

" Call pathogen to make it easy to install plugins under ~/.vim/bundle
"call pathogen#infect()
"call pathogen#helptags()

" Hide files instead of closing them. You can have unwritten changes to a file
" and open a new file using :e, without being forced to write or undo your
" changes first
set hidden
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set nobackup             " no backup files (different from no swapfiles!)
"set noswapfile          " no swap files (you don't want it for remote connections)
set swapsync=''          " don't force fsync of swapfiles after every write.
set updatetime=100       " write the swapfile every 100ms. Suggested by vim-signify
set directory=$HOME/.vim/swapfiles// " directory for swapfiles. The double slash
                         " enables unique swap filenames.
set autowrite            " saves on certain actions, like make
set autoread             " check for changes outside of vim

let mapleader = ','      " use ',' as the leader
set wildignore=*.swp,*.bak,*.pyc,*.class,*.synctex*,*.aux,*.toc,*.snm,*.nav,*.fdb_latexmk,*.fls,*.gz,*.blg,*.bcf,*.pdf,*.bz2,*.png,*.jpeg,*.jpg,*.gif,*.zip,*.rar,*.tgz,*.tbz,*.docx,*.odp,*.pptx,*.dSYM
set colorcolumn=+1       " highlight the column after textwidth
set termguicolors		 " To have true colors
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set laststatus=2         " always show status
set ruler                " show the ruler
set number               " always show line numbers
set showcmd              " Show number of selected lines (+ others)
"set nomodeline          " ignore modelines at the beginning of files (for the
                         " sake of security)
set textwidth=80         " textwidth is 80 columns
set splitright           " Open new vertical splits to the right
set splitbelow           " Open new horizontal splits on the bottom
set switchbuf=usetab     "When switching between buffers, consider tabs in all
                         "windows. Suggested by command-t
set ttyfast              " Fast terminal connection
set lazyredraw           " Do not redraw while executing background macros and
                         " commands
set mouse=a              " Activate the mouse
set mousehide            " hide mouse pointer while typing
set showmatch            " set show matching parenthesis
set ignorecase           " ignore case when searching
set smartcase            " ignore case if search pattern is all lowercase,
                         " case-sensitive otherwise
set hlsearch             " highlight search terms
set incsearch            " show search matches as you type

" Highlight line number of where cursor currently is
hi CursorLineNr guifg=#050505

set printoptions=paper:letter
"set printexpr=system('open -a Preview '.v:fname_in) + v:shell_error
"
setlocal spell
set spelllang=en_us
let g:tex_comment_nospell=1 " don't spellcheck in latex comments
let g:tex_verbspell=0    " don't spellcheck in latex verbatim environment
" press Ctrl-l while typing to fix the previous mistake
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"set nowrap              " don't wrap lines
set backspace=indent,eol,start " allow backspacing over everything in insert mode
"set autoindent          " always set autoindenting on
set copyindent           " copy the previous indentation on autoindenting
set shiftround           " use multiple of shiftwidth when indenting with '<' and '>'
set tabstop=4            " interpret \t as having a width of 4 spaces
set shiftwidth=4         " set auto-indents to have a width of 4
set softtabstop=4        " set the number of columns for a TAB
set smarttab             " insert tabs on the start of a line according to
                         " shiftwidth, not tabstop

"set clipboard=unnamed " On OSX, use the clipboard for cut and paste
"
" Let vim determine the file type to be edited.
filetype plugin on
filetype indent on
set autoindent

syntax on

set background=dark
if !has("gui_running")
	let g:solarized_termcolors=256
    let g:solarized_termtrans=1
endif
colorscheme solarized8

autocmd BufEnter * silent! lcd %:p:h

let java_highlight_all=1
let java_highlight_functions="style"
let java_allow_cpp_keywords=1

set grepprg=grep\ -nH\ $*

let g:Imap_UsePlaceHolders = 0


" Ignore indents caused by parentheses in FreeBSD style.
"fun! IgnoreParenIndent()
"     let indent = cindent(v:lnum)
"
"     if indent > 4000
"         if cindent(v:lnum - 1) > 4000
"             return indent(v:lnum - 1)
"         else
"             return indent(v:lnum - 1) + 4
"         endif
"     else
"         return (indent)
"     endif
"endfun
"
"" Conform to style(9).
"fun! FreeBSD_Style()
"     setlocal cindent
"     setlocal formatoptions=clnoqrt
"     setlocal textwidth=80
"
"     setlocal indentexpr=IgnoreParenIndent()
"     setlocal indentkeys=0{,0},0),:,0#,!^F,o,O,e
"
"     setlocal cinoptions=(4200,u4200,+0.5s,*500,t0,U4200
"     setlocal shiftwidth=8
"     setlocal tabstop=8
"     setlocal noexpandtab
"endfun

let python_highlight_all = 1
let python_slow_sync = 1

"let g:miniBufExplorerAutoStart = 1
"let g:miniBufExplBuffersNeeded = 1

"map T :TaskList<CR>
"map P :TlistToggle<CR>

set completeopt=menuone,longest,preview

autocmd FileType python setlocal autoindent expandtab textwidth=79 tabstop=8 softtabstop=4 shiftwidth=4 foldmethod=indent foldlevel=99 completeopt-=preview

autocmd FileType sh setlocal autoindent formatoptions=tcq2l textwidth=70 tabstop=4 softtabstop=4 shiftwidth=4 expandtab

autocmd FileType cpp setlocal autoindent expandtab textwidth=80 tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=indent foldlevel=99 keywordprg=cppman

autocmd FileType java setlocal autoindent expandtab textwidth=80 tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=indent foldlevel=99

autocmd filetype crontab setlocal nobackup nowritebackup
au BufNewFile,BufRead crontab.* set nobackup nowritebackup

autocmd filetype html setlocal autoindent expandtab textwidth=80 tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=indent foldlevel=99

autocmd filetype xhtml setlocal autoindent expandtab textwidth=80 tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=indent foldlevel=99

autocmd filetype tex setlocal autoindent expandtab textwidth=80 tabstop=2 softtabstop=2 shiftwidth=2 expandtab

set statusline+=%{fugitive#statusline()}

" Suggested by syntastic README
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_compiler_options = ' -std=c++17'
if has("unix")
    let s:uname = system("uname -s")
    if s:uname == "Darwin\n"
        let g:syntastic_cpp_compiler = '/opt/local/bin/g++'
        let g:syntastic_python_python_exec = '/opt/local/bin/python3'
    endif
endif
let g:syntastic_python_checkers = ['flake8'] "flake8 can be installed via pip3
" We have a different plugin for tex
"let g:syntastic_tex_checkers = ['']
let g:syntastic_disabled_filetypes = ['tex']
let g:syntastic_filetype_map = { "plaintex": "tex", }

let g:gitgutter_max_signs = 2048
let g:signify_vcs_list = [ 'svn' ]

let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor = 'latex'

" Disable overfull/underfull \hbox
let g:vimtex_quickfix_warnings = {
            \  'overfull' : 0,
            \ 'underfull' : 0,
            \}

set foldmethod=syntax
let g:tex_fold_enabled=1
let g:vimsyn_folding='af'

set foldenable
set foldlevel=0
set foldlevelstart=0
" specifies for which commands a fold will be opened
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

let g:vimtex_complete_close_braces = 1
let g:vimtex_complete_recursive_bib = 1
let g:vimtex_indent_enabled = 1
let g:vimtex_fold_enabled = 1
"Suggested by vimtex docs, but gives an error.
"set fillcharsivert:|,fold:\
if has("unix")
    let s:uname = system("uname -s")
    if s:uname == "Darwin\n"
        let g:vimtex_view_method = 'skim'
    endif
endif
" Concealment of LaTeX code
set conceallevel=1
let g:tex_conceal='abdmg'

" LaTeX completion with YouCompleteMe. From the VimTeX docs
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_seed_identifiers_with_syntax = 1
if has("unix")
    let s:uname = system("uname -s")
    if s:uname == "Darwin\n"
        let g:ycm_python_binary_path = '/opt/local/bin/python3'
        let g:ycm_server_python_interpreter = '/opt/local/bin/python3'
    endif
endif
:function! DisableYCMIdCompl()
    let g:ycm_min_num_of_chars_for_completion=1000
    :YcmRestartServer
:endfunction
"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'

"" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-z>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

"let g:autotagCtagsCmd='ctags -a --fields=+l'

nnoremap <F5> :GundoToggle<CR>
