require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Save
map("n", "<leader>w", "<cmd>w<cr>", { desc = "save file" })

-- Git (lazygit floating window)
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "lazygit" })

-- Move lines up/down
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "move selection up" })

-- Sessions (persistence.nvim)
map("n", "<leader>qs", function() require("persistence").load() end, { desc = "session restore (dir)" })
map("n", "<leader>qS", function() require("persistence").select() end, { desc = "session select" })
map("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "session load last" })
map("n", "<leader>qd", function() require("persistence").stop() end, { desc = "session stop (don't save)" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
