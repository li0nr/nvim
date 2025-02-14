local M =
{
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    -- [[-- editing --]]
    require('mini.comment').setup()
    require('mini.ai').setup()
    require('mini.surround').setup()
    require("mini.pairs").setup({
      mappings = {
        ["`"] = false,
      },
    })

    -- [[-- UI --]]
    require("mini.statusline").setup()
    require("mini.notify").setup()
    -- require('mini.indentscope').setup()
    local indentscope = require('mini.indentscope')
    indentscope.setup({
      draw = {
        animation = indentscope.gen_animation.none(),
      },
      symbol = '╎' --'╎',
    })
    local starter = require('mini.starter')
    starter.setup({
      items = {
        starter.sections.recent_files(5, true),
        { action = function() require("snacks").picker.files() end, name = 'Files', section = 'Picker' },
        { action = function() require("snacks").picker.grep() end,  name = 'Grep',  section = 'Picker' },
        starter.sections.builtin_actions(),
        -- command_history
        { action = function() if vim.fn.filereadable("session.nvim") == 1 then vim.cmd("source " .. "session.nvim") end end, name = 'Reload Session',  section = 'Picker' },
        { action = function() require("snacks").picker.command_history() end, name = 'Command history', section = 'Picker' },
        { action = function() require("snacks").picker.help() end,            name = 'Help tags',       section = 'Picker' },

      },
      header = table.concat({
        [[                                   .-')   ]],
        [[                                  ( OO )  \( -O-O-)/ ]],
        [[  ,--.      ,-.-')   .----.  ,--./ ,--,'  ,------.   ]],
        [[  |  |.-')  |  |OO) /  ..  \ |   \ |  |\  |   /`. ' ]],
        [[  |  | OO ) |  |  \.  /  \  .|    \|  | ) |  /  | | ]],
        [[  |  |`-' | |  |(_/|  |  '  ||  .     |/  |  |_.' | ]],
        [[ (|  '---.',|  |_.''  \  /  '|  |\    |   |  .  '.' ]],
        [[  |      |(_|  |    \  `'  / |  | \   |   |  |\  \  ]],
        [[  `------'  `--'     `---''  `--'  `--'   `--' '--' ]],
        [[──────────────────────────────────────────────────────]],
      }, "\n"),
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function(ev)
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        local pad_footer = string.rep(" ", 8)
        starter.config.footer = pad_footer .. "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        -- Refresh the starter if it's active
        if vim.bo[ev.buf].filetype == "ministarter" then
          pcall(starter.refresh)
        end
      end,
    })

    -- Handle Lazy auto-closing and reopening
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniStarterOpened",
      callback = function()
        if vim.o.filetype == "lazy" then
          vim.cmd.close()
          require("lazy").show()
        end
      end,
    })



    -- [[-- file navigation --]]
    -- maybe move all mini stuff onto seprate file
    require("mini.files").setup({
      vim.keymap.set("n", "<leader>mo", function()
        require("mini.files").open(vim.bo.filetype == 'ministarter' and vim.fn.getcwd() or vim.api.nvim_buf_get_name(0))
      end, { desc = "Open mini.files (Directory of Current File)" }),

      -- Module mappings created only inside explorer.
      -- Use `''` (empty string) to not create one.
      mappings = {
        close       = 'q',
        go_in       = 'n',
        go_in_plus  = 'N',
        go_out      = 'p',
        go_out_plus = 'P',
        mark_goto   = "'",
        mark_set    = 'm',
        reset       = '<BS>',
        reveal_cwd  = '@',
        show_help   = '?',
        synchronize = 's',
        trim_left   = '<',
        trim_right  = '>',
      },
    })

    -- Centered on screen
    local win_config = function()
      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.4 * vim.o.columns)
      return {
        anchor = "NW",
        height = height,
        width = width,
        border = "double",
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end
  end
}

return M


-- removed for no real use for these modules
-- https://github.com/folke/zen-mode.nvim
-- https://github.com/folke/twilight.nvim
-- https://github.com/lukas-reineke/virt-column.nvim
-- https://github.com/folke/todo-comments.nvim
-- https://github.com/lukas-reineke/headlines.nvim
-- https://github.com/RRethy/vim-illuminate
--
-- Maybe change dashboard + indent blankline to snacks.nvim
-- changed to mini nvim stuff
-- "stevearc/dressing.nvim",
-- "nvimdev/dashboard-nvim",
--  https://github.com/lukas-reineke/indent-blankline.nvim
--  "nvim-lualine/lualine.nvim", -- status line
--
--
--  -- removed for mini
-- https://github.com/kylechui/nvim-surround
-- https://github.com/numToStr/Comment.nvim
-- https://github.com/j-hui/fidget.nvim
