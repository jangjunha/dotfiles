return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
    },
    opts = {
      ensure_installed = {
        "pyright",
        "ruff",
        "rust_analyzer",
        "terraformls",
        "ts_ls",
        "biome",
        "lua_ls",
        "kotlin_language_server",
        "jsonls",
        "yamlls",
        "html",
        "cssls",
        "gh_actions_ls",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      vim.lsp.config('pyright', {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "strict",
            }
          }
        }
      })

      local servers = {
        "pyright",
        "ruff",
        "rust_analyzer",
        "terraformls",
        "ts_ls",
        "biome",
        "lua_ls",
        "kotlin_language_server",
        "jsonls",
        "yamlls",
        "html",
        "cssls",
        "gh_actions_ls",
      }
      vim.lsp.enable(servers)
    end,
  },
}
