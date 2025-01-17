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

M = {}

M.setup_conform = function()
    -- local conform = require("conform")
    -- conform.setup({
    --     format_on_save = function(bufnr)
    --         -- Disable with a global or buffer-local variable
    --         if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
    --             return
    --         end
    --         return { timeout_ms = 500, lsp_fallback = true }
    --     end,
    --     formatters_by_ft = {
    --         lua = { "stylua" },
    --         -- Conform will run multiple formatters sequentially
    --         python = { "isort", "black" },
    --     },
    -- })
    -- `Format` user command bound to `<leader><leader>f` during lsp `on_attach()`
    -- vim.api.nvim_create_user_command("Format", function(args)
    --     local range = nil
    --     if args.count ~= -1 then
    --         local end_line = vim.api.nvim_buf_get_lines(
    --             0,
    --             args.line2 - 1,
    --             args.line2,
    --             true
    --         )[1]
    --         range = {
    --             start = { args.line1, 0 },
    --             ["end"] = { args.line2, end_line:len() },
    --         }
    --     end
    --     conform.format({ async = true, lsp_fallback = true, range = range })
    -- end, { range = true })


    --the idea of formatting on save i dont like
    --[[ local conform = require("conform")
  conform.setup({
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
    },
  }) ]]

    --[[ vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
      -- FormatDisable! will disable formatting just for this buffer
      vim.b.disable_autoformat = true
    else
      vim.g.disable_autoformat = true
    end
  end, {
    desc = "Disable autoformat-on-save",
    bang = true,
  })

  vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
  end, {
    desc = "Re-enable autoformat-on-save",
  }) ]]
end

local function format_hunks()
  local ignore_filetypes = { "nofile" } --{ "lua" }
  if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
    vim.notify("range formatting for " .. vim.bo.filetype .. " not working properly.")
    return
  end

  local hunks = require("gitsigns").get_hunks()
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

require("conform").setup({
  -- options,
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      print("Auto format disabled!")
      return
    end
    -- Prefer to format git hunks instead of the entire file
    format_hunks()
  end,
})
return M
