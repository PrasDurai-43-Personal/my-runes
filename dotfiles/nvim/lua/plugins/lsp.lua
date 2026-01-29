return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",

    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },

  config = function()
    ------------------------------------------------------------------
    -- Diagnostics
    ------------------------------------------------------------------
    vim.diagnostic.config({
      virtual_text = true,
      severity_sort = true,
      float = { border = "rounded" },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "✘",
          [vim.diagnostic.severity.WARN]  = "▲",
          [vim.diagnostic.severity.INFO]  = "»",
          [vim.diagnostic.severity.HINT]  = "⚑",
        },
      },
    })

    ------------------------------------------------------------------
    -- Capabilities
    ------------------------------------------------------------------
    local capabilities =
      require("cmp_nvim_lsp").default_capabilities()

    ------------------------------------------------------------------
    -- LSP Keymaps
    ------------------------------------------------------------------
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
      end,
    })

    ------------------------------------------------------------------
    -- Mason
    ------------------------------------------------------------------
    require("mason").setup()

    ------------------------------------------------------------------
    -- Server groups (future-proof)
    ------------------------------------------------------------------
    local servers = {

      ----------------------------------------------------------------
      -- C / C++ / Qt
      ----------------------------------------------------------------
      clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
        },
      },

      ----------------------------------------------------------------
      -- QML (Qt)
      ----------------------------------------------------------------
      qmlls = {
        filetypes = { "qml", "qmljs" },
      },

      ----------------------------------------------------------------
      -- Python
      ----------------------------------------------------------------
      pyright = {},

      ----------------------------------------------------------------
      -- Java
      ----------------------------------------------------------------
      jdtls = {},

      ----------------------------------------------------------------
      -- JavaScript / TypeScript
      ----------------------------------------------------------------
      tsserver = {},
      eslint = {},

      ----------------------------------------------------------------
      -- JSON
      ----------------------------------------------------------------
      jsonls = {},

      ----------------------------------------------------------------
      -- Bash
      ----------------------------------------------------------------
      bashls = {},

      ----------------------------------------------------------------
      -- Build systems
      ----------------------------------------------------------------
      cmake = {
	  cmd = { vim.fn.expand("~/.local/bin/cmake-language-server") },
      },
      marksman = {},

      ----------------------------------------------------------------
      -- Lua (Neovim)
      ----------------------------------------------------------------
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      },
    }

    ------------------------------------------------------------------
    -- Mason-LSP bridge
    ------------------------------------------------------------------
    require("mason-lspconfig").setup({
        ensure_installed = {
	    "clangd",
	    "qmlls",
	    "pyright",
	    "jdtls",
	    "tsserver",
	    "eslint",
	    "jsonls",
	    "bashls",
	    "lua_ls",
	},
	handlers = {
	    function(server)
	    local opts = servers[server] or {}
	    opts.capabilities = capabilities
	    require("lspconfig")[server].setup(opts)
	    end,
	},
    })

    ------------------------------------------------------------------
    -- Completion
    ------------------------------------------------------------------
    local cmp = require("cmp")
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
      },
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      }),
    })
  end,
}

