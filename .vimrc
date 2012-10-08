call pathogen#infect()

set nocompatible
set encoding=utf-8
filetype plugin indent on       " load file type plugins + indentation
set showcmd                     " display incomplete commands
set history=1000                " Store a ton of history (default is 20)
set hidden                      " auto hide unsaved items in the buffer

" Set to auto read when a file is changed from the outside
set autoread

" add ctrp
set runtimepath^=~/.vim/bundle/ctrlp.vim

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" A mapping to save and then run the current file
" useful for running tests
" map ,t :w\|!ruby %<cr>

" effects the list style when browsing dirs
let g:netrw_liststyle = 3

" Adjust viewports to the same size
map <Leader>= <C-w>=

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" change to current working dir
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Fast saving
nmap <leader>w :w!<cr>

" Easier moving in windows
map <leader>j <C-W>j<C-W>
map <leader>k <C-W>k<C-W>
map <leader>l <C-W>l<C-W>
map <leader>h <C-W>h<C-W>

"" Whitespace
set wrap                        " wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
nnoremap <CR> :noh<CR><CR>      " This unsets the last search pattern register by hitting return

syntax enable
set background=dark
colorscheme solarized

"" user interface
set showmatch                   " Show matching bracets when text indicator is over them
set magic                       " Set magic on, for regular expressions
set number                      " show line numbers
set ruler                       " Always show current position
set cmdheight=2                 " The commandbar height
set ls=2                        " Always show filename
set ruler                       " Show character position
set visualbell t_vb=            " No bell!
set wildmenu                    " show menu with tab completion
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.DS_Store
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
set cursorline
set scrolloff=3                 " minimum lines to keep above and below cursor
set list
set listchars=tab:,.            " Highlight problematic whitespace

" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

" Close the current buffer
map <leader>bd :bd<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

" Always hide the statusline
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ \ Line:\ %l/%L:%c\ \ \ %=\ %y\ [%{(&fenc==\"\"?&enc:&fenc)}]\ %{fugitive#statusline()}

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" show and whitespace hanging around
highlight ExtraWhitespace ctermbg=red guibg=red
augroup WhitespaceMatch
  " Remove ALL autocommands for the WhitespaceMatch group.
  autocmd!
  autocmd BufWinEnter * let w:whitespace_match_number =
        \ matchadd('ExtraWhitespace', '\s\+$')
  autocmd InsertEnter * call s:ToggleWhitespaceMatch('i')
  autocmd InsertLeave * call s:ToggleWhitespaceMatch('n')
augroup END
function! s:ToggleWhitespaceMatch(mode)
  let pattern = (a:mode == 'i') ? '\s\+\%#\@<!$' : '\s\+$'
  if exists('w:whitespace_match_number')
    call matchdelete(w:whitespace_match_number)
    call matchadd('ExtraWhitespace', pattern, 10, w:whitespace_match_number)
  else
    " Something went wrong, try to be graceful.
    let w:whitespace_match_number =  matchadd('ExtraWhitespace', pattern)
  endif
endfunction
