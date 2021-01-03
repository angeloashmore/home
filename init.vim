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
    colorscheme codedark

    " Show netrw banner to prevent yank issues
    let g:netrw_banner=1

    " Hide fzf status bar
    autocmd! FileType fzf set laststatus=0 noshowmode noruler
          \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Indention
    filetype plugin indent on
    set tabstop=8
    set shiftwidth=8
    set expandtab

" Folding
    set foldmethod=indent
    set foldlevelstart=99

" Terminal window movement mappings
    tnoremap <C-w>h <C-\><C-n><C-w>h
    tnoremap <C-w>j <C-\><C-n><C-w>j
    tnoremap <C-w>k <C-\><C-n><C-w>k
    tnoremap <C-w>l <C-\><C-n><C-w>l

" Make 0 go to first character in line
    map 0 ^

" Prevent `:Gf` (:Gfetch) when you meant `:GF`
    command Gf GF

" Language Support
    let g:jsx_ext_required = 0

    " Set Dockerfile syntax for *.dockerfile
    au BufRead,BufNewFile *.[Dd]ockerfile setf Dockerfile

    " Syntax highlight Markdown fenced blocks
    let g:vim_markdown_fenced_languages = ['js', 'bash=sh']

    let g:polyglot_disabled = ['jsx'] 

" lightline
    let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" indentLine
    let g:indentLine_color_gui = '#373c44'
    let g:indentLine_char = '│'

    " Don't hide characters like the "**" in "**word**"
    let g:vim_json_syntax_conceal = 0
    let g:vim_markdown_conceal = 0
    let g:vim_markdown_conceal_code_blocks = 0

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

" nvim-treesitter
    packadd nvim-treesitter

" Language server
    nnoremap <silent> ]g    <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
    nnoremap <silent> [g    <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
    nnoremap <silent> <C-m> <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

    autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Completion
    autocmd BufEnter * lua require'completion'.on_attach()

    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    set completeopt=menuone,noinsert,noselect
    set shortmess+=c

    let g:completion_chain_complete_list = {
        \'default' : {
        \  'default' : [
        \    {'complete_items' : ['lsp', 'ts', 'snippet']},
        \    {'mode' : 'file'}
        \  ],
        \  'comment' : [],
        \  'string' : []
        \  }
        \}

" Lua config
    lua package.path = os.getenv("HOME") .. "/.config/nixpkgs/lua/?.lua;" .. package.path
    lua require("init")
