-- return {
--   {
--     "hrsh7th/nvim-cmp",
--     enabled = true, -- Ensure it's enabled
--     opts = function(_, opts)
--       local cmp = require("cmp")
--       local context = require("cmp.config.context")
--
--       opts.enabled = function()
--         -- Allow completion in command mode
--         if vim.api.nvim_get_mode().mode == "c" then
--           return true
--         end
--         -- Disable completion inside comments
--         return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
--       end
--
--       opts.sources = cmp.config.sources({
--         { name = "nvim_lsp" },
--         { name = "buffer" },
--         { name = "path" },
--       })
--
--       return opts
--     end,
--   },
-- }

return {
  {
    "hrsh7th/nvim-cmp",
    enabled = true, -- Ensure nvim-cmp is enabled
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
      })
    end,
  },
}
