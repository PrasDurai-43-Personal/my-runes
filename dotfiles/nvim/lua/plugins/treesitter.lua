
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },

  dependencies = {
    "windwp/nvim-ts-autotag",
  },

  opts = {
    ensure_installed = {},

    auto_install = false,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    indent = {
      enable = true,
    },

    autotag = {
      enable = true,
    },
  },
}

