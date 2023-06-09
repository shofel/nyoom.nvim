(local wk (require :which-key))

(lambda key [tbl prop] [(. tbl prop) prop])

(local list-workspace-folders
       [(fn [] (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
        "list workspace folders"])

;; basic lsp keys
(wk.register {"<leader>d" {:name "lsp:inspect"
                           "d" (key vim.lsp.buf :definition)
                           "D" (key vim.lsp.buf :declaration)
                           "i" (key vim.lsp.buf :implementation)
                           "t" (key vim.lsp.buf :type_definition)
                           "s" (key vim.lsp.buf :signature_help)
                           "h" (key vim.lsp.buf :hover)
                           "r" (key vim.lsp.buf :references)}
              "<leader>h" {:name "lsp:diagnostic"
                           "k" (key vim.diagnostic :goto_prev)
                           "j" (key vim.diagnostic :goto_next)
                           "w" (key vim.diagnostic :open_float)
                           "q" (key vim.diagnostic :setloclist)}
              "<leader>a" {:name "lsp:action"
                           "r" (key vim.lsp.buf :rename)
                           "a" (key vim.lsp.buf :code_action)
                           "f" (key vim.lsp.buf :formatting)}
              "<leader>W" {:name "lsp:workspace"
                           "a" (key vim.lsp.buf :add_workspace_folder)
                           "r" (key vim.lsp.buf :remove_workspace_folder)
                           "l" list-workspace-folders}})

;; upgrade standard keys with lsp
(λ set-lsp-keys! [bufnr]
  (wk.register {"K"  (key vim.lsp.buf :hover)
                "gd" (key vim.lsp.buf :definition)
                "gD" (key vim.lsp.buf :declaration)}
               {:buffer bufnr}))

;; export
{: set-lsp-keys!}
