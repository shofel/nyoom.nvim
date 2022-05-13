(local {: use-package! : unpack! : pack} (require :utils.plugins))

;; Setup packer
(local {: init} (require :packer))
(init {:autoremove true
       :git {:clone_timeout 300}
       :profile {:enable true :threshold 0}
       :display {:header_lines 2
                 :title " packer.nvim"
                 :open_fn (λ open_fn []
                            (local {: float} (require :packer.util))
                            (float {:border :solid}))}})

(macro call-setup [name config]
  `(λ []
      ((. (require ,name) :setup)
       ,config)))

;; There are some plugins we only want to load for lisps. Heres a list of lispy filetypes I use
(local lisp-ft [:fennel :clojure :lisp :racket :scheme])

;; Packer can manage itself
(use-package! :wbthomason/packer.nvim)

;; Set and document keymaps
(use-package! :folke/which-key.nvim {:config (call-setup :which-key)})

;; Tim Pope
(use-package! :tpope/vim-commentary)
(use-package! :tpope/vim-dispatch)
(use-package! :tpope/vim-eunuch)
(use-package! :tpope/vim-fugitive)
(use-package! :tpope/vim-projectionist)
(use-package! :tpope/vim-repeat)
(use-package! :tpope/vim-rsi)
; TODO (use-package! :tpope/vim-surround)
(use-package! :tpope/vim-unimpaired)

;; Follow conventions
(use-package! :tpope/vim-sleuth)
(use-package! :gpanders/editorconfig.nvim)

;; lispy configs
(use-package! :rktjmp/hotpot.nvim {:branch :master})
(use-package! :gpanders/nvim-parinfer)
(use-package! :Olical/conjure {:branch :develop :ft lisp-ft})
(use-package! "guns/vim-sexp")
(use-package! "tpope/vim-sexp-mappings-for-regular-people")

;; Pairs
(use-package! "RRethy/nvim-treesitter-endwise")
(use-package! "windwp/nvim-autopairs" {:config (call-setup :nvim-autopairs)})

;; Various small plugins
(use-package! "gbprod/substitute.nvim")
(use-package! :ggandor/lightspeed.nvim {:config-file "lightspeed"})
(use-package! :echasnovski/mini.nvim)

;; Visual
(use-package! :lewis6991/gitsigns.nvim {:config (call-setup :gitsigns)
                                        :requires [(pack :nvim-lua/plenary.nvim)]})
; TODO (use-package! :nvim-lualine/lualine.nvim {:config-file "lualine"})

;; Fzf
(use-package! :ibhagwan/fzf-lua
              {:branch :main
               :requires [(pack :junegunn/fzf {:run (. vim.fn :fzf#install)})]
               :config (call-setup :fzf-lua {:border :single})})

;; tree-sitter
(use-package! :nvim-treesitter/nvim-treesitter
              {:run ":TSUpdate"
               :config-file :treesitter
               :event [:BufRead :BufNewFile]
               :requires [(pack :p00f/nvim-ts-rainbow {:event [:BufRead :BufNewFile]})
                          (pack :nvim-treesitter/playground {:cmd :TSPlayground})
                          (pack :nvim-treesitter/nvim-treesitter-textobjects {:event [:BufRead :BufNewFile]})]})

;; lsp
(use-package! :neovim/nvim-lspconfig
              {:config-file :lsp
               :requires [(pack :j-hui/fidget.nvim {:after :nvim-lspconfig
                                                    :config (call-setup :fidget)})]})

;; trouble
(use-package! :folke/trouble.nvim
              {:cmd :Trouble
               :config (call-setup :trouble {:icons false})})

;; completion/copilot
(use-package! :zbirenbaum/copilot.lua
              {:event :InsertEnter
               :config (λ []
                         (vim.schedule (call-setup :copilot)))})

(use-package! :hrsh7th/nvim-cmp
              {:config-file :cmp
               :wants [:LuaSnip]
               :event [:InsertEnter :CmdlineEnter]
               :requires [(pack :hrsh7th/cmp-path {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-buffer {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-cmdline {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-nvim-lsp {:after :nvim-cmp})
                          (pack :onsails/lspkind-nvim {:module :lspkind})
                          (pack :PaterJason/cmp-conjure {:after :conjure})
                          (pack :saadparwaiz1/cmp_luasnip {:after :nvim-cmp})
                          (pack :zbirenbaum/copilot-cmp {:after :copilot.lua})
                          (pack :lukas-reineke/cmp-under-comparator {:module :cmp-under-comparator})
                          (pack :L3MON4D3/LuaSnip {:event :InsertEnter
                                                   :wants :friendly-snippets
                                                   :config-file :luasnip
                                                   :requires [(pack :rafamadriz/friendly-snippets
                                                                    {:opt false})]})]})

;; aesthetics
(use-package! :RRethy/nvim-base16 {:config-file :base16})
(use-package! :rcarriga/nvim-notify {:config-file :notify})
(use-package! :Pocco81/TrueZen.nvim {:cmd     "TZAtaraxis"
                                     :config-file "truezen"})
(use-package! :norcalli/nvim-colorizer.lua {:config-file "colorizer" :event [:BufRead :BufNewFile]})

;; At the end of the file, the unpack! macro is called to initialize packer and pass each package to the packer.nvim plugin.
(unpack!)
