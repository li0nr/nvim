local oil_lazy_config = function()
  local oil = require("oil")
  oil.setup({
    default_file_explorer = false,
    keymaps = {
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-h>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<Esc>"] = "actions.close",
    },
    float = {
      max_width = 88,
      max_height = 50,
      win_options = {
        winblend = 20,
      },
    },
    preview = {
      win_options = {
        winblend = 20,
      },
    },
  })

  require("which-key").register({
    ["o"] = {
      function()
        oil.toggle_float()
      end,
      "Oil: Toggle float",
    },
    ["<leader>o"] = {
      function()
        oil.open()
      end,
      "Oil: Open",
    },
  }, { prefix = "<leader>" })
end

local M = {
  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      -- spec elsewhere
      "folke/which-key.nvim",
    },
    config = oil_lazy_config,
  },
  --[[   {
    -- https://github.com/prichrd/netrw.nvim
    "prichrd/netrw.nvim",
    config = function()
      local netrw = require("netrw")
      netrw.setup({
        mappings = {
          ["p"] = function(payload)
            -- Payload is an object describing the node under the cursor, the object
            -- has the following keys:
            -- - dir: the current netrw directory (vim.b.netrw_curdir)
            -- - node: the name of the file or directory under the cursor
            -- - link: the referenced file if the node under the cursor is a symlink
            -- - extension: the file extension if the node under the cursor is a file
            -- - type: the type of node under the cursor (0 = dir, 1 = file, 2 = symlink)
            print(vim.inspect(payload))
          end,
        },
      })
    end,
  }, ]]
  {
    -- https://github.com/nvim-neo-tree/neo-tree.nvim
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    event = "VeryLazy",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "folke/which-key.nvim",
    },
    init = function()
      if vim.fn.argc(-1) == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    config = function()
      local neotree = require("neo-tree")
      neotree.setup({
        close_if_last_window = true,
        sources = {
          "filesystem",
          "buffers",
          "git_status",
          "document_symbols",
        },
        open_files_do_not_replace_types = {
          "terminal",
          "Trouble",
          "trouble",
          "qf",
          "Outline",
        },
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
        hijack_netrw_behavior = "disabled",
        use_default_mappings = false,
        -- removing all default mappings and setting up the sutff i use
        window = {
          mappings = {
            ["<space>"] = {
              "toggle_node",
              nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "cancel", -- close preview or floating neo-tree window
            ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
            -- Read `# Preview Mode` for more information
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            -- ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            -- ["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            -- ['C'] = 'close_all_subnodes',
            -- ["Z"] = "expand_all_nodes",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["a"] = {
              "add",
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "none" -- "none", "relative", "absolute"
              }
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["i"] = "show_file_details",
            ["ff"] = "fuzzy_finder",
            ["H"] = "toggle_hidden",
            ["D"] = "fuzzy_finder_directory",
            ["[g"] = "prev_git_modified",
            ["]g"] = "next_git_modified",

          }
        },
        -- window = {
        --   mappings = {
        --     ["<bs>"] = "navigate_up",
        --     ["."] = "set_root",
        --     ["H"] = "",
        --     --["x/"] = "fuzzy_finder",
        --     ["Z"] = "toggle_hidden",
        --     ["D"] = "fuzzy_finder_directory",
        --     ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
        --     -- ["D"] = "fuzzy_sorter_directory",
        --     ["f"] = "filter_on_submit",
        --     ["<c-x>"] = "clear_filter",
        --     ["[g"] = "prev_git_modified",
        --     ["]g"] = "next_git_modified",
        --     ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
        --     ["oc"] = { "order_by_created", nowait = false },
        --     ["od"] = { "order_by_diagnostics", nowait = false },
        --     ["og"] = { "order_by_git_status", nowait = false },
        --     ["om"] = { "order_by_modified", nowait = false },
        --     ["on"] = { "order_by_name", nowait = false },
        --     ["os"] = { "order_by_size", nowait = false },
        --     ["ot"] = { "order_by_type", nowait = false },
        --   },
        --   fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
        --     ["<down>"] = "move_cursor_down",
        --     ["<C-n>"] = "move_cursor_down",
        --     ["<up>"] = "move_cursor_up",
        --     ["<C-p>"] = "move_cursor_up",
        --   },
        -- },
      })
      -- init.lua
      local neotree_command = require("neo-tree.command")
      require("which-key").register({
        ["\\\\"] = {
          function()
            neotree_command.execute({ toggle = true })
          end,
          "Neotree Explore",
        },
        ["\\b"] = {
          function()
            neotree_command.execute({ toggle = true, source = "buffers" })
          end,
          "Neotree Buffers",
        },
        ["\\g"] = {
          function()
            neotree_command.execute({ toggle = true, source = "git_status" })
          end,
          "Neotree Git Status",
        },
      }, {})
    end,
  },
}

return M
