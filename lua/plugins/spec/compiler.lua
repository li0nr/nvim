local M = {
  {
    -- https://github.com/tpope/vim-fugitive
    "tpope/vim-dispatch",
  }
}

-- Function to set makeprg and errorformat
local set_makeprg_vast = function(args)
  local make_args = "-ad python_debug=1 -j128 ccache=1 "
  if not args or string.len(args) == 0 then
    make_args = make_args .. "dist/tests/nfs_ios_mock "
  else
    make_args = make_args .. args
  end

  vim.api.nvim_buf_set_option(0, 'makeprg', 'nvim-compiler.sh ' .. make_args)
  vim.api.nvim_buf_set_option(0, 'errorformat', table.concat({
    "%f:%l:%c: %m",
    "%*[^\"]\\\"%f\\\"%*\\\\D%l:%c: %m",
    "%*[^\"]\\\"%f\\\"%*\\\\D%l: %m",
    "\\\"%f\\\"%*\\\\D%l:%c: %m",
    "\\\"%f\\\"%*\\\\D%l: %m",
    "%f:%l: %trror: Each undeclared identifier is reported only once",
    "%f:%l: %trror: for each function it appears in.",
    "%f:%l:%c: %trror: %m",
    "%f:%l:%c: %tarning: %m",
    "%f:%l:%c: %m",
    "%f:%l: %trror: %m",
    "%f:%l: %tarning: %m",
    "%f:%l: %m",
    "%f:(%*[^)])\\): %m",
    "\\\"%f\\\", line %l%*\\\\D%c%*[^\"] %m",
    "%D%*\\\\a[%*\\\\d]: Entering directory %*[`']%f",
    "%X%*\\\\a[%*\\\\d]: Leaving directory %*[`']%f",
    "%D%*\\\\a: Entering directory %*[`']%f",
    "%X%*\\\\a: Leaving directory %*[`']%f",
    "%DMaking %*\\\\a in %f"
  }, ','))

  print("Make program and error format set with args: " .. make_args)
end

-- Create a command for user convenience
vim.api.nvim_create_user_command(
  'Vast',
  function(opts)
    set_makeprg_vast(opts.args)
  end,
  { nargs = '?' }
)

vim.api.nvim_set_keymap('n', '<C-b>', ':Dispatch<CR>', { noremap = true, silent = true })


return M
