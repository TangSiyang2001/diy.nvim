-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
return {
  clangd = {
    keys = {
      { '<leader>ch', '<cmd>ClangdSwitchSourceHeader<CR>', desc = 'Switch Source/Header (C/C++)' },
    },
    root_mark = {
      'compile_commands.json',
      'compile_flags.txt',
      'configure.ac', -- AutoTools
      'Makefile',
      'configure.ac',
      'configure.in',
      'config.h.in',
      'meson.build',
      'meson_options.txt',
      'build.ninja',
      '.git',
    },
    capabilities = {
      offsetEncoding = { 'utf-16' },
    },
    filetypes = {
      'c',
      'cpp',
      'objc',
      'objcpp',
      'cuda',
    },
    cmd = {
      'clangd',
      '--background-index',
      '--clang-tidy',
      '--header-insertion=iwyu',
      '--completion-style=detailed',
      '--function-arg-placeholders=true',
      '--fallback-style=llvm',
      '--log=verbose',
      '--all-scopes-completion',
      '--cross-file-rename',
      '--header-insertion-decorators',
      -- '-j=32',
      '--pch-storage=disk',
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
    -- server specific callback for lsp attach
    on_attach = function(client, bufnr)
      local function switch_source_header()
        local method_name = 'textDocument/switchSourceHeader'
        ---@diagnostic disable-next-line:param-type-mismatch
        if not client or not client:supports_method(method_name) then
          return vim.notify(('method %s is not supported by any servers active on the current buffer'):format(method_name))
        end
        local params = vim.lsp.util.make_text_document_params(bufnr)
        ---@diagnostic disable-next-line:param-type-mismatch
        client:request(method_name, params, function(err, result)
          if err then
            error(tostring(err))
          end
          if not result then
            vim.notify 'corresponding file cannot be determined'
            return
          end
          vim.cmd.edit(vim.uri_to_fname(result))
        end, bufnr)
      end

      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
      end

      map('<leader>ch', switch_source_header, 'Switch Source/Header (C/C++)')
      map('gY', require('clangd_extensions.type_hierarchy').show_hierarchy, 'Show Type Hierachy (C/C++)')
    end,
  },
  -- gopls = {},
  pyright = {},
  rust_analyzer = {},
  -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
  --
  -- Some languages (like typescript) have entire language plugins that can be useful:
  --    https://github.com/pmizio/typescript-tools.nvim
  --
  -- But for many setups, the LSP (`ts_ls`) will work just fine
  -- ts_ls = {},
  --

  lua_ls = {
    -- cmd = {...},
    -- filetypes = { ...},
    -- capabilities = {},
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
}
