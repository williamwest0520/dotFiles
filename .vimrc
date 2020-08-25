augroup autoFileTypes
  autocmd!
  autocmd BufNewFile,BufRead *.markdown,*.md set filetype=markdown
  autocmd BufNewFile,BufRead *.markdown,*.md setlocal spell
  autocmd BufNewFile,BufRead *.cfg,*.scn set filetype=xml
  autocmd BufNewFile,BufRead *.qml set filetype=qml
  autocmd BufNewFile,BufRead *.c,*.cpp,*.cxx,*.h,*.hpp set cindent
augroup END

syntax enable

set wildmenu
set hidden
set incsearch
set hlsearch
set splitright
set number
set relativenumber
set cursorline
set ruler
set expandtab
set backspace=start,eol,indent
set shiftwidth=4
set colorcolumn=81,101
set undofile
set undodir=~/.vim/undo
set laststatus=2
set iskeyword+=-
set tags=tags;~

"" Set netrw options
let g:netrw_browse_split=2
let g:netrw_winsize=25
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_altv=1

"" Automatically open with file tree on left
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

"" Autotoggle relative numbers
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

"" Define comment style per file type
augroup comment_leaders
  autocmd!
  autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
  autocmd FileType sh,ruby,python   let b:comment_leader = '# '
  autocmd FileType conf,fstab       let b:comment_leader = '# '
  autocmd FileType tex              let b:comment_leader = '% '
  autocmd FileType vim              let b:comment_leader = '" '
augroup END

nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <Leader>// ^i<C-R>=b:comment_leader<CR><Esc>
nnoremap <Leader>/? 0i<C-R>=b:comment_leader<CR><Esc>
vnoremap <Leader>// ^o^I<C-R>=b:comment_leader<CR><Esc>
nnoremap <Leader>.. ^df <Esc>
nnoremap <Leader>.> 0df <Esc>
vnoremap <Leader>.. ^o^f d<Esc>
highlight StatusLine cterm=bold ctermfg=6 ctermbg=5
highlight StatusLineNC cterm=bold ctermfg=0 ctermbg=13
highlight LineNr ctermfg=242
highlight CursorLineNr term=bold cterm=NONE ctermfg=11 gui=bold guifg=Yellow
highlight CursorLine cterm=NONE
highlight PmenuSel ctermfg=0 ctermbg=203
highlight ColorColumn ctermbg=238 ctermfg=203
highlight SpellBad ctermfg=9 ctermbg=NONE
