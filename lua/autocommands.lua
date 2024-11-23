-- [[ Highlight on yank ]]
local setup_highlight_on_yank = function()
  -- See `:help vim.highlight.on_yank()`
  local highlight_group = vim.api.nvim_create_augroup(
    "YankHighlight",
    { clear = true }
  )
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
  })
end

setup_highlight_on_yank()

-- Clear the jump list on Neovim startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("clearjumps")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "git",
  callback = function()
    vim.api.nvim_create_autocmd("BufLeave", {
      buffer = vim.fn.bufnr(),
      callback = function()
        vim.cmd("bwipeout")
      end,
    })
  end,
})

-- this touches whitespaces all over the buffer and po
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--     pattern = {"*"},
--     callback = function()
--         local save_cursor = vim.fn.getpos(".")
--         pcall(function() vim.cmd [[%s/\s\+$//e]] end)
--         vim.fn.setpos(".", save_cursor)
--     end,
-- })
