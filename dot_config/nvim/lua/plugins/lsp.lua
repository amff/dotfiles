return {
    {
    'neovim/nvim-lspconfig',
    config = function ()
        local border = {
              {"┌", "FloatBorder"},
              {"─", "FloatBorder"},
              {"┐", "FloatBorder"},
              {"│", "FloatBorder"},
              {"┘", "FloatBorder"},
              {"─", "FloatBorder"},
              {"└", "FloatBorder"},
              {"│", "FloatBorder"},

--              {"🭽", "FloatBorder"},
--              {"▔", "FloatBorder"},
--              {"🭾", "FloatBorder"},
--              {"▕", "FloatBorder"},
--              {"🭿", "FloatBorder"},
--              {"▁", "FloatBorder"},
--              {"🭼", "FloatBorder"},
--              {"▏", "FloatBorder"},

        }


        -- LSP settings (for overriding per client)
        local handlers =  {
          ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
          ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
        }

        -- To instead override globally
        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
          opts = opts or {}
          opts.border = opts.border or border
          return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end
        local on_attach = function(client, bufnr)
            local builtin = require('telescope.builtin')
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local bufopts = { noremap=true, silent=true, buffer=bufnr }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', '<F12>', builtin.lsp_definitions, bufopts) -- mine
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
            vim.keymap.set('n', '<space>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, bufopts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
            --vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', 'gr', builtin.lsp_references, bufopts) -- mine
            vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
            vim.keymap.set('n', '<leader>tr', builtin.lsp_references, bufopts) --notworking noremap
            vim.keymap.set('v', '<space>f', function() vim.lsp.buf.range_formatting { async = true } end, bufopts) -- mine
            vim.keymap.set('n', '<space>ts', builtin.lsp_document_symbols, bufopts) 
        end
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        vim.lsp.config['roslyn_ls'] = {
            cmd = { "dotnet", "/home/andre/sandbox/roslyn/Release/net9.0/Microsoft.CodeAnalysis.LanguageServer.dll", "--logLevel", "Information", "--extensionLogDirectory", "/tmp/roslyn_ls/logs", "--stdio"  },
            on_attach = on_attach
        }
        vim.lsp.config['ocamllsp'] = {
            on_attach = on_attach
        }

        vim.lsp.config['lua_ls'] = {
          -- Command and arguments to start the server.
          cmd = { 'lua-language-server' },
          -- Filetypes to automatically attach to.
          filetypes = { 'lua' },
          -- Sets the "workspace" to the directory where any of these files is found.
          -- Files that share a root directory will reuse the LSP server connection.
          -- Nested lists indicate equal priority, see |vim.lsp.Config|.
          root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
          -- Specific settings to send to the server. The schema is server-defined.
          -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
              }
            }
          }
        }

        vim.lsp.enable('roslyn_ls')
        vim.lsp.enable('ocamllsp')
        vim.lsp.enable('hls')
        vim.lsp.enable('lua_ls')
        --vim.lsp.enable('ocamllsp')
        --local lspconfig = require('lspconfig')

        -- lspconfig.omnisharp.setup {
        --    capabilities = capabilities,
        --    cmd = { "/home/andre/omnisharp-1.39.12/OmniSharp", "--languageserver", "--hostPID", tostring(pid) },
        --    --cmd = { "/home/andre/sandbox/omnisharp/OmniSharp", "-z", "--languageserver", "DotNet:enablePackageRestore=false","--encoding", "utf-8","--hostPID", tostring(pid) },
        --    on_attach = on_attach 
        --}

        --lspconfig.ocamllsp.setup {
        --    on_attach = on_attach
        --}

    end
    }
}
