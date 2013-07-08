if &cp || exists("g:loaded_zoom")
    finish
endif
let g:loaded_zoom = 1

let s:save_cpo = &cpo
set cpo&vim

" keep default value
let s:current_font = &guifont

" command
command! -narg=? ZoomIn    :call s:ZoomIn(<f-args>)
command! -narg=? ZoomOut   :call s:ZoomOut(<f-args>)
command! -narg=0 ZoomReset :call s:ZoomReset()

" Map Ctrl-MouseWheel to zoom in/out
nmap <C-MouseDown> :ZoomIn<CR>
nmap <C-MouseUp> :ZoomOut<CR>

" Map Ctrl-KeypadPlus/Minus to zoom in/out
nmap <C-kPlus> :ZoomIn<CR>
nmap <C-kMinus> :ZoomOut<CR>

" guifont size + 1
function! s:ZoomIn(...)
  let amount = a:1 ? a:1 : 1
  " Original: let l:fsize = substitute(&guifont, '^.*:h\([^:]*\).*$', '\1', '')
  " But we made some changes for Vim6 on WindowsXP.
  let l:fsize = substitute(&guifont, '^.*[ -]\([0-9]*\)$', '\1', '')
  let l:fsize += amount
  let l:guifont = substitute(&guifont, '^\(.*[ -]\)[0-9]*$', '\1' . l:fsize, '')
  let &guifont = l:guifont
endfunction

" guifont size - 1
function! s:ZoomOut(...)
  let amount = a:1 ? a:1 : 1
  let l:fsize = substitute(&guifont, '^.*[ -]\([0-9]*\)$', '\1', '')
  let l:fsize -= amount
  let l:guifont = substitute(&guifont, '^\(.*[ -]\)[0-9]*$', '\1' . l:fsize, '')
  let &guifont = l:guifont
endfunction

" reset guifont size
function! s:ZoomReset()
  let &guifont = s:current_font
endfunction

let &cpo = s:save_cpo
finish

==============================================================================
zoom.vim : control gui font size with "+" or "-" keys.
------------------------------------------------------------------------------
$VIMRUNTIMEPATH/plugin/zoom.vim
==============================================================================
author  : OMI TAKU (changes by joeytwiddle)
url     : http://nanasi.jp/
email   : mail@nanasi.jp
version : 2013/06/26 19:22:00
==============================================================================

Control Vim editor font size with key "+", or key "-".
Press "+" key, Vim editor gui font size will change bigger.
And, press "-" key, Vim editor gui font size will change smaller.

This plugin is for GUI only.

Normal Mode:

    CTRL-kPlus         ... make font size bigger
    CTRL-MouseUp

    CTRL-kMinus        ... make font size smaller
    CTRL-MouseDown

Command-line Mode:

    :ZoomIn [amount]   ... make font size bigger
    :ZoomOut [amount]  ... make font size smaller
    :ZoomReset         ... reset font size changes.

==============================================================================

1. Copy the zoom.vim script to
   $HOME/vimfiles/plugin or $HOME/.vim/plugin directory.
   Refer to ':help add-plugin', ':help add-global-plugin' and
   ':help runtimepath' for more details about Vim plugins.

2. Restart Vim.

==============================================================================
" vim: set ff=unix et ft=vim nowrap :
