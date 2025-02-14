

local M = {}

M.setup = function()
  local vanilla = require("plugins.config.lsp.vanilla")

  local on_attach = function(client, bufnr)
    vanilla.setup_native_buffer_mappings(client, bufnr)
  end

  require("lspconfig").pyright.setup({
    on_attach = on_attach,
    capabilities = vanilla.capabilities,
    settings = {
      pyright = {
        -- Using Ruff's import organizer
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          -- Ignore all files for analysis to exclusively use Ruff for linting
          ignore = { '*' },
        },
      },
    },
  })
end

return M
