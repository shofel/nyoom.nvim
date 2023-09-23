-- [nfnl] Compiled from fnl/pack/vim-sexp.fnl by https://github.com/Olical/nfnl, do not edit.
local keymaps = require("pack/which-key")
local lisp_filetypes = {"fennel", "clojure", "lisp", "racket", "scheme"}
local group = vim.api.nvim_create_augroup("sexp-mappings", {})
return vim.api.nvim_create_autocmd({"FileType"}, {pattern = lisp_filetypes, callback = keymaps["set-sexp-keys!"], group = group})
