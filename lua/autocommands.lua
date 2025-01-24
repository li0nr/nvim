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
--

-- dont check spelling for nofile types ===================================================================
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.buftype == "nofile" or vim.bo.buftype == "nowrite" then
      vim.wo.spell = false
    end
  end,
  desc = "Disable spell checking for 'nofile' buffers",
})


-- closing Neovim with nofile buffs ===================================================================
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    -- Iterate through all open buffers
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.bo[buf].buftype == "nofile" or vim.bo[buf].buftype == "nowrite" then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end,
  desc = "Close 'nofile' buffers when writing a regular buffer",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { 'c', 'cpp', 'h' },
  callback = function()
    vim.opt.commentstring = "// %s"
  end,
  desc = "Change commentstring for c/c++ files",
})
