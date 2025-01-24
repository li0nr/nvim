local M = {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install && git restore .",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    config = function()
      -- Add key mappings for Markdown preview
      -- vim.api.nvim_set_keymap("n", "<C-s>", "<Plug>MarkdownPreview", { noremap = false, silent = true })
      -- vim.api.nvim_set_keymap("n", "<M-s>", "<Plug>MarkdownPreviewStop", { noremap = false, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>m", "<Plug>MarkdownPreviewToggle", { noremap = false, silent = true })
    end,
  },
}

return M
