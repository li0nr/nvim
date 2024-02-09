local lazy_cmp_config = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local lspkind = require("lspkind")
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      -- ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
      --["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-y>"] = cmp.mapping(
        cmp.mapping.confirm({ select = true }),
        { "i", "c" }
      ),
      -- ["<CR>"] = cmp.mapping(
      --   cmp.mapping.confirm({ select = false }),
      --   { "i", "c" }
      -- ),

      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- that way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        -- elseif luasnip.has_words_before() then
        --   cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      --["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "vim_lsp" },
      { name = "luasnip" },
    }, {
      { name = "path" },
      { name = "buffer", keyword_length = 4 },
    }),
    --[[ formatting = {
      fields = { "abbr", "kind", "menu" },
      format = lspkind.cmp_format({
        mode = "symbol", -- show only symbol annotations
        with_text = true,
        menu = {
          nvim_lsp = "[LSP]",
          nvim_lua = "[NVLUA]",
          luasnip = "[SNIP]",
          path = "[Path]",
          buffer = "[BUF]",
        },
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      }),
    }, ]]
    view = {
      entries = {
        name = "custom",
        selection_order = "near_cursor",
      },
    },
  })

  -- Use buffer source for `/` and `?`
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':'
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end

local M = {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = lazy_cmp_config,
    dependencies = {
      {
        "hrsh7th/cmp-nvim-lsp",
      },
      {
        "hrsh7th/cmp-nvim-lua",
      },
      {
        "hrsh7th/cmp-buffer",
      },
      {
        "hrsh7th/cmp-path",
      },
      {
        "hrsh7th/cmp-cmdline",
      },
      {
        "saadparwaiz1/cmp_luasnip",
      },
      {
        "L3MON4D3/LuaSnip",
      },
      {
        "onsails/lspkind-nvim",
      },
    },
  },
}

-- check :h ins-completion for more vim/nvim builtin completions
-- what abort
return M
