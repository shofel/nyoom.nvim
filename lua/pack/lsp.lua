-- [nfnl] Compiled from fnl/pack/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
local lsp = require("lspconfig")
local keymaps = require("pack/which-key")
do
  local _let_1_ = vim.diagnostic
  local config = _let_1_["config"]
  local severity = _let_1_["severity"]
  local _let_2_ = vim.fn
  local sign_define = _let_2_["sign_define"]
  config({underline = {severity = {min = severity.INFO}}, signs = {severity = {min = severity.INFO}}, update_in_insert = true, severity_sort = true, float = {border = "rounded", show_header = false}, virtual_text = false})
  sign_define("DiagnosticSignError", {text = "\239\129\151", texthl = "DiagnosticSignError"})
  sign_define("DiagnosticSignWarn", {text = "\239\129\177", texthl = "DiagnosticSignWarn"})
  sign_define("DiagnosticSignInfo", {text = "\239\129\170", texthl = "DiagnosticSignInfo"})
  sign_define("DiagnosticSignHint", {text = "\239\129\154", texthl = "DiagnosticSignHint"})
end
do
  local _let_3_ = vim.lsp
  local with = _let_3_["with"]
  local handlers = _let_3_["handlers"]
  vim.lsp.handlers["textDocument/signatureHelp"] = with(handlers.signature_help, {border = "solid"})
  vim.lsp.handlers["textDocument/hover"] = with(handlers.hover, {border = "solid"})
end
local function on_attach(client, bufnr)
  return keymaps["set-lsp-keys!"](bufnr)
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
local defaults = {on_attach = on_attach, capabilities = capabilities, flags = {debounce_text_changes = 150}}
lsp.lua_ls.setup({on_attach = on_attach, capabilities = capabilities, settings = {Lua = {diagnostics = {globals = {"vim"}}, workspace = {library = {[vim.fn.expand("$VIMRUNTIME/lua")] = true, [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true}, maxPreload = 100000, preloadFileSize = 10000}}}})
lsp.powershell_es.setup({on_attach = on_attach, bundle_path = "/home/shovel/opt/PowerShellEditorServices/"})
local function _4_()
  return vim.api.nvim_command("autocmd BufWritePre <buffer> EslintFixAll")
end
lsp.eslint.setup({on_attach = _4_})
lsp.stylelint_lsp.setup({cmd = {"yarn", "dlx", "-p", "stylelint-lsp", "stylelint-lsp", "--stdio"}, filetypes = {"css", "less", "scss", "sugarss", "vue", "wxss"}, root_dir = lsp.util.root_pattern(".stylelintrc", "package.json"), settings = {}})
lsp.rnix.setup(defaults)
lsp.hls.setup(defaults)
lsp.terraformls.setup(defaults)
lsp.tsserver.setup({on_attach = on_attach, capabilities = capabilities})
lsp.vimls.setup(defaults)
lsp.yamlls.setup({on_attach = on_attach, capabilities = capabilities, settings = {yaml = {keyOrdering = false}}})
return lsp.jsonnet_ls.setup({})
