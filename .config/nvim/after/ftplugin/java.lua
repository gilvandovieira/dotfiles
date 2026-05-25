local jdtls = require("jdtls")

local root_markers = {
  ".git",
  "mvnw",
  "gradlew",
  "pom.xml",
  "build.gradle",
  "build.gradle.kts",
  "settings.gradle",
  "settings.gradle.kts",
}

local root_dir = vim.fs.root(0, root_markers)

if root_dir == nil then
  return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

local config = {
  cmd = {
    "jdtls",
    "-data",
    workspace_dir,
  },

  root_dir = root_dir,

  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-21",
            path = "/usr/lib/jvm/java-21-openjdk",
            default = true,
          },
        },
      },

      signatureHelp = {
        enabled = true,
      },

      contentProvider = {
        preferred = "fernflower",
      },

      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },

      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },

      completion = {
        favoriteStaticMembers = {
          "org.junit.jupiter.api.Assertions.*",
          "org.mockito.Mockito.*",
          "org.mockito.ArgumentMatchers.*",
        },
      },
    },
  },

  init_options = {
    bundles = {},
  },
}

jdtls.start_or_attach(config)

local map = vim.keymap.set
local opts = { buffer = true }

map("n", "<leader>jo", jdtls.organize_imports, vim.tbl_extend("force", opts, { desc = "Java: organizar imports" }))
map("n", "<leader>jv", jdtls.extract_variable, vim.tbl_extend("force", opts, { desc = "Java: extrair variável" }))
map("v", "<leader>jv", [[<esc><cmd>lua require('jdtls').extract_variable(true)<cr>]], vim.tbl_extend("force", opts, { desc = "Java: extrair variável" }))
map("n", "<leader>jc", jdtls.extract_constant, vim.tbl_extend("force", opts, { desc = "Java: extrair constante" }))
map("v", "<leader>jc", [[<esc><cmd>lua require('jdtls').extract_constant(true)<cr>]], vim.tbl_extend("force", opts, { desc = "Java: extrair constante" }))
map("v", "<leader>jm", [[<esc><cmd>lua require('jdtls').extract_method(true)<cr>]], vim.tbl_extend("force", opts, { desc = "Java: extrair método" }))
