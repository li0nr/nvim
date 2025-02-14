local M = {}

--    capabilities = vanilla.capabilities,
local get_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  return require('blink.cmp').get_lsp_capabilities(capabilities)

end

M.setup_plugin_buffer_mappings = function(
  _, --[[ client --]]
  bufnr
)
  local which_key = require("which-key")

  --============================================================================
  -- https://github.com/nvim-telescope/telescope.nvim
  local telescope_builtin = require("telescope.builtin")
  which_key.register({
    ["lr"] = {
      function()
        telescope_builtin.lsp_references(require("telescope.themes").get_ivy({
          winblend = 20,
        }))
      end,
      "lsp: [g]oto [r]eferences in telescope",
    },
    ["ls"] = {
      function()
        telescope_builtin.lsp_document_symbols(
          require("telescope.themes").get_ivy({
            winblend = 20,
          })
        )
      end,
      "lsp: [g]oto [s]ymbols",
    },
  }, { prefix = "<leader>", buffer = bufnr })
end

  -----------------------------------------------------------------------------

  --============================================================================
  -- https://github.com/aznhe21/actions-preview.nvim
  --[[ which_key.register({
    ["la"] = {
      require("actions-preview").code_actions,
      "[l]sp: code [a]ctions",
    },
  }, { prefix = "<leader>", buffer = bufnr }) ]]

  -----------------------------------------------------------------------------

M.capabilities = get_capabilities()

M.setup_native_buffer_mappings = function(_, bufnr)
  local function lsp_prefix(desc)
    return "LSP: " .. desc
  end

  -- Normal mode LSP keymaps
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = lsp_prefix("goto definition") })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = lsp_prefix("goto Declaration") })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = lsp_prefix("goto implementation") })
  vim.keymap.set("n", "gh", vim.lsp.buf.hover, { buffer = bufnr, desc = lsp_prefix("hover documentation") })
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
    { buffer = bufnr, desc = lsp_prefix("rename identifier under cursor") })

  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = lsp_prefix("code actions") })
  -- "MunifTanjim/nui.nvim", maybe we need this if we want to enable preview-action.nvim


  -- format the whole buffer
  vim.keymap.set("n", "<leader>fb", function() vim.lsp.buf.format { async = true } end,
    { buffer = bufnr, desc = lsp_prefix("Format buffer") })

  -- Visual mode formatter
  vim.keymap.set("v", "<leader>1f", function() vim.lsp.buf.format { async = true } end,
    { buffer = bufnr, desc = "Visual formatter" })
end

return M
