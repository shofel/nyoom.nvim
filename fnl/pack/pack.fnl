;; Helpers.

(macro call-setup [name config]
  "To config a plugin: call the setup function."
  `(λ []
      ((. (require ,name) :setup)
       ,config)))

(macro load-file [name]
  "To config a plugin: load a file from pack/ folder."
  `#(require ,(.. "pack." name)))

;; Describe plugins.

(local lisp-filetypes ["fennel" "clojure" "lisp" "racket" "scheme"])

(local plugins
  [;; Set and document keymaps
   {:url "folke/which-key.nvim" :config true}

   ;; Tim Pope
   ["https://tpope.io/vim/eunuch.git"]
   ["https://tpope.io/vim/repeat.git"]
   ["https://tpope.io/vim/rsi.git"]
   ["https://tpope.io/vim/unimpaired.git"]

   {:url "https://tpope.io/vim/fugitive.git"
    :cmd ["G" "Git"]
    :keys [["<leader>gs" "<cmd>vert Git<cr>"]
           ["<leader>ga" "<cmd>Gwrite<cr>"]
           ["<leader>gp" "<cmd>TermExec cmd='git push'<cr>"]
           ["<leader>gP" "<cmd>G push --force-with-lease<cr>"]
           ["<leader>gm" "<cmd>GitMessenger<cr>"]]}

   ;; Follow conventions
   ["https://tpope.io/vim/sleuth.git"]

   ;; Lisps
   ["rktjmp/hotpot.nvim"] ;; in sync with init.lua
   ["gpanders/nvim-parinfer"]
   {:url "Olical/conjure"
    :event ["BufReadPre *.fnl" "BufReadPre *.clj"]
    :init (tset vim.g "conjure#extract#tree_sitter#enabled" true)}

   {:url "fladson/vim-kitty" :ft "kitty"}
   [:mbbill/undotree]

   ;; Pairs
   {:url "windwp/nvim-autopairs" :opts {:disable_filetype lisp-filetypes}}

   ["tommcdo/vim-exchange"]

   ;; Motion
   {:url "ggandor/leap.nvim"
    :keys (let [_ #{1 $1 2 $2 :mode [:n :x :o]}]
            [(_ "l" "<Plug>(leap-forward-to)")
             (_ "h" "<Plug>(leap-backward-to)")
             (_ "L" "<Plug>(leap-forward-till)")
             (_ "H" "<Plug>(leap-backward-till)")
             (_ "gs" "<Plug>(leap-cross-window)")])}

   {:url "ggandor/flit.nvim"
    :opts {:keys {:f "t" :t "T" ; forward
                  :F "f" :T "F"}}}

   {:url "echasnovski/mini.nvim"
    :config (λ []
               ((call-setup "mini.surround" {:mappings {:add "sa"
                                                        :delete "sd"
                                                        :find "st"
                                                        :find_left "sf"
                                                        :highlight "sh"
                                                        :replace "sr"
                                                        :update_n_lines "sn"}
                                             :n_lines 50}))
               ((call-setup "mini.comment")))}

   ;; Statusline
   {:url "nvim-lualine/lualine.nvim"
    :config (load-file "lualine")}

   ;; Fzf
   {:url "ibhagwan/fzf-lua"
    :branch :main
    :dependencies {:url "junegunn/fzf" :build ":call fzf#install()"}
    :opts {:border "single"}
    :cmd "FzfLua"
    :keys (let [_ (λ [lhs method] { 1 lhs
                                    2 (λ [?opts] ((. (require :fzf-lua) method) ?opts))
                                    :desc method})]
            [(_ "<leader>ff" :git_files)
             (_ "<leader>fF" :files {:fd-opts "--no-ignore --hidden"})
             (_ "<leader>fs" :git_status)
             (_ "<leader>fg" :live_grep)
             (_ "<leader>fh" :help_tags)
             (_ "<leader>fH" :command_history)
             (_ "<leader>fc" :commands)
             (_ "<leader>f," :builtin)
             (_ "<leader>fk" :keymaps)
             (_ "<leader>f." :resume)
             (_ "<leader>fw" :grep_cword)
             (_ "<leader>fW" :grep_cWORD)
             (_ "<leader>/"  :blines)
             (_ "<leader>bl" :buffers)])}

   ;; Neorg
   {:url "nvim-neorg/neorg"
    :ft "norg"
    :build ":Neorg sync-parsers"
    :opts {:load {:core.defaults {}
                  :core.dirman {:config {:workspaces {:knowledge "~/10-19-Computer/14-Notes"
                                                      :gtd "~/10-19-Computer/15-GTD"}}}}}
    :dependencies [{:url "nvim-lua/plenary.nvim"}
                   {:url "nvim-treesitter/nvim-treesitter"}]}

   ;; Treesitter
   {:url "nvim-treesitter/nvim-treesitter"
    :config (load-file "treesitter")
    :build ":TSUpdate"
    :dependencies [{:url "nvim-treesitter/playground"
                    :cmd :TSPlayground
                    :keys [["<Leader>tp" "<cmd>TSPlayground<cr>"]
                           ["<Leader>th" "<cmd>TSHighlightCapturesUnderCursor<cr>"]]}
                   ["nvim-treesitter/nvim-treesitter-refactor"]
                   ["nvim-treesitter/nvim-treesitter-textobjects"]
                   ["RRethy/nvim-treesitter-textsubjects"]
                   ["RRethy/nvim-treesitter-endwise"]
                   {:url "ThePrimeagen/refactoring.nvim"
                    :keys [{1 "<leader>r" :modes ["n" "x"]}]}
                   {:url "simrat39/symbols-outline.nvim" :config true}]}

   ;; LSP
   {:url "neovim/nvim-lspconfig"
    :config (load-file "lsp")
    :dependencies {:url "j-hui/fidget.nvim"
                   :config true}}

   ;; Autocompletion
   {:url "ms-jpq/coq_nvim"
    :branch "coq"
    :build ":COQdeps"
    :dependencies ["nvim-lspconfig"]
    :event "InsertEnter"
    :config (λ [] (vim.cmd ":COQnow -s"))}

   ;; Trouble
   {:url "folke/trouble.nvim"
    :cmd "Trouble"
    :opts {:icons false}}

   {:url "akinsho/toggleterm.nvim"
    :opts {:direction "float"
           :float_opts {:width vim.o.columns
                        :height vim.o.lines}}
    :keys [["<c-z>" "<cmd>1ToggleTerm<cr>"]
           {1 "<c-z>" 2 "" :mode "t"}
           ["<leader>tf" "<cmd>1ToggleTerm<cr>"]
           ["<leader>ts" "<cmd>2ToggleTerm<cr>"]]}

   ;; Look
   {:url "catppuccin/nvim"
    :name "catpuccin"
    :lazy false
    :priority 1000
    :config (λ []
               ((call-setup :catppuccin
                            {:custom_highlights {:MatchParen {:fg "#FE640B"
                                                              :bg "#000000"
                                                              :style ["bold"]}}}))
               (vim.cmd "colorscheme catppuccin-frappe"))}

   {:url "folke/noice.nvim"
    :lazy false
    :dependencies [{:url "rcarriga/nvim-notify"}
                   {:url "MunifTanjim/nui.nvim"}]
    :opts {; override markdown rendering so that **cmp** and other plugins use **Treesitter**
           :lsp {:override {:vim.lsp.util.convert_input_to_markdown_lines true
                            :vim.lsp.util.stylize_markdown true
                            :cmp.entry.get_documentation true}}
           ; you can enable a preset for easier configuration
           :presets {:bottom_search false ; use a classic bottom cmdline for search
                     :command_palette false ; position the cmdline and popupmenu together
                     :long_message_to_split true ; long messages will be sent to a split
                     :inc_rename false ; enables an input dialog for inc-rename.nvim
                     :lsp_doc_border false}}} ; add a border to hover docs and signature help

   {:url "rcarriga/nvim-notify"
    :config (λ []
               (set vim.notify (require :notify))
               ((call-setup "notify" {:stages :fade_in_slide_out
                                      :fps 60
                                      :icons {:ERROR ""
                                              :WARN ""
                                              :INFO ""
                                              :DEBUG ""
                                               :TRACE "✎"}})))}

   {:url "Pocco81/TrueZen.nvim"
    :cmd     "TZAtaraxis"
    :keys [["<leader>tz" "<cmd>TZAtaraxis<cr>"]]
    :opts {:ui {:bottom {:cmdheight 0
                          :laststatus 0
                          :ruler true
                          :showmode false
                          :showcmd false}
                :left {:number false
                       :relativenumber false
                       :signcolumn :no}}
           :modes {:ataraxis {:left_padding 32
                              :right_padding 32
                              :top_padding 1
                              :bottom_padding 1
                              :ideal_writing_area_width {1 0}
                              :auto_padding false
                              :bg_configuration true}
                   :focus {:margin_of_error 5
                           :focus_method :experimental}}}}


   {:url "norcalli/nvim-colorizer.lua"
    :event [:BufRead :BufNewFile]
    :config (call-setup "colorizer" ["*"] {:RGB true
                                           :RRGGBB true
                                           :names true
                                           :RRGGBBAA true
                                           :rgb_fn true
                                           :hsl_fn true
                                           :mode :foreground})}

   ;; Folds
   {:url "kevinhwang91/nvim-ufo"
    :event "BufRead"
    :dependencies [["kevinhwang91/promise-async"]]
    :opts {:provider_selector (λ [bufnr filetype buftype]
                                 ["treesitter" "indent"])}}

   {:url "dstein64/vim-startuptime"
    :cmd "StartupTime"
    :config (λ [] (set vim.g.startuptime_tries 10))}

   ;; Git
   {:url "lewis6991/gitsigns.nvim"
    :config true
    :dependencies [{:url "nvim-lua/plenary.nvim"}]}])

;; Call `setup` with the plugins described.
(let [lazy (require :lazy)]
  (lazy.setup plugins {:defaluts {:lazy true}}))
