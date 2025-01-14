(local keymaps (require :pack/which-key))

;; This is a COPY-PASTE from pack/pack
(local lisp-filetypes ["fennel" "clojure" "lisp" "racket" "scheme"])

(local group (vim.api.nvim_create_augroup "sexp-mappings" {}))

(vim.api.nvim_create_autocmd ["FileType"]
                             {:pattern lisp-filetypes
                              :callback keymaps.set-sexp-keys!
                              : group})
