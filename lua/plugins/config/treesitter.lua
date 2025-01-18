local M = {}

local setup_treesitter = function()
  local ts_config = require("nvim-treesitter.configs")
  ts_config.setup({
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    ensure_installed = { "bash", "python", "c", "cmake", "cpp", "lua", "markdown", "vim", },
    auto_install = false,
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection    = "<leader>ss",
        node_incremental  = "<leader>si",
        node_decremental  = "<leader>sd",
      },
    },
    indent = { enable = true },
    disable = function(_, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  })
end

M.setup = function()
  vim.defer_fn(setup_treesitter, 0)
end

return M
