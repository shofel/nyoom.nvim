(import-macros {: map! : doc-map!} :macros.keybind-macros)
(import-macros {: lazy-require!} :macros.package-macros)

;; Document top level keys with which-key
(doc-map! :n "<leader>:" :silent :M-x)

;; who actually uses C-z or ex mode?
(map! [n] :<C-z> :<Nop>)
(map! [n] :Q :<Nop>)

;;jk/jj for escape. Some people like this, others don't
(map! [i] :jk :<esc>)

;; easier command line mode
(map! [n] ";" ":")
(map! [v] ";" ":")

;; move between windows
(map! [n] :<C-h> :<C-w>h)
(map! [n] :<C-j> :<C-w>j)
(map! [n] :<C-k> :<C-w>k)
(map! [n] :<C-l> :<C-w>l)

;; Resize splits
(map! [n] :<C-Up> "<cmd>resize +2<cr>")
(map! [n] :<C-Down> "<cmd>resize -2<cr>")
(map! [n] :<C-Left> "<cmd>vertical resize +2<cr>")
(map! [n] :<C-Right> "<cmd>vertical resize -2<cr>")

;; wrap/unwrap
(map! [n] :<leader>tw "<cmd>set wrap!<CR>")

;;
(map! [n] "<leader>s" "<cmd>w<cr>" "Save file")
(map! [n] "<leader>n" "<cmd>nohlsearch<cr>")
(map! [n] "<leader>o" "<cmd>only<cr>")

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

;; treesitter 
(map! [n] :<Leader>th ":TSHighlightCapturesUnderCursor<CR>")
(map! [n] :<Leader>tp ":TSPlayground<CR>")

;; nvimtree
(map! [n] :<leader>op :<cmd>NvimTreeToggle<CR>)

;; truezen
(map! [n] :<leader>tz :<cmd>TZAtaraxis<CR>)
