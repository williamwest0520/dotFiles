augroup autoFileTypes
  autocmd!
  autocmd BufNewFile,BufRead *.markdown,*.md set filetype=markdown
  autocmd BufNewFile,BufRead *.markdown,*.md setlocal spell
  autocmd BufNewFile,BufRead *.markdown,*.md setlocal textwidth=80
  autocmd BufNewFile,BufRead *.cfg,*.scn set filetype=xml
  autocmd BufNewFile,BufRead *.qml set filetype=qml
  autocmd BufNewFile,BufRead *.c,*.cpp,*.cxx,*.h,*.hpp set cindent
  autocmd BufNewFile,BufRead *.frag,*.vert set filetype=cpp
augroup END

augroup autoQuickFix
  autocmd!
  if $JSIG_HOME != ""
    autocmd QuickFixCmdPre make* cd $JSIG_HOME
    autocmd QuickFixCmdPost make* cd -
  endif
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
augroup END

syntax enable

set wildmenu
set hidden
set incsearch
set hlsearch
set splitright
set splitbelow
set number
set relativenumber
set ruler
set expandtab
set backspace=start,eol,indent
set shiftwidth=4
set colorcolumn=81,101
set undofile
set undodir=~/.vim/undo
set laststatus=2
set mouse=nv
set tags=tags;~
set t_TI= t_TE=

"" Set netrw options
let g:netrw_browse_split=4
let g:netrw_winsize=20
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_altv=1
"" Define for toggle
let g:NetrwIsOpen=0
"" Enable highlighting of code syntax in fenced markdown
let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'vim', 'cpp', 'c']

"" Automatically open with file tree on left
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :call ToggleNetrw()
" augroup END

"" Close netrw or quickfix if only buffer open
" autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif

"" Toggle netrw
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Vexplore
    endif
endfunction

"" Netrw split alternatives
function! OpenToRight()
    :normal v
    let g:path=expand('%:p')
    :q!
    execute 'belowright vnew' g:path
    :normal <C-l>
endfunction

function! OpenBelow()
    :normal v
    let g:path=expand('%:p')
    :q!
    execute 'belowright new' g:path
    :normal <C-l>
endfunction

function! NetrwMappings()
    noremap <buffer> V :call OpenToRight()<CR>
    noremap <buffer> H :call OpenBelow()<CR>
endfunction

augroup netrw_mappings
    autocmd!
    autocmd FileType netrw :call NetrwMappings()
augroup END

"" Autotoggle relative numbers
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

"" Define comment style per file type
augroup comment_leaders
  autocmd!
  autocmd FileType c,cpp,java,scala       let b:comment_leader = '// '
  autocmd FileType sh,ruby,python,cmake   let b:comment_leader = '# '
  autocmd FileType conf,fstab             let b:comment_leader = '# '
  autocmd FileType tex                    let b:comment_leader = '% '
  autocmd FileType vim                    let b:comment_leader = '" '
augroup END

"" Tab through buffers
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>
"" Tab through completions
inoremap <Tab> <C-n>
inoremap <S-Tab> <C-p>
"" grep for a word recursively in the arglist
nnoremap <c-k> :grep  -rI ## --exclude-dir=.git<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
"" vimgrep for current word in current directory
nnoremap <Leader>f :vimgrep /<C-r><C-w>/j ./*
"" Add quotes
nnoremap <Leader>" ciw""<ESC>P
vnoremap <Leader>" c""<ESC>P
"" Begin substitution with word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
"" Comments
nnoremap <Leader>// ^i<C-R>=b:comment_leader<CR><Esc>
nnoremap <Leader>/? 0i<C-R>=b:comment_leader<CR><Esc>
vnoremap <Leader>// ^o^I<C-R>=b:comment_leader<CR><Esc>
"" xml comments
nnoremap <Leader>xc mzI<!-- <Esc>A --><Esc>`z<Right><Right><Right><Right><Right>:delm z<CR>
nnoremap <Leader>xC mz^df $F d$`z<Left><Left><Left><Left><Left>:delm z<CR>
vnoremap <Leader>xc c<!--<CR><Esc>i--><Esc>P
vnoremap <Leader>xC <Esc>`<dd`>dd
"" Uncomment
nnoremap <Leader>.. ^df <Esc>
nnoremap <Leader>.> 0df <Esc>
vnoremap <Leader>.. ^o^f d<Esc>
"" Toggle netrw
nnoremap <C-f> :call ToggleNetrw()<CR>
"" fzf commands
nnoremap <Leader>o :Files<CR>
nnoremap <Leader>l :Lines<CR>

"" abbreviations
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep'

highlight StatusLine cterm=bold ctermfg=6 ctermbg=5
highlight StatusLineNC cterm=bold ctermfg=0 ctermbg=13
highlight LineNr ctermfg=242
highlight CursorLineNr term=bold cterm=NONE ctermfg=11 gui=bold guifg=Yellow
highlight CursorLine cterm=underline
highlight PmenuSel ctermfg=0 ctermbg=203
highlight ColorColumn ctermbg=238 ctermfg=203
highlight SpellBad ctermfg=9 ctermbg=NONE
