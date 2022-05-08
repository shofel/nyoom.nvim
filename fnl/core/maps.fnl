(import-macros {: map! : doc-map!} :macros.keybind-macros)
(import-macros {: lazy-require!} :macros.package-macros)

(local set-key! vim.keymap.set)
(local doc-key! (. (lazy-require! "which-key") :register))

;; who actually uses C-z or ex mode?
(map! [n] "<C-z>" :<Nop>)
(map! [n] "Q"     :<Nop>)

;; move between windows
;; ?TODO

;;
(map! [n] "<leader>s" "<cmd>w<cr>" "Save file")
(map! [n] "<leader>n" "<cmd>nohlsearch<cr>")

(doc-map! :n "<leader>w" :silent "windows")
(map! [n] "<leader>wo" "<cmd>only<cr>")
(map! [n] "<leader>wc" "<cmd>bwipeout<cr>")

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

(doc-map! :n :<leader>f :silent "fzf")

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
(set-key! :n "<leader>b"  (fzf :buffers))

;; git
(doc-map! :n "<leader>g"  :silent "git")
(set-key! :n "<Leader>gs" "<cmd>vert Git<cr>")
(set-key! :n "<Leader>ga" "<cmd>Gwrite<cr>")
(set-key! :n "<Leader>gp" "<cmd>Dispatch git push<cr>")
(set-key! :n "<Leader>gP" "<cmd>Dispatch git push --force-with-lease<cr>")
(set-key! :n "<Leader>gm" "<cmd>GitMessenger<cr>")
(set-key! :n "<Leader>gV" "<cmd>GV!<cr>")
(set-key! :n "<Leader>gv" "<cmd>TermExec cmd=\"glog; exit\"<cr>")

;; conjure
(doc-map! :n "<localleader>E" :silent "eval motion")
(doc-map! :n "<localleader>e" :silent "execute")
(doc-map! :n "<localleader>l" :silent "log")
(doc-map! :n "<localleader>r" :silent "reset")
(doc-map! :n "<localleader>t" :silent "test")

;; treesitter 
(map! [n] :<Leader>th ":TSHighlightCapturesUnderCursor<CR>")
(map! [n] :<Leader>tp ":TSPlayground<CR>")

;; truezen
(map! [n] :<leader>tz :<cmd>TZAtaraxis<CR>)
