" This option must be first, because it changes other options as side effect
set nocompatible
" Load the sensible plugin first, as it sets many options that we may want to
" override
runtime! plugin/sensible.vim

"set nomodeline          " ignore modelines at the beginning of files (for the
                         " sake of security)
                         "

" Always start a server (suggested by the vimtex docs)
if empty(v:servername) && exists('*remote_startserver')
    call remote_startserver('VIM')
endif

" File management
set hidden               " hide files instead of closing them. You can have
                         " unwritten changes to a file and open a new file using
                         " :e, without being forced to write or undo your
                         " changes first
set history=1000         " remember more commands and search history
set undolevels=1000      " use many levels of undo
set nobackup             " no backup files (different from no swapfiles!)
"set noswapfile          " no swap files (you don't want it for remote connections)
set swapsync=''          " don't force fsync of swapfiles after every write.
set updatetime=100       " write the swapfile every 100ms. Suggested by vim-signify
set directory=$HOME/.vim/swapfiles// " directory for swapfiles. The double slash
                         " enables unique swap filenames.
set autowrite            " saves on certain actions, like make
set autoread             " check for changes outside of vim
set wildignore=*.swp,*.bak,*.pyc,*.class,*.synctex*,*.aux,*.toc,*.snm,*.nav,*.fdb_latexmk,*.fls,*.gz,*.blg,*.bcf,*.pdf,*.bz2,*.png,*.jpeg,*.jpg,*.gif,*.zip,*.rar,*.tgz,*.tbz,*.docx,*.odp,*.pptx,*.dSYM " list of extensions to ignore

" Appearance
set ttyfast              " assume a fast terminal connection
set title                " change the terminal's title
set lazyredraw           " do not redraw while executing background macros and
                         " commands. Makes the macro faster (folklore?)
set mouse=a              " activate the mouse
set mousehide            " hide mouse pointer while typing
set textwidth=80         " textwidth is 80 columns
set visualbell           " don't beep
set noerrorbells         " don't beep
set laststatus=2         " always show status
set ruler                " show the ruler
set number               " always show line numbers
set colorcolumn=+1       " highlight the column after textwidth
set showcmd              " show number of selected lines (+ others)
set splitright           " open new vertical splits to the right
set splitbelow           " open new horizontal splits on the bottom
set switchbuf=usetab     " when switching between buffers, consider tabs in all
                         " windows. Suggested by command-t
set cursorline           " highlight the line of the cursor
set scrolloff=12         " keep at least 12 lines above and below the cursor
" Highlight line number of where cursor currently is
hi CursorLineNr guifg=#050505
syntax on                " enable syntax highlighting
set foldenable           " enable folding
set foldlevel=0          " start with all folds closed
set foldlevelstart=0     " set foldlevel to zero when editing another buffer
" specifies for which commands a fold will be opened
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
" Slightly cleaner fold text (note the whitespace after backslash)
set fillchars="fold:\ "
"set showmatch            " when inserting a parenthesis, briefly jump to the
                         "matching one. XXX: Disabling because it seems to "eat"
                         " characters from completion and others
set matchtime=2          " tenths of a second to show the matching parenthesis
"set nowrap              " don't wrap lines
set termguicolors        " enable true colors, assuming that our terminal
                         " supports them. Disable if it doesn't (in 2020?)
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum" " Additional instructions for true
                                        "colors, needed in tmux
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum" " As above.
set background=dark      " we use a dark background
colorscheme solarized8   " use the solarized8 coloscheme

" Searching
set ignorecase           " ignore case when searching
set smartcase            " ignore case if search pattern is all lowercase,
                         " case-sensitive otherwise
set hlsearch             " highlight search terms
set incsearch            " show search matches as you type

" Printing
set printoptions=paper:letter
"set printexpr=system('open -a Preview '.v:fname_in) + v:shell_error

" Spellcheck
setlocal spell
set spelllang=en_us
" press Ctrl-l while typing to fix the previous mistake
" from https://castel.dev/post/lecture-notes-1/
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Editing and indenting
set backspace=indent,eol,start " allow backspacing over everything in insert mode
"set autoindent          " always set autoindenting on
set copyindent           " copy the previous indentation on autoindenting
set shiftround           " use multiple of shiftwidth when indenting with '<' and '>'
set tabstop=4            " interpret \t as having a width of 4 spaces
set shiftwidth=4         " set auto-indents to have a width of 4
set softtabstop=4        " set the number of columns for a TAB
set smarttab             " insert tabs on the start of a line according to
                         " shiftwidth, not tabstop
set timeoutlen=200       " millisecs timeout waiting for completion of mappings
"set clipboard=unnamed " On OSX, use the clipboard for cut and paste. It's
                         "easier to use the '*' register (see help quotestar)
set grepprg=grep\ -nH\ $* " Set the program for :grep.
                          " -H prints the filename in the header
                          " -n prints the line number
                          "    $* is used for additional arguments
set nojoinspaces          " use one space after a period when joining lines

" Interaction and custom mapping
let mapleader=','      " use ',' as the leader
" Use ,t to open a terminal
nmap <leader>t    :terminal<CR>

" Replace three dots with the horizontal ellipsis
inoreabbrev ...  …

" Automatic actions on start and on entering buffers
autocmd VimEnter * silent! helptags ALL " Generate help tags files on start
autocmd BufEnter * silent! lcd %:p:h " Set the current directory to the
                                     " directory of the file edited in
                                     " the window where the cursor is

set completeopt=menuone,longest,preview " autocompletion settings

" Filetype stuff
filetype on                " Enable detection of type of file to be edited
filetype plugin on         " Enable loading filetype-specific plugin files
filetype indent on         " Enable loading of filetype-specific indent files

" CPP settings
autocmd FileType cpp setlocal autoindent expandtab textwidth=80 tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=indent foldlevel=99 keywordprg=cppman

" Crontab settings
autocmd FileType crontab setlocal nobackup nowritebackup
autocmd BufNewFile,BufRead crontab.* set nobackup nowritebackup

" HTML settings
autocmd filetype html setlocal autoindent expandtab textwidth=80 tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=indent foldlevel=99
autocmd filetype xhtml setlocal autoindent expandtab textwidth=80 tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=indent foldlevel=99

" Java settings
autocmd FileType java setlocal autoindent expandtab textwidth=80 tabstop=4 softtabstop=4 shiftwidth=4
let java_highlight_all=1 " Enable all possible Java highlighting
let java_highlight_functions="style" " Highlight functions using Java style
let java_allow_cpp_keywords=1 " Don't flag C++ keywords as errors (?)

" Markdown settings. See also the settings for the vim-markdown plugin below
autocmd FileType markdown setlocal autoindent expandtab textwidth=80 tabstop=4 softtabstop=4 shiftwidth=4

" Python settings
autocmd FileType python setlocal autoindent expandtab textwidth=79 tabstop=8 softtabstop=4 shiftwidth=4 foldmethod=indent foldlevel=99 completeopt-=preview
let python_highlight_all=1 " Enable all possible Python highlighting

" sh/bash settings
autocmd FileType sh setlocal autoindent formatoptions=tcq2l textwidth=70 tabstop=4 softtabstop=4 shiftwidth=4 expandtab
let g:sh_fold_enabled= 7 " Enable folding of functions, heredoc, and if/do/for

" Tex settings. More settings for the vimtex plugin are below
autocmd FileType tex setlocal autoindent expandtab textwidth=80 tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vimtex not being loaded.
" The following option resets the default filetype to 'tex'
let g:tex_flavor = 'latex'
let g:tex_comment_nospell=1 " don't spellcheck in latex comments
let g:tex_verbspell=0       " don't spellcheck in latex verbatim environment
set conceallevel=1          " Concealment of LaTeX code
let g:tex_conceal='abdmg'   " Conceal accents, bold and italic, delimiters,
                            " math symbols, and Greek letters. Adding 's' would
                            " enable concealment for superscript and subscripts.
"let g:tex_fold_enabled=1    " Enable syntax folding in tex files. Despite the
                            "use of the FastFold plugin, it seems very slow,
                            "likely because it clashes with the vimtex plugin.

" vim files
let g:vimsyn_folding='af'   " fold augroups and functions

"Plugin settings

" airline plugin
if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif
let g:airline_symbols.crypt='🔒'
let g:airline_symbols.dirty='⚡'
let g:airline_symbols.linenr=''
let g:airline_symbols.maxlinenr=''
"let g:airline_symbols.readonly='🔒'
let g:airline_symbols.readonly='🔏'
"let g:airline_symbols.spell='SPL'
let g:airline_symbols.spell='📖'
let g:airline_section_y=''        " we don't care about fileencoding, fileformat
let g:airline_section_x=''        " or about tagbar, filetype, virtualenv
"custom z section to only have line/totaline:column
let g:airline_section_z='%#__accent_bold#%{g:airline_symbols.linenr}%l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__#:%v'
" airline ALE extension symbols
let airline#extensions#ale#warning_symbol='❗️'
let airline#extensions#ale#error_symbol='❌'

" ALE plugin
" Some stuff is from https://www.lucasfcosta.com/2019/02/10/terminal-guide-2019.html
let g:ale_open_list=1 " Make ALE automatically open the loclist window
" Make Ale close the loclist window when the buffer is closed
augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END
let g:ale_fix_on_save=1 " fix files on save
" lint after 1000ms after changes are made
let g:ale_lint_delay=1000
" use nice symbols for errors and warnings
"let g:ale_sign_error= ✗\ '
let g:ale_sign_error='❌'
"let g:ale_sign_warning='🚨'
let g:ale_sign_warning='❗️'
"let g:ale_sign_warning='!'
let g:ale_sign_info='💡'
let g:ale_sign_style_error='🖍'
"let g:ale_sign_style_warning='✏'
let g:ale_sign_style_warning='🖌'
" fixer configurations: always remove trailing lines
let g:ale_fixers = {
\   '*': ['remove_trailing_lines'],
\}
let g:ale_cpp_clang_options="-std=gnu++17 -Wall -Wextra -Werro -pedantic -pedantic-errors -Wformat=2 -Wpointer-arith -Wcast-qual -fexceptions -fopenmp"
let g:ale_python_flake8_executable='/opt/local/bin/flake8'
let g:ale_python_flake8_use_global=1

" calendar plugin
let g:calendar_google_calendar=1        " show events from google calendar
let g:calendar_frame = 'unicode_double' " show a better frame XXX (doesn't work?)
let g:calendar_first_day="monday"		" my week starts on Monday
let g:calendar_date_month_name=1		" show the name of the month
let g:calendar_view="week"				" show week view by default
let g:calendar_cyclic_view=1			" cycle through views with < and >
let g:calendar_task_width = 0
"source ~/.cache/calendar.vim/credentials.vim
source ~/.cache/calendar.vim/credentials-amherst.vim
" filetype autocmd for the calendar. Drawing the calendar is a bit slow, so give
" it more time.
autocmd FileType calendar setlocal nospell redrawtime=10000
" trailing spaces are highlighted in calendar, probably by solarized8. Just don't.
autocmd FileType calendar match ErrorMsg ''

" Ctrl-P plugin
let g:ctrlp_map = '<leader>b' " Activate Ctrl-P with ,b
let g:ctrlp_cmd = 'CtrlPBuffer' " Default Ctrl-P to allow selection of buffers.

" Fugitive plugin
set statusline+=%{fugitive#statusline()} " Add git info to status line

" indent_guides plugin
let g:indent_guides_enable_on_vim_startup=1 " enable plugin on startup
let g:indent_guides_start_level=2        " show the guides starting at level 2
let g:indent_guides_guide_size=1        " use skinny guides of a single char
let g:indent_guides_exclude_filetypes=['help', 'calendar'] " disable on some file types

" markdown plugin
let g:vim_markdown_conceal=1 " use concealement in markdown files

" notmuch_address plugin

" signify plugin
let g:signify_sign_change='~' " use tilde for changed lines

" tex-conceal plugin
" Avoid having inscrutable utf-8 glyphs appear
let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"

" trailing-whitespace plugin
let g:extra_whitespace_ignored_filetypes=['calendar', 'help']

" UltiSnips plugin
" The snippets definition are in the UltiSnips directory
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" vimtex plugin
let g:vimtex_fold_enabled = 1 " custom vimtex folding (0 = disabled)
let g:vimtex_fold_manual = 1  "  update the folds manually
let g:vimtex_indent_enabled = 1 " custom vimtex indentation
let g:vimtex_complete_close_braces = 1 " close the brace after a label/citation
" Autoload extra syntax support for amsmath, cleveref, natbib
let g:vimtex_syntax_autoload_packages = ['amsmath', 'cleveref', 'natbib']
" Disable overfull/underfull \hbox warnings
let g:vimtex_quickfix_latexlog = {
            \  'overfull' : 0,
            \ 'underfull' : 0,
            \}
" Enable the use of skim as the viewer when on OSX
if has("unix")
    let s:uname = system("uname -s")
    if s:uname == "Darwin\n"
        let g:vimtex_view_method = 'skim'
    endif
endif

" YouCompleteMe plugin
"let g:ycm_add_preview_to_completeopt = 1 " Add more info for semantic completion.
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_complete_in_comments = 1
"let g:ycm_collect_identifiers_from_comments_and_strings = 1
"let g:ycm_collect_identifiers_from_tags_files = 1
" To avoid conflict with UltiSnips, use Ctrl-j and Ctrl-k to move between
" completions, not tab.
" See also https://github.com/ycm-core/YouCompleteMe/issues/36
let g:ycm_key_list_select_completion=['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-k>', '<Up>']

" Set the Python path on OSX
if has("unix")
    let s:uname = system("uname -s")
    if s:uname == "Darwin\n"
        let g:ycm_python_binary_path = '/opt/local/bin/python3'
        let g:ycm_server_python_interpreter = '/opt/local/bin/python3'
    endif
endif
" disable the YCM identifier completer.
function! DisableYCMIdCompl()
    if exists("g:ycm_min_num_of_chars_for_completion")
        if g:ycm_min_num_of_chars_for_completion < 99
            let g:ycm_min_num_of_chars_for_completion = 99
            "if g:loaded_youcompleteme
            "    call YcmRestartServer
            "endif
        endif
    else
        let g:ycm_min_num_of_chars_for_completion = 99
    endif
endfunction
" LaTeX completion with YouCompleteMe. From the vimtex docs
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
autocmd VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme
autocmd FileType tex call DisableYCMIdCompl()
" Email address completion with YouCompleteMe with not muchaddress
autocmd VimEnter * unlet g:ycm_filetype_blacklist.mail
autocmd VimEnter * let g:ycm_semantic_triggers.mail=g:notmuchaddress#config#ycmtrigger
autocmd FileType mail call DisableYCMIdCompl()

"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'

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
