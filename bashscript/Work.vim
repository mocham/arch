
function! s:time()
python3 << EOF
import vim
import time
vim.command("return " + str(time.time()))
EOF
endfunction


let g:init_time = s:time()
let g:working = 0
let g:duration = 0
let g:expected_duration = 60*60*2

function! s:work_switch()
    if g:working == 0
        let g:start_time = s:time()
    else
        let g:duration = g:duration+s:time()-g:start_time
        call s:syscmd("echo ".float2nr(g:duration)." >~/duration")
        if g:expected_duration<g:duration
            echo "You finished this session. Congratulations"
            call s:syscmd("echo $(date) >> ~/sessions")
            let g:duration = 0
        endif
    endif
    let g:working = 1 - g:working
endfunction

command! W :call s:work_switch()
command! Wb :call s:syscmd("cp ~/bashscript/conky-work ~/bashscript/conkyrc")
command! We :call s:syscmd("cp ~/bashscript/conky-normal ~/bashscript/conkyrc")
command! Ws :echo g:working

