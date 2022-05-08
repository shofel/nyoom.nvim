(import-macros {: lazy-require!} :macros.package-macros)

(local {: set-key! : doc-key!} (require :utils.keymap))

;; TODO
;;      - DONE migrate lsp keys
;;      - DONE remove keybind-macros
;;      - rename this file to core.keymaps

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

;; fzf-lua
(lambda fzf [x]
  "Given a topic `x`, return lua function and a description."
  (let [fzf-lua (lazy-require! :fzf-lua)] 
    (values (. fzf-lua x)
            {:desc x})))

(lambda fzf-files []
  (let [{: files} (lazy-require! :fzf-lua)]
    (values (lambda [] (files {:fd-opts "--no-ignore --hidden"}))
            {:desc "all files"})))

(doc-key!    "<leader>f" "fzf")
(set-key! :n "<leader>ff" (fzf :git_files))
(set-key! :n "<leader>fs" (fzf :git_status))
(set-key! :n "<leader>fF" (fzf-files))
(set-key! :n "<leader>fg" (fzf :live_grep))
(set-key! :n "<leader>fh" (fzf :help_tags))
(set-key! :n "<leader>fH" (fzf :command_history))
(set-key! :n "<leader>fc" (fzf :commands))
(set-key! :n "<leader>f," (fzf :builtin))
(set-key! :n "<leader>fk" (fzf :keymaps))
(set-key! :n "<leader>f." (fzf :resume))
(set-key! :n "<leader>fw" (fzf :grep_cword))
(set-key! :n "<leader>fW" (fzf :grep_cWORD))
(set-key! :n "<leader>/"  (fzf :blines))
(set-key! :n "<leader>bl" (fzf :buffers))

;; git
(doc-key!    "<leader>g"  "git")
(set-key! :n "<Leader>gs" "<cmd>vert Git<cr>")
(set-key! :n "<Leader>ga" "<cmd>Gwrite<cr>")
(set-key! :n "<Leader>gp" "<cmd>Dispatch git push<cr>")
(set-key! :n "<Leader>gP" "<cmd>Dispatch git push --force-with-lease<cr>")
(set-key! :n "<Leader>gm" "<cmd>GitMessenger<cr>")
(set-key! :n "<Leader>gV" "<cmd>GV!<cr>")
(set-key! :n "<Leader>gv" "<cmd>TermExec cmd=\"glog; exit\"<cr>")

;; conjure prefixes
(doc-key! "<localleader>E" "eval motion")
(doc-key! "<localleader>e" "execute")
(doc-key! "<localleader>l" "log")
(doc-key! "<localleader>r" "reset")
(doc-key! "<localleader>t" "test")

;; lsp keys for a buffer
(lambda set-lsp-keys! [bufnr]
  (let [wk (require :which-key)
        key (lambda [tbl prop] [(. tbl prop) prop])]
    (wk.register {"<leader>d" {:name "lsp"
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
                               "l" [(fn [] (print (vim.inspect (vim.lsp.buf.list_workspace_folders)))),
                                    "list_workspace_folders"]}
                  ; reassgn some builtin mappings
                  "K"  (key vim.lsp.buf :hover)
                  "gd" (key vim.lsp.buf :definition)
                  "gD" (key vim.lsp.buf :declaration)}
                 ; only for one buffer
                 {:buffer bufnr})))

;; treesitter 
(set-key! :n "<Leader>th" ":TSHighlightCapturesUnderCursor<CR>")
(set-key! :n "<Leader>tp" ":TSPlayground<CR>")

;; truezen:n
(set-key! :n "<leader>tz" :<cmd>TZAtaraxis<CR>)

;; export
{: set-lsp-keys!}
