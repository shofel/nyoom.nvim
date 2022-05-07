(require-macros :macros.keybind-macros)

;; Document leader keys with which-key
(doc-map! :n :<leader>f :silent "fzf")

;; Document top level keys with which-key
(doc-map! :n "<leader>:" :silent :M-x)
(doc-map! :n :<leader><space> :silent "Project Fuzzy Search")

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
(vim.keymap.set [:n] "<leader>s" "<cmd>w<cr>" {:desc "Save file"})
(vim.keymap.set [:n] "<leader>n" ":nohlsearch<cr>")

;; fzf-lua
(lambda fzf [x]
  "Given a topic `x`, return lua function and a description."
  (let [fzf-lua (require :fzf-lua)]
    (values (. fzf-lua x)
            {:desc x})))

(lambda fzf-files []
  (let [{: files} (require :fzf-lua)]
    (values (lambda [] (files {:fd-opts "--no-ignore --hidden"}))
            {:desc "all files"})))

(vim.keymap.set [:n] "<leader>ff" (fzf "git_files"))
(vim.keymap.set [:n] "<leader>fs" (fzf "git_status"))
(vim.keymap.set [:n] "<leader>fF" (fzf-files))
(vim.keymap.set [:n] "<leader>fg" (fzf "live_grep"))
(vim.keymap.set [:n] "<leader>fh" (fzf "help_tags"))
(vim.keymap.set [:n] "<leader>fH" (fzf "command_history"))
(vim.keymap.set [:n] "<leader>fc" (fzf "commands"))
(vim.keymap.set [:n] "<leader>f," (fzf "builtin"))
(vim.keymap.set [:n] "<leader>fk" (fzf "keymaps"))
(vim.keymap.set [:n] "<leader>f." (fzf "resume"))
(vim.keymap.set [:n] "<leader>fw" (fzf "grep_cword"))
(vim.keymap.set [:n] "<leader>fW" (fzf "grep_cWORD"))
(vim.keymap.set [:n] "<leader>/"  (fzf "blines"))
(vim.keymap.set [:n] "<leader>b"  (fzf "buffers"))

;; treesitter 
(map! [n] :<Leader>th ":TSHighlightCapturesUnderCursor<CR>")
(map! [n] :<Leader>tp ":TSPlayground<CR>")

;; nvimtree
(map! [n] :<leader>op :<cmd>NvimTreeToggle<CR>)

;; truezen
(map! [n] :<leader>tz :<cmd>TZAtaraxis<CR>)
