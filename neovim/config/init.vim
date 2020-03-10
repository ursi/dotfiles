call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'ursi/vim-match'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Elm
Plug 'andys8/vim-elm-syntax'

" Pug
Plug 'digitaltoad/vim-pug'

Plug 'relastle/bluewery.vim'
call plug#end()

let mapleader = "\<Space>"

let gruvbox_invert_tabline = 1
let gruvbox_invert_selection = 0
colorscheme gruvbox

" since this is primarily going to be used for elm for now
let match_autoindent = 0

aug vimrc
	au!
	" highlight trailing whitespace
	au BufRead,SourcePre,WinNew * match trailingwhitespace /\s\+$/

	" ftplugins like to change this setting
	au BufWinEnter * set formatoptions-=o formatoptions -=r

	" make autoread work like gvim
	au FocusGained * :checktime
aug end

"highlight Folded ctermbg=DarkBlue ctermfg=White guibg=#666666 guifg=white
highlight trailingWhitespace ctermbg=Red guibg=red

fu! MapEvery(mapStr)
	"let prefixes = ['', "v", "s", 'l', 't']
	let prefixes = ['', 'v', 's', 'i', 'l', 't']
	let almostAllMapCmds = map(prefixes, 'v:val . "noremap"')
	"let allMapCmds = add(almostAllMapCmds, 'noremap!')
	"let allMaps = map(allMapCmds, 'v:val . " " . a:mapStr')
	let allMaps = map(almostAllMapCmds, 'v:val . " " . a:mapStr')
	cal map(allMaps, 'execute(v:val)')
endf

"cal MapEvery('<Tab> <Esc>')
"cal MapEvery('<BS> <Tab>')
"cnoremap <Tab> <Esc>

noremap <Leader>n :nohlsearch<CR>
noremap <Leader>v :tabedit $MYVIMRC<CR>
noremap <Leader>s :write<CR>:source %<CR>

inoremap <C-J> <Right>

set
\	complete=.
\	foldmethod=indent
\	ignorecase smartcase
\	nofoldenable
\	nowrap
\	relativenumber
\	scrolloff=1 sidescrolloff=1
\	shiftwidth=0 tabstop=4
\	splitbelow splitright
\	wildmode=longest
" ftplugins like to change this setting
"set formatoptions-=o

fu! Init(type)
	let lnum = line(".")
	let lines =readfile(findfile("init/" . a:type . ".init", &runtimepath))
	let first_line = lines[0]
	let rest = lines[1:]
	cal setline(lnum, first_line)
	cal append(lnum, rest)
endf

command! -nargs=1 Init :cal Init(<f-args>)