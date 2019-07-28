"curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
""https://github.com/junegunn/vim-plug
"lynx2
"taglist
"tabular
""ctrlp
"conque_term
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'SirVer/ultisnips'
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

Plug 'https://github.com/ervandew/supertab.git'
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabDefaultCompletionType = "context"

" 表格模式
Plug 'https://github.com/dhruvasagar/vim-table-mode.git'
let g:table_mode_corner='|'
" 括号插件
Plug 'https://github.com/kien/rainbow_parentheses.vim.git'
syntax on " 自动语法高亮,下面不要再开这个选项
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound "()
autocmd Syntax * RainbowParenthesesLoadSquare "[]
autocmd Syntax * RainbowParenthesesLoadBraces "{}
"au BufNewFile,BufRead *.c,*.cpp RainbowParenthesesLoadChevrons "<>
Plug 'https://github.com/junegunn/vim-easy-align.git'
"Plug 'https://github.com/vim-scripts/Align.git'
Plug 'https://github.com/zxqfl/tabnine-vim.git'

call plug#end()





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
highlight CursorLine ctermbg=darkgray "修改光标颜色
highlight CursorColumn ctermbg=darkgray "修改光标颜色
set cursorline " 突出显示当前行
"set cursorcolumn
"set cursorbind
set ruler " 打开状态栏标尺
set list listchars=tab:`\  "显示隐藏字符
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

