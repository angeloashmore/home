" Clipboard
    " Use the system clipboard
    set clipboard+=unnamedplus

" UI
    set termguicolors
    set lazyredraw
    set cursorline
    set number
    set noshowmode
    syntax sync fromstart
    set redrawtime=20000

    " Invisible characters
    set list
    set listchars=tab:\ \ │,trail:·,extends:…,precedes:…

    " Themes
    set background=dark
    let g:rose_pine_variant = "moon"
    colorscheme rose-pine

    " Hide netrw banner
    let g:netrw_banner=0

    " Hide fzf status bar
    autocmd! FileType fzf set laststatus=0 noshowmode noruler
          \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" lightline
    let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'colorscheme': 'nord',
      \ }

" Terminal window movement mappings
    tnoremap <C-w>h <C-\><C-n><C-w>h
    tnoremap <C-w>j <C-\><C-n><C-w>j
    tnoremap <C-w>k <C-\><C-n><C-w>k
    tnoremap <C-w>l <C-\><C-n><C-w>l

" fugitive.vim
    " Prevent `:Gf` (:Gfetch) when you meant `:GF`
    command Gf GF

" editorconfig-vim
    " Ensure fugitive.vim is not affected by editorconfig
    let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" dispatch.vim
    command! -bang -bar -nargs=* Gpush execute 'Dispatch<bang> -dir=' .
          \ fnameescape(FugitiveGitDir()) . '/../' 'git push' <q-args>
    command! -bang -bar -nargs=* Gpull execute 'Dispatch<bang> -dir=' .
          \ fnameescape(FugitiveGitDir()) . '/../' 'git pull' <q-args>

" Indention
    filetype plugin indent on
    set tabstop=8
    set expandtab

    autocmd Filetype go setlocal tabstop=8 shiftwidth=8 expandtab!

" indentLine
    " highlight IndentBlanklineChar guifg=#2a2d30 gui=nocombine
    highlight IndentBlanklineContextChar guifg=#FF00FF gui=nocombine
    let g:indent_blankline_char = '│'

    " Fix UI bug where highlighted line extends past current line
    set colorcolumn=99999


    " Don't hide characters like the "**" in "**word**"
    let g:vim_json_syntax_conceal = 0
    let g:vim_markdown_conceal = 0
    let g:vim_markdown_conceal_code_blocks = 0

" Folding
    set foldmethod=indent
    set foldlevelstart=99

" EasyAlign
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)

" nvim-miniyank
    map p <Plug>(miniyank-autoput)
    map P <Plug>(miniyank-autoPut)
    map <C-p> <Plug>(miniyank-cycle)
    map <C-n> <Plug>(miniyank-cycleback)

" vista.vim
    let g:vista_default_executive = 'coc'
    let g:vista#renderer#enable_icon = 0
    let g:vista_sidebar_width = 50
    let g:vista_echo_cursor = 0
    let g:vista_highlight_whole_line = 1

" Language Support
    let g:jsx_ext_required = 0

    " Set Dockerfile syntax for *.dockerfile
    au BufRead,BufNewFile *.[Dd]ockerfile setf Dockerfile

    " Syntax highlight Markdown fenced blocks
    let g:vim_markdown_fenced_languages = ['js', 'bash=sh']

    let g:polyglot_disabled = ['jsx', 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'go']

" Prettier
    command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Make 0 go to first character in line
    map 0 ^

" Allow netrw to remove non-empty local directories
    let g:netrw_rmdir_cmd = 'trash'

" nvim-treesitter
packadd nvim-treesitter
    lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {},     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {'php'},  -- list of language that will be disabled
  },
  indent = {
    enable = true,
  },
}
EOF

" coc.nvim
    " Update diagnostics every 300 milliseconds.
    set updatetime=300

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Show all diagnostics
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>

    " Remap for format selected region
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    " Remap <C-f> and <C-b> for scroll float windows/popups.
    if has('nvim-0.4.0') || has('patch-8.2.0750')
      nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
      inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
      inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
      vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    " Run jest for current project
    command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')

    " Run jest for current file
    command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])

    " Run jest for current test
    nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>

    " Treat markdown.mdx files as mdx
    let g:coc_filetype_map = { 'markdown.mdx': 'mdx' }
