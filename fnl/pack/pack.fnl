;; Helpers.

(λ pack [identifier ?options]
   "Make a mixed table to use it as an arg for `lazy.setup`."
   (doto (or ?options {})
     (tset 1 identifier)))

(λ key [lhs rhs ?opts]
   "Make a LazyKey spec."
   (doto (or ?opts {})
     (tset 1 lhs)
     (tset 2 rhs)))

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
   (pack :folke/which-key.nvim {:event "VeryLazy" :config (call-setup :which-key)})

   ;; Tim Pope
   (pack "https://tpope.io/vim/eunuch.git" {:cmd ["MkDir" "Chmod"]})
   (pack "https://tpope.io/vim/repeat.git")
   (pack "https://tpope.io/vim/rsi.git")
   (pack "https://tpope.io/vim/unimpaired.git"
         {:keys [["["] ["]"]]})

   (pack "https://tpope.io/vim/fugitive.git"
         {:cmd ["G" "Git"]
          :keys [["<leader>gs" "<cmd>vert Git<cr>"]
                 ["<leader>ga" "<cmd>Gwrite<cr>"]
                 ["<leader>gp" "<cmd>TermExec cmd='git push'<cr>"]
                 ["<leader>gP" "<cmd>G push --force-with-lease<cr>"]
                 ["<leader>gm" "<cmd>GitMessenger<cr>"]]})

   ;; Follow conventions
   (pack "https://tpope.io/vim/sleuth.git")

   ;; Lisps
   (pack :rktjmp/hotpot.nvim) ;; in sync with init.lua
   (pack :gpanders/nvim-parinfer)
   (pack :Olical/conjure {:event "BufReadPre"
                          :init (tset vim.g "conjure#extract#tree_sitter#enabled" true)})

   (pack :fladson/vim-kitty {:ft "kitty"})
   (pack :mbbill/undotree {:cmd :UndotreeToggle})

   ;; Pairs
   (pack :windwp/nvim-autopairs {:config (call-setup :nvim-autopairs
                                                     {:disable_filetype lisp-filetypes})})

   (pack :tommcdo/vim-exchange)

   ;; Motion
   (pack :ggandor/leap.nvim
         {:keys [(key "l" "<Plug>(leap-forward-to)"    {:mode [:n :x :o]})
                 (key "h" "<Plug>(leap-backward-to)"   {:mode [:n :x :o]})
                 (key "L" "<Plug>(leap-forward-till)"  {:mode [:n :x :o]})
                 (key "H" "<Plug>(leap-backward-till)" {:mode [:n :x :o]})
                 (key "gs" "<Plug>(leap-cross-window)" {:mode [:n :x :o]})]})

   (pack :ggandor/flit.nvim
         {:opts {:keys {:f "t" :t "T" ; forward
                        :F "f" :T "F"}}})

   (pack :echasnovski/mini.nvim
         {:config (λ []
                      ((call-setup "mini.surround" {:mappings {:add "sa"
                                                               :delete "sd"
                                                               :find "st"
                                                               :find_left "sf"
                                                               :highlight "sh"
                                                               :replace "sr"
                                                               :update_n_lines "sn"}
                                                    :n_lines 50}))
                      ((call-setup "mini.comment")))})

   ;; Statusline
   (pack :nvim-lualine/lualine.nvim {:config (load-file "lualine")})

   ;; Fzf
   (pack :ibhagwan/fzf-lua
         {:branch :main
          :dependencies [(pack :junegunn/fzf {:build ":call fzf#install()"})]
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
                   (_ "<leader>bl" :buffers)])})

   ;; Neorg
   (pack :nvim-neorg/neorg
         {:ft "norg"
          :build ":Neorg sync-parsers"
          :opts {:load {:core.defaults {}
                        :core.dirman {:config {:workspaces {:knowledge "~/10-19-Computer/14-Notes"
                                                            :gtd "~/10-19-Computer/15-GTD"}}}}}
          :dependencies [(pack :nvim-lua/plenary.nvim)
                         (pack :nvim-treesitter/nvim-treesitter)]})

   ;; Treesitter
   (pack :nvim-treesitter/nvim-treesitter
         {:event "VeryLazy"
          :config (load-file "treesitter")
          :build ":TSUpdate"
          :dependencies [(pack :nvim-treesitter/playground
                               {:cmd :TSPlayground
                                :keys [(key "<Leader>tp" "<cmd>TSPlayground<cr>")
                                       (key "<Leader>th" "<cmd>TSHighlightCapturesUnderCursor<cr>")]})
                         (pack :nvim-treesitter/nvim-treesitter-refactor)
                         (pack :nvim-treesitter/nvim-treesitter-textobjects)
                         (pack :RRethy/nvim-treesitter-textsubjects)
                         (pack "RRethy/nvim-treesitter-endwise")
                         (pack "ThePrimeagen/refactoring.nvim"
                               {:keys [{1 "<leader>r" :modes ["n" "x"]}]})
                         (pack "simrat39/symbols-outline.nvim" {:config (call-setup :symbols-outline)})]})

   ;; LSP
   (pack :neovim/nvim-lspconfig
         {:event "VeryLazy"
          :config (load-file "lsp")
          :dependencies [(pack :j-hui/fidget.nvim
                               {:config (call-setup :fidget)})]})

   ;; Autocompletion
   (pack :ms-jpq/coq_nvim {:branch "coq"
                           :build ":COQdeps"
                           :dependencies (pack :nvim-lspconfig)
                           :event "InsertEnter"
                           :config (λ [] (vim.cmd ":COQnow -s"))})

   ;; Trouble
   (pack :folke/trouble.nvim
         {:cmd :Trouble
          :config (call-setup :trouble {:icons false})})

   (pack :akinsho/toggleterm.nvim
         {:opts {:direction "float"
                 :float_opts {:width vim.o.columns
                              :height vim.o.lines}}
          :keys [(key "<c-z>" "<cmd>1ToggleTerm<cr>")
                 (key "<c-z>" "" {:mode "t"})
                 (key "<leader>tf" "<cmd>1ToggleTerm<cr>")
                 (key "<leader>ts" "<cmd>2ToggleTerm<cr>")]})

   ;; Look
   (pack :catppuccin/nvim {:name "catpuccin"
                           :lazy false
                           :priority 1000
                           :config (λ []
                                      ((call-setup :catppuccin
                                                   {:custom_highlights {:MatchParen {:fg "#FE640B"
                                                                                     :bg "#000000"
                                                                                     :style ["bold"]}}}))
                                      (vim.cmd "colorscheme catppuccin-frappe"))})

   (pack :folke/noice.nvim {:event "VeryLazy"
                            :dependencies [(pack :rcarriga/nvim-notify)
                                           (pack :MunifTanjim/nui.nvim)]
                            :config (call-setup :noice
                                                {; override markdown rendering so that **cmp** and other plugins use **Treesitter**
                                                 :lsp {:override {:vim.lsp.util.convert_input_to_markdown_lines true
                                                                  :vim.lsp.util.stylize_markdown true
                                                                  :cmp.entry.get_documentation true}}
                                                 ; you can enable a preset for easier configuration
                                                 :presets {:bottom_search false ; use a classic bottom cmdline for search
                                                           :command_palette false ; position the cmdline and popupmenu together
                                                           :long_message_to_split true ; long messages will be sent to a split
                                                           :inc_rename false ; enables an input dialog for inc-rename.nvim
                                                           :lsp_doc_border false}})}) ; add a border to hover docs and signature help

   (pack :rcarriga/nvim-notify
         {:events "VeryLazy"
          :config
           (λ []
              (set vim.notify (require :notify))
              ((call-setup "notify" {:stages :fade_in_slide_out
                                     :fps 60
                                     :icons {:ERROR ""
                                             :WARN ""
                                             :INFO ""
                                             :DEBUG ""
                                             :TRACE "✎"}})))})

   (pack :Pocco81/TrueZen.nvim
         {:cmd     "TZAtaraxis"
          :keys [(key "<leader>tz" "<cmd>TZAtaraxis<cr>" {:desc "truezen"})]
          :config (call-setup :true-zen
                              {:ui {:bottom {:cmdheight 0
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
                                               :focus_method :experimental}}})})


   (pack :norcalli/nvim-colorizer.lua
          {:event [:BufRead :BufNewFile]
           :config (call-setup "colorizer" ["*"] {:RGB true
                                                  :RRGGBB true
                                                  :names true
                                                  :RRGGBBAA true
                                                  :rgb_fn true
                                                  :hsl_fn true
                                                  :mode :foreground})})


   ;; Folds
   (pack :kevinhwang91/nvim-ufo
         {:event "BufRead"
          :dependencies [(pack :kevinhwang91/promise-async)]
          :opts {:provider_selector (λ [bufnr filetype buftype]
                                      ["treesitter" "indent"])}})

   (pack :dstein64/vim-startuptime
         {:cmd "StartupTime"
          :config (λ [] (set vim.g.startuptime_tries 10))})

   ;; Git
   (pack :lewis6991/gitsigns.nvim {:event "VeryLazy"
                                   :config true
                                   :dependencies [(pack :nvim-lua/plenary.nvim)]})])

;; Call `setup` with the plugins described.
(let [lazy (require :lazy)]
  (lazy.setup plugins))
