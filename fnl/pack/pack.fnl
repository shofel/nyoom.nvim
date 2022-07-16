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
   (pack :tpope/vim-commentary)
   (pack :tpope/vim-dispatch)
   (pack :tpope/vim-eunuch)
   (pack :tpope/vim-fugitive)
   (pack :tpope/vim-projectionist)
   (pack :tpope/vim-repeat)
   (pack :tpope/vim-rsi)
   (pack :tpope/vim-surround)
   (pack :tpope/vim-unimpaired)

   ;; Follow conventions
   (pack :tpope/vim-sleuth)
   (pack :gpanders/editorconfig.nvim)

   ;; Lisps
   (pack :rktjmp/hotpot.nvim {:branch :master})
   (pack :gpanders/nvim-parinfer)
   (pack :Olical/conjure {:branch :develop}
                         :ft lisp-filetypes
                         :config (tset vim.g "conjure#extract#tree_sitter#enabled" true))
   (pack :guns/vim-sexp {:config (load-file "vim-sexp")})

   ;; Pairs
   (pack :windwp/nvim-autopairs {:config (call-setup :nvim-autopairs
                                                     {:disable_filetype lisp-filetypes})})

   ;; Various small plugins
   (pack :tommcdo/vim-exchange)
   (pack :ggandor/lightspeed.nvim {:config (load-file "lightspeed")})
   (pack :echasnovski/mini.nvim)

   ;; Visual
   (pack :lewis6991/gitsigns.nvim {:config (call-setup :gitsigns)
                                   :requires [(pack :nvim-lua/plenary.nvim)]})
   (pack :nvim-lualine/lualine.nvim {:config (load-file "lualine")})

   ;; Fzf
   (pack :ibhagwan/fzf-lua
         {:branch :main
          :requires [(pack :junegunn/fzf {:run (. vim.fn :fzf#install)})]
          :config (call-setup :fzf-lua {:border :single})})

   ;; Neorg
   (pack :nvim-neorg/neorg
         {:config (call-setup :neorg {:load {:core.defaults {}
                                             :core.norg.dirman {:config {:workspaces {:knowledge "~/notes/knowledge"
                                                                                      :gtd "~/notes/gtd"}}}}}) ;; TODO rename XXX to johnydecimal
          :requires [(pack :nvim-lua/plenary.nvim)]
          :after :nvim-treesitter})

   ;; Treesitter
   (pack :nvim-treesitter/nvim-treesitter
         {:config (load-file "treesitter")
          :requires [(pack :nvim-treesitter/playground {:cmd :TSPlayground})
                     (pack :nvim-treesitter/nvim-treesitter-refactor {:after :nvim-treesitter})
                     (pack :nvim-treesitter/nvim-treesitter-textobjects {:after :nvim-treesitter})
                     (pack "RRethy/nvim-treesitter-endwise" {:after :nvim-treesitter})
                     (pack :p00f/nvim-ts-rainbow {:after :nvim-treesitter})]})

   ;; LSP
   (pack :neovim/nvim-lspconfig
         {:config (load-file "lsp")
          :requires [(pack :j-hui/fidget.nvim {:after :nvim-lspconfig
                                               :config (call-setup :fidget)})]})

   ;; Trouble
   (pack :folke/trouble.nvim
         {:cmd :Trouble
          :config (call-setup :trouble {:icons false})})

   (pack :akinsho/toggleterm.nvim {:config (load-file "toggleterm")})

   ;; Look
   (pack :catppuccin/nvim {:as "catpuccin"
                           :config (λ []
                                      ; latte, frappe, macchiato, mocha
                                      (set vim.g.catppuccin_flavour "frappe")
                                      (vim.cmd "colorscheme catppuccin"))})
   (pack :rcarriga/nvim-notify {:config (load-file "notify")})
   (pack :Pocco81/TrueZen.nvim {:cmd     "TZAtaraxis"
                                :config (load-file "truezen")})
   (pack :norcalli/nvim-colorizer.lua
         {:config (load-file "colorizer")
          :event [:BufRead :BufNewFile]})])

;; Call `startup` with the plugins described.
(packer.startup (lambda [use]
                  (each [_ x (pairs plugins)]
                    (use x))))

(assure-compiled)
