(local which-key (require :which-key))

(lambda key [tbl prop] [(. tbl prop) prop])

;; Without prefix
(let [maps [["<leader>s" "<cmd>w<cr>"]
            ["<leader>n" "<cmd>nohlsearch<cr>"]
            ["<leader>e" ":"]]]
  (icollect [i [lhs rhs] (ipairs maps)]
    (vim.keymap.set :n lhs rhs)))

;; A handier unimpared
(which-key.register {"[d" (key vim.diagnostic :goto_prev)
                     "]d" (key vim.diagnostic :goto_next)
                     "[c" ["<cmd>Gitsigns prev_hunk<cr>" "prev hunk"]
                     "]c" ["<cmd>Gitsigns next_hunk<cr>" "next hunk"]
                     "<leader>j" ["]" "unimpared-next"]
                     "<leader>k" ["[" "unimpared-prev"]}
                    {:noremap false})

;; ThePrimeagen/refactoring.nvim
(let [refactor (λ [x] [ (.. "<Esc><Cmd>lua require('refactoring').refactor('" x "')<CR>")
                        x])]
  ;
  ; Visual mode
  (which-key.register {"<leader>r" {:name "refactoring"
                                    "f" (refactor "Extract Function")
                                    "F" (refactor "Extract Function To File")
                                    "v" (refactor "Extract Variable")
                                    "i" (refactor "Inline Variable")}}
                      {:mode "v"})
  ;
  ; Normal mode
  (which-key.register {"<leader>r" {:name "refactoring"
                                    "b" (refactor "Extract Block")
                                    "B" (refactor "Extract Block To File")
                                    "i" (refactor "Inline Variable")}}
                      {:mode "n"}))

;; buffers and windows
(let [{: unshow_in_window} (require "mini.bufremove")]
  (which-key.register {"<leader>b" {:name "buffers"
                                    "o" ["<cmd>only<cr>"      "close others"]
                                    "k" ["<cmd>bwipeout!<cr>" "kill buffer and close window"]
                                    "h" [unshow_in_window     "hide buffer"]
                                    "c" ["<cmd>close<cr>"     "close buffer"]}}))

;; git
(which-key.register {"<leader>g" {:name "git"}})

;; fzf prefix
(which-key.register {"<leader>f" {:name "fzf"}})

;; document conjure prefixes
(which-key.register {"<localleader>E" "eval motion"
                     "<localleader>e" "execute"
                     "<localleader>l" "log"
                     "<localleader>r" "reset"
                     "<localleader>t" "test"})

(local list-workspace-folders
       [(fn [] (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
        "list workspace folders"])

;; basic lsp keys
(which-key.register {"<leader>d" {:name "lsp:inspect"
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
  (which-key.register {"K"  (key vim.lsp.buf :hover)
                       "gd" (key vim.lsp.buf :definition)
                       "gD" (key vim.lsp.buf :declaration)}
                      {:buffer bufnr}))

;; export
{: set-lsp-keys!}
