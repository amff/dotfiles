local toggle_opts = {
    path = nil,
    current_window = false,
    find_file = false,
    update_root = false,
    focus = true,
}
return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    config =  function()

        local function open_nvim_tree(data)

          -- buffer is a directory
          local directory = vim.fn.isdirectory(data.file) == 1

          if not directory then
            return
          end

          -- create a new, empty buffer
          vim.cmd.enew()

          -- wipe the directory buffer
          vim.cmd.bw(data.buf)

          -- change to the directory
          vim.cmd.cd(data.file)

          -- open the tree
          require("nvim-tree.api").tree.open()
        end


        local function my_on_attach(bufnr)
            local api = require 'nvim-tree.api'

            local function opts(desc)
                return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- custom mappings
            vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
            --vim.keymap.set('n', '<C-P>', api.tree.open({ find_file = true }),   opts('Find file in Tree'))
            vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
        end
        require('nvim-tree').setup({
            on_attach = my_on_attach
        })
        vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
    end,
    keys = {
        { '<F2>', function() require('nvim-tree.api').tree.toggle(toggle_opts) end, mode="n", desc="nvim-tree: toggle tree" },
        { '<F3>', "<cmd>:NvimTreeFindFile<cr>", mode="n", desc="nvim-tree: find file in tree" }
    }
  },
};
