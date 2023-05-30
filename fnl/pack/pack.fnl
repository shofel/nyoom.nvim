;; Helpers.

(λ pack [identifier ?options]
  "Make a mixed table to use it as an arg for `lazy.setup`."
  (doto (or ?options {})
    (tset 1 identifier)))

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
   (pack :folke/which-key.nvim {:config (call-setup :which-key)})

   ;; Tim Pope
   (pack "https://tpope.io/vim/dispatch.git")
   (pack "https://tpope.io/vim/eunuch.git")
   (pack "https://tpope.io/vim/repeat.git")
   (pack "https://tpope.io/vim/rsi.git")
   (pack "https://tpope.io/vim/unimpaired.git")
   (pack "https://tpope.io/vim/fugitive.git")

   ;; Follow conventions
   (pack "https://tpope.io/vim/sleuth.git")
   (pack :gpanders/editorconfig.nvim)

   ;; Lisps
   (pack :rktjmp/hotpot.nvim) ;; in sync with init.lua
   (pack :gpanders/nvim-parinfer)
   (pack :Olical/conjure {:branch :develop
                          :ft lisp-filetypes
                          :config (tset vim.g "conjure#extract#tree_sitter#enabled" true)})
   (pack :guns/vim-sexp {:ft lisp-filetypes
                         :config (load-file "vim-sexp")})

   ;; Languages
   (pack :fladson/vim-kitty)

   ;; Pairs
   (pack :windwp/nvim-autopairs {:config (call-setup :nvim-autopairs
                                                     {:disable_filetype lisp-filetypes})})

   (pack :tommcdo/vim-exchange)

   ;; Motion
   (pack :ggandor/leap.nvim {:name :leap})
   ; ggandor/flit.nvim is cool, but clever-f is a lot more mature and better tested.
   (pack :rhysd/clever-f.vim
         {:init (λ []
                   (set vim.g.clever_f_mark_char_color "LeapMatch")
                   (set vim.g.clever_f_fix_key_direction 1)
                   (set vim.g.clever_f_timeout_ms 500))})

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
          :config (call-setup :fzf-lua {:border :single})})

   ;; Neorg
   (pack :nvim-neorg/neorg
         {:build ":Neorg sync-parsers"
          :config (call-setup :neorg {:load {:core.defaults {}
                                             :core.dirman {:config {:workspaces {:knowledge "~/10-19-Computer/14-Notes"
                                                                                           :gtd "~/10-19-Computer/15-GTD"}}}}})
                                             ; :core.gtd.base {:config {:workspace :gtd}}}})
          :dependencies [(pack :nvim-lua/plenary.nvim)
                         (pack :nvim-treesitter)]})

   ;; Treesitter
   (pack :nvim-treesitter/nvim-treesitter
         {:config (load-file "treesitter")
          :build ":TSUpdate"
          :dependencies [(pack :nvim-treesitter/playground {:cmd :TSPlayground})
                         (pack :nvim-treesitter/nvim-treesitter-refactor)
                         (pack :nvim-treesitter/nvim-treesitter-textobjects)
                         (pack :RRethy/nvim-treesitter-textsubjects)
                         (pack "RRethy/nvim-treesitter-endwise")
                         (pack "ThePrimeagen/refactoring.nvim")
                         (pack "simrat39/symbols-outline.nvim" {:config (call-setup :symbols-outline)})]})

   ;; LSP
   (pack :neovim/nvim-lspconfig
         {:config (load-file "lsp")
          :dependencies [(pack :j-hui/fidget.nvim
                               {:config (call-setup :fidget)})]})

   ;; Autocompletion
   ;; TODO install deps and call start
   (pack :ms-jpq/coq_nvim {:branch "coq"
                           :dependencies (pack :nvim-lspconfig)
                           :build ":COQdeps"
                           :config (λ []
                                      (let [coq (require "coq")]
                                        (coq.Now "-s")))})

   ;; Trouble
   (pack :folke/trouble.nvim
         {:cmd :Trouble
          :config (call-setup :trouble {:icons false})})

   (pack :akinsho/toggleterm.nvim
         {:config (load-file "toggleterm")
          :keys [["<c-z>" "<cmd>ToggleTerm<cr>"]]})

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

   (pack :folke/noice.nvim {:dependencies [(pack :rcarriga/nvim-notify)
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
         {:config
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
         {:dependencies [(pack :kevinhwang91/promise-async)]
          :config (call-setup :ufo {:provider_selector
                                    (λ [bufnr filetype buftype]
                                       ["treesitter" "indent"])})})

   ;; Git
   (pack :lewis6991/gitsigns.nvim {:config (call-setup :gitsigns)
                                   :dependencies [(pack :nvim-lua/plenary.nvim)]})])

;; Call `setup` with the plugins described.
(let [lazy (require :lazy)]
  (lazy.setup plugins))
