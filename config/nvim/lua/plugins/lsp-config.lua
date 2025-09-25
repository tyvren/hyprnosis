return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",   -- Lua
          "pyright",  -- Python
          "ts_ls", -- JavaScript/TypeScript
          "gopls",    -- Go
          "rust_analyzer", -- Rust
          "bashls",   -- Bash
          "jsonls",   -- JSON
          "yamlls",   -- YAML
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local on_attach = function(_, bufnr)
        -- Example keybinds
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      end

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
        pyright = {},
        tsserver = {},
        gopls = {},
        rust_analyzer = {},
        bashls = {},
        jsonls = {},
        yamlls = {},
      }

      for server, config in pairs(servers) do
        vim.lsp.config(server, vim.tbl_extend("force", {
          capabilities = capabilities,
          on_attach = on_attach,
        }, config))
      end
    end
  }
}
