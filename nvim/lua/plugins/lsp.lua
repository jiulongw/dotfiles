return {
  {
    "neovim/nvim-lspconfig",
    version = "^2.1.0",
  },
  {
    "mason-org/mason.nvim",
    version = "^2.0.0",
  },
  {
    "mason-org/mason-lspconfig.nvim",
    version = "^2.0.0",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  {
    "L3MON4D3/LuaSnip",
    version = "^2.1.0",
  },
}
