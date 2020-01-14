"curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
""https://github.com/junegunn/vim-plug
"lynx2
"tabular
""ctrlp
call plug#begin('~/.vim/plugged')

"Plug 'SirVer/ultisnips'
"Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

"Plug 'https://github.com/ervandew/supertab.git'
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
"let g:SuperTabDefaultCompletionType = "context"

"Plug 'notomo/ctrlb.nvim', {'do': 'npm run setup'}

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }


" indent
"Plug 'https://github.com/Yggdroot/indentLine.git'
let g:listChar_switch = 1
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
nnoremap <silent> <C-K>t <ESC>:TableModeRealign<CR>
inoremap <silent> <C-K>t <ESC>:TableModeRealign<CR>a
let g:table_mode_corner='|'

"
Plug 'https://github.com/junegunn/vim-easy-align.git'
Plug 'https://github.com/vim-scripts/Align.git'
map <unique> <Leader>tt	<Plug>AM_tt   "to avoid confile map

"Plug 'https://github.com/zxqfl/tabnine-vim.git'
"tabular
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

source ~/.vimrc.coc
source ~/.vimrc.code
source ~/.vimrc.mdp

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
"highlight CursorLine guibg=darkyellow ctermbg=darkgray "修改光标颜色
"highlight CursorColumn guibg=darkyellow ctermbg=darkgray "修改光标颜色
"highlight CursorLine ctermbg=yellow    "darkgray "修改光标颜色
"highlight CursorColumn ctermbg=yellow  "修改光标颜色
"set cursorline " 突出显示当前行
"set cursorcolumn
"set cursorbind
set ruler " 打开状态栏标尺
set nowrap "不换行显示

" 搜索相关
set ignorecase smartcase " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set wrapscan " 在搜索到文件两端时重新搜索
set incsearch " 输入搜索内容时就显示搜索结果
set hlsearch " 搜索时高亮显示被找到的文本

" 移动匹配单词
"autocmd CursorMoved * silent! exe printf('match IncSearch /\<%s\>/', expand('<cword>'))
set updatetime=400
autocmd CursorHold,CursorHoldI * silent! exe printf('match IncSearch /\<%s\>/', expand('<cWORD>'))

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

