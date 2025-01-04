return {
  {
    "nvim-lualine/lualine.nvim", -- status line
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        sections = { lualine_c = { { 'filename', path = 1, } } },
      })
    end,
  },
  {
    -- https://github.com/lukas-reineke/indent-blankline.nvim
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = function()
      require("ibl").setup({
        indent = { char = "▏" },
        exclude = {
          filetypes = {
            'help',
            'startify',
            'aerial',
            'alpha',
            'dashboard',
            'packer',
            'neogitstatus',
            'NvimTree',
            'neo-tree',
            'Trouble',
          },
          buftypes = {
            'nofile',
            'terminal',
          },
        },
      })
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
    opts = function()
      local logo = [[

                                 .-') _  _  .-')
                                ( OO ) )( \( -O )
 ,--.      ,-.-')   .----.  ,--./ ,--,'  ,------.
 |  |.-')  |  |OO) /  ..  \ |   \ |  |\  |   /`. '
 |  | OO ) |  |  \.  /  \  .|    \|  | ) |  /  | |
 |  |`-' | |  |(_/|  |  '  ||  .     |/  |  |_.' |
(|  '---.',|  |_.''  \  /  '|  |\    |   |  .  '.'
 |      |(_|  |    \  `'  / |  | \   |   |  |\  \
 `------'  `--'     `---''  `--'  `--'   `--' '--'
]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = 'Telescope find_files', desc = " Find File", icon = " ", key = "f" },
            { action = 'Telescope live_grep', desc = " Find Text", icon = " ", key = "l" },
            -- { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
            -- { action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "x" },
            { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "z" },
            { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit", icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- open dashboard after closing lazy
      if vim.o.filetype == "lazy" then
        vim.api.nvim_create_autocmd("WinClosed", {
          pattern = tostring(vim.api.nvim_get_current_win()),
          once = true,
          callback = function()
            vim.schedule(function()
              vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
            end)
          end,
        })
      end

      return opts
    end,
  },
  -- {
  --   "stevearc/dressing.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("dressing").setup({
  --       input = {
  --         enabled = true,
  --         default_prompt = "Input> ",
  --       },
  --     })
  --   end,
  -- },
  -- removed for no real use for these modules
  -- https://github.com/folke/zen-mode.nvim
  -- https://github.com/folke/twilight.nvim
  -- https://github.com/lukas-reineke/virt-column.nvim
  -- https://github.com/folke/todo-comments.nvim
  -- https://github.com/lukas-reineke/headlines.nvim
  -- https://github.com/RRethy/vim-illuminate
  --
  -- Maybe change dashboard + indent blankline to snacks.nvim

}
