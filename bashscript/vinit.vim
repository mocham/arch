set fileencodings=utf-8,gb18030
set autoindent
set smartindent
set shiftwidth=4
set ts=4
set expandtab
"set showmatch
colorscheme darkblue
filetype plugin on
set shellslash
set grepprg=grep\ -nH\$*
let g:tex_flavor="latex"
"set lines=50 columns=100
"inoremap <C-U> <C-G>u<C-U>
noremap <C-Z> :TlistToggle<CR>
noremap <C-C> "+y<CR>
noremap <C-V> "+p<CR>
noremap L 30l
let g:vimrc_path="/common/vimrc"

function! s:syscmd(cmd)
python3 << EOF
import vim
import os
os.system(vim.eval("a:cmd"))
EOF
endfunction

function! s:bufextname(extlen)
	let l:name = bufname("%")
	return strpart(l:name, len(l:name) - a:extlen, a:extlen)
endfunction

function! s:compile()
	let l:name = bufname("%")
	if s:bufextname(3) == "tex"
		call s:compiletex()
	elseif s:bufextname(3) == "cpp"
		call s:compilecxx()
	elseif s:bufextname(6) == "coffee"
		call s:compilecoffee()
	elseif s:bufextname(1) == "c"
		call s:compilec()
	endif
endfunction

function! s:compilec()
	let l:name = bufname("%")
	exe "!clang -c " . l:name
	let l:name = substitute(l:name, "c", "o", 1)
	let l:ename = strpart(l:name, 0, len(l:name) - 2)
	exe "!clang -o " .l:ename . " " . l:name
	exe "!\.\/" . l:ename
endfunction


function! s:compilecoffee()
	let l:name = bufname("%")
	exe "!coffee --compile -b " . l:name
	let l:name = substitute(l:name, "coffee", "js", 1)
	exe "!uglifyjs " . l:name . ' > min-'.l:name
endfunction

function! s:compilecxx()
	let l:name = bufname("%")
	exe "!g++ -std=c++11 -c " . l:name
	let l:name = substitute(l:name, "cpp", "o", 1)
	let l:ename = strpart(l:name, 0, len(l:name) - 2)
	exe "!g++ -std=c++11 -o " .l:ename . " " . l:name
	exe "!\.\/" . l:ename
endfunction

function! s:compiletex()
	exe "!python /opt/ortin/utils/pdflatex.py " . bufname("%")
endfunction

function! s:openfile(filename, open_command)
python3 << EOF
import vim

def current_line():
	return vim.current.window.cursor[0] - 1

def line_string(n):
	return vim.current.buffer[n]

def between(str, left, right):
	l = str.find(left)
	r = str.find(right)
	if l == -1:
		return ""
	if r == -1:
		return ""
	return str[l + len(left): r]

def find_buffer(name):
	for i in range(0, vim.buffers):
		if vim.buffers[i].name == name:
			return i
	return -1

def find_line(str):
	for i in range(0, len(vim.current.buffer) - 1):
		if vim.current.buffer[i] == str:
			return i + 2
	return -1

def change_buffer(name, open_command):
	while True:
		if vim.current.buffer.name == name:
			return True
		num = vim.current.buffer.number
		vim.command("exe \"normal \<c-w>l\"")
		if num == vim.current.buffer.number:
			break
	while True:
		if vim.current.buffer.name == name:
			return True
		num = vim.current.buffer.number
		vim.command("exe \"normal \<c-w>h\"")
		if num == vim.current.buffer.number:
			break
	while True:
		if vim.current.buffer.name == name:
			return True
		num = vim.current.buffer.number
		vim.command("exe \"normal \<c-w>j\"")
		if num == vim.current.buffer.number:
			break
	while True:
		if vim.current.buffer.name == name:
			return True
		num = vim.current.buffer.number
		vim.command("exe \"normal \<c-w>k\"")
		if num == vim.current.buffer.number:
			break
	vim.command("execute \"" + open_command + " " + name + "\"")
	return False

change_buffer(vim.current.buffer.name + vim.eval("a:filename"), vim.eval("a:open_command"))
EOF
endfunction

function! s:texcount()
    let l:name = bufname("%")
    exe "!/usr/share/vim/vimfiles/texcount.pl " . l:name
endfunction

command! Texcount :call s:texcount()
command! Gn :call s:compile()
command! SyncB :!rsync -r /opt/hw/blog-web/blog zlin15@math.jhu.edu:public_html/

source ~/bashscript/MathTexPreview.vim
