local M = {}

local get_capabilities = function()
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  return cmp_nvim_lsp.default_capabilities(capabilities)
end

M.capabilities = get_capabilities()

M.setup_native_buffer_mappings = function(
  _, --[[ client --]]
  bufnr
)
  local lsp_prefix = function(desc)
    return "[l]sp: " .. desc
  end

  local which_key = require("which-key")
  which_key.register({
      ["gd"]         = { vim.lsp.buf.definition, lsp_prefix("goto [d]efinition") },
      ["gD"]         = { vim.lsp.buf.declaration, lsp_prefix("goto [D]eclaration") },
      ["gi"]         = { vim.lsp.buf.implementation, lsp_prefix("goto [i]mplementation") },
      ["gh"]         = { vim.lsp.buf.hover, lsp_prefix("hover documentation") },
      ["<F2>"]       = { vim.lsp.buf.rename, lsp_prefix("rename identifier under cursor") },
      ["<leader>ca"] = {
        require("actions-preview").code_actions,
        "lsp: [c]ode [a]ctions",
      },
      ["<leader>lk"] = {
        function()
          require("lsp_signature").toggle_float_win()
        end,
        "lsp: Signature help",
      },
      -- `Format` user command is setup during `conform` setup.
      ["<leader>lf"] = { "<Cmd>Format<Cr>", lsp_prefix("[f]ormat buffer") },
      -- https://github.com/aznhe21/actions-preview.nvim

      -- a lot of not needed noise
      --[[ ["lk"] = { vim.lsp.buf.signature_help, lsp_prefix("[k] signature help") },
    ["lt"] = {
      vim.lsp.buf.type_definition,
      lsp_prefix("goto [t]ype definition"),
    },]]
    },
    { mode = "n", buffer = bufnr }) --prefix = "<leader>",
  which_key.register({
    ["1f"] = { "<Cmd>Format<Cr>", "[l]sp: symbols [o]utline" },
  }, { mode = "v", prefix = "<leader>", buffer = bufnr })
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

  --============================================================================
  -- https://github.com/ray-x/lsp_signature.nvim
  --[[ require("which-key").register({
    ["<C-h>"] = {
      function()
        require("lsp_signature").toggle_float_win()
      end,
      "lsp: Signature help",
    },
  }, { buffer = bufnr }) ]]

  -----------------------------------------------------------------------------

  --============================================================================
  -- https://github.com/simrat39/symbols-outline.nvim
  which_key.register({
    ["lo"] = { "<Cmd>SymbolsOutline<Cr>", "[l]sp: symbols [o]utline" },
  }, { prefix = "<leader>", buffer = bufnr })

  -----------------------------------------------------------------------------
end

M.setup_autocmds = function(client, bufnr)
  -- TODO: Replace following with an approproate plugin
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    local group = vim.api.nvim_create_augroup(
      "lsp_document_highlight",
      { clear = true }
    )
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved" }, {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

return M
