(import-macros {: lazy-require!} :macros.package-macros)

(local which-key (require :which-key))
(local {: set-key! : doc-key!} (require :utils.keymap))

(lambda key [tbl prop] [(. tbl prop) prop])

;; TODO
;;      - DONE migrate lsp keys
;;      - DONE remove keybind-macros
;;      - DOME rename this file to core.keymaps
;;      - remove :utils.keymap

;; who actually uses C-z or ex mode?
(set-key! :n "<C-z>" :<Nop>)
(set-key! :n "Q"     :<Nop>)

;;
(set-key! :n "<leader>s" "<cmd>w<cr>" {:desc "Save file"})
(set-key! :n "<leader>n" "<cmd>nohlsearch<cr>")

(doc-key!    "<leader>b"  "buffers")
(set-key! :n "<leader>bo" "<cmd>only<cr>")
(set-key! :n "<leader>bk" "<cmd>bwipeout<cr>")
(set-key! :n "<leader>bh" "<cmd>close<cr>") ; TODO mini.buffers.delete()

(lambda fzf-files []
  (let [{: files} (lazy-require! :fzf-lua)]
    [(lambda [] (files {:fd-opts "--no-ignore --hidden"}))
     "all files"]))

(let [fzf-lua (lazy-require! :fzf-lua)]
  (let [key-all-files (lambda []
                        (fzf-lua.files {:fd-opts "--no-ignore --hidden"}))]
    which-key.register {"<leader>f" {:name "fzf"
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
                        "/"  (key fzf-lua :blines)
                        "bl" (key fzf-lua :buffers)}))

;; git
(which-key.register {"<leader>g" {:name "git"
                                  "s" ["<cmd>vert Git<cr>" "Fugitive"]
                                  "a" ["<cmd>Gwrite<cr>"   "Stage file"]
                                  "p" ["<cmd>Dispatch git push<cr>"                    "Push"]
                                  "P" ["<cmd>Dispatch git push --force-with-lease<cr>" "Push force"]
                                  "m" ["<cmd>GitMessenger<cr>" "GitMessenger"]
                                  "V" ["<cmd>GV!<cr>"                         "GV"]
                                  "v" ["<cmd>TermExec cmd=\"glog; exit\"<cr>" "Log"]}})

;; document conjure prefixes
(which-key.register {"<localleader>E" "eval motion"
                     "<localleader>e" "execute"
                     "<localleader>l" "log"
                     "<localleader>r" "reset"
                     "<localleader>t" "test"})

;; lsp keys for a buffer
(lambda set-lsp-keys! [bufnr]
  (which-key.register {"<leader>d" {:name "lsp"
                                    ; inspect
                                    "d" (key vim.lsp.buf :definition)
                                    "D" (key vim.lsp.buf :declaration)
                                    "i" (key vim.lsp.buf :implementation)
                                    "t" (key vim.lsp.buf :type_definition)
                                    "s" (key vim.lsp.buf :signature_help)
                                    "h" (key vim.lsp.buf :hover)
                                    "r" (key vim.lsp.buf :references)
                                    ; diagnstic
                                    "k" (key vim.diagnostic :goto_prev)
                                    "j" (key vim.diagnostic :goto_next)
                                    "w" (key vim.diagnostic :open_float)
                                    "q" (key vim.diagnostic :setloclist)
                                    ; code
                                    "r" (key vim.lsp.buf :rename)
                                    "a" (key vim.lsp.buf :code_action)
                                    "f" (key vim.lsp.buf :formatting)}
                       "<leader>W" {:name "lsp workspace"
                                    "a" (key vim.lsp.buf :add_workspace_folder)
                                    "r" (key vim.lsp.buf :remove_workspace_folder)
                                    "l" [(fn [] (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
                                         "list_workspace_folders"]}
                       ; reassgn some builtin mappings
                       "K"  (key vim.lsp.buf :hover)
                       "gd" (key vim.lsp.buf :definition)
                       "gD" (key vim.lsp.buf :declaration)}
               ; only for one buffer
               {:buffer bufnr}))

;; treesitter 
(which-key.register {"<Leader>th" [":TSHighlightCapturesUnderCursor<CR>" "TS highlight captures"]})
(which-key.register {"<Leader>tp" [":TSPlayground<CR>"                   "TSPlayground"]})

;; truezen:n
(which-key.register {"<leader>tz" ["<cmd>TZAtaraxis<cr>" "truezen"]})

;; export
{: set-lsp-keys!}
