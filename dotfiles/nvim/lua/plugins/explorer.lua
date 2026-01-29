return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
        },

        renderer = {
          group_empty = true,
        },

        filters = {
          dotfiles = false,
        },

        -- ⭐ THIS IS THE IMPORTANT PART ⭐
        sync_root_with_cwd = true,
        respect_buf_cwd = true,

        update_focused_file = {
          enable = true,
          update_root = true,
        },
      })

      -- Toggle tree
      vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { silent = true })
    end,
  },
}

