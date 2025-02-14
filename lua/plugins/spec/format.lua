-- https://github.com/stevearc/conform.nvim
vim.api.nvim_create_user_command("DisableAutoformat", function()
  -- Disable autoformatting globally
  vim.g.disable_autoformat = true
  vim.notify("Global autoformatting disabled", vim.log.levels.INFO)
end, {
  desc = "Disable autoformatting globally or for the current buffer (use ! for buffer-only)",
  bang = true,
})

vim.api.nvim_create_user_command("EnableAutoformat", function()
  -- Enable autoformatting globally
  vim.g.disable_autoformat = false
  vim.notify("Global autoformatting enabled", vim.log.levels.INFO)
end, {
  desc = "Enable autoformatting globally or for the current buffer (use ! for buffer-only)",
  bang = true,
})

local function format_hunks(bufnr)
  local hunks = require("gitsigns").get_hunks(bufnr)
  if hunks == nil then
    return
  end

  local format = require("conform").format

  local function format_range()
    if next(hunks) == nil then
      -- print("done formatting! ")
      -- vim.notify("done formatting git hunks", "info", { title = "formatting" })
      return
    end
    local hunk = nil
    while next(hunks) ~= nil and (hunk == nil or hunk.type == "delete") do
      hunk = table.remove(hunks)
    end

    if hunk ~= nil and hunk.type ~= "delete" then
      -- print(hunk)
      local start = hunk.added.start
      local last = start + hunk.added.count
      -- nvim_buf_get_lines uses zero-based indexing -> subtract from last
      local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
      local range = { start = { start, 0 }, ["end"] = { last - 1, last_hunk_line:len() } }
      format({ range = range, async = false, lsp_fallback = true, quiet = true }, function()
        vim.defer_fn(function()
          format_range()
        end, 1)
      end)
    end
  end

  format_range()
end

local M = {
  {
    -- https://github.com/stevearc/conform.nvim
    "stevearc/conform.nvim",
    event = "VeryLazy",
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          if vim.bo.buftype == "nofile" or vim.bo.buftype == "nowrite" or vim.bo.buftype == "quickfix" then
            return
          end
          -- Prefer to format git hunks instead of the entire file
          format_hunks(bufnr)
        end,
      })
    end,
  },
}

return M
