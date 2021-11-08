set autoindent
set smarttab
set paste
set nocompatible            " 关闭 vi 兼容模式
syntax on                   " 自动语法高亮
set number                  " 显示行号
set ruler                   " 打开状态栏标尺
set shiftwidth=4            " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4           " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4               " 设定 tab 长度为 4
set nobackup                " 覆盖文件时不备份
set autochdir               " 自动切换当前目录为当前文件所在的目录
set backupcopy=yes          " 设置备份时的行为为覆盖
set incsearch               " 输入搜索内容时就显示搜索结果
set hlsearch                " 搜索时高亮显示被找到的文本
set magic                   " 设置魔术
set hidden                  " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏
set smartindent             " 开启新行时使用智能自动缩进
set backspace=indent,eol,start
set cmdheight=1             " 设定命令行的行数为 1
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\ 
set t_Co=256
"禁止生成临时文件
set nobackup
set helplang=cn             " 设定帮助文档为中文
set encoding=utf-8
set noswapfile
"代码补全 
set completeopt=preview,menu 
" setlocal spell spelllang=en_us "拼写检查
"设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

"" for error highlight，防止错误整行标红导致看不清
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

"自动补全
inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { {<CR>}<ESC>O
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction
filetype plugin indent on 
"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu


"新建.c,.h,.sh,.java文件，自动插入文件头   
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()"   
""定义函数SetTitle，自动插入文件头   
func SetTitle()   
    "如果文件类型为.sh文件   
    if &filetype == 'sh'   
        call setline(1,"\#!/bin/bash")   
        call append(line("."), "")   
    elseif &filetype == 'python'  
        call setline(1,"#!/usr/bin/env python")  
        call append(line("."),"# coding=utf-8")  
        call append(line(".")+1, "")   
  
    elseif &filetype == 'ruby'  
        call setline(1,"#!/usr/bin/env ruby")  
        call append(line("."),"# encoding: utf-8")  
        call append(line(".")+1, "")  
    endif  
    if expand("%:e") == 'cpp'  
        call setline(1, "#include <iostream>") 
        call append(line("."), "")  
        call append(line(".")+1,  "using namespace std;")  
        call append(line(".")+2, "")  
    endif  
    if &filetype == 'c'  
        call setline(1, "#include<stdio.h>")  
        call append(line("."), "")  
    endif  
    if expand("%:e") == 'h'  
        call setline(1, "#ifndef _".toupper(expand("%:r"))."_H")  
        call append(line("."), "#define _".toupper(expand("%:r"))."_H")  
        call append(line(".")+1, "#endif")  
    endif  
    if &filetype == 'java'  
        call setline(1,"public class ".expand("%:r"))  
        call append(line("."),"")  
    endif  
    "新建文件后，自动定位到文件末尾  
endfunc   
autocmd BufNewFile * normal G  

"在vim编辑sh文件后，自动拥有执行权限"
function ModeChange()
  if getline(1) =~ "^#!"
    if getline(1) =~ "bin/"
        silent !chmod a+x <afile>
    endif
  endif
endfunction
au BufWritePost * call ModeChange()

