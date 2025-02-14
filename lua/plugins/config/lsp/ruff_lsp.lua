
local M = {}

M.setup = function()
  local vanilla = require("plugins.config.lsp.vanilla")

  local on_attach = function(client, bufnr)
    vanilla.setup_native_buffer_mappings(client, bufnr)
    client.server_capabilities.hoverProvider = false
  end

  require("lspconfig").ruff.setup({
    on_attach = on_attach,
    capabilities = vanilla.capabilities,
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = {
          enable = false,
        },
      },
    },
  })
end

return M
