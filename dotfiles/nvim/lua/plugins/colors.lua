return {
  {
    "tanvirtin/monokai.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true

      require("monokai").setup({
        palette = {
          base0 = "#272822",
          base1 = "#272822",
          base2 = "#272822",
        },
        custom_hlgroups = {
          -- Comments (VSCode default: NOT italic)
          Comment = { fg = "#75715E", italic = false },

          -- Strings
          String = { fg = "#E6DB74" },
          Character = { fg = "#E6DB74" },

          -- Keywords
          Keyword = { fg = "#F92672" },
          Conditional = { fg = "#F92672" },
          Repeat = { fg = "#F92672" },

          -- Functions
          Function = { fg = "#A6E22E" },
          Method = { fg = "#A6E22E" },

          -- Types / classes
          Type = { fg = "#A6E22E" },
          StorageClass = { fg = "#A6E22E" },
          Structure = { fg = "#A6E22E" },
          Typedef = { fg = "#A6E22E" },

          -- Namespace / std
          Namespace = { fg = "#66D9EF" },

          -- Numbers / constants
          Constant = { fg = "#AE81FF" },
          Number = { fg = "#AE81FF" },
          Boolean = { fg = "#AE81FF" },

          -- Operators
          Operator = { fg = "#F8F8F2" },
          Delimiter = { fg = "#F8F8F2" },

          -- Preprocessor
          PreProc = { fg = "#F92672" },
          Include = { fg = "#F92672" },
          Define = { fg = "#F92672" },
        },
      })

      vim.cmd.colorscheme("monokai")

      --------------------------------------------------
      -- HARD background lock (NO terminal bleed)
      --------------------------------------------------
      local bg = "#272822"
      local fg = "#F8F8F2"

      local groups = {
        "Normal", "NormalNC", "SignColumn", "FoldColumn",
        "EndOfBuffer", "LineNr", "CursorLineNr",
        "StatusLine", "StatusLineNC",
        "TabLine", "TabLineFill", "TabLineSel",
        "VertSplit",
        "NormalFloat", "FloatBorder",
      }

      for _, g in ipairs(groups) do
        vim.api.nvim_set_hl(0, g, { fg = fg, bg = bg })
      end

      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3E3D32" })
      vim.api.nvim_set_hl(0, "Visual", { bg = "#49483E" })

      --------------------------------------------------
      -- Treesitter overrides (THIS fixes C++)
      --------------------------------------------------
      vim.api.nvim_set_hl(0, "@type",        { fg = "#A6E22E" })
      vim.api.nvim_set_hl(0, "@namespace",   { fg = "#66D9EF" })
      vim.api.nvim_set_hl(0, "@function",    { fg = "#A6E22E" })
      vim.api.nvim_set_hl(0, "@variable",    { fg = "#F8F8F2" })
      vim.api.nvim_set_hl(0, "@constant",    { fg = "#AE81FF" })
      vim.api.nvim_set_hl(0, "@number",      { fg = "#AE81FF" })
      vim.api.nvim_set_hl(0, "@operator",    { fg = "#F8F8F2" })
      vim.api.nvim_set_hl(0, "@comment",     { fg = "#75715E" })
    end,
  },
}

