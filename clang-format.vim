" Check if the CLANG_FORMAT_PATH environment variable is set
if empty($CLANG_FORMAT_PATH)
  echoerr "CLANG_FORMAT_PATH is not set! Please set it in your environment."
  finish
endif

" Incude guard
if exists("g:loaded_clang_format")
  finish
endif
let g:loaded_clang_format = 1

" https://clang.llvm.org/docs/ClangFormat.html#vim-integration
if has('python')
  nnoremap <C-K> :pyf $CLANG_FORMAT_PATH<CR>
  inoremap <C-K> <c-o>:pyf $CLANG_FORMAT_PATH<CR>
elseif has('python3')
  nnoremap <C-K> :py3f $CLANG_FORMAT_PATH<CR>
  inoremap <C-K> <c-o>:py3f $CLANG_FORMAT_PATH<CR>
endif

function! Formatonsave()
  let l:formatdiff = 1
  py3f $CLANG_FORMAT_PATH<CR>
endfunction

autocmd BufWritePre *.h,*.hpp,*.cc,*.cpp call Formatonsave()

