local M = {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function() vim.fn["mkdp#util#install"]() end,

  config = function()
    -- Add key mappings for Markdown preview
    -- vim.api.nvim_set_keymap("n", "<C-s>", "<Plug>MarkdownPreview", { noremap = false, silent = true })
    -- vim.api.nvim_set_keymap("n", "<M-s>", "<Plug>MarkdownPreviewStop", { noremap = false, silent = true })
    vim.api.nvim_set_keymap("n", "<C-p>", "<Plug>MarkdownPreviewToggle", { noremap = false, silent = true })
  end,
}

return M
