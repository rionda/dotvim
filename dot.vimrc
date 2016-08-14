" To disable a plugin, add it's bundle name to the following list
" XXX It doesn't seem to work...
let g:pathogen_disabled = []
"call add(g:pathogen_disabled, 'vim-plugin-minbufexpl')
" This is always first because we have pathogen in bundle/
runtime bundle/vim-pathogen/autoload/pathogen.vim

" This must be first, because it changes other options as side effect
set nocompatible

" Call pathogen to make it easy to install plugins under ~/.vim/bundle
call pathogen#infect()
call pathogen#helptags()

" Hide files instead of closing them. You can have unwritten changes to a file
" and open a new file using :e, without being forced to write or undo your
" changes firs
set hidden

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set nobackup			 " no backup files (different from no swapfiles!)
"set noswapfile			 " no swap files (you don't want it for remote connections
set directory=$HOME/.vim/swapfiles// " directory for swapfiles

let mapleader = ','		" use ',' as the leader
set wildignore=*.swp,*.bak,*.pyc,*.class
set colorcolumn=+1		 " highlight the column after textwidth
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set mousehide   " hide mouse pointer while typing
set autowrite "saves on certain actions, like make
set laststatus=2 "always show status
"set nomodeline " ignore modelines at the beggining of files (for the sake of security)
set printoptions=paper:letter
set spell
"set nowrap        " don't wrap lines
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set ruler		  " show the ruler
"set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set tabstop=4     " interpret \t as having a width of 4 spaces
set shiftwidth=4  " set auto-indents to have a width of 4
set softtabstop=4 " set the number of columns for a TAB
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set textwidth=80  " textwidth is 80 columns
set showcmd		  " Show number of selected lines (+ others)

syntax on
set background=dark
if !has("gui_running")
	let g:solarized_termtrans=1
endif
colorscheme solarized

" Let vim determine the file type to be edited.
filetype plugin on
filetype indent on
set autoindent

autocmd BufEnter * silent! lcd %:p:h

let java_highlight_all=1
let java_highlight_functions="style"
let java_allow_cpp_keywords=1

set grepprg=grep\ -nH\ $*

let g:Imap_UsePlaceHolders = 0


" Ignore indents caused by parentheses in FreeBSD style.
"fun! IgnoreParenIndent()
" 	let indent = cindent(v:lnum)
"
" 	if indent > 4000
" 		if cindent(v:lnum - 1) > 4000
" 			return indent(v:lnum - 1)
" 		else
" 			return indent(v:lnum - 1) + 4
" 		endif
" 	else
" 		return (indent)
" 	endif
"endfun
"
"" Conform to style(9).
"fun! FreeBSD_Style()
" 	setlocal cindent
" 	setlocal formatoptions=clnoqrt
" 	setlocal textwidth=80
"
" 	setlocal indentexpr=IgnoreParenIndent()
" 	setlocal indentkeys=0{,0},0),:,0#,!^F,o,O,e
"
" 	setlocal cinoptions=(4200,u4200,+0.5s,*500,t0,U4200
" 	setlocal shiftwidth=8
" 	setlocal tabstop=8
" 	setlocal noexpandtab
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

autocmd FileType cpp setlocal autoindent expandtab textwidth=80 tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=indent foldlevel=99

autocmd filetype crontab setlocal nobackup nowritebackup

autocmd filetype html setlocal autoindent expandtab textwidth=80 tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=indent foldlevel=99

autocmd filetype xhtml setlocal autoindent expandtab textwidth=80 tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=indent foldlevel=99

autocmd filetype tex setlocal autoindent expandtab textwidth=80 tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Suggested by syntastic README
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:syntastic_cpp_compiler = '/opt/local/bin/g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_python_python_exec = '/opt/local/bin/python3'
let g:syntastic_python_checkers = ['flake8'] "flake8 can be installed via pip3
" We have a different plugin for tex
let g:syntastic_tex_checkers = ['']
let g:syntastic_disabled_filetypes = ['tex']

let g:gitgutter_max_signs = 2048
let g:signify_vcs_list = [ 'svn' ]

let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor = 'latex'
"let g:Tex_ViewRule_pdf = 'Preview'"
"let g:Tex_ViewRule_pdf = '/Applications/Adobe\ Reader.app/Contents/MacOS/AdobeReader'"

let g:vimtex_quickfix_ignored_warnings = [
\ 'Underfull',
\ 'Overfull',
\ 'specifier changed to',
\ ]

" LaTeX completion with YouCompleteMe. From the VimTeX docs
if !exists('g:ycm_semantic_triggers')
let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
    \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
    \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
    \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
    \ 're!\\(include(only)?|input){[^}]*'
    \ ]

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
"set fillchars=fold:\,vert:| Suggested by vimtex docs, but gives an error.
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'

" This adds a callback hook that updates Skim after compilation
let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
function! UpdateSkim(status)
	if !a:status | return | endif

	let l:out = b:vimtex.out()
	let l:tex = expand('%:p')
	let l:cmd = [g:vimtex_view_general_viewer, '-r']
	if !empty(system('pgrep Skim'))
		call extend(l:cmd, ['-g'])
	endif
	if has('nvim')
		call jobstart(l:cmd + [line('.'), l:out, l:tex])
	elseif has('job')
		call job_start(l:cmd + [line('.'), l:out, l:tex])
	else
		call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
	endif
endfunction
"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'