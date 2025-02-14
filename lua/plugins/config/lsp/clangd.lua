-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd
-- https://github.com/p00f/clangd_extensions.nvim
local M = {}

M.should_install = function() end

local root_files = {
  "compile_commands.json",
}
local root_dir_func = function(fname)
  return require("lspconfig.util").root_pattern(unpack(root_files))(fname)
end

local clangd_custom_setup = function(_, bufnr)
  -- https://github.com/p00f/clangd_extensions.nvim
  vim.keymap.set("n", "<leader>s", "<Cmd>ClangdSwitchSourceHeader<CR>",
    { buffer = bufnr, desc = "Clangd: Switch Cpp/Header file" })
end

M.setup = function()
  local vanilla = require("plugins.config.lsp.vanilla")

  local nproc = string.gsub(vim.fn.system('nproc'), "\n", "")
  local opts = {
    cmd = {'clangd', '--header-insertion=never', '-j', nproc, '--background-index', '--clang-tidy'},
    on_attach = function(client, bufnr)
      vanilla.setup_native_buffer_mappings(client, bufnr)
      clangd_custom_setup(bufnr)
    end,
    capabilities = vanilla.capabilities,
    root_dir = root_dir_func,
    single_file_support = false,
  }

  require("lspconfig").clangd.setup(opts)
end

return M
