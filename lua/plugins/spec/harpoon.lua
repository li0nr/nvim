
return {
  "ThePrimeagen/harpoon",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = true,
  keys = {
    { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with Harpoon" },
    { "<leader>he", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Toggle Harpoon menu" },
    { "<C-n>",      "<cmd>lua require('harpoon.ui').nav_next()<cr>",          desc = "Next Harpoon mark" },
    { "<C-p>",      "<cmd>lua require('harpoon.ui').nav_prev()<cr>",          desc = "Prev Harpoon mark" },
    { "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "Harpoon mark 1" },
    { "<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "Harpoon mark 2" },
    { "<leader>h3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "Harpoon mark 3" },
    { "<leader>h4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Harpoon mark 4" },
  },
}
