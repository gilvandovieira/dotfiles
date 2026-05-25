-- ~/.config/nvim/lua/core/plugins.lua

local map = vim.keymap.set

vim.pack.add({
  -- Tema
  "https://github.com/catppuccin/nvim",

  -- UI/statusline
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",

  -- Telescope
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",

  -- Treesitter
  "https://github.com/nvim-treesitter/nvim-treesitter",

  -- LSP
  "https://github.com/neovim/nvim-lspconfig",

  -- Autocomplete
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },

  -- Git
  "https://github.com/lewis6991/gitsigns.nvim",

  -- QoL
  "https://github.com/folke/which-key.nvim",

  -- Java
  "https://github.com/mfussenegger/nvim-jdtls",
})

-- Tema
require("catppuccin").setup({
  flavour = "mocha",
})

vim.cmd.colorscheme("catppuccin")

-- Statusline
require("lualine").setup({
  options = {
    theme = "auto",
    globalstatus = true,
  },
})

-- Telescope
local telescope = require("telescope")
telescope.setup({})

-- Telescope
local builtin = require("telescope.builtin")

map("n", "<leader>ff", builtin.find_files, { desc = "Buscar arquivos" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Buscar texto" })
map("n", "<leader>fb", builtin.buffers, { desc = "Buscar buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Buscar ajuda" })
map("n", "<leader>fr", builtin.oldfiles, { desc = "Arquivos recentes" })
map("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Símbolos do documento" })
map("n", "<leader>fw", builtin.lsp_dynamic_workspace_symbols, { desc = "Símbolos do workspace" })
map("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnósticos" })
map("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
map("n", "<leader>fc", builtin.commands, { desc = "Comandos" })

local ts = require("nvim-treesitter")

ts.setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

ts.install({
  "lua",
  "vim",
  "vimdoc",
  "bash",
  "json",
  "yaml",
  "markdown",
  "markdown_inline",
  "typescript",
  "javascript",
  "tsx",
  "html",
  "css",
  "python",
  "go",
  "rust",
  "java",
})

-- Git signs
require("gitsigns").setup()

-- Which-key
require("which-key").setup()

-- Autocomplete
require("blink.cmp").setup({
  keymap = {
    preset = "default",
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = {
      auto_show = true,
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
})

-- LSP básico
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

vim.lsp.enable({
  "lua_ls",
  "ts_ls",
  "pyright",
  "gopls",
  "rust_analyzer",
})
