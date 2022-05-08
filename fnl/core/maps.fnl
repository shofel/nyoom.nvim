(import-macros {: map! : doc-map!} :macros.keybind-macros)
(import-macros {: lazy-require!} :macros.package-macros)

;; who actually uses C-z or ex mode?
(map! :n "<C-z>" :<Nop>)
(map! :n "Q"     :<Nop>)

;; move between windows
;; ?TODO

;;
(map! :n "<leader>s" "<cmd>w<cr>" "Save file")
(map! :n "<leader>n" "<cmd>nohlsearch<cr>")

(doc-map! :n "<leader>w" :silent "windows")
(map! :n "<leader>wo" "<cmd>only<cr>")
(map! :n "<leader>wc" "<cmd>bwipeout<cr>")

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

(vim.keymap.set :n "<leader>ff" (fzf :git_files))
(vim.keymap.set :n "<leader>fs" (fzf :git_status))
(vim.keymap.set :n "<leader>fF" (fzf-files))
(vim.keymap.set :n "<leader>fg" (fzf :live_grep))
(vim.keymap.set :n "<leader>fh" (fzf :help_tags))
(vim.keymap.set :n "<leader>fH" (fzf :command_history))
(vim.keymap.set :n "<leader>fc" (fzf :commands))
(vim.keymap.set :n "<leader>f," (fzf :builtin))
(vim.keymap.set :n "<leader>fk" (fzf :keymaps))
(vim.keymap.set :n "<leader>f." (fzf :resume))
(vim.keymap.set :n "<leader>fw" (fzf :grep_cword))
(vim.keymap.set :n "<leader>fW" (fzf :grep_cWORD))
(vim.keymap.set :n "<leader>/"  (fzf :blines))
(vim.keymap.set :n "<leader>b"  (fzf :buffers))

;; git
(doc-map!       :n "<leader>g"  :silent "git")
(vim.keymap.set :n "<Leader>gs" "<cmd>vert Git<cr>")
(vim.keymap.set :n "<Leader>ga" "<cmd>Gwrite<cr>")
(vim.keymap.set :n "<Leader>gp" "<cmd>Dispatch git push<cr>")
(vim.keymap.set :n "<Leader>gP" "<cmd>Dispatch git push --force-with-lease<cr>")
(vim.keymap.set :n "<Leader>gm" "<cmd>GitMessenger<cr>")
(vim.keymap.set :n "<Leader>gV" "<cmd>GV!<cr>")
(vim.keymap.set :n "<Leader>gv" "<cmd>TermExec cmd=\"glog; exit\"<cr>")

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
