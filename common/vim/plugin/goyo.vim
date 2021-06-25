let g:limelight_conceal_ctermfg = 240
function! s:goyo_enter()
  set nu
  set relativenumber
endfunction

function! s:goyo_leave()
  set nu
  set relativenumber
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
