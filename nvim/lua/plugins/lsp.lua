-- return {
--   {
--     "neovim/nvim-lspconfig",
--     dependencies = { "hrsh7th/cmp-nvim-lsp" }, -- Ensure cmp-nvim-lsp is loaded
--     opts = function()
--       local lspconfig = require("lspconfig")
--
--       -- Try to require cmp_nvim_lsp safely
--       local capabilities = vim.lsp.protocol.make_client_capabilities()
--       local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
--       if ok then
--         capabilities = cmp_nvim_lsp.default_capabilities()
--       end
--
--       -- Configure clangd
--       lspconfig.clangd.setup({
--         cmd = { "clangd", "--background-index", "--clang-tidy" },
--         filetypes = { "c", "cpp", "objc", "objcpp" },
--         root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
--         capabilities = capabilities,
--         settings = {
--           clangd = {
--             "--compile-commands-dir=build",
--           },
--         },
--       })
--     end,
--   },
-- }

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" }, -- Ensure cmp-nvim-lsp is loaded
    opts = function()
      local lspconfig = require("lspconfig")

      -- Try to require cmp_nvim_lsp safely
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_nvim_lsp.default_capabilities()
      end

      -- Configure clangd
      lspconfig.clangd.setup({
        cmd = { "clangd", "--background-index", "--clang-tidy" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
        capabilities = capabilities,
        settings = {
          clangd = {
            "--compile-commands-dir=build",
          },
        },
        -- Include SDL2 and SDL3 headers and libraries
        init_options = {
          compilationDatabasePath = "build",
        },
        args = {
          "--query-driver=/opt/homebrew/bin/clang++",
          "--header-insertion=never",
          "--pch-storage=memory",
          "--compile-commands-dir=build",
          "--fallback-style=Google",
          "--log=verbose",
          "--enable-config",
          "--clang-tidy",
          "--clang-tidy-checks=-*,clang-analyzer-*",
          "--all-scopes-completion",
          "--completion-style=detailed",
          "--header-insertion=never",
          "--limit-results=500",
          "--suggest-missing-includes",

          -- SDL3 Headers & Libraries
          "-I/opt/homebrew/opt/sdl3/include",
          "-L/opt/homebrew/opt/sdl3/lib",
          "-L/opt/homebrew/opt/sdl3",
          "-lSDL3",

          -- SDL2 Headers & Libraries
          "-I/opt/homebrew/opt/sdl2/include",
          "-I/opt/homebrew/opt/sdl2",
          "-L/opt/homebrew/opt/sdl2/lib",
          "-lSDL2",
        },
      })
    end,
  },
}
