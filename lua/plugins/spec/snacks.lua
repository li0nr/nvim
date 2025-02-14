local function buffer_picker()
  Snacks.picker.buffers({
    win = {
      input = {
        keys = {
          ["d"] = "bufdelete",
        },
      },
      list = { keys = { ["d"] = "bufdelete" } },
    },
  })
end

return {
  -- HACK: docs @ https://github.com/folke/snacks.nvim/blob/main/docs
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    -- NOTE: Options
    opts = {
      explorer = {
        enabled = true,
        layout = {
          cycle = false,
        }
      },
      quickfile = {
        enabled = true,
      },

      -- HACK: read picker docs @ https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
      picker = {
        enabled = true,
        formatters = {
          file = {
            filename_first = false,
            filename_only = false,
            icon_width = 2,
          },
        },

        win = {
          input = {
            keys = {
              --refine / live grep
              ["<c-e>"] = { "toggle_live", mode = { "i", "n" } },
            }
          }

        },
        matcher = {
          frecency = true,
        },
        layout = {
          -- presets options : "default" , "ivy" , "ivy-split" , "telescope" , "vscode", "select" , "sidebar", "vertical"
          -- override picker layout in keymaps function as a param below
          preset = "telescope", -- defaults to this layout unless overidden
          cycle = true,
        },
        layouts = {
          select = {
            preview = false,
            layout = {
              backdrop = false,
              width = 0.6,
              min_width = 80,
              height = 0.4,
              min_height = 10,
              box = "vertical",
              border = "rounded",
              title = "{title}",
              title_pos = "center",
              { win = "input",   height = 1,          border = "bottom" },
              { win = "list",    border = "none" },
              { win = "preview", title = "{preview}", width = 0.6,      height = 0.4, border = "top" },
            }
          },
          telescope = {
            reverse = true, -- set to false for search bar to be on top
            layout = {
              box = "vertical",
              backdrop = true,
              width = 0.9,
              height = 0.9,
              border = "none",
              {
                box = "vertical",
                {
                  win = "preview",
                  title = "{preview:Preview}",
                  border = "rounded",
                  title_pos = "center",
                },
                { win = "list",  title = " Results ", height = 10,        title_pos = "center",             border = "rounded" },
                { win = "input", height = 1,          border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
              },
            },
          },
          ivy = {
            layout = {
              box = "vertical",
              backdrop = false,
              width = 1,
              height = 0.4,
              position = "bottom",
              border = "top",
              title = " {title} {live} {flags}",
              title_pos = "left",
              { win = "input", height = 1, border = "bottom" },
              {
                box = "horizontal",
                { win = "list",    border = "none" },
                { win = "preview", title = "{preview}", width = 0.5, border = "left" },
              },
            },
          },
        }
      },
    },


    -- NOTE: Keymaps
    keys = {
      { "<leader>lg",  function() require("snacks").lazygit() end,                                  desc = "Lazygit" },
      { "<leader>gl",  function() require("snacks").lazygit.log() end,                              desc = "Lazygit Logs" },
      { "<leader>o",   function() require("snacks").explorer() end,                                 desc = "Open Snacks Explorer" },
      { "<leader>rN",  function() require("snacks").rename.rename_file() end,                       desc = "Fast Rename Current File" },
      { "<leader>dB",  function() require("snacks").bufdelete() end,                                desc = "Delete or Close Buffer  (Confirm)" },

      -- Snacks Picker
      { "<leader>sf",  function() require("snacks").picker.files() end,                             desc = "Find Files (Snacks Picker)" },
      { "<leader>sl",  function() require("snacks").picker.grep() end,                              desc = "Grep word -- Search Live" },
      { "<leader>b",   buffer_picker,                                                               desc = "Find Buffers (Snacks Picker)" },
      { "<leader>sw",  function() require("snacks").picker.grep_word() end,                         desc = "Search Visual selection or Word",  mode = { "n", "x" } },
      { "<leader>sg",  function() require("snacks").picker.git_grep() end,                          desc = "Git grep " },

      -- Lsp
      { "<leader>lr",  function() require("snacks").picker.lsp_references({ layout = "ivy" }) end,  desc = "LSP references" },
      { "<leader>ls",  function() require("snacks").picker.lsp_symbols({ layout = "ivy" }) end,     desc = "LSP symbols" },

      -- Git Stuff
      { "<leader>gbr", function() require("snacks").picker.git_branches({ layout = "select" }) end, desc = "Pick and Switch Git Branches" },

      -- Other Utils
      --
      { "<leader>pc",  function() require("snacks").picker.colorschemes({ layout = "ivy" }) end,    desc = "Pick Color" },

      { "<leader>ch",  function() require("snacks").picker.command_history() end,                   desc = "Command history" },
      { "<leader>sh",  function() require("snacks").picker.search_history() end,                    desc = "Search history" },
      { "<leader>sm",  function() require("snacks").picker.marks() end,                             desc = "Search marks" },
      { "<leader>sr",  function() require("snacks").picker.registers() end,                         desc = "Search regs" },
      { "<leader>sk",  function() require("snacks").picker.keymaps() end,                           desc = "Search Keymaps" },

      { "<leader>sh",  function() require("snacks").picker.help() end,                              desc = "Help Pages" },


      { "<leader>zf",  function() require("snacks").picker.spelling() end,                          desc = "spelling checker" },
      { "\\s",         function() require("snacks").picker.resume() end,                            desc = "Resume" },

    }
  },
}
