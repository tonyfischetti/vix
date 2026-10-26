vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})

vim.api.nvim_create_user_command("Sep", ":normal! i<args> --------------------------------------------------------------- <args><ESC>o", { nargs = 1 })

-- :ProseMode -- toggle hard wrapping at 79 columns in this buffer.
-- lines are broken for real as you type past the margin, so j/k/dd work
-- on them like any other line. `gw` (not `gq`, which goes through par at
-- its own width) reflows existing text to the same margin: gwip for a
-- paragraph, gww for a line. the previous settings are restored on toggle
local function prose_mode()
  if vim.b.vix_prose then
    vim.opt_local.textwidth = vim.b.vix_prose.textwidth
    vim.opt_local.formatoptions = vim.b.vix_prose.formatoptions
    vim.b.vix_prose = nil
    vim.notify("prose mode off")
  else
    vim.b.vix_prose = { textwidth = vim.bo.textwidth, formatoptions = vim.bo.formatoptions }
    vim.opt_local.textwidth = 79
    vim.opt_local.formatoptions:append("t")  -- auto-wrap at textwidth while typing
    vim.notify("prose mode on: wrapping at 79, gw to reflow")
  end
end
vim.api.nvim_create_user_command("ProseMode", prose_mode,
  { desc = "toggle hard wrapping at 79 columns in this buffer" })
vim.keymap.set("n", "<Space>M", prose_mode, { desc = "toggle prose mode" })

