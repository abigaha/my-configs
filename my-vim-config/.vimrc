" ========== vim-plug 插件管理器配置 ==========
call plug#begin('~/.vim/plugged')

" 智能补全引擎
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 代码高亮
Plug 'octol/vim-cpp-enhanced-highlight'
" 异步语法检查
Plug 'dense-analysis/ale'
" 文件树
Plug 'preservim/nerdtree'
" 代码结构侧边栏
Plug 'preservim/tagbar'
" 状态栏美化
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" 模糊搜索
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" 代码模板
Plug 'vim-scripts/c.vim'
" 代码片段（UltiSnips）
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" CMake 语法高亮和缩进
Plug 'pboettch/vim-cmake-syntax'
" 一键注释
Plug 'tpope/vim-commentary'
" 配色方案
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'arcticicestudio/nord-vim'
" 自动控制代码缩进
Plug 'sheerun/vim-polyglot'     " 语言缩进规则
Plug 'Yggdroot/indentLine'      " 缩进参考线
Plug 'Chiel92/vim-autoformat'   " 自动格式化（需安装外部工具）
" github copilot
Plug 'github/copilot.vim'

call plug#end()

" ========== 基础行为与界面设置 ==========
set nocompatible                " 使用 Vim 模式，而非纯 Vi 兼容模式
filetype on                     " 启用文件类型检测
filetype plugin indent on       " 启用文件类型检测及对应的插件和缩进规则
syntax on                       " 开启语法高亮
set encoding=utf-8              " 使用 UTF-8 编码

" 界面显示
set number                      " 显示行号
"set relativenumber             " 显示相对行号（方便跳转）
set cursorline                  " 高亮当前行
set showcmd                     " 在状态栏显示未完成的命令
set laststatus=2                " 总是显示状态栏
colorscheme dracula             " 设置配色方案，可选：slate, murphy, evening

" 编辑与缩进
set autoindent                  " 新行自动缩进
set smartindent                 " 智能缩进
set expandtab                   " 将 Tab 键转换为空格
set tabstop=2                   " Tab 显示为 4 个空格宽度
set shiftwidth=2                " 自动缩进和 << >> 操作的宽度为 4 空格
set softtabstop=2               " 在编辑模式下按退格键一次删除 4 个空格

" 设置缩进参考线
let g:indentLine_char = '│'                 " 竖线字符（推荐）
let g:indentLine_color_gui = '#555555'      " GUI颜色（十六进制）

" 指定C++格式化工具为clang-format
let g:formatdef_clangformat = '"clang-format -style=file"'
let g:formatters_cpp = ['clangformat']

" 保存时自动缩进
autocmd BufWrite *.cpp :Autoformat

" 搜索
set incsearch                   " 输入搜索模式时实时高亮匹配
set hlsearch                    " 高亮所有搜索结果
set ignorecase                  " 搜索时忽略大小写
set smartcase                   " 如果搜索模式包含大写，则区分大小写

" 其他实用设置
set backspace=indent,eol,start  " 允许在插入模式下用退格键删除
set hidden                      " 允许在未保存时切换缓冲区
set mouse=a                     " 启用鼠标支持（可选，便于滚动和选择）
set clipboard=unnamed           " 默认使用系统粘贴板

" 使用 Tab 和 S-Tab 在补全列表中导航
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" 使用回车键确认补全
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 跳转到定义
nmap <silent> gd <Plug>(coc-definition)
" 跳转到类型定义
nmap <silent> gy <Plug>(coc-type-definition)
" 跳转到引用
nmap <silent> gr <Plug>(coc-references)
" 重命名符号
nmap <silent> rn <Plug>(coc-rename)
" 显示函数/变量的文档
nnoremap <silent> K :call ShowDocumentation()<CR>

" ========== 插件快捷键配置 ==========

" 1. NERDTree 文件树配置
nnoremap <F2> :NERDTreeToggle<CR>       " F2 切换文件树
nnoremap <leader>nf :NERDTreeFind<CR>   " \nf 在文件树中定位当前文件
let NERDTreeShowHidden=1                " 显示隐藏文件
let NERDTreeQuitOnOpen=1                " 打开文件后自动关闭NERDTree
let NERDTreeMinimalUI=1                 " 简化UI
let NERDTreeDirArrows=1                 " 使用箭头而不是ASCII字符
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif " 无文件时自动打开

" 2. Tagbar 符号大纲配置
nnoremap <F3> :TagbarToggle<CR>         " F3 切换符号大纲
let g:tagbar_width = 35                 " 设置宽度
let g:tagbar_autofocus = 1              " 打开时自动获取焦点
let g:tagbar_sort = 0                   " 按源码顺序排序
let g:tagbar_compact = 1                " 紧凑显示
let g:tagbar_show_linenumbers = 2       " 显示行号

" 3. ALE 语法检查配置
let g:ale_sign_error = '✗'              " 错误标志
let g:ale_sign_warning = '⚠'            " 警告标志
let g:ale_linters = {
\   'cpp': ['clangd', 'cppcheck'],
\   'c': ['clangd', 'cppcheck'],
\}
let g:ale_fixers = {
\   'cpp': ['clang-format'],
\   'c': ['clang-format'],
\}
nmap <silent> <F8> :ALENext<CR>         " F8 下一个错误
nmap <silent> <S-F8> :ALEPrevious<CR>   " Shift+F8 上一个错误
nmap <silent> <leader>af :ALEFix<CR>    " \af 自动格式化
let g:ale_fix_on_save = 1               " 保存时自动修复
"let g:ale_cpp_clangtidy_checks = ['*'] " 启用所有clang-tidy检查
"let g:ale_cpp_clangtidy_options = '-std=c++23 -Wall -Wextra'
let g:ale_cpp_cppcheck_options = '--enable=all --suppress=missingIncludeSystem'
let g:ale_cpp_clangd_options = '--query-driver=/usr/bin/g++-14 -std=c++23'
let g:ale_pattern_options = {
\ '\.cpp$': {'ale_linters': ['clangd']},
\ '\.h$': {'ale_linters': ['clangd']}
\}

" 确保clangd始终从项目根目录解析路径
let g:ale_cpp_clangd_options = '--background-index --query-driver=/usr/bin/g++-14'

" 4. FZF 模糊搜索配置
nnoremap <C-p> :Files<CR>               " Ctrl+p 搜索文件
nnoremap <C-f> :Rg<CR>                  " Ctrl+f 搜索内容
nnoremap <C-b> :Buffers<CR>             " Ctrl+b 切换缓冲区
nnoremap <leader>fc :Commands<CR>       " \fc 搜索命令
nnoremap <leader>fl :Lines<CR>          " \fl 搜索当前文件内容
nnoremap <leader>fh :History<CR>        " \fh 搜索历史
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" 5. c.vim 插件配置
let g:C_UseTool_cmake = 'yes'           " 启用cmake支持
let g:C_UseTool_doxygen = 'yes'         " 启用doxygen支持
" 完全自定义编译运行快捷键

" ========== 智能双模式编译配置 ==========

" F5: 智能编译并运行（自动检测模式）
nnoremap <F5> :w<CR>:call SmartCompileAndRun()<CR>

" F6: 智能仅编译（自动检测模式）
nnoremap <F6> :w<CR>:call SmartCompileOnly()<CR>

" Ctrl + F5: 清理构建文件
nnoremap <C-F5> :call CleanBuild()<CR>

" 核心模式检测函数
function! DetectProjectMode()
    let l:current_dir = expand('%:p:h')
    let l:has_src_dir = isdirectory(l:current_dir . '/src')
    let l:has_include_dir = isdirectory(l:current_dir . '/include')
    let l:has_cmake = findfile('CMakeLists.txt', '.;') != ''
    
    " 规则判断
    if has_cmake
        if has_src_dir && has_include_dir
            echo "检测到: [CMake + 标准三层分离] 项目"
            return 'cmake_standard'
        else
            echo "检测到: [CMake + 单层混合] 项目"
            return 'cmake_single'
        endif
    else
        if has_src_dir && has_include_dir
            echo "检测到: [直接编译 + 标准三层分离] 项目"
            return 'direct_standard'
        else
            echo "检测到: [直接编译 + 单层混合] 项目"
            return 'direct_single'
        endif
    endif
endfunction

" 主调度函数
function! SmartCompileAndRun()
    let l:mode = DetectProjectMode()
    
    if l:mode == 'cmake_standard' || l:mode == 'cmake_single'
        call CMakeCompileAndRun()
    elseif l:mode == 'direct_standard'
        call DirectCompileStandard()
    elseif l:mode == 'direct_single'
        call DirectCompileSingle()
    endif
endfunction

function! SmartCompileOnly()
    let l:mode = DetectProjectMode()
    
    if l:mode == 'cmake_standard' || l:mode == 'cmake_single'
        call CMakeCompileOnly()
    elseif l:mode == 'direct_standard'
        call DirectCompileOnlyStandard()
    elseif l:mode == 'direct_single'
        call DirectCompileOnlySingle()
    endif
endfunction

" ========== 直接编译模式：单层混合 ==========
function! DirectCompileSingle()
    let l:base = expand('%:r')
    let l:source = expand('%')
    
    echo "直接编译（单层模式）..."
    let l:cmd = 'rm -f ' . l:base . '.o ' . l:base . '.out 2>/dev/null; ' .
               \ 'g++-14 -std=c++23 -Wall -Wextra -g ' . shellescape(l:source) . 
               \ ' -o ' . shellescape(l:base) . '.out'
    
    execute '!' . l:cmd
    
    if v:shell_error == 0
        echo "编译成功！运行程序..."
        execute '!./' . l:base . '.out'
    else
        echo "编译失败"
    endif
endfunction

function! DirectCompileOnlySingle()
    let l:base = expand('%:r')
    let l:source = expand('%')
    
    echo "直接编译（单层模式）..."
    let l:cmd = 'rm -f ' . l:base . '.o ' . l:base . '.out 2>/dev/null; ' .
               \ 'g++-14 -std=c++23 -Wall -Wextra -g ' . shellescape(l:source) . 
               \ ' -o ' . shellescape(l:base) . '.out'
    
    execute '!' . l:cmd
    
    if v:shell_error == 0
        echo "编译成功！输出文件: " . l:base . ".out"
    else
        echo "编译失败"
    endif
endfunction

" ========== 直接编译模式：标准三层分离 ==========
function! DirectCompileStandard()
    let l:current_dir = expand('%:p:h')
    let l:project_root = l:current_dir
    let l:source_dir = l:project_root . '/src'
    let l:include_dir = l:project_root . '/include'
    let l:build_dir = l:project_root . '/build'
    
    " 确保build目录存在
    if !isdirectory(l:build_dir)
        call mkdir(l:build_dir, 'p')
    endif
    
    " 查找src目录下的所有cpp文件
    let l:cpp_files = glob(l:source_dir . '/*.cpp', 0, 1)
    if empty(l:cpp_files)
        echoerr "错误：在 src/ 目录下未找到任何 .cpp 文件！"
        return
    endif
    
    " 获取主文件名（用于命名可执行文件）
    let l:main_file = expand('%:t:r')
    let l:output_name = l:main_file . '.out'
    let l:output_path = l:build_dir . '/' . l:output_name
    
    echo "直接编译（标准三层模式）..."
    echo "源文件: " . len(l:cpp_files) . " 个"
    echo "头文件目录: " . l:include_dir
    
    " 构建编译命令
    let l:cmd = 'g++-14 -std=c++23 -Wall -Wextra -g ' .
               \ '-I' . shellescape(l:include_dir) . ' ' .
               \ join(map(l:cpp_files, 'shellescape(v:val)'), ' ') .
               \ ' -o ' . shellescape(l:output_path)
    
    execute '!' . l:cmd
    
    if v:shell_error == 0
        echo "编译成功！运行程序..."
        execute '!cd ' . shellescape(l:build_dir) . ' && ./' . l:output_name
    else
        echo "编译失败"
    endif
endfunction

function! DirectCompileOnlyStandard()
    let l:current_dir = expand('%:p:h')
    let l:project_root = l:current_dir
    let l:source_dir = l:project_root . '/src'
    let l:include_dir = l:project_root . '/include'
    let l:build_dir = l:project_root . '/build'
    
    if !isdirectory(l:build_dir)
        call mkdir(l:build_dir, 'p')
    endif
    
    let l:cpp_files = glob(l:source_dir . '/*.cpp', 0, 1)
    if empty(l:cpp_files)
        echoerr "错误：在 src/ 目录下未找到任何 .cpp 文件！"
        return
    endif
    
    let l:main_file = expand('%:t:r')
    let l:output_name = l:main_file . '.out'
    let l:output_path = l:build_dir . '/' . l:output_name
    
    echo "直接编译（标准三层模式）..."
    echo "源文件: " . len(l:cpp_files) . " 个"
    
    let l:cmd = 'g++-14 -std=c++23 -Wall -Wextra -g ' .
               \ '-I' . shellescape(l:include_dir) . ' ' .
               \ join(map(l:cpp_files, 'shellescape(v:val)'), ' ') .
               \ ' -o ' . shellescape(l:output_path)
    
    execute '!' . l:cmd
    
    if v:shell_error == 0
        echo "编译成功！输出文件: " . l:output_path
    else
        echo "编译失败"
    endif
endfunction

" ========== 检测 ninja 是否可用 ==========
function! NinjaAvailable()
    " 检查 ninja 命令是否可用
    let l:result = system('which ninja 2>/dev/null')
    return v:shell_error == 0 && !empty(l:result)
endfunction

" ========== CMake模式函数（使用 ninja） ==========
function! CMakeCompileAndRun()
    echo "CMake模式（使用 ninja）..."

    " 保存当前目录
    let l:original_dir = getcwd()

    " 查找CMakeLists.txt（在当前目录或父目录）
    let l:cmake_file = findfile('CMakeLists.txt', '.;')

    if empty(l:cmake_file)
        echo "错误：未找到CMakeLists.txt文件！"
        return
    endif

    " 获取项目根目录（CMakeLists.txt所在目录的绝对路径）
    let l:project_root = fnamemodify(l:cmake_file, ':p:h')
    echo "项目根目录: " . l:project_root

    " 切换到项目根目录
    try
        execute 'lcd ' . fnameescape(l:project_root)
    catch
        echo "切换到项目根目录失败: " . v:exception
        return
    endtry

    " 检查build目录是否存在，不存在则创建
    let l:build_dir = l:project_root . '/build'
    if !isdirectory(l:build_dir)
        call mkdir(l:build_dir, 'p')
        echo "创建build目录..."
    endif

    " 进入build目录
    try
        execute 'lcd ' . fnameescape(l:build_dir)
    catch
        echo "切换到build目录失败: " . v:exception
        return
    endtry

    echo "当前构建目录: " . getcwd()

    " 检查是否需要运行CMake配置
    let l:current_project_root = l:project_root
    let l:need_cmake = 0

    " 检查ninja是否可用
    let l:use_ninja = NinjaAvailable()
    if l:use_ninja
        echo "检测到 ninja，将使用 ninja 进行构建"
    else
        echo "未检测到 ninja，将使用 make 进行构建"
    endif

    " 检查是否需要重新配置CMake
    if !filereadable('CMakeCache.txt')
        let l:need_cmake = 1
    else
        " 读取缓存中的旧路径
        let l:cache_lines = readfile('CMakeCache.txt')
        let l:old_path = ''
        for line in l:cache_lines
            if line =~ '^CMAKE_HOME_DIRECTORY:INTERNAL='
                let l:old_path = split(line, '=')[1]
                break
            endif
        endfor
    
        " 如果路径不一致，则强制重新配置
        if l:old_path != l:current_project_root
            echo "检测到项目路径变更（旧: " . l:old_path . "），强制重新配置CMake..."
            let l:need_cmake = 1
        endif
    endif

    if l:need_cmake
        echo "运行CMake配置..."
        
        " 构建CMake命令
        let l:cmake_cmd = 'cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ' .
                         \ '-DCMAKE_CXX_STANDARD=23 ' .
                         \ '-DCMAKE_C_COMPILER=gcc-14 ' .
                         \ '-DCMAKE_CXX_COMPILER=g++-14 '
        
        " 如果ninja可用，使用Ninja生成器
        if l:use_ninja
            let l:cmake_cmd .= '-G Ninja '
        endif
        
        let l:cmake_cmd .= '.. 2>&1'
        
        echo "CMake命令: " . l:cmake_cmd
        let l:cmake_output = system(l:cmake_cmd)

        if v:shell_error != 0
            echo "CMake配置失败："
            echo l:cmake_output
            " 返回原目录
            execute 'lcd ' . fnameescape(l:original_dir)
            return
        endif
    endif

    echo "编译中..."
    if l:use_ninja
        let l:build_cmd = 'ninja -j' . min([4, system('nproc 2>/dev/null || echo 4')]) . ' 2>&1'
    else
        let l:build_cmd = 'make -j4 2>&1'
    endif
    
    echo "构建命令: " . l:build_cmd
    let l:build_output = system(l:build_cmd)

    if v:shell_error == 0
        echo "CMake编译成功！"

        " 查找可执行文件并运行
        let l:executable = FindExecutable()
        if !empty(l:executable)
            echo "运行程序: " . l:executable
            let l:run_cmd = 'cd ' . shellescape(l:build_dir) . ' && ./' . l:executable
            execute '!' . l:run_cmd
        else
            echo "警告：未找到可执行文件，请检查CMakeLists.txt中的add_executable"
            " 尝试查找任何可执行文件
            let l:find_cmd = 'find . -maxdepth 2 -type f -executable ! -name "*.so" ! -name "*.a" ! -name "CMake*" 2>/dev/null | head -5'
            let l:all_executables = system(l:find_cmd)
            if !empty(l:all_executables)
                echo "找到的可执行文件:"
                echo l:all_executables
            endif
        endif
    else
        echo "CMake编译失败："
        echo l:build_output
    endif

    " 创建编译数据库符号链接（为Vim的clangd）
    if filereadable('compile_commands.json')
        let l:link_cmd = 'ln -sf "' . getcwd() . '/compile_commands.json" "' . l:project_root . '/" 2>/dev/null'
        call system(l:link_cmd)
        echo "编译数据库已链接"
    endif

    " 返回原目录
    try
        execute 'lcd ' . fnameescape(l:original_dir)
    catch
        echo "返回原目录失败: " . v:exception
    endtry
endfunction

function! CMakeCompileOnly()
    echo "CMake仅编译（使用 ninja）..."

    let l:original_dir = getcwd()
    let l:cmake_file = findfile('CMakeLists.txt', '.;')

    if empty(l:cmake_file)
        echo "错误：未找到CMakeLists.txt文件！"
        return
    endif

    let l:project_root = fnamemodify(l:cmake_file, ':p:h')
    echo "项目根目录: " . l:project_root

    try
        execute 'lcd ' . fnameescape(l:project_root)
    catch
        echo "切换到项目根目录失败: " . v:exception
        return
    endtry

    let l:build_dir = l:project_root . '/build'
    if !isdirectory(l:build_dir)
        call mkdir(l:build_dir, 'p')
    endif

    try
        execute 'lcd ' . fnameescape(l:build_dir)
    catch
        echo "切换到build目录失败: " . v:exception
        return
    endtry

    echo "当前构建目录: " . getcwd()

    " 检查是否需要运行CMake配置
    let l:current_project_root = l:project_root
    let l:need_cmake = 0

    " 检查ninja是否可用
    let l:use_ninja = NinjaAvailable()
    if l:use_ninja
        echo "检测到 ninja，将使用 ninja 进行构建"
    else
        echo "未检测到 ninja，将使用 make 进行构建"
    endif

    " 检查是否需要重新配置CMake
    if !filereadable('CMakeCache.txt')
        let l:need_cmake = 1
    else
        " 读取缓存中的旧路径
        let l:cache_lines = readfile('CMakeCache.txt')
        let l:old_path = ''
        for line in l:cache_lines
            if line =~ '^CMAKE_HOME_DIRECTORY:INTERNAL='
                let l:old_path = split(line, '=')[1]
                break
            endif
        endfor
    
        " 如果路径不一致，则强制重新配置
        if l:old_path != l:current_project_root
            echo "检测到项目路径变更（旧: " . l:old_path . "），强制重新配置CMake..."
            let l:need_cmake = 1
        endif
    endif

    if l:need_cmake
        echo "运行CMake配置..."
        
        " 构建CMake命令
        let l:cmake_cmd = 'cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ' .
                         \ '-DCMAKE_CXX_STANDARD=23 ' .
                         \ '-DCMAKE_C_COMPILER=gcc-14 ' .
                         \ '-DCMAKE_CXX_COMPILER=g++-14 '
        
        " 如果ninja可用，使用Ninja生成器
        if l:use_ninja
            let l:cmake_cmd .= '-G Ninja '
        endif
        
        let l:cmake_cmd .= '.. 2>&1'
        
        echo "CMake命令: " . l:cmake_cmd
        let l:cmake_output = system(l:cmake_cmd)

        if v:shell_error != 0
            echo "CMake配置失败："
            echo l:cmake_output
            execute 'lcd ' . fnameescape(l:original_dir)
            return
        endif
    endif

    echo "编译中..."
    if l:use_ninja
        let l:build_cmd = 'ninja -j' . min([4, system('nproc 2>/dev/null || echo 4')]) . ' 2>&1'
    else
        let l:build_cmd = 'make -j4 2>&1'
    endif
    
    echo "构建命令: " . l:build_cmd
    let l:build_output = system(l:build_cmd)

    if v:shell_error == 0
        echo "CMake编译成功！"

        if filereadable('compile_commands.json')
            let l:link_cmd = 'ln -sf "' . getcwd() . '/compile_commands.json" "' . l:project_root . '/" 2>/dev/null'
            call system(l:link_cmd)
            echo "编译数据库已链接"
        endif
    else
        echo "编译失败："
        echo l:build_output
    endif

    try
        execute 'lcd ' . fnameescape(l:original_dir)
    catch
        echo "返回原目录失败: " . v:exception
    endtry
endfunction

" ========== 查找可执行文件函数 ==========
function! FindExecutable()
    let l:project_root = fnamemodify(findfile('CMakeLists.txt', '.;'), ':p:h')
    let l:build_dir = l:project_root . '/build'
    
    if !isdirectory(l:build_dir)
        echoerr "构建目录不存在: " . l:build_dir
        return ''
    endif
    
    " 1. 在 build_dir 下直接查找
    let l:direct_files = glob(l:build_dir . '/*', 0, 1)
    for l:file in l:direct_files
        if executable(l:file) && l:file !~? '\.so$' && l:file !~? '\.a$'
            return fnamemodify(l:file, ':t')
        endif
    endfor
    
    " 2. 在 build/bin/ 下查找
    let l:bin_dir = l:build_dir . '/bin'
    if isdirectory(l:bin_dir)
        let l:bin_files = glob(l:bin_dir . '/*', 0, 1)
        for l:file in l:bin_files
            if executable(l:file) && l:file !~? '\.so$' && l:file !~? '\.a$'
                return 'bin/' . fnamemodify(l:file, ':t')
            endif
        endfor
    endif
    
    " 3. 如果上述都没找到，查找所有可执行文件
    let l:find_cmd = 'find "' . l:build_dir . '" -type f -executable ' .
                   \ '! -name "*.so" ! -name "*.a" ! -path "*/CMakeFiles/*" ' .
                   \ '! -name "cmake" ! -name "ctest" ! -name "cpack" 2>/dev/null'
    let l:all_executables = system(l:find_cmd)
    
    if !empty(l:all_executables)
        let l:exe_list = split(l:all_executables, '\n')
        if len(l:exe_list) == 1
            let l:single_exe = l:exe_list[0]
            return substitute(l:single_exe, '^' . l:build_dir . '/', '', '')
        else
            echo "找到多个可执行文件:"
            let l:index = 1
            for l:exe in l:exe_list
                let l:rel_path = substitute(l:exe, '^' . l:build_dir . '/', '', '')
                echo printf("%2d. %s", l:index, l:rel_path)
                let l:index += 1
            endfor
            let l:choice = input("请选择要运行的程序编号 (1-" . (len(l:exe_list)) . "): ")
            if l:choice =~ '^\d\+$' && l:choice >= 1 && l:choice <= len(l:exe_list)
                let l:selected = l:exe_list[l:choice - 1]
                return substitute(l:selected, '^' . l:build_dir . '/', '', '')
            else
                echoerr "选择无效"
                return ''
            endif
        endif
    endif
    
    echoerr "未在构建目录中找到任何可执行文件。"
    echoerr "请检查: 1) CMakeLists.txt中的add_executable() 2) 编译是否成功"
    return ''
endfunction

" ========== 清理构建文件 ==========
function! CleanBuild()
    let l:mode = DetectProjectMode()
    
    if l:mode == 'cmake_standard' || l:mode == 'cmake_single'
        echo "清理CMake构建（将删除build目录）..."
        if isdirectory('build')
            let l:choice = confirm("这将删除整个build目录并清除所有缓存。确定吗？", "&是\n&否", 2)
            if l:choice == 1
                call system('rm -rf build')
                echo "build目录及所有缓存已删除"
            endif
        else
            echo "build目录不存在"
        endif    
    elseif l:mode == 'direct_standard'
        echo "清理直接编译（标准模式）文件..."
        let l:build_dir = expand('%:p:h') . '/build'
        if isdirectory(l:build_dir)
            let l:choice = confirm("确定要删除build目录及其内容吗？", "&是\n&否", 2)
            if l:choice == 1
                call system('rm -rf ' . shellescape(l:build_dir))
                echo "build目录已删除"
            endif
        else
            echo "build目录不存在"
        endif
    else " direct_single
        echo "清理直接编译（单层模式）文件..."
        let l:base = expand('%:r')
        call system('rm -f ' . l:base . '.o ' . l:base . '.out 2>/dev/null')
        echo "清理完成"
    endif
endfunction

" ========== 调试函数 ==========
function! DebugCMake()
    let l:project_root = fnamemodify(findfile('CMakeLists.txt', '.;'), ':p:h')
    let l:build_dir = l:project_root . '/build'
    
    echo "=== 可执行文件调试信息 ==="
    echo "项目根目录: " . l:project_root
    echo "构建目录: " . l:build_dir
    echo "构建目录是否存在: " . (isdirectory(l:build_dir) ? "是" : "否")
    
    if isdirectory(l:build_dir)
        echo "构建目录内容:"
        let l:ls_output = system('ls -la ' . shellescape(l:build_dir))
        echo l:ls_output
        
        let l:exe = FindExecutable()
        echo "FindExecutable() 返回: '" . l:exe . "'"
        if !empty(l:exe)
            echo "完整路径: " . l:build_dir . '/' . l:exe
            echo "文件是否存在: " . (filereadable(l:build_dir . '/' . l:exe) ? "是" : "否")
            echo "是否可执行: " . (executable(l:build_dir . '/' . l:exe) ? "是" : "否")
        endif
    endif
endfunction

nnoremap <leader>dc :call DebugCMake()<CR>  " \dc 调试CMake

" 6. UltiSnips 代码片段配置
let g:UltiSnipsExpandTrigger = '<tab>'          " Tab键展开代码片段
let g:UltiSnipsJumpForwardTrigger = '<tab>'     " Tab键跳到下一个占位符
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'  " Shift+Tab跳到上一个占位符
let g:UltiSnipsSnippetDirectories = ['~/.vim/plugged/vim-snippets/UltiSnips', 'UltiSnips']
let g:UltiSnipsEditSplit = 'vertical'           " 垂直分割编辑片段

" 7. vim-airline 状态栏配置
let g:airline#extensions#tabline#enabled = 1    " 启用顶部标签栏
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1               " 使用powerline字体
let g:airline_theme = 'molokai'                 " 设置主题
let g:airline#extensions#coc#enabled = 1        " 启用coc支持
let g:airline#extensions#ale#enabled = 1        " 启用ALE支持
let g:airline#extensions#tagbar#enabled = 1     " 启用Tagbar支持

" 8. coc.nvim 额外快捷键（补充）
nmap <silent> gi <Plug>(coc-implementation)     " 跳转到实现
nmap <silent> gl :call CocAction('diagnosticNext')<CR>      " 下一个诊断
nmap <silent> gh :call CocAction('diagnosticPrevious')<CR>  " 上一个诊断
nmap <silent> <leader>ca :CocAction<CR>         " \ca 执行代码动作
nmap <silent> <leader>cd :CocDiagnostics<CR>    " \cd 查看所有诊断
nmap <silent> <leader>cr :CocRestart<CR>        " \cr 重启coc
nmap <silent> <leader>cf :CocFix<CR>            " \cf 快速修复

" 自动补全时使用Tab选择补全项，回车确认
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 9. 通用编译运行快捷键（备用）
nnoremap <leader>cc :w<CR>:!g++-14 -std=c++23 -Wall -Wextra -o %:r.out % && echo "编译成功"<CR>
nnoremap <leader>cr :!./%:r.out<CR>

" 10. 窗口管理快捷键
nnoremap <C-h> <C-w>h       " Ctrl+h 切换到左边窗口
nnoremap <C-j> <C-w>j       " Ctrl+j 切换到下边窗口
nnoremap <C-k> <C-w>k       " Ctrl+k 切换到上边窗口
nnoremap <C-l> <C-w>l       " Ctrl+l 切换到右边窗口
nnoremap <leader>wv :vsplit<CR>     " \wv 垂直分割窗口
nnoremap <leader>wh :split<CR>      " \wh 水平分割窗口
nnoremap <leader>wc :close<CR>      " \wc 关闭当前窗口
nnoremap <leader>wo :only<CR>       " \wo 只保留当前窗口

" 11. 快速保存和退出
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>a
nnoremap <leader>q :q<CR>
nnoremap <leader>qq :q!<CR>
nnoremap <leader>wq :wq<CR>

" 12. 代码注释（如果安装vim-commentary插件）
" Plug 'tpope/vim-commentary' 可以添加到插件列表
nnoremap \\ :Commentary<CR>
vnoremap \\ :Commentary<CR>

" 13. 搜索相关快捷键
nnoremap <leader>ss :%s///g<Left><Left><Left>   " \ss 全局替换
nnoremap <leader>sc :nohlsearch<CR>             " \sc 清除搜索高亮

" 14. 配置文件快捷操作
nnoremap <leader>sv :source ~/.vimrc<CR>        " \sv 重新加载配置
nnoremap <leader>ev :vsplit ~/.vimrc<CR>        " \ev 编辑配置文件

" 15. 其他实用快捷键
nnoremap Y y$                       " Y 复制到行尾
nnoremap <leader>p "+p              " \p 从系统剪贴板粘贴
vnoremap <leader>y "+y              " \y 复制到系统剪贴板
nnoremap <leader>d "_d              " \d 删除到黑洞寄存器（不覆盖复制内容）
vnoremap <leader>d "_d

" 16. 标签页管理
nnoremap <leader>tn :tabnew<CR>     " \tn 新建标签页
nnoremap <leader>tc :tabclose<CR>   " \tc 关闭当前标签页
nnoremap <leader>th :tabprev<CR>    " \th 上一个标签页
nnoremap <leader>tl :tabnext<CR>    " \tl 下一个标签页
nnoremap <leader>t1 :tabn 1<CR>     " \t1 切换到标签页1
nnoremap <leader>t2 :tabn 2<CR>     " \t2 切换到标签页2

" 17. coc.nvim 需要的函数定义
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 18. 自动命令
augroup CppIDE
  autocmd!
  " 保存时自动删除末尾空格
  autocmd BufWritePre *.cpp,*.h,*.c :%s/\s\+$//e
  " 打开文件时自动定位到上次编辑位置
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  " 自动设置文件类型
  autocmd BufNewFile,BufRead *.cpp,*.hpp,*.cc,*.cxx set filetype=cpp
  autocmd BufNewFile,BufRead *.h set filetype=cpp
augroup END

" 19. 配色优化
set termguicolors           " 启用真彩色支持
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set background=dark         " 使用深色背景

" 20. 备份设置
set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set undofile

" ========== 自动创建备份目录 ==========
function! EnsureDirExists(dir)
    if !isdirectory(a:dir)
        call mkdir(a:dir, 'p', 0700)
    endif
endfunction

" 在 Vim 启动时自动创建必要的目录
augroup AutoMkdir
    autocmd!
    autocmd VimEnter * call EnsureDirExists(&backupdir)
    autocmd VimEnter * call EnsureDirExists(&directory)
    autocmd VimEnter * call EnsureDirExists(&undodir)
augroup END

" 确保备份相关设置完整
set backup                          " 启用备份
set writebackup                     " 写入时创建备份
set backupcopy=auto                 " 根据需求调整备份方式

" 忽略某些文件的备份
set backupskip=/tmp/*,/private/tmp/*

" ========== F7：快速唤出终端 ==========

" F7 在当前窗口下方打开一个终端（高度占20%）
nnoremap <F7> :belowright split<CR>:resize 6<CR>:terminal ++curwin<CR>

" F7 在右侧打开一个终端（宽度占30%）
" nnoremap <F7> :belowright vsplit \| vertical resize 40 \| terminal<CR>

" 终端模式下的退出映射
tnoremap <Esc> <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

" 终端中也可以使用jk快速返回Normal模式
tnoremap jk <C-\><C-n>

" 终端启动后自动进入插入模式（可选）
" 只在支持 TermOpen 事件的 Vim 版本中执行
if exists('##TermOpen')
    autocmd TermOpen * startinsert
endif

" ========== 添加 ninja 清理支持 ==========
" 在 CleanBuild 函数中添加对 ninja 的清理支持
function! CleanBuild()
    let l:mode = DetectProjectMode()
    
    if l:mode == 'cmake_standard' || l:mode == 'cmake_single'
        echo "清理CMake构建..."
        if isdirectory('build')
            let l:choice = confirm("请选择清理方式:", "&完全删除build目录\n&使用ninja clean\n&使用make clean\n&取消", 1)
            if l:choice == 1
                " 完全删除build目录
                call system('rm -rf build')
                echo "build目录及所有缓存已删除"
            elseif l:choice == 2
                " 使用ninja clean
                if isdirectory('build')
                    let l:original_dir = getcwd()
                    execute 'lcd build'
                    if filereadable('build.ninja')
                        call system('ninja clean')
                        echo "已使用 ninja clean 清理构建文件"
                    else
                        echo "未找到 build.ninja 文件，无法使用 ninja clean"
                    endif
                    execute 'lcd ' . fnameescape(l:original_dir)
                endif
            elseif l:choice == 3
                " 使用make clean
                if isdirectory('build')
                    let l:original_dir = getcwd()
                    execute 'lcd build'
                    if filereadable('Makefile')
                        call system('make clean')
                        echo "已使用 make clean 清理构建文件"
                    else
                        echo "未找到 Makefile 文件，无法使用 make clean"
                    endif
                    execute 'lcd ' . fnameescape(l:original_dir)
                endif
            endif
        else
            echo "build目录不存在"
        endif    
    elseif l:mode == 'direct_standard'
        echo "清理直接编译（标准模式）文件..."
        let l:build_dir = expand('%:p:h') . '/build'
        if isdirectory(l:build_dir)
            let l:choice = confirm("确定要删除build目录及其内容吗？", "&是\n&否", 2)
            if l:choice == 1
                call system('rm -rf ' . shellescape(l:build_dir))
                echo "build目录已删除"
            endif
        else
            echo "build目录不存在"
        endif
    else " direct_single
        echo "清理直接编译（单层模式）文件..."
        let l:base = expand('%:r')
        call system('rm -f ' . l:base . '.o ' . l:base . '.out 2>/dev/null')
        echo "清理完成"
    endif
endfunction

" ========== 添加 ninja 特定快捷键 ==========
" F9: 快速清理 (ninja clean 或 make clean)
nnoremap <F9> :call QuickClean()<CR>

function! QuickClean()
    let l:mode = DetectProjectMode()
    
    if l:mode == 'cmake_standard' || l:mode == 'cmake_single'
        let l:project_root = fnamemodify(findfile('CMakeLists.txt', '.;'), ':p:h')
        let l:build_dir = l:project_root . '/build'
        
        if isdirectory(l:build_dir)
            let l:original_dir = getcwd()
            execute 'lcd ' . fnameescape(l:build_dir)
            
            if filereadable('build.ninja')
                echo "使用 ninja clean 清理..."
                call system('ninja clean')
                echo "清理完成"
            elseif filereadable('Makefile')
                echo "使用 make clean 清理..."
                call system('make clean')
                echo "清理完成"
            else
                echo "未找到构建文件，无法清理"
            endif
            
            execute 'lcd ' . fnameescape(l:original_dir)
        else
            echo "build目录不存在"
        endif
    else
        echo "当前不是CMake项目模式"
    endif
endfunction

augroup CMakeDB
  autocmd!
  " 保存CMakeLists.txt时自动生成编译数据库
  autocmd BufWritePost CMakeLists.txt :call GenerateCompileCommands()
augroup END

function! GenerateCompileCommands()
  let l:cmake_file = findfile('CMakeLists.txt', '.;')
  if !empty(l:cmake_file)
    let l:project_root = fnamemodify(l:cmake_file, ':p:h')
    let l:build_dir = l:project_root . '/build'
    if isdirectory(l:build_dir)
      execute 'lcd ' . fnameescape(l:build_dir)
      call system('cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..')
      call system('ln -sf ' . l:build_dir . '/compile_commands.json ' . l:project_root)
      lcd -
    endif
  endif
endfunction
