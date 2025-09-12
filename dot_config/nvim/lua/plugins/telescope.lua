return {
    { 'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                              , branch = '0.1.x',
      lazy = false,
      dependencies = { 'nvim-lua/plenary.nvim',  'nvim-telescope/telescope-ui-select.nvim' },
      config = function () 
        local builtin = require('telescope.builtin')
        vim.keymap.set('n' ,'<leader>ff', builtin.find_files) 
        vim.keymap.set('n' ,'<leader>fb', builtin.buffers) 
        vim.keymap.set('n' ,'<leader>fg', builtin.live_grep) 
        local telescope = require('telescope')

        telescope.setup{
            extensions = {
                ['ui-select'] = { require('telescope.themes').get_dropdown {} }
            }
        }
        telescope.load_extension('ui-select')
        vim.keymap.set("n", "<leader>ce", function() builtin.find_files { cwd = vim.fn.stdpath "config" } end)
      end
    }
    
}
