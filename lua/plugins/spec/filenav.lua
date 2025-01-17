local M = {
  {
    -- https://github.com/nvim-neo-tree/neo-tree.nvim
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    event = "VeryLazy",
    cmd = "Neotree",
    keys = {
      {
        "\\\\",
        function()
          require("neo-tree.command").execute({ toggle = true })
        end,
        desc = "Neotree Explore",
      },
      {
        "\\b",
        function()
          require("neo-tree.command").execute({ toggle = true, source = "buffers" })
        end,
        desc = "Neotree Buffers",
      },
      {
        "\\g",
        function()
          require("neo-tree.command").execute({ toggle = true, source = "git_status" })
        end,
        desc = "NeoTree Git Status",
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
}

return M
