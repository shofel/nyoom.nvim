(local which-key (require :which-key))

(lambda key [tbl prop] [(. tbl prop) prop])

;; Suppress probably unused keys.
(which-key.register {"Q"     [:<Nop> "nop"]})

;;
(which-key.register {"<leader>s" ["<cmd>w<cr>"          "Save file"]
                     "<leader>n" ["<cmd>nohlsearch<cr>" "nohlsearch"]})

;; A handier unimpared
(which-key.register {"[d" (key vim.diagnostic :goto_prev)
                     "]d" (key vim.diagnostic :goto_next)
                     "[c" ["<cmd>Gitsigns prev_hunk<cr>" "prev hunk"]
                     "]c" ["<cmd>Gitsigns next_hunk<cr>" "next hunk"]
                     "<leader>j" ["]" "unimpared-next"]
                     "<leader>k" ["[" "unimpared-prev"]}
                    {:noremap false})

;; ThePrimeagen/refactoring.nvim
(fn refactor [x] [(.. "<Esc><Cmd>lua require('refactoring').refactor('" x "')<CR>")
                  x])
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
                    {:mode "n"})

;; buffers and windows
(let [{: unshow_in_window} (require "mini.bufremove")]
  (which-key.register {"<leader>b" {:name "buffers"
                                    "o" ["<cmd>only<cr>"      "close others"]
                                    "k" ["<cmd>bwipeout!<cr>" "kill buffer and close window"]
                                    "h" [unshow_in_window     "hide buffer"]
                                    "c" ["<cmd>close<cr>"     "hide buffer"]}}
                      {:silent true}))

;; fzf
(let [fzf-lua (require :fzf-lua)]
  (let [key-all-files (lambda []
                        (fzf-lua.files {:fd-opts "--no-ignore --hidden"}))]
    (which-key.register {"<leader>f" {:name "fzf"
                                      "f" (key fzf-lua :git_files)
                                      "F" [key-all-files "all files"]
                                      "s" (key fzf-lua :git_status)
                                      "g" (key fzf-lua :live_grep)
                                      "h" (key fzf-lua :help_tags)
                                      "H" (key fzf-lua :command_history)
                                      "c" (key fzf-lua :commands)
                                      "," (key fzf-lua :builtin)
                                      "k" (key fzf-lua :keymaps)
                                      "." (key fzf-lua :resume)
                                      "w" (key fzf-lua :grep_cword)
                                      "W" (key fzf-lua :grep_cWORD)}
                         "<leader>/"  (key fzf-lua :blines)
                         "<leader>bl" (key fzf-lua :buffers)})))

;; git
(which-key.register {"<leader>g" {:name "git"
                                  "s" ["<cmd>vert Git<cr>"
                                       "Fugitive"]

                                  "a" ["<cmd>Gwrite<cr>"
                                       "Stage file"]

                                  "p" ["<cmd>G push<cr>"
                                       "Push"]

                                  "P" ["<cmd>G push --force-with-lease<cr>"
                                       "Push force"]

                                  "m" ["<cmd>GitMessenger<cr>"
                                       "GitMessenger"]

                                  "V" ["<cmd>GV!<cr>"
                                       "GV"]

                                  "v" ["<cmd>TermExec cmd=\"glog; exit\"<cr>"
                                       "Log"]}}
                    {:silent true})

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

;; treesitter
(which-key.register {"<Leader>th" ["<cmd>TSHighlightCapturesUnderCursor<cr>"
                                   "TS highlight captures"]})

(which-key.register {"<Leader>tp" ["<cmd>TSPlayground<cr>"
                                   "TSPlayground"]})

;; truezen:n
(which-key.register {"<leader>tz" ["<cmd>TZAtaraxis<cr>" "truezen"]})

(λ set-sexp-keys! [{: buf}]
  "@see https://github.com/tpope/vim-sexp-mappings-for-regular-people"
  (which-key.register {"dsf" ["<Plug>(sexp_splice_list)" "sexp splice list"]
                       ; Barf and slurp.
                       "<I" ["<Plug>(sexp_insert_at_list_head)"   "insert at head"]
                       ">I" ["<Plug>(sexp_insert_at_list_tail)"   "insert at tail"]
                       "<f" ["<Plug>(sexp_swap_list_backward)"    "gswap list backward"]
                       ">f" ["<Plug>(sexp_swap_list_forward)"     "swap list forward"]
                       "<e" ["<Plug>(sexp_swap_element_backward)" "swap element backward"]
                       ">e" ["<Plug>(sexp_swap_element_forward)"  "swap element forward"]
                       ">(" ["<Plug>(sexp_emit_head_element)"     "emit head"]
                       "<)" ["<Plug>(sexp_emit_tail_element)"     "emit tail"]
                       "<(" ["<Plug>(sexp_capture_prev_element)"  "capture prev"]
                       ">)" ["<Plug>(sexp_capture_next_element)"  "capture next"]}
                      {:buffer buf})

  ; Navigate by word
  (let [word-navigation {"B"  ["<Plug>(sexp_move_to_prev_element_head)" "prev head"]
                         "W"  ["<Plug>(sexp_move_to_next_element_head)" "next head"]
                         "gE" ["<Plug>(sexp_move_to_prev_element_tail)" "prev tail"]
                         "E"  ["<Plug>(sexp_move_to_next_element_tail)" "next tail"]}]
    (each [_ mode (ipairs ["n" "x" "o"])]
      (which-key.register word-navigation {: mode :buffer buf}))))

;; export
{: set-lsp-keys!
 : set-sexp-keys!}
