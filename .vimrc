" ============================================================================
"				<< 基判断操作系统是否是 Windows 还是 Linux >>								
" ============================================================================
let g:iswindows = 0
let g:islinux 	= 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux 	= 1
endif

" nocompatible就是不兼容,具体是不兼容什么，简单点说就是很老的vi的格式。vim是vi的扩展，nocompatible就是指vim在工作的时候不需要考虑和vi兼容
set nocompatible    "关闭兼容模式

" ============================================================================
"							<< 基本设定 >>								
" ============================================================================

" ---界面设置
	" colorscheme molokai         " 设定配色方案
	colorscheme Tomorrow-Night-Eighties         " 设定配色方案
	" colorscheme dracula         " 设定配色方案

au GUIEnter * simalt ~x		" 启动窗口最大化
syntax on                   " 自动语法高亮
set number                  " 显示行号
set cursorline              " 高亮显示当前行
set cursorcolumn			" 高亮显示当前列
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏
set guioptions-=r 			" 关闭右侧滚动条
set guioptions-=L 			" 关闭左侧滚动条
set mouse=a                 " 使能鼠标滚轮

" ---缩进设置
set expandtab				" tab转为空格
set tabstop=4               " 设定 tab 长度为 4
set shiftwidth=4			" (shift)+(</>)时对齐长度为 4
set smartindent				" 为C程序提供自动缩进
set cindent					" 使用C样式的缩进

" ---搜索设置
set ignorecase				" 搜索忽略大小写
set incsearch               " 输入搜索内容时就显示搜索结果
set hlsearch                " 搜索时高亮显示被找到的文本
set magic                   " 设置魔术(正则表达式:除了 $ . * ^ 之外其他元字符都要加反斜杠)
" set nowrapscan              " 禁止在搜索到文件两端时重新搜索

" ---文件操作
set nobackup				"不生成备份文件
set autowrite				"自动写入缓冲区

" ---Set to auto read when a file is changed from the outside
if exists("&autoread")
set autoread
endif


" ---开启保存 undo 历史功能
set undofile
if (g:islinux)
	set undodir=~/.undo_history/ "undo历史保存路径
else
	set undodir=$vim/vimfiles/undo_history/ "undo历史保存路径
endif

" ---关闭 preview窗口
set completeopt-=preview


" ============================================================================
"							<< 编码设定 >>								
" ============================================================================
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                                    "设置gvim内部编码
set fileencoding=utf-8                                "设置当前文件编码
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "设置支持打开的文件的编码

" 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新文件的<EOL>格式
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型

if (g:iswindows)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "解决consle输出乱码
    language messages zh_CN.utf-8
endif


" ============================================================================
"							<< 插件配置 >>								
" ============================================================================
"
" -------------------------------------------------------------
"  < vundle 插件配置 >
" -------------------------------------------------------------
filetype off	"禁用文件类型侦测

if (g:islinux)
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
else
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
endif

" ---Let Vundle manage Vundle
" ~~~用于管理(安装与卸载)从 "https://github.com" 上下载的插件
Bundle 'gmarik/vundle'

" ---Define bundles via Github repos
" ~~~ctrlp用于文件搜索，ctrlpfunky用于搜索当前C/C++文件里的函数
let g:ctrlp_en = 0
if (g:ctrlp_en)
	Bundle 'kien/ctrlp.vim'
	Bundle 'tacahiroy/ctrlp-funky'
endif
" ~~~文件搜索(比ctrlp搜索更全)，genutils为lookupfile辅助插件，必须同时存在
let g:lookupfile_en = 1
if (g:lookupfile_en)
	Bundle 'vim-scripts/lookupfile'
	Bundle 'vim-scripts/genutils'
endif
" ~~~显示当前文件夹目录结构
let g:nerdtree_en = 1
if (g:nerdtree_en)
	Bundle 'scrooloose/nerdtree'
endif
" ~~~显示当前文件 所在路径/编码格式/光标所在文件百分比/行列号
let g:powerline_en = 0
if (g:powerline_en)
	Bundle 'Lokaltog/vim-powerline'
endif
" ~~~光标停留时显示函数原型提示
let g:echofunc_en = 0
if (g:echofunc_en)
	Bundle 'mbbill/echofunc'
	" Bundle 'vim-scripts/echofunc.vim'
endif
" ~~~注释与反注释所选内容(两个插件可以二选一)
let g:tcomment_en = 1
if (g:tcomment_en)
	Bundle 'vim-scripts/tComment'
	" Bundle 'scrooloose/nerdcommenter'
endif
" ~~~显示当前文件 宏定义/变量/函数 列表
let g:taglist_en = 1
if (g:taglist_en)
	Bundle 'vim-scripts/taglist.vim'
endif
" ~~~补全关键字
if !empty(glob("./compile_commands.json"))
    let g:neocomplcache_en = 0
else
    let g:neocomplcache_en = 1
endif
if (g:neocomplcache_en)
	Bundle 'Shougo/neocomplcache.vim'
endif
" ~~~C/C++结构体补全
if !empty(glob("./compile_commands.json"))
    let g:OmniCppComplete_en = 0
else
    let g:OmniCppComplete_en = 1
endif
if (g:OmniCppComplete_en)
	Bundle 'vim-scripts/OmniCppComplete'
endif
" ~~~C语言语法高亮
let g:std_c_en = 1
if (g:std_c_en)
	Bundle 'vim-scripts/std_c.zip'
endif
" ~~~重复上次操作
let g:repeat_en = 1
if (g:repeat_en)
	Bundle 'tpope/vim-repeat'
endif
" ~~~显示之前打开过的窗口的缓存列表
let g:bufexplorer_en = 1
if (g:bufexplorer_en)
	Bundle 'jlanzarotta/bufexplorer'
endif
" ~~~增加多窗口标签功能
let g:minibufexpl_en = 0
if (g:minibufexpl_en)
	Bundle 'fholgado/minibufexpl.vim'
endif
" ~~~书签提示
let g:signature = 0
if (g:signature)
	Bundle 'kshenoy/vim-signature'
	" Bundle 'vim-scripts/BOOKMARKS--Mark-and-Highlight-Full-Lines'
endif
" ~~~文本查找与替换
let g:easygrep = 1
if (g:easygrep)
	Bundle 'dkprice/vim-easygrep'
endif
" ~~~状态栏+minibuf显示工具
let g:airline_en = 1
if (g:airline_en)
	Bundle 'vim-airline/vim-airline'
	Bundle 'vim-airline/vim-airline-themes'
	Bundle 'tpope/vim-fugitive'
endif
" ~~~语法自动补全
if !empty(glob("./compile_commands.json"))
    let g:youcompleteme_en = 0
else
    let g:youcompleteme_en = 0
endif
if (g:youcompleteme_en)
	Bundle 'Valloric/YouCompleteMe'
endif
" ~~~ctrlsf文本查找
let g:ctrlsf_en = 0
if (g:ctrlsf_en)
	Bundle 'dyng/ctrlsf.vim'
endif
" ~~~同时选中编辑同一文件内相同字符串
let g:multiple_cursors_en = 1
if (g:multiple_cursors_en)
	Bundle 'terryma/vim-multiple-cursors'
endif
" ~~~分支undo
let g:gundo_en = 1
if (g:gundo_en)
	Bundle 'sjl/gundo.vim'
endif
" ~~~光标快速定向移动
let g:easymotion_en = 1
if (g:easymotion_en)
    Bundle 'easymotion/vim-easymotion'
endif
" ~~~多个关键字高亮
let g:interestingwords_en = 1
if (g:interestingwords_en)
    Bundle 'lfv89/vim-interestingwords'
endif
" ~~~不同颜色标识匹配括号
let g:rainbow_parentheses = 1
if (g:rainbow_parentheses)
    Bundle 'kien/rainbow_parentheses.vim'
endif
" ~~~代码缩进提醒
let g:indentLine_en = 1
if (g:indentLine_en)
    Bundle 'Yggdroot/indentLine'
endif
" ~~~代码补全
let g:code_complete = 1
if (g:code_complete)
    Bundle 'mbbill/code_complete'
endif
" ~~~代码缩略图
let g:code_minimap = 0
if (g:code_minimap)
    " Bundle 'severin-lemaignan/vim-minimap'
    Bundle 'koron/minimap-vim'
endif

let g:gitblame_en = 1
if (g:gitblame_en)
    Bundle 'zivyangll/git-blame.vim'
endif

filetype on

" -------------------------------------------------------------
"  < ctrlp-funky 插件配置 >
" -------------------------------------------------------------
"---作用：搜索当前窗口文件匹配的关键字，并全部将相关匹配选项显示到ctrlp窗口
if (g:ctrlp_en)
	nnoremap <Leader>fu :CtrlPFunky<Cr>
	" narrow the list down with a word under cursor
	nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
	" highlight feature
	let g:ctrlp_funky_matchtype = 'path'
	" 高亮显示高级语言关键字
	let g:ctrlp_funky_syntax_highlight = 1
endif

" -------------------------------------------------------------
"  < vim-powerline 插件配置 >
" -------------------------------------------------------------
"---作用：在命令窗口上显示当前文件“编码方式”、“文件类型”、“当前光标所在文件位置”、“行列号“
"---副作用：令ctrlp,ctrlp-funky插件颜色更好看
if (g:powerline_en)
	" open a powerline quickly when vim starts up
	let g:Powerline_symbols = 'fancy'

	" Always show the statusline
	set laststatus=2   

	" 解决windows & linux下部分特殊符号显示出错的问题，需要安装4个特殊字体到系统
	" 下载源地址：https://github.com/eugeii/consolas-powerline-vim
	" 安装方法：打开"LINUX_TOOL/vim/.vim/fonts/consolas-powerline-vim-master"，双击.ttf结尾的字体文件即可(windows 和 linux下安装方法相同)
	" set guifont=Courier_New:h13:cANSI " 字体字号设置：h13代表字号
	set guifont=Consolas\ for\ Powerline\ FixedD:h13 " 字体字号设置：h13代表字号
endif

" -------------------------------------------------------------
"  < vim-airline 插件配置 >
" -------------------------------------------------------------
if (g:airline_en)
	" Always show the statusline
	set laststatus=2   

	let g:airline_powerline_fonts = 1

	let g:airline#extensions#syntastic#enabled = 1

	" enable/disable fugitive/lawrencium integration
	" let g:airline#extensions#branch#enabled = 1
	" let g:airline#extensions#branch#vcs_priority = ["git"]
	"
	" enable/disable detection of whitespace errors. >
	let g:airline#extensions#whitespace#enabled = 0
	let g:airline#extensions#whitespace#symbol = '!'

	" enable/disable enhanced tabline. (c)
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#buffer_nr_show = 0
	let g:airline#extensions#tabline#buffer_idx_mode = 1

	" switch position of buffers and tabs on splited tabline (c)
	" let g:airline#extensions#tabline#switch_buffers_and_tabs = 1

	let g:airline#extensions#tabline#show_splits = 1
	" let g:airline#extensions#tabline#show_buffers = 0
	" let g:airline#extensions#tabline#show_tabs= 1
	" let g:airline#extensions#tabline#show_tab_nr = 0
	let g:airline#extensions#tabline#show_tab_type = 0 "不显示"buffers"

	" Show just the filename
	let g:airline#extensions#tabline#fnamemod = ':t'
	""
	nmap <leader>1 <Plug>AirlineSelectTab1
	nmap <leader>2 <Plug>AirlineSelectTab2
	nmap <leader>3 <Plug>AirlineSelectTab3
	nmap <leader>4 <Plug>AirlineSelectTab4
	nmap <leader>5 <Plug>AirlineSelectTab5
	nmap <leader>6 <Plug>AirlineSelectTab6
	nmap <leader>7 <Plug>AirlineSelectTab7
	nmap <leader>8 <Plug>AirlineSelectTab8
	nmap <leader>9 <Plug>AirlineSelectTab9
	" nmap <leader>- <Plug>AirlineSelectPrevTab
	" nmap <leader>+ <Plug>AirlineSelectNextTab
	"

	" fix exit insert mode delay
	set ttimeoutlen=50   
	" theme:dark light simple badwolf molokai base16 murmur luna wombat bubblegum jellybeans laederon
	"papercolor kolor kalisi behelit base16color 
	if (g:iswindows)
		let g:airline_theme='kolor'
	else
		" let g:airline_theme='dracula_new'
		let g:airline_theme='kolor'
	endif

	set guifont=Ubuntu_Mono_derivative_Powerlin:h14:cANSI " 字体字号设置：h13代表字号
	" set guifont=Ubuntu\ Mono\ derivative\ Powerline\ Regular:h13:cANSI " 字体字号设置：h13代表字号
	" set guifont=Droid_Sans_Mono_Slashed_for_Pow:h13:cANSI " 字体字号设置：h13代表字号
	" set guifont=Hack:h13:cANSI " 字体字号设置：h13代表字号
	"set guifont=Consolas\ for\ Powerline\ FixedD:h13 " 字体字号设置：h13代表字号
" function! MyOverride(...)
"     	call a:1.add_section('StatusLine'       ,           'all')
"     	call a:1.add_section('Tag'       ,           'your')
"     	call a:1.add_section('Search'       ,           'base')
"     	call a:1.add_section('Title'       ,           'are')
"     	call a:1.add_section('TabLineSel'       ,           'belong')
"     	call a:1.add_section('ErrorMsg'       ,           'to')
"     	call a:1.add_section('StatusLineNC'       ,           '%f')
"     	call a:1.split()
"     	call a:1.add_section('Error'       ,           '%p%%')
" 	return 1
" endfunction
" call airline#add_statusline_func('MyOverride')

" function! AccentDemo()
"   let keys = ['a','b','c','d','e','f','g','h']
"   for k in keys
"     call airline#parts#define_text(k, k)
"   endfor
"   call airline#parts#define_accent('a', 'red')
"   call airline#parts#define_accent('b', 'green')
"   call airline#parts#define_accent('c', 'blue')
"   call airline#parts#define_accent('d', 'yellow')
"   call airline#parts#define_accent('e', 'orange')
"   call airline#parts#define_accent('f', 'purple')
"   call airline#parts#define_accent('g', 'bold')
"   call airline#parts#define_accent('h', 'italic')
"   let g:airline_section_a = airline#section#create(keys)
" endfunction
" autocmd VimEnter * call AccentDemo()

" function! AirlineInit()
	" let g:airline_section_b = airline#section#create_left(['%{EchoFuncGetStatusLine()}'])
" endfunction
" autocmd VimEnter * call AirlineInit()
"
let g:airline#extensions#tagbar#flags = 'f'  " show full tag hierarchy

fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map ff :call ShowFuncName() <CR>

endif

" -------------------------------------------------------------
"  < nerdtree 插件配置 >
" -------------------------------------------------------------
if (g:nerdtree_en)
	" open a NERDTree automatically when vim starts up
	" autocmd vimenter * NERDTree
	" open a NERDTree automatically when vim starts up if no files were specified
	"autocmd StdinReadPre * let s:std_in=1
	"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
	" close vim if the only window left open is a NERDTree
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	map <F2> :NERDTreeToggle<CR>
endif
    "文件(夹)过滤
    let NERDTreeIgnore=['\.d$[[file]]', '\.o$[[file]]']
    " let NERDTreeIgnore=['temp$[[dir]]']
    "显示增强
    " let NERDChristmasTree=1
    "打开文件后自动关闭
    let NERDTreeQuitOnOpen=0
    "高亮显示当前文件或目录
    let NERDTreeHighlightCursorline=1
    "窗口位置
    let NERDTreeWinPos='left'
    "窗口宽度
    let NERDTreeWinSize=31
    "不显示'Bookmarks' label 'Press ? for help'
    let NERDTreeMinimalUI=1
    "显示行号
    let NERDTreeShowLineNumbers=0

" 常用快捷键(要将光标跳到NERDTree窗口)
	" I : 显示隐藏文件
	" o : 打开目录折叠或者打开文件并跳到该文件窗口
	" O : 递归 打开选中结点下的所有目录
	" x : 合拢选中结点的父目录
	" X : 递归 合拢选中结点下的所有目录
	" r : 递归刷新选中目录
	" R : 递归刷新根结点

" -------------------------------------------------------------
"  < nerdcommenter 插件配置 >
" -------------------------------------------------------------
if (g:tcomment_en)
	" <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
	" <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
	" <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
	" <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
	" <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
	" <Leader>cA 行尾注释
	let NERDSpaceDelims = 1                     "在左注释符之后，右注释符之前留有空格
endif

" -------------------------------------------------------------
"  < lookupfile 插件配置 >
" -------------------------------------------------------------
" 功能说明：高亮显示C语言语法
" 使用说明：vim 启动时自动生效
" 帮助文件：有，命令(:h lookupfile)
" 自带快捷键：没有
" 自定义快捷键："ctrl + f"
if (lookupfile_en)
	let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
	let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
	let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
	let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
	let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
	if filereadable("filenametags")                "设置tag文件的名字
		let g:LookupFile_TagExpr = '"./filenametags"'
	endif
	nmap <c-f> :LookupFile<CR>
endif

" -------------------------------------------------------------
"  < std_c 插件配置 >
" -------------------------------------------------------------
" 功能说明：高亮显示C语言语法
" 使用说明：vim 启动时自动生效
" 帮助文件：有，命令(:h std_c)
" 自带快捷键：没有
" 自定义快捷键：没有
if (g:std_c_en)
	" 停止 // 深色注视风格
	let c_cpp_comments = 1
endif

" -------------------------------------------------------------
"  < neocomplcache 插件配置 >
" -------------------------------------------------------------
" 功能说明：补全 关键字/函数名/变量/结构体成员
" 			(其实vim自身已携带此功能，当没有该插件时需要手动 "ctrl + n" 激活补全功能
" 使用说明：vim 启动时自动生效，建议通过 "ctrl + j" "ctrl + k" 上下选择，按下"Enter"后确定
" 插件缺陷：在弹出补全列表后用 <c-p> 或 <c-n> 进行上下选择后按下 "Enter" 键会导致换行
" 帮助文件：有，命令(:h neocomplcache)
" 自带快捷键：	"ctrl + n"	选择下一个
" 				"ctrl + p"	选择上一个
" 自定义快捷键：没有
if (g:neocomplcache_en)
	" 关键字补全、文件路径补全、tag补全等等，各种，非常好用，速度超快。
	let g:neocomplcache_enable_at_startup = 1     "vim 启动时启用插件
	" let g:neocomplcache_disable_auto_complete = 1 "不自动弹出补全列表
endif


" -------------------------------------------------------------
"  < TagList 插件配置 >
" -------------------------------------------------------------
" 功能说明：列出了当前文件中的所有 宏/全局变量/函数名 列表，就像vc中的workpace
" 使用说明：常规模式下键入 tl 调用插件，并于最右生成列表窗口
" 插件引起问题：新建 quickfix 窗口时会挤到 taglist 窗口下方，影响 quickfix 阅览
" 帮助文件：有，命令(:h taglist)
" 自带快捷键：没有
" 自定义快捷键："tl"
if (g:taglist_en)
	" 如果有打开 Tagbar 窗口则先将其关闭
	" nmap tl :TagbarClose<CR>:Tlist<CR>
	nmap tl :Tlist<CR>
	let Tlist_Show_One_File=1                   "只显示当前文件的tags
	" let Tlist_Enable_Fold_Column=0              "使taglist插件不显示左边的折叠行
	let Tlist_Exit_OnlyWindow=1                 "如果Taglist窗口是最后一个窗口则退出Vim
	let Tlist_File_Fold_Auto_Close=1            "自动折叠
	let Tlist_WinWidth=30                       "设置窗口宽度
	let Tlist_Use_Right_Window=1                "在右侧窗口中显示
endif

" -------------------------------------------------------------
"  < echofunc 插件配置 >
" -------------------------------------------------------------
if (g:echofunc_en)
    "Because the message line often cleared by some other plugins (e.g. ominicomplete), an other choice is to show message in status line.First, add  %{EchoFuncGetStatusLine()}  to your 'statusline' option.
    let g:EchoFuncShowOnStatus = 0
    " set statusline=%{EchoFuncGetStatusLine()}
    let g:EchoFuncAutoStartBalloonDeclaration = 1
endif

" -------------------------------------------------------------
"  < easygrep 插件配置 >
" -------------------------------------------------------------
" 详细参考 "~/.vim/bundle/vim-easygrep/README.md"
if (g:easygrep)
	nmap <silent><Leader>vs <Leader>vv :ccl<CR> :botright copen 6<CR>
	nmap <silent><Leader>vt <Leader>vV :ccl<CR> :botright copen 6<CR>
	nmap <silent><Leader>vr <Leader>vr :ccl<CR> :botright copen 6<CR>
	vmap <silent><Leader>vs <Leader>vv :ccl<CR> :botright copen 6<CR>
	vmap <silent><Leader>vt <Leader>vV :ccl<CR> :botright copen 6<CR>
	vmap <silent><Leader>vr <Leader>vr :ccl<CR> :botright copen 6<CR>
	nmap <silent><Leader>vo :GrepOptions<CR>
	nmap <silent><Leader>vu :ReplaceUndo<CR>

	nmap ;vs :Grep 
	nmap ;vr :Replace 
endif	

" -------------------------------------------------------------
"  < omnicppcomplete 插件配置 >
" -------------------------------------------------------------
" 用于C/C++代码补全，这种补全主要针对命名空间、类、结构、共同体等进行补全
" 使用前先执行如下 ctags 命令（本配置中可以直接使用 ccvext 插件来执行以下命令）
" ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
if (g:OmniCppComplete_en)
	set nocp
	filetype plugin on
	" set completeopt=menu,menuone  
	" set completeopt=menu
	" let OmniCpp_MayCompleteDot=1    "打开  . 操作符
	" let OmniCpp_MayCompleteArrow=1  "打开 -> 操作符
	" let OmniCpp_MayCompleteScope=1  "打开 :: 操作符
	" let OmniCpp_NamespaceSearch=1   "打开命名空间
	" let OmniCpp_GlobalScopeSearch=1  
	" let OmniCpp_DefaultNamespace=["std"]  
	" let OmniCpp_ShowPrototypeInAbbr=1  		"打开显示函数原型
	" let OmniCpp_SelectFirstItem = 2			"自动弹出时自动跳至第一个
	"
	" set completeopt=longest,menu "关闭菜单
	" let OmniCpp_NamespaceSearch = 2     " search namespaces in the current buffer   and in included files
	let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
	" let OmniCpp_MayCompleteScope = 1    " 输入 :: 后自动补全
	" let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
	"
	" set autochdir
	" set tags=tags;
endif

" -------------------------------------------------------------
"  < ctrlsf 插件配置 >
" -------------------------------------------------------------
if (g:ctrlsf_en)
	nmap     <C-F>f <Plug>CtrlSFPrompt
	vmap     <C-F>f <Plug>CtrlSFVwordPath
	vmap     <C-F>F <Plug>CtrlSFVwordExec
	nmap     <C-F>n <Plug>CtrlSFCwordPath
	nmap     <C-F>p <Plug>CtrlSFPwordPath
	nnoremap <C-F>o :CtrlSFOpen<CR>
	nnoremap <C-F>t :CtrlSFToggle<CR>
	inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
	nmap     <C-F>l <Plug>CtrlSFQuickfixPrompt
	vmap     <C-F>l <Plug>CtrlSFQuickfixVwordPath
	vmap     <C-F>L <Plug>CtrlSFQuickfixVwordExec
endif

" -------------------------------------------------------------
"  < multiple-cursors 插件配置 >
" -------------------------------------------------------------
if (g:multiple_cursors_en)
	" Default mapping
	" let g:multi_cursor_next_key='<C-n>'
	" let g:multi_cursor_prev_key='<C-p>'
	" let g:multi_cursor_skip_key='<C-x>'
	" let g:multi_cursor_quit_key='<Esc>'
endif

" -------------------------------------------------------------
"  < gundo 插件配置 >
" -------------------------------------------------------------
if (g:gundo_en)
	" 调用 gundo 树
	nnoremap <Leader>ud :GundoToggle<CR>
endif

" ------------------------------------------------------------- "  
"  < easymotion 插件配置 >
" -------------------------------------------------------------
if (g:easymotion_en)
    let g:EasyMotion_do_mapping = 0 " Disable default mappings
    " Jump to anywhere you want with minimal keystrokes, with just one key binding.
    " `s{char}{label}`
    nmap 's <Plug>(easymotion-overwin-f)
    " or
    " `s{char}{char}{label}`
    " Need one more keystroke, but on average, it may be more comfortable.
    nmap 's <Plug>(easymotion-overwin-f2)
       
    " Turn on case insensitive feature
    let g:EasyMotion_smartcase = 1
       
    " JK motions: Line motions
    map ;j <Plug>(easymotion-j)
    map ;k <Plug>(easymotion-k)
endif  

" ------------------------------------------------------------- 
"  < interestingwords 插件配置 >
" -------------------------------------------------------------
if (g:interestingwords_en)
	" nnoremap <silent> <leader>k :call InterestingWords('n')<cr>
	" nnoremap <silent> <leader>K :call UncolorAllWords()<cr>
	" nnoremap <silent> n :call WordNavigation('forward')<cr>
	" nnoremap <silent> N :call WordNavigation('backward')<cr>
	"
	" set gui colors
	" 			 						 浅蓝    浅绿   淡橙   浅红    粉红   浅紫
	let g:interestingWordsGUIColors = ['#71dcff', '#A4E57E', '#F5E1AE', '#FF7272', '#FFB3FF', '#9999FF']

	" set terminal colors
	" let g:interestingWordsTermColors = ['154', '121', '211', '137', '214', '222']
	"                                    蓝色    天蓝    红     草绿   紫色   深红
	let g:interestingWordsTermColors = ['blue', 'cyan', 'red', '118', '135', '161']

	" randomise the colors (applied to each new buffer):颜色随机化
	let g:interestingWordsRandomiseColors = 1
endif

" ------------------------------------------------------------- 
"  < rainbow_parentheses 插件配置 >
" -------------------------------------------------------------
if (g:rainbow_parentheses)
	" Options
    " ['linux',         'windows],'
	let g:rbpt_colorpairs = [
    \ ['brown',         'brown'],
    \ ['Darkblue',      'Darkblue'],
    \ ['darkgray',      'darkgray'],
    \ ['darkgreen',     'darkgreen'],
    \ ['darkcyan',      'darkcyan'],
    \ ['darkred',       'darkred'],
    \ ['darkmagenta',   'darkmagenta'],
    \ ['brown',         'brown'],
    \ ['gray',          'gray'],
    \ ['cyan',          'cyan'],
    \ ['161',           'DarkOrchid3'],
    \ ['118',           'SeaGreen3'],
    \ ['135',           'RoyalBlue3'],
    \ ['blue',          'blue'],
    \ ['red',           'red'],
    \ ['white',         'white'],
    \ ]

	let g:rbpt_max = 16
	let g:rbpt_loadcmd_toggle = 0

	" Commands
	" :RainbowParenthesesToggle       " Toggle it on/off
	" :RainbowParenthesesLoadRound    " (), the default when toggling
	" :RainbowParenthesesLoadSquare   " []
	" :RainbowParenthesesLoadBraces   " {}
	" :RainbowParenthesesLoadChevrons " <>
	
	" Always On
	au VimEnter * RainbowParenthesesToggle
	" au Syntax * RainbowParenthesesLoadRound
	" au Syntax * RainbowParenthesesLoadSquare
	au Syntax * RainbowParenthesesLoadBraces
endif

" ------------------------------------------------------------- 
"  < indentLine_en 插件配置 >
" -------------------------------------------------------------
if (g:indentLine_en)
	" 高亮缩进符号
	" let g:indentLine_setColors = 0
	
	" 缩进符号颜色设置
	let g:indentLine_color_term = 'grey'
	let g:indentLine_color_gui = '#71dcff'

	" let g:indentLine_setConceal = 2
	" let g:indentLine_concealcursor = 'inc'
	" let g:indentLine_conceallevel = 2
endif

" ------------------------------------------------------------- 
"  < YouCompleteMe 插件配置 >
" -------------------------------------------------------------
if (g:youcompleteme_en)
    let g:ycm_server_python_interpreter = '/usr/bin/python'
    " 不显示开启vim时检查ycm_extra_conf文件的信息  
    let g:ycm_confirm_extra_conf = 0

	"在注释输入中也能补全
	let g:ycm_complete_in_comments = 1
	"在字符串输入中也能补全
	let g:ycm_complete_in_strings = 1

    "跳转到定义处
    nnoremap go :YcmCompleter GoToDefinitionElseDeclaration<CR>
    "打开文件时关闭错误
    " au BufReadPost * silent YcmDiags
endif

" ------------------------------------------------------------- 
"  < code_complete 插件配置 >
" -------------------------------------------------------------
if (g:code_complete)
    let g:huayue_add = 1 "修改插件
    if (g:huayue_add)
        let g:rs = '{ '     "region start
        let g:re = ' }'     "region stop
        let g:completekey = "<c-b>"     "hotkey
        let g:template = {}
        let g:template['c'] = {}

        "---自定义模板
        " C templates
        let g:template['c']['de'] = "#define "
        let g:template['c']['in'] = "#include \"\"\<left>"
        let g:template['c']['is'] = "#include <>\<left>"
        let g:template['c']['ff'] = "#ifndef  \_\_\<c-r>=GetFileName()\<cr>\_\_\<CR>#define  \_\_\<c-r>=GetFileName()\<cr>\_\_\<CR>".repeat("\<CR>",5)."#endif  /*\_\_\<c-r>=GetFileName()\<cr>\_\_*/".repeat("\<up>",3)
        let g:template['c']['for'] = "for (".g:rs."...".g:re."; ".g:rs."...".g:re."; ".g:rs."...".g:re.") {\<cr>".g:rs."...".g:re."\<cr>}\<cr>"
        let g:template['c']['switch'] = "switch (".g:rs."...".g:re.") {\<cr>case ".g:rs."...".g:re.":\<cr>break;\<cr>case ".g:rs."...".g:re.":\<cr>break;\<cr>default :\<cr>break;\<cr>}"
        let g:template['c']['while'] = "while (".g:rs."...".g:re.") {\<cr>".g:rs."...".g:re."\<cr>}"
        let g:template['c']['if'] = "if (".g:rs."...".g:re." ) {\<cr>".g:rs."...".g:re."\<cr>}"
        let g:template['c']['ife'] = "if (".g:rs."...".g:re." ) {\<cr>".g:rs."...".g:re."\<cr>} else {\<cr>".g:rs."...".g:re."\<cr>}"
        let g:template['c']['pfx'] = "printf(\"".g:rs."...".g:re."=0x%x\\n\", ".g:rs."...".g:re.");"
        let g:template['c']['pfd'] = "printf(\"".g:rs."...".g:re."=%d\\n\", ".g:rs."...".g:re.");"
        let g:template['c']['pfb'] = "printf_buf(".g:rs."u8 *buf".g:re.", ".g:rs."u32 len".g:re.");"
        let g:template['c']['memset'] = "memset(".g:rs."void *buf".g:re.", ".g:rs."int value".g:re.", ".g:rs."u32 len".g:re.");"
        let g:template['c']['memcpy'] = "memcpy(".g:rs."void *to".g:re.", ".g:rs."const void *from".g:re.", ".g:rs."u32 len".g:re.");"
        let g:template['c']['memcmp'] = "memcmp(".g:rs."const void *".g:re.", ".g:rs."const void *".g:re.", ".g:rs."u32 len".g:re.");"
        let g:template['c']['st'] = "struct ".g:rs."NAME".g:re." {\<cr>".g:rs."type".g:re."     ".g:rs."name".g:re.";\<cr>".g:rs."type".g:re."     ".g:rs."name".g:re.";\<cr>"."};"
        let g:template['c']['tst'] = "typedef struct ".g:rs."\_\_NAME".g:re." {\<cr>".g:rs."type".g:re."     ".g:rs."name".g:re.";\<cr>".g:rs."type".g:re."     ".g:rs."name".g:re.";\<cr>"."}\_NAME;"
        let g:template['c']['enum'] = "enum {\<cr>".g:rs."NAME0".g:re." = 0,\<cr>".g:rs."NAME1".g:re.",\<cr>};"
    endif
endif



" ============================================================================
"							<< 工具配置 >>								
" ============================================================================
"
" -------------------------------------------------------------
"  < cscope 工具配置 >
" -------------------------------------------------------------
" 功能说明：C/C++下 变量/函数/宏定义/头文件 跳转或搜索，搜索时在quickfix下显示搜索结果
" 使用说明：请将tools目录(或者包含cscope.exe、ctags.exe、sync.bat、sync.sh的文件夹)加到系统环境变量里
"			在工程根目录打开vim，常规模式下键入sy将在此目录产生cscope.out和tags文件，使能该工具功能
" 自带快捷键：没有
" 自定义快捷键："\fs"或者"fs"		Find this C symbol
"				"\fg"或者"fg"		Find this definition
"				"\fc"或者"fc"		Find functions calling this function
"				"\ft"或者"ft"		Find this text string	
"				"\fe"或者"fe"		Find this egrep pattern
"				"\ff"或者"ff"		Find this file
"				"\fi"或者"fi"		Find files #including this file
"				"\fd"或者"fd"		Find functions called by this function	
function! Session_load()
	" if &filetype == 'svim'
	" if has("workspace.svim")
		source 		workspace.svim
	" endif
	" if &filetype == 'viminfo'
	" if has("workspace.viminfo")
		rviminfo 	workspace.viminfo
	" endif
endfunction

function! Session_save()
	" if &filetype == 'svim'
		!rm 		workspace.svim
	" endif
	mksession! 	workspace.svim
	" if &filetype == 'viminfo'
		!rm 		workspace.viminfo
	" endif
	wviminfo! 	workspace.viminfo
endfunction

function!  Cscope_init()
	" ---cscope设置
	if has("cscope")
		" 先断开先前的cscope链接
		cs kill -1
		" 设定可以使用 quickfix 窗口来查看 cscope 结果
		set cscopequickfix=s-,c-,d-,i-,t-,e-
		" 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
		set cscopetag
		" 如果你想反向搜索顺序设置为1
		set csto=0
		" 在当前目录中添加任何数据库
		if filereadable("cscope.out") 
			cs add cscope.out
			normal :<CR>
		" 否则添加数据库环境中所指出的 
		elseif $CSCOPE_DB != "" 
			cs add $CSCOPE_DB 
		endif 
		set cscopeverbose 
		" 自定义快捷键设置：针对光标在文件窗口
		nmap <Leader>fs :cs find s <C-R>=expand("<cword>")<CR><CR>:botright copen 6<CR>
		vmap <Leader>fs <C-C>:cs find s <S-Insert><CR><CR>:botright copen 6<CR>
		nmap <Leader>fg :cs find g <C-R>=expand("<cword>")<CR><CR>
		nmap <Leader>fc :cs find c <C-R>=expand("<cword>")<CR><CR>:botright copen 6<CR>
		nmap <Leader>ft :cs find t <C-R>=expand("<cword>")<CR><CR>:botright copen 6<CR>	
		vmap <Leader>ft <C-C>:cs find t <S-Insert><CR><CR>:botright copen 6<CR>
		nmap <Leader>fe :cs find e <C-R>=expand("<cword>")<CR><CR>:botright copen 6<CR>	
		nmap <Leader>ff :cs find f <C-R>=expand("<cfile>")<CR><CR>
		nmap <Leader>fi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:botright copen 6<CR>
		nmap <Leader>fd :cs find d <C-R>=expand("<cword>")<CR><CR>:botright copen 6<CR>	
		" 自定义快捷键设置：针对光标在命令输入窗口
		nmap ;fs :cscope find s 
		nmap ;fg :cscope find g 
		nmap ;fc :cscope find c 
		nmap ;ft :cscope find t 
		nmap ;fe :cscope find e 
		nmap ;ff :cscope find f 
		nmap ;fi :cscope find i 
		nmap ;fd :cscope find d 
	endif
	" ---lookupfile设置
	" if filereadable("filenametags")
		let g:LookupFile_TagExpr = '"./filenametags"'
	" endif
endfunction

function!  CscopeSync()
	if has("cscope")
        cs kill -1
    endif
	if(g:islinux)
        !bash sync.sh
	else
	    silent !sync.bat "\%f\\t\%p\\t1\\n"
	endif
	call Cscope_init()
    if (g:youcompleteme_en)
        YcmRestartServer
    endif
endfunction
" autocmd BufWritePost *.c,*.h silent call CscopeSync()
" autocmd VimEnter *.c,*.h silent call CscopeSync()
autocmd VimEnter * silent call Cscope_init()
" autocmd VimEnter * call Session_load()
" autocmd VimLeave * call Session_save()
"---常规模式下键入 sy 使能该工具 
nmap <silent>sy :call CscopeSync()<CR><CR><CR>

if (g:gitblame_en)
    nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
endif

" -------------------------------------------------------------
"  < vimtweak 工具配置 > 
" -------------------------------------------------------------
" 功能说明：用于窗口透明与置顶，仅限于Windows使用
" 使用说明：请确保vim74文件夹存在vimtweak.dll，并将vim74文件夹加入系统环境变量
" 自带快捷键：没有
" 自定义快捷键："shift + Up(上方向键)" 		增加不透明度
"				"shift + Down(下方向键)" 	减少不透明度
"				"<Leader>t" 				窗口置顶与否切换
if (g:iswindows)
    let dll_path = "vimtweak.dll"
    let g:Current_Alpha = 220
    let g:Top_Most = 0
	
    func! Alpha_add()
        let g:Current_Alpha = g:Current_Alpha + 10
        if g:Current_Alpha > 255
            let g:Current_Alpha = 255
        endif
        call libcallnr(dll_path,"SetAlpha",g:Current_Alpha)
    endfunc
    func! Alpha_sub()
        let g:Current_Alpha = g:Current_Alpha - 10
        if g:Current_Alpha < 155
            let g:Current_Alpha = 155
        endif
        call libcallnr(dll_path,"SetAlpha",g:Current_Alpha)
    endfunc
    func! Top_window()
        if  g:Top_Most == 0
            call libcallnr(dll_path,"EnableTopMost",1)
            let g:Top_Most = 1
        else
            call libcallnr(dll_path,"EnableTopMost",0)
            let g:Top_Most = 0
        endif
    endfunc

	" 开机自动透明
	autocmd GUIEnter * call libcallnr(dll_path, "SetAlpha", g:Current_Alpha)
    " 快捷键设置
    map <s-up> :call Alpha_add()<CR>
    map <s-down> :call Alpha_sub()<CR>
    map <leader>t :call Top_window()<CR>
endif

" -------------------------------------------------------------
"  < gvimfullscreen 工具配置 >
" -------------------------------------------------------------
" 功能说明：全屏窗口(不仅是最大化)，仅限于Windows使用
" 使用说明：请确保vim74文件夹存在gvimfullscreen.dll，并将vim74文件夹加入系统环境变量
" 自带快捷键：没有 
" 自定义快捷键："F11"
if (g:iswindows)
	map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
	" autocmd GUIEnter * call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)
endif


" ============================================================================
"							<< 自定义快捷键设置 >>								
" 详细map参考 "http://www.jianshu.com/p/8ae25a680ed7"
" ============================================================================
"
" ---常规模式下 空格键(space)快速进入命令输入(:)
nmap <SPACE> :
" ---常规模式下 连续输入 88 取消搜索高亮
nmap 88 :nohlsearch<CR>
" ---常规模式下 输入 / 后全字匹配搜索
nmap ;/ 	/\<\><Left><Left>
" ---常规模式下 重新映射系统默认窗口切换快捷键
nmap <c-k> <c-w>k
nmap <c-j> <c-w>j
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l

" ---插入模式下 光标上下左右移动
" 副作用：可以令 neocomplcache/lookupfile/ctrlpfunky/ctrlp 插件直接"ctrl + j"和"ctrl + k"上下选择，
"         并解决 neocomplcache "Enter" 键选择补全信息时会多换一行的问题
imap <c-k> <Up>
imap <c-j> <Down>
imap <c-h> <Left>
imap <c-l> <Right>

" ---常规模式下 窗口大小调整
" 使用说明："shift + ="变为"+" Y轴扩大窗口
"			"shift + -"变为"_" Y轴缩小窗口
"			"shift + ."变为">" X轴扩大窗口
"			"shift + ,"变为"<" X轴缩小窗口
nmap + <c-w>+
nmap _ <c-w>-
nmap > <c-w>>
nmap < <c-w><

" ---常规模式下 输入 cS 清除行尾空格，输入 cM 清除行尾 ^M 符号
nmap cS :%s/\s\+$//g<cr>:noh<cr>
nmap cM :%s/\r$//g<cr>:noh<cr>

" ---常规模式下 makefile 快捷键
" for codeblocks build
function! Codeblocks_build()
	set makeprg=codeblocks\ --build\ *.cbp 	
    set errorformat=%f:%l:%c:\ %trror:\ %m
    " 将相对路径转为绝对路径
    set errorformat+=\
					\%D%*\\a[%*\\d]:\ Entering\ directory\ %*[`']%f',
	make							
	botright copen 6
	" normal G
endfunction

if (g:islinux)
" for IAR build
function! IAR_build(type)
	set makeprg=make
    if a:type == 'runsdk'
        silent !make runsdk -j > ~/.wine/.cctmp
    else
        silent !make runlib -j > ~/.wine/.cctmp
    endif
    silent !cat ~/.wine/.cctmp | tr '\\' '/' > ~/.wine/.ccinfo
    silent !rm ~/.wine/.cctmp
    " e .ccinfo
    " %s/\\/\//g
    " w
    " %trror 表示匹配“rror”的字符串，即找出“error”，并显示出来
    set errorformat=%EZ:%f(%l)\ :\ %trror[Pe%n]:\ %m
    cf ~/.wine/.ccinfo
	botright copen 6
    set errorformat-=%EZ:%f(%l)\ :\ %trror[Pe%n]:\ %m
    call SourceVimrc()
	" normal G
endfunction
else
function! IAR_build(type)
    if a:type == 'runsdk'
        set makeprg=iarbuild\ SDK_AC109N.ewp\ Release\ -log\ all
    else
        set makeprg=iarbuild\ lib.ewp\ Release\ -log\ all
    endif
    set errorformat-=%EZ:%f(%l)\ :\ %trror[Pe%n]:\ %m
    make
endfunction
endif

" for Makefile build
function! BQ_Makefile(type)
	set makeprg=make
    set errorformat=%f:%l:%c:\ %trror:\ %m
    set errorformat+=%f:%l:%c:\ fatal\ %trror:\ %m
    " 将相对路径转为绝对路径
    set errorformat+=\
					\%D%*\\a[%*\\d]:\ Entering\ directory\ %*[`']%f',
    " 默认errorformat格式设置
    " set errorformat=%*[^\"]\"%f\"%*\\D%l:\ %m,
    "               \"%f\"%*\\D%l:\ %m,
	" 				\%-G%f:%l:\ (Each\ undeclared\ identifier\ is\ reported\ only\ once,%-G%f:%l:\ for\ each\ function\ it\ appears\ in.),
	" 				\%-GIn\ file\ included\ from\ %f:%l:%c:,
	" 				\%-GIn\ file\ included\ from\ %f:%l:%c\\,,
	" 				\%-GIn\ file\ included\ from\ %f:%l:%c,
	" 				\%-GIn\ file\ included\ from\ %f:%l,
	" 				\%-G%*[\ ]from\ %f:%l:%c,
	" 				\%-G%*[\ ]from\ %f:%l:,
	" 				\%-G%*[\ ]from\ %f:%l\\,,
	" 				\%-G%*[\ ]from\ %f:%l,
    " 				\%f:%l:%c:%m,
	" 				\%f(%l):%m,%f:%l:%m,
    " 				\\"%f\"\\,
    " 				\\ line\ %l%*\\D%c%*[^\ ]\ %m,
	" 				\%D%*\\a[%*\\d]:\ Entering\ directory\ %*[`']%f',
	" 				\%X%*\\a[%*\\d]:\ Leaving\ directory\ %*[`']%f',
	" 				\%D%*\\a:\ Entering\ directory\ %*[`']%f',
	" 				\%X%*\\a:\ Leaving\ directory\ %*[`']%f',
	" 				\%DMaking\ %*\\a\ in\ %f,
	" 				\%f\|%l\|\ %m
    NERDTreeClose
    TlistClose
    cclose
    if a:type == 'libs'
        " make clean_libs && make libs -j
        terminal ++rows=11
        if (g:islinux)
            call term_sendkeys('',"bash MakeErrorOutput.sh libs && exit")
        else
            call term_sendkeys('',"call MakeErrorOutput.bat libs")
        endif
    else
        " make clean && make -j
        terminal ++rows=11
        if (g:islinux)
            call term_sendkeys('',"bash MakeErrorOutput.sh && exit")
        else
            call term_sendkeys('',"call MakeErrorOutput.bat")
        endif
    endif
	" botright copen 6
endfunction

" for ninja build
function! Ninja_build()
	set makeprg=ninja
    set errorformat=%f:%l:%c:\ %trror:\ %m
    " 将相对路径转为绝对路径
    set errorformat+=\
					\%D%*\\a[%*\\d]:\ Entering\ directory\ %*[`']%f',

    make -C build flash_beaconing_nrf52832_xxAA_s132_6.0.0
	" botright copen 6
endfunction

	" for IAR build
	" nmap <F6> :call IAR_build('runlib')<CR> <Esc>/\<error\><CR><CR>
	" nmap <F7> :call IAR_build('runsdk')<CR> <Esc>/\<error\><CR><CR>
    " for Makefile build
	nmap <F6> :call BQ_Makefile('libs')<CR><CR>
	nmap <F7> :call BQ_Makefile('apps')<CR><CR>
	" for codeblocks build
	" nmap <F8> :wa<CR> :set makeprg=codeblocks\ --build\ *.cbp<CR> 	:make<CR><CR><CR>							:botright copen 6<CR> <Esc>G<CR>
	" nmap <F8> :call Codeblocks_build()<CR> <Esc>/\<error\><CR><CR>
	" for ninja build
	" nmap <F7> :call Ninja_build()<CR> <Esc>/\<error\><CR><CR>

" ---插入模式下 快捷键
" uart打印快捷键
" imap pu<Enter> puts("\n");<Esc>F\i
" imap log<Enter> log_info("\n");<Esc>F\i
" imap pc<Enter> putchar('');<Esc>F'i
" imap pfx<Enter> printf("=0x%x\n", );<Esc>F=i
" imap pfd<Enter> printf("=%d\n", );<Esc>F=i
imap pff<Enter> printf("\n--func=%s\n", __FUNCTION__);<Esc>
imap pfl<Enter> printf("func:%s, line:%d", __FUNCTION__, __LINE__);<Esc>
imap putchar<Enter> putchar('')<Left><Left>
imap printf<Enter> printf("");<Left><Left><Left>
" bit操作快捷键
" imap ba<Enter>  &= ~BIT();<Esc>F)i
" imap bo<Enter>  \|= BIT();<Esc>F)i
" imap or<Enter>  \|= <Esc>i
" imap an<Enter>  &= ~<Esc>a
" 大括号自动补齐 输入"{"后按回车键自动补齐"}"并进入插入模式
imap {<Enter> {<Esc>o<tab><Esc>o}<Esc>ka<tab><Esc>lDa
" 小括号自动补齐 输入"("后按回车键自动补齐")"并进入插入模式
" imap (<Enter> ()<Esc>i

" ---常规模式下 quickfix 跳转快捷键
" 使用说明："F9" 上一个要寻找的目标
"			"F10" 下一个要寻找的目标
nmap <F9>   :cp<CR>
nmap <F10>  :cn<CR>

" ---常规模式下 minibufexpl 跳转快捷键
" 使用说明："1" 上一个标签
"			"2" 下一个标签
nmap 1 :bp<CR>
nmap 2 :bn<CR>


" ---常规模式下 编辑vimrc/zshrc文件
if (g:islinux)
	nmap <Leader>ev :e ~/.vimrc<CR>
	nmap <Leader>ez :e ~/.zshrc<CR>
else
	nmap <Leader>ev :e $vim/_vimrc<CR>
endif

" ---常规模式下 编辑zshrc/sync.h文件(仅适用于linux)
function! EDIT_sync()
    if (g:islinux)
        if !empty(glob("./sync.sh"))
            e ./sync.sh
        else
            e ~/.vim/tools/sync.sh
        endif
    else
        e $vim/vimfiles/tools/sync.bat
    endif
endfunction
nmap <Leader>es :call EDIT_sync()<CR>

" ---跳到句首或者句尾
" 使用说明："; + e" 跳到句尾
"			"; + h" 跳到句首
map ;e $
map ;h ^

" ---使用复制缓存寄存器进行粘贴
map ;p "0p
map ;P "0P

" ---常规模式下 重新source .vimrc
if(g:islinux)
    function! SourceVimrc()
        !source ~/.vimrc
        AirlineRefresh      "airline resresh cmd
    endfunction

	nmap ;s :call SourceVimrc()<CR><CR>
endif

" ---常规模式下 tab标签页操作
nmap - :tabp<CR>
nmap = :tabn<CR>

" ---常规模式下 定义跳转
nnoremap fo <c-]>

" ---指定数值光标移动
map H 5h
map J 5j
map K 5k
map L 5l

" ---自动跳转到粘贴文本的最后 
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" ---{}/()括号匹配
nmap {	%

" ---高亮光标所在关键字(光标位置不移动)
nmap * *N

" ---黄色高亮visual模式下选中关键字(光标位置不移动)
"  注：/进入命令模式，命令模式不适用<S-Insert>命令，所以要cmap一下
vmap <C-C> 			"+y
cmap <S-Insert> 	<C-R>+
vmap * 				<C-C>/<S-Insert><Enter>N

" ---F1 打开/关闭quickfix窗口
function! ToggleQf()
  for buffer in tabpagebuflist()
    if bufname(buffer) == ''
        cclose
        echo "here0"
        return
    endif
  endfor

    botright copen 6
endfunction
map <silent><F1>    :call ToggleQf()<CR>

" ---tComment 插件注释重映射
map ;// \__

inoremap xx<CR> /*!< */<Esc>F a
inoremap xc<CR> /* */<Esc>F a
inoremap xv<CR> /*! \brief      x */<Esc>Fxxi

" ---F4 打开/关闭paste功能
let g:set_paste_flag = 1
function! Set_paste()
    if (g:set_paste_flag)   
        let g:set_paste_flag = 0
        set paste
    else
        let g:set_paste_flag = 1
        set nopaste
    endif
endfunction
map <silent><F4>    :call Set_paste()<CR>

" ---插入模式下 输入当前系统时间
imap xtime <c-r>=strftime("%Y-%m-%d %H:%M:%S")<Esc><Esc>

"---跳转到报错代码处
function! Jump_code_error()
    " q
    if !empty(glob("./ErrorOut"))
        cf ErrorOut
        botright copen 7
    endif
endfunction
map <silent><F3> :call Jump_code_error()<CR>

