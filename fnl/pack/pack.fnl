(local packer (require :packer))

;; Manage compilation.

(local compile-path (.. (vim.fn.stdpath :config)
                        "/lua/packer_compiled.lua"))

(λ assure-compiled []
  (let [compiled? (= (vim.fn.filereadable compile-path) 1)
        load-compiled #(require :packer_compiled)]
   (if compiled?
       (load-compiled)
       (packer.sync))))

;; Setup packer
(packer.init {:max_jobs 50
              :autoremove true
              :git {:clone_timeout 300}
              :profile {:enable true}
              :compile_path compile-path
              :auto_reload_compiled true
              :display {:header_lines 2
                        :open_fn (λ open_fn []
                                         (local {: float} (require :packer.util))
                                         (float {:border :solid}))}})
;; Helpers.

(λ pack [identifier ?options]
  "Make a mixed table to use it as an arg for `packer.use`."
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
  [(pack :wbthomason/packer.nvim)
   ;; Set and document keymaps
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
   (pack :Olical/conjure {:branch :develop}
                         :ft lisp-filetypes
                         :config (tset vim.g "conjure#extract#tree_sitter#enabled" true))
   (pack :guns/vim-sexp {:config (load-file "vim-sexp")})

   ;; Languages
   (pack :fladson/vim-kitty)

   ;; Pairs
   (pack :windwp/nvim-autopairs {:config (call-setup :nvim-autopairs
                                                     {:disable_filetype lisp-filetypes})})

   (pack :tommcdo/vim-exchange)

   ;; Motion
   (pack :ggandor/leap.nvim {:as :leap})
   ; ggandor/flit.nvim is cool, but clever-f is a lot more mature and better tested.
   (set vim.g.clever_f_mark_char_color "LeapMatch")
   (set vim.g.clever_f_fix_key_direction 1)
   (pack :rhysd/clever-f.vim)

   (pack :echasnovski/mini.nvim {:config (λ []
                                            ((call-setup "mini.surround"))
                                            ((call-setup "mini.comment")))})

   ;; Statusline
   (pack :nvim-lualine/lualine.nvim {:config (load-file "lualine")})

   ;; Fzf
   (pack :ibhagwan/fzf-lua
         {:branch :main
          :requires [(pack :junegunn/fzf {:run ":call fzf#install()"})]
          :config (call-setup :fzf-lua {:border :single})})

   ;; Neorg
   ;; TODO call :Neorg sync-parsers
   (pack :nvim-neorg/neorg
         {:config (call-setup :neorg {:load {:core.defaults {}
                                             :core.norg.dirman {:config {:workspaces {:knowledge "~/10-19-Computer/14-Notes"}}}}})
                                                                                      ; :gtd "~/10-19-Computer/15-GTD"}}}}})
                                             ; :core.gtd.base {:config {:workspace :gtd}}}})
          :requires [(pack :nvim-lua/plenary.nvim)]
          :after :nvim-treesitter})

   ;; Treesitter
   (pack :nvim-treesitter/nvim-treesitter
         {:config (load-file "treesitter")
          :run ":TSUpdate"
          :requires [(pack :nvim-treesitter/playground {:cmd :TSPlayground})
                     (pack :nvim-treesitter/nvim-treesitter-refactor {:after :nvim-treesitter})
                     (pack :nvim-treesitter/nvim-treesitter-textobjects {:after :nvim-treesitter})
                     (pack :RRethy/nvim-treesitter-textsubjects {:after :nvim-treesitter})
                     (pack "RRethy/nvim-treesitter-endwise" {:after :nvim-treesitter})
                     (pack "ThePrimeagen/refactoring.nvim" {:after :nvim-treesitter})]})

   ;; LSP
   (pack :neovim/nvim-lspconfig
         {:config (load-file "lsp")
          :requires [(pack :j-hui/fidget.nvim
                           {:after :nvim-lspconfig
                            :config (call-setup :fidget)})]})

   ;; Autocompletion
   ;; TODO install deps and call start
   (pack :ms-jpq/coq_nvim {:branch "coq"
                           :after :nvim-lspconfig
                           :run ":COQdeps"
                           :config (λ []
                                      (let [coq (require "coq")]
                                        ; (coq.deps) ; only once after install
                                        (coq.Now "-s")))})

   ;; Trouble
   (pack :folke/trouble.nvim
         {:cmd :Trouble
          :config (call-setup :trouble {:icons false})})

   (pack :akinsho/toggleterm.nvim {:config (load-file "toggleterm")})

   ;; Look
   (pack :catppuccin/nvim {:as "catpuccin"
                           :config (λ []
                                      ((call-setup :catppuccin
                                                   {:custom_highlights {:MatchParen {:fg "#FE640B"
                                                                                     :bg "#000000"
                                                                                     :style ["bold"]}}}))
                                      ; [latte frappe macchiato mocha]
                                      (vim.cmd "colorscheme catppuccin-frappe"))})

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
         {:requires [(pack :kevinhwang91/promise-async)]
          :config (call-setup :ufo {:provider_selector
                                    (λ [bufnr filetype buftype]
                                       ["treesitter" "indent"])})})

   ;; Git
   (pack :lewis6991/gitsigns.nvim {:config (call-setup :gitsigns)
                                   :requires [(pack :nvim-lua/plenary.nvim)]})])

;; Call `startup` with the plugins described.
(packer.startup (lambda [use]
                  (each [_ x (pairs plugins)]
                    (use x))))

(assure-compiled)
