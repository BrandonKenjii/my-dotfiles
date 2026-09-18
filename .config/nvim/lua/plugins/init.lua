return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Auto-install LSP servers + formatters via mason
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "html-lsp", "css-lsp", "json-lsp",
        "typescript-language-server", "emmet-language-server", "lua-language-server",
        "prettier",
      },
      run_on_start = true,
    },
  },

  -- Git TUI in a floating window (<leader>gg)
  { "kdheepak/lazygit.nvim", cmd = "LazyGit" },

  -- Surround selections: ys / ysiw / cs / ds
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },

  -- Restore window/buffer layout per directory on reopen
  { "folke/persistence.nvim", event = "BufReadPre", opts = {} },

  -- Auto close & rename HTML tags
  { "windwp/nvim-ts-autotag", event = "InsertEnter", opts = {} },

  -- Syntax highlighting for web dev languages (extends NvChad defaults)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local opts = require "nvchad.configs.treesitter"
      vim.list_extend(opts.ensure_installed, {
        "html", "css", "javascript", "typescript", "tsx", "json", "markdown", "bash",
      })
      return opts
    end,
  },
}
