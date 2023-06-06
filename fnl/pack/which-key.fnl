(local wk (require :which-key))

(lambda key [tbl prop] [(. tbl prop) prop])

;; Root leader keys
(wk.register {"<leader>" {:s ["<cmd>w<cr>" "Write buffer"]
                          :n ["<cmd>nohlsearch<cr>" "Clear search"]
                          :e [":" ":"]}})

;; A handier unimpared
(wk.register {"[d" (key vim.diagnostic :goto_prev)
              "]d" (key vim.diagnostic :goto_next)
              "[c" ["<cmd>Gitsigns prev_hunk<cr>" "prev hunk"]
              "]c" ["<cmd>Gitsigns next_hunk<cr>" "next hunk"]
              "<leader>j" ["]" "Unimpared next"]
              "<leader>k" ["[" "Unimpared prev"]}
             {:noremap false})

;; buffers and windows
(let [{: unshow_in_window} (require "mini.bufremove")]
  (wk.register {"<leader>b" {:name "buffers"
                             "o" ["<cmd>only<cr>"      "close others"]
                             "k" ["<cmd>bwipeout!<cr>" "kill buffer and close window"]
                             "h" [unshow_in_window     "hide buffer"]
                             "c" ["<cmd>close<cr>"     "close buffer"]}}))

;; git
(wk.register {"<leader>g" {:name "git"}})

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
