vim.cmd([[
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
set nocompatible
syntax on
filetype plugin on
set mouse=a
set showmatch
set autoindent
set smartindent
set backspace=2
set tabstop=4
set number
set expandtab
set shiftwidth=4
set completeopt=menu,menuone,noselect
]])

--for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.lazy")
require("config.keymaps")
