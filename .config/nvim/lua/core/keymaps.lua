-- ~/.config/nvim/lua/core/keymaps.lua

local map = vim.keymap.set

map("n", "<leader>w", "<cmd>write<cr>", { desc = "Salvar" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Sair" })
map("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "Limpar busca" })

map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnóstico" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnóstico anterior" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Próximo diagnóstico" })

-- Comentar bloco selecionado
map("x", "<leader>/", "gc", { remap = true, desc = "Comentar bloco" })
map("n", "<leader>/", "gcc", { remap = true, desc = "Comentar linha" })


-- Buffers
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Próximo buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Buffer anterior" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Fechar buffer" })

-- Melhor indentação no modo visual
map("v", "<", "<gv", { desc = "Indentar para esquerda" })
map("v", ">", ">gv", { desc = "Indentar para direita" })

-- Copiar para clipboard do sistema
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copiar para clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Copiar linha para clipboard" })

-- Deletar sem copiar
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Deletar sem copiar" })

-- Selecionar tudo
map("n", "<leader>a", "ggVG", { desc = "Selecionar tudo" })

-- Salvar e sair rápido
map("n", "<leader>x", "<cmd>x<cr>", { desc = "Salvar e sair" })

-- Recarregar arquivo atual
map("n", "<leader>r", "<cmd>edit<cr>", { desc = "Recarregar arquivo" })

-- Quickfix
map("n", "<leader>co", "<cmd>copen<cr>", { desc = "Abrir quickfix" })
map("n", "<leader>cc", "<cmd>cclose<cr>", { desc = "Fechar quickfix" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "Próximo quickfix" })
map("n", "[q", "<cmd>cprevious<cr>", { desc = "Quickfix anterior" })

-- Location list
map("n", "<leader>lo", "<cmd>lopen<cr>", { desc = "Abrir location list" })
map("n", "<leader>lc", "<cmd>lclose<cr>", { desc = "Fechar location list" })
map("n", "]l", "<cmd>lnext<cr>", { desc = "Próxima location" })
map("n", "[l", "<cmd>lprevious<cr>", { desc = "Location anterior" })

-- Diagnósticos
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnósticos na location list" })
map("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnósticos no quickfix" })

-- Terminal
map("n", "<leader>tt", "<cmd>terminal<cr>", { desc = "Abrir terminal" })
map("t", "<esc><esc>", "<C-\\><C-n>", { desc = "Sair do modo terminal" })

-- LSP
map("n", "gd", vim.lsp.buf.definition, { desc = "Ir para definição" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Ir para declaração" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Ir para implementação" })
map("n", "gr", vim.lsp.buf.references, { desc = "Referências" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Renomear símbolo" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Formatar arquivo" })
