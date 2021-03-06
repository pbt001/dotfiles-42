" pip install python-language-server
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
        \ 'whitelist': ['rust'],
        \ })
endif
if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes

    " Folding
    " set foldmethod=expr
    "             \ foldexpr=lsp#ui#vim#folding#foldexpr()
    "             \ foldtext=lsp#ui#vim#folding#foldtext()

    " Keybinding
    nmap <buffer> <leader>ac <plug>(lsp-code-action)
    nmap <buffer> gD <plug>(lsp-declaration)
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gy <plug>(lsp-type-definition)
    nmap <buffer> <leader>gD <plug>(lsp-peek-declaration)
    nmap <buffer> <leader>gd <plug>(lsp-peek-definition)
    nmap <buffer> <leader>gi <plug>(lsp-peek-implementation)
    nmap <buffer> <leader>gy <plug>(lsp-peek-type-definition)
    nmap <buffer> <leader>ls <plug>(lsp-document-symbol)
    nmap <buffer> <leader>fwo <plug>(lsp-workspace-symbol)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> <leader>ld <plug>(lsp-document-diagnostics)
    " nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    " nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> <leader>f <plug>(lsp-document-format)
    vmap <buffer> <leader>f <plug>(lsp-document-range-format)
    nmap <buffer> K <plug>(lsp-hover)
    " nnoremap <plug>(lsp-next-reference)
    " nnoremap <plug>(lsp-preview-close)
    " nnoremap <plug>(lsp-preview-focus)
    " nnoremap <plug>(lsp-previous-reference)
    " nnoremap <plug>(lsp-previous-warning)
    " nnoremap <plug>(lsp-type-hierarchy)
    " nnoremap <plug>(lsp-signature-help)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Turn off diagnostic (use ALE instead)
let g:lsp_diagnostics_enabled = 0
