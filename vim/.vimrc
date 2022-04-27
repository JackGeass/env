"let g:python3_host_prog = '/mnt/d/home/devtools/anaconda3/bin/python3'
"let g:loaded_python3_provider = 0 

"curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
""https://github.com/junegunn/vim-plug
"lynx2
"tabular
""ctrlp
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " File navigator
" Use Ctrl-k Ctrl-k to open a sidebar with the list of files
map <C-k><C-k> :NERDTreeToggle<cr>
let g:netrw_liststyle=3
let g:netrw_banner=0
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " Install fuzzy finder binary
Plug 'junegunn/fzf.vim'               " Enable fuzzy finder in Vim
" Use Ctrl-P to open the fuzzy file opener
nnoremap <C-p> :Files<cr>

Plug 'tpope/vim-sensible'         " Sensible defaults

Plug 'https://github.com/majutsushi/tagbar.git'
nnoremap <silent> <C-K>b <ESC>:TagbarToggle<CR>
"Plug 'SirVer/ultisnips'
"Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

"Plug 'https://github.com/ervandew/supertab.git'
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
"let g:SuperTabDefaultCompletionType = "context"

"Plug 'notomo/ctrlb.nvim', {'do': 'npm run setup'}

Plug 'glench/vim-jinja2-syntax'
" autocmd! BufRead,BufNewFile *.jinja call jinja#AdjustFiletype()
" line break"
Plug 'reedes/vim-pencil'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
let g:mkdp_auto_close = 0 " may in command


" indent
"Plug 'https://github.com/Yggdroot/indentLine.git'
"let g:listChar_switch = 1
"function SwitchListChar()
"if (&g:listChar_switch == 0)
"	set list listchars=tab:┊\  "显示隐藏字符'|', '¦', '┆', '┊'
"	set number
"else if (&g:listChar_switch == 1)
"	set listchars=tab:\ \
"	set nonumber
"endif
"let g:listChar_switch=(g:listChar_switch + 1)/2
"endfunction
"nnoremap <silent> <C-K>l <ESC>:SwitchListChar<CR>
" set list/nolist
set list listchars=tab:┊\  "显示隐藏字符'|', '¦', '┆', '┊'


Plug 'https://github.com/mbbill/undotree.git'
nnoremap <silent> <C-K>u <ESC>:TagbarToggle<CR>

" 训练not hjkl
Plug 'takac/vim-hardtime'
let g:hardtime_default_on = 0
let g:hardtime_maxcount = 10
let g:hardtime_ignore_quickfix = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_ignore_buffer_patterns = [ "CustomPatt[ae]rn", "NERD.*" ]
let g:hardtime_showmsg = 1
let g:hardtime_timeout = 500

" minimap

" 表格模式
Plug 'https://github.com/dhruvasagar/vim-table-mode.git'
"noremap <silent><C-H>:TableModeRealign
noremap <silent> <C-K>t <ESC>:TableModeRealign<CR>a
"inoremap <silent> <C-K>t <ESC>:TableModeRealign<CR>a
let g:table_mode_corner='|'

" 排列工具
Plug 'https://github.com/junegunn/vim-easy-align.git'
Plug 'https://github.com/vim-scripts/Align.git'
map <unique> <Leader>tt	<Plug>AM_tt   "to avoid confile map

"Plug 'https://github.com/zxqfl/tabnine-vim.git'
"tabular
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

" 文字图形
Plug 'gyim/vim-boxdraw'
"set virtualedit+=all
Plug 'https://github.com/vim-scripts/DrawIt'
"\di on  |  \ds off


source ~/.vimrc.coc
Plug 'https://github.com/andys8/vscode-jest-snippets.git'
Plug 'https://github.com/SirVer/ultisnips.git'
source ~/.vimrc.code
source ~/.vimrc.mdp
source ~/.vimrc.theme

" enters insert mode to write vertically,垂直编写
function! VertStart()
    augroup Vert
        autocmd!
        " handles each entered character and moves cursor down
        autocmd InsertCharPre * call feedkeys("\<left>\<down>", 'n')
        autocmd InsertLeave * call VertEnd()
    augroup END

    inoremap <BS> <Up><Del>
    startinsert
endfunction

" cleans up on leaving insert mode
function! VertEnd()
    iunmap <BS>
    augroup Vert
        autocmd!
    augroup END
endfunction

" command to start writing vertically
command! Vert call VertStart()



call plug#end()






" ctrl-c esc
inoremap <silent> <C-C> <ESC>

"------ vim default ----
" 其他
set backupcopy=yes " 设置备份时的行为为覆盖
set noswapfile "no swap files
"set nobackup " 覆盖文件时不备份
"set nowritebackup "only in case you don’t want a backup file while editing
set autochdir " 自动切换当前目录为当前文件所在的目录

" 显示相关
set number " 显示行号
highlight CursorLine guibg=darkyellow ctermbg=darkgray "修改光标颜色
highlight CursorColumn guibg=darkyellow ctermbg=darkgray "修改光标颜色
"highlight CursorLine ctermbg=yellow    "darkgray "修改光标颜色
"highlight CursorColumn ctermbg=yellow  "修改光标颜色
"set cursorline " 突出显示当前行
"set cursorcolumn
"set cursorbind
set ruler " 打开状态栏标尺
set nowrap "不换行显示

" 搜索相关
set ignorecase smartcase " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set hlsearch " 搜索时高亮显示被找到的文本
set wrapscan " 在搜索到文件两端时重新搜索
set incsearch " 输入搜索内容时就显示搜索结果

" 移动匹配单词
"autocmd CursorMoved * silent! exe printf('match IncSearch /\<%s\>/', expand('<cword>'))
set updatetime=400
"autocmd CursorHold,CursorHoldI * silent! exe printf('match IncSearch /\<%s\>/', expand('<cWORD>'))

" tab 相关
"set smarttab "智能tab
set noexpandtab " tab不转换空格
set shiftwidth=4 " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4 " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4 " 设定 tab 长度为 4

"set smartindent

"set cindent

"filetype indent on
" python 重定义
autocmd FileType python set expandtab "tab转为空格
"autocmd FileType python set list listchars=eol:$,tab:`\  
"
"


" XXX
set noerrorbells          " I hate bells
set belloff=esc
set mouse=a               " Enable mouse on all modes
autocmd BufRead,BufNewFile *.md,*.txt setlocal wrap " DO wrap on markdown files
set clipboard=unnamed,unnamedplus     " Use the OS clipboard
set showmatch
set termguicolors
set splitright splitbelow
let &t_SI = "\e[6 q"      " Make cursor a line in insert
let &t_EI = "\e[2 q"      " Make cursor a line in insert
colorscheme gruvbox " Activate the theme

let mapleader = "," " leader 
" Keep VisualMode after indent with > or <
vmap < <gv
vmap > >gv
"
" Move Visual blocks with J an K
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Autocomand to remember las editing position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

