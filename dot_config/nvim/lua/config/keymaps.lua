local set = vim.keymap.set

-- Buffer stuffs
set('n', '<leader>bp', ':bp<cr>')
set('n', '<leader>bn', ':bn<cr>')
set('n', '<leader>bw', ':bw<cr>')
set('n', '<leader>bd', ':bd<cr>')

-- Diagnostics, check this later
set('n', '<space>e', vim.diagnostic.open_float)
set('n', '<space>q', vim.diagnostic.setloclist)
set('n', '<leader>dp', vim.diagnostic.goto_prev)
set('n', '<leader>dn', vim.diagnostic.goto_next)
