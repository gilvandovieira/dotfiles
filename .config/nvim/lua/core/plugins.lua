-- ~/.config/nvim/lua/core/plugins.lua

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

  'https://github.com/MeanderingProgrammer/render-markdown.nvim',

  'https://github.com/stevearc/oil.nvim',
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


require('render-markdown').setup({})

require("oil").setup({
  default_file_explorer = true,
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime",
  },
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  prompt_save_on_select_new_entry = true,
  cleanup_delay_ms = 2000,
  lsp_file_methods = {
    enabled = true,
    timeout_ms = 1000,
    autosave_changes = false,
  },
  constrain_cursor = "editable",
  watch_for_changes = true,
  keymaps = {
    ["g?"] = { "actions.show_help", mode = "n" },
    ["<CR>"] = "actions.select",
    ["<C-s>"] = { "actions.select", opts = { vertical = true } },
    ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
    ["<C-t>"] = { "actions.select", opts = { tab = true } },
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = { "actions.close", mode = "n" },
    ["q"] = { "actions.close", mode = "n" },
    ["<C-r>"] = "actions.refresh",
    ["-"] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["`"] = { "actions.cd", mode = "n" },
    ["~"] = { "actions.tcd", mode = "n" },
    ["gs"] = { "actions.change_sort", mode = "n" },
    ["gx"] = "actions.open_external",
    ["g."] = { "actions.toggle_hidden", mode = "n" },
    ["g\\"] = { "actions.toggle_trash", mode = "n" },
  },
  use_default_keymaps = false,
  view_options = {
    show_hidden = true,
    natural_order = "fast",
    is_always_hidden = function(name, _)
      return name == ".git" or name == ".."
    end,
  },
  float = {
    padding = 2,
    max_width = 0.9,
    max_height = 0.9,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
  },
  preview_win = {
    update_on_cursor_moved = true,
    preview_method = "fast_scratch",
  },
})
