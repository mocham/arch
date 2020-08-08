
function! s:buf_change_filetype(oldext, newext)
	let l:name = bufname("%")
	let l:name = strpart(l:name, 0, len(l:name) - len(a:oldext)) . a:newext
	return l:name
endfunction

function! s:viewtex()
    exe ("!zathura " . s:buf_change_filetype("tex", "pdf") . " &")
"    exe "silent !mpw &"
endfunction

function! s:mpvbuffer(str)
    let l:cmd="mpw-sender '".a:str."'"
python3 << EOF
import os
import sys
cmd=vim.eval("l:cmd")
os.system(cmd)
EOF
endfunction

function! s:mpw(howtocopy, prefix, suffix)
    let l:pos=getpos('.')
    exe a:howtocopy
    call cursor(l:pos[1],l:pos[2])
    call s:mpvbuffer(a:prefix.@9.a:suffix)
endfunction

command! TexExtractMathEnv :call s:mpw("normal ?\\$\<cr>\"9y/\\$\<cr>","","\$")
command! TexExtractLine :call s:mpw("normal \"9yy","","")
command! TexExtractBracket :call s:mpw("normal ?\^{\$\<cr>\"9y/^}\$\<cr>","","}")
noremap <C-P>m :TexExtractMathEnv<CR>
noremap <C-P>p :TexExtractLine<CR>
noremap <C-P>[ :TexExtractBracket<CR>
command! View :call s:viewtex()
