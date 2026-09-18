require "nvchad.options"

-- add yours here!
local opt = vim.opt

-- Line numbers
opt.number = true           -- Show absolute line number for current line
opt.relativenumber = true   -- Show relative numbers for other lines (great for jumping)

-- Indentation
opt.shiftwidth = 2          -- Number of spaces for auto-indent
opt.tabstop = 2             -- Number of spaces a tab counts for
opt.expandtab = true        -- Convert tabs to spaces
opt.smartindent = true      -- Make indenting "smart"

-- UI tweaks
opt.cursorline = true       -- Highlight the line your cursor is on
opt.mouse = "a"             -- Enable mouse support
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Search
opt.ignorecase = true       -- Ignore case in search...
opt.smartcase = true        -- ...unless you type capitals

-- Persistent undo across sessions
opt.undofile = true

-- Keep context around the cursor
opt.scrolloff = 8           -- Lines of context above/below cursor
opt.sidescrolloff = 8       -- Columns of context left/right

-- Open splits to the right / below
opt.splitright = true
opt.splitbelow = true
