-- [nfnl] Compiled from fnl/pack/which-key.fnl by https://github.com/Olical/nfnl, do not edit.
local wk = require("which-key")
local function key(tbl, prop)
  _G.assert((nil ~= prop), "Missing argument prop on /home/slava/10-19-Computer/12-Tooling/13.03-nyoom.nvim/fnl/pack/which-key.fnl:3")
  _G.assert((nil ~= tbl), "Missing argument tbl on /home/slava/10-19-Computer/12-Tooling/13.03-nyoom.nvim/fnl/pack/which-key.fnl:3")
  return {tbl[prop], prop}
end
local list_workspace_folders
local function _1_()
  return print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end
list_workspace_folders = {_1_, "list workspace folders"}
wk.register({["<leader>d"] = {name = "lsp:inspect", d = key(vim.lsp.buf, "definition"), D = key(vim.lsp.buf, "declaration"), i = key(vim.lsp.buf, "implementation"), t = key(vim.lsp.buf, "type_definition"), s = key(vim.lsp.buf, "signature_help"), h = key(vim.lsp.buf, "hover"), r = key(vim.lsp.buf, "references")}, ["<leader>h"] = {name = "lsp:diagnostic", k = key(vim.diagnostic, "goto_prev"), j = key(vim.diagnostic, "goto_next"), w = key(vim.diagnostic, "open_float"), q = key(vim.diagnostic, "setloclist")}, ["<leader>a"] = {name = "lsp:action", r = key(vim.lsp.buf, "rename"), a = key(vim.lsp.buf, "code_action"), f = key(vim.lsp.buf, "formatting")}, ["<leader>W"] = {name = "lsp:workspace", a = key(vim.lsp.buf, "add_workspace_folder"), r = key(vim.lsp.buf, "remove_workspace_folder"), l = list_workspace_folders}})
local function set_lsp_keys_21(bufnr)
  _G.assert((nil ~= bufnr), "Missing argument bufnr on /home/slava/10-19-Computer/12-Tooling/13.03-nyoom.nvim/fnl/pack/which-key.fnl:33")
  return wk.register({K = key(vim.lsp.buf, "hover"), gd = key(vim.lsp.buf, "definition"), gD = key(vim.lsp.buf, "declaration")}, {buffer = bufnr})
end
return {["set-lsp-keys!"] = set_lsp_keys_21}
