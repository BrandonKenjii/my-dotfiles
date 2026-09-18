require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "ts_ls", "emmet_language_server", "jsonls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
