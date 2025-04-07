-- return {
--   {
--      "craftzdog/solarized-osaka.nvim",
--      lazy = true,
--      priority = 1000,
--      opts = function()
--        return {
--          transparent = true,
--        }
--      end,
--   },
--
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "solarized-osaka",
--     },
--   },
-- }

-- return {
--   -- add gruvbox
--   { "ellisonleao/gruvbox.nvim" },
--
--   -- Configure LazyVim to load gruvbox
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "gruvbox",
--     },
--   },
-- }

-- return {
--   "catppuccin/nvim",
--   lazy = true,
--   name = "catppuccin",
--   opts = {
--     integrations = {
--       aerial = true,
--       alpha = true,
--       cmp = true,
--       dashboard = true,
--       flash = true,
--       fzf = true,
--       grug_far = true,
--       gitsigns = true,
--       headlines = true,
--       illuminate = true,
--       indent_blankline = { enabled = true },
--       leap = true,
--       lsp_trouble = true,
--       mason = true,
--       markdown = true,
--       mini = true,
--       native_lsp = {
--         enabled = true,
--         underlines = {
--           errors = { "undercurl" },
--           hints = { "undercurl" },
--           warnings = { "undercurl" },
--           information = { "undercurl" },
--         },
--       },
--       navic = { enabled = true, custom_bg = "lualine" },
--       neotest = true,
--       neotree = true,
--       noice = true,
--       notify = true,
--       semantic_tokens = true,
--       snacks = true,
--       telescope = true,
--       treesitter = true,
--       treesitter_context = true,
--       which_key = true,
--     },
--   },
--   specs = {
--     {
--       "akinsho/bufferline.nvim",
--       optional = true,
--       opts = function(_, opts)
--         if (vim.g.colors_name or ""):find("catppuccin") then
--           opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
--         end
--       end,
--     },
--   },
-- }

return {
  {
    "catppuccin/nvim",
    name = "catppuccin", -- Ensure it's correctly named
    priority = 1000, -- Load before other plugins
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- Options: latte, frappe, macchiato, mocha
        integrations = {
          aerial = true,
          alpha = true,
          cmp = true,
          dashboard = true,
          flash = true,
          fzf = true,
          grug_far = true,
          gitsigns = true,
          headlines = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          leap = true,
          lsp_trouble = true,
          mason = true,
          markdown = true,
          mini = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          navic = { enabled = true, custom_bg = "lualine" },
          neotest = true,
          neotree = true,
          noice = true,
          notify = true,
          semantic_tokens = true,
          snacks = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
