""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""
""  Basic configuration
""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" set encoding to UTF-8
set encoding=utf-8
scriptencoding utf-8

"" update terminal title
set title

"" use 256 colors in terminal
set t_Co=256

"" fast terminal connection
set ttyfast

"" use mouse in terminal
set mouse=a

"" show line numbers
set number

"" enable fold column
set foldcolumn=1
highlight FoldColumn ctermbg=235

"" highlight current line
set cursorline
highlight CursorLine ctermbg=235 cterm=bold

"" show maxwidth column
set textwidth=79
let &colorcolumn=&textwidth
highlight ColorColumn ctermbg=235

"" save last 128 commands in history
set history=128

"" setup persistent undo-redo history
set undofile
set undodir=~/.vim/undodir
set undolevels=1024
set undoreload=4096

"" highlight search results
set hlsearch

"" do incremental search
set incsearch

"" don't close buffers
set hidden

"" don't wrap text
set wrap!

"" setup tabulation
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""
""  Fast buffer changing
""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! ChangeBuf(cmd)
    if (&modified && &modifiable)
        execute ":w"
    endif
    execute a:cmd
endfunction

"" go to the next buffer with ctrl-n
nnoremap <silent> <C-n> :call ChangeBuf(":bn")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""
""  Autodetect django html files
""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! DetectTemplate()
    let n = 1
    while n < line("$")
        if getline(n) =~ '{%' || getline(n) =~ '{{'
            set ft=htmldjango
            return
        endif
        let n = n + 1
    endwhile
    set ft=html "default html
endfun

autocmd BufNewFile,BufRead *.html call DetectTemplate()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""
""  Key mappings
""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" open new buffer on new window with crtl-c
nmap <C-c> :enew<CR>

"" quick save with F5
nmap <F5> :w<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""
""  Abbreviations
""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

iab doctype! <!DOCTYPE html>
iab perlbang! #!/data/data/com.termux/files/usr/bin/perl
iab pybang! #!/data/data/com.termux/files/usr/bin/python
iab shbang! #!/data/data/com.termux/files/usr/bin/sh
iab utf! # -*- coding: utf-8 -*-

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""
""  Quick autocommands
""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" remove trailing whitespaces
autocmd BufWritePre * %s/\s\+$//e
