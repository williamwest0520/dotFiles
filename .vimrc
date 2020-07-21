augroup autoFileTypes
  autocmd!
  autocmd BufNewFile,BufRead *.markdown,*.md set filetype=markdown
  autocmd BufNewFile,BufRead *.c,*.cpp,*.cxx,*.h,*.hpp set cindent
augroup END

set wildmenu
set hidden
set incsearch
set splitright
set number
set relativenumber
set expandtab
set shiftwidth=4
set colorcolumn=80,100
set undofile
set undodir=~/.vim/undo
set laststatus=2

"" Set netrw options
let g:netrw_browse_split=3
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
nnoremap <Leader>.. ^df <Esc>
nnoremap <Leader>.> 0df <Esc>
highlight StatusLine cterm=bold ctermfg=6 ctermbg=5
highlight StatusLineNC cterm=bold ctermfg=0 ctermbg=13
highlight LineNr ctermfg=242
highlight ColorColumn ctermbg=238 ctermfg=203
