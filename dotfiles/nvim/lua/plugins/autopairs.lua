return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = { "hrsh7th/nvim-cmp" },

  config = function()
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    npairs.setup({
      check_ts = true,
      enable_check_bracket_line = true,

      -- CRITICAL: prevents multi-line paste truncation
      enable_moveright = false,

      disable_filetype = { "TelescopePrompt", "vim" },
      ignored_next_char = "[%w%.]",
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        end_key = "$",
      },
    })

    ------------------------------------------------------------------
    -- C / C++ / Qt: safe template pairing
    ------------------------------------------------------------------
    npairs.add_rules({
      Rule("<", ">")
        :with_pair(cond.before_regex("%a+"))
        :with_move(cond.none())
        :with_del(cond.none())
        :use_key(">"),
    })

    ------------------------------------------------------------------
    -- Python: do NOT interfere with triple quotes
    ------------------------------------------------------------------
    npairs.add_rules({
      Rule('"""', '"""'):with_pair(cond.none()),
      Rule("'''", "'''"):with_pair(cond.none()),
    })

    ------------------------------------------------------------------
    -- nvim-cmp integration (safe)
    ------------------------------------------------------------------
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")

    cmp.event:on(
      "confirm_done",
      cmp_autopairs.on_confirm_done({
        map_char = { tex = "" },
      })
    )
  end,
}

