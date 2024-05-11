return {
  "max397574/better-escape.nvim",
  config = function()
    require("better_escape").setup({
      mapping = { "jk", "kj" },
      --      keys = "<Esc><cmd>update<CR>",
    })
  end,
}
