require "nvchad.autocmds"

-- Open PDFs in zathura instead of loading the binary into a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.pdf",
  callback = function()
    local path = vim.fn.expand "%:p"
    vim.fn.jobstart({ "zathura", path }, { detach = true })
    vim.api.nvim_buf_delete(0, { force = true })
  end,
})
