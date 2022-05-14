(local packer (require :packer))

(packer.init {:autoremove true}
        :git {:clone_timeout 300}
        :profile {:enable true :threshold 0}
        :display {:header_lines 2
                  :title " packer.nvim"
                  :open_fn (λ open_fn []
                             (local {: float} (require :packer.util))
                             (float {:border :solid}))})

;; Helpers.

(λ pack [identifier ?options]
  "Make a mixed table to use it as an arg for `packer.use`."
  (doto (or ?options {})
    (tset 1 identifier)))

;; TODO remove as unused
(macro use-p [identifier ?options]
  "Call `use` function with a mixed table.
   Use it inside callback for packer.startup."
  `(use (pack ,identifier ,?options)))

(macro call-setup [name config]
  "To config a plugin: call the setup function."
  `(λ []
      ((. (require ,name) :setup)
       ,config)))

(macro load-file [name]
  "To config a plugin: load a file from pack/ folder."
  `#(require ,(.. "pack." name)))

;; There are some plugins we only want to load for lisps. Heres a list of lispy filetypes I use
(local lisp-ft [:fennel :clojure :lisp :racket :scheme])

(local plugins
  [[:wbthomason/packer.nvim]
   ;; Set and document keymaps
   [:folke/which-key.nvim {:config (call-setup :which-key)}]

   ;; Tim Pope
   [:tpope/vim-commentary]
   [:tpope/vim-dispatch]
   [:tpope/vim-eunuch]
   [:tpope/vim-fugitive]
   [:tpope/vim-projectionist]
   [:tpope/vim-repeat]
   [:tpope/vim-rsi]
   [:tpope/vim-surround]
   [:tpope/vim-unimpaired]

   ;; Follow conventions
   [:tpope/vim-sleuth]
   [:gpanders/editorconfig.nvim]

   ;; lispy configs
   [:rktjmp/hotpot.nvim {:branch :master}]
   [:gpanders/nvim-parinfer]
   [:Olical/conjure {:branch :develop :ft lisp-ft}]
   [:guns/vim-sexp]
   [:tpope/vim-sexp-mappings-for-regular-people]

   ;; Pairs
   [:windwp/nvim-autopairs {:config (call-setup :nvim-autopairs)}]

   ;; Various small plugins
   [:gbprod/substitute.nvim]
   [:ggandor/lightspeed.nvim {:config (load-file "lightspeed")}]
   [:echasnovski/mini.nvim]

   ;; Visual
   [:lewis6991/gitsigns.nvim {:config (call-setup :gitsigns)
                              :requires [(pack :nvim-lua/plenary.nvim)]}]
   [:nvim-lualine/lualine.nvim {:config (load-file "lualine")}]

   ;; Fzf
   [:ibhagwan/fzf-lua
     {:branch :main
      :requires [(pack :junegunn/fzf {:run (. vim.fn :fzf#install)})]
      :config (call-setup :fzf-lua {:border :single})}]

   ;; tree-sitter
   [:nvim-treesitter/nvim-treesitter
     {:run ":TSUpdate"
      :config (load-file "treesitter")
      :event [:BufRead :BufNewFile]
      :requires [(pack :p00f/nvim-ts-rainbow {:event [:BufRead :BufNewFile]})
                 (pack :nvim-treesitter/playground {:cmd :TSPlayground})
                 (pack :nvim-treesitter/nvim-treesitter-textobjects {:event [:BufRead :BufNewFile]})]}]
                 ;; TODO (pack "RRethy/nvim-treesitter-endwise")

   ;; lsp
   [:neovim/nvim-lspconfig
     {:config (load-file "lsp")
      :requires [(pack :j-hui/fidget.nvim {:after :nvim-lspconfig
                                           :config (call-setup :fidget)})]}]

   ;; trouble
   [:folke/trouble.nvim
     {:cmd :Trouble
      :config (call-setup :trouble {:icons false})}]

   [:hrsh7th/nvim-cmp
     {:config (load-file "cmp")
      :wants [:LuaSnip]
      :event [:InsertEnter :CmdlineEnter]
      :requires [(pack :hrsh7th/cmp-path {:after :nvim-cmp})
                 (pack :hrsh7th/cmp-buffer {:after :nvim-cmp})
                 (pack :hrsh7th/cmp-cmdline {:after :nvim-cmp})
                 (pack :hrsh7th/cmp-nvim-lsp {:after :nvim-cmp})
                 (pack :onsails/lspkind-nvim {:module :lspkind})
                 (pack :PaterJason/cmp-conjure {:after :conjure})
                 (pack :saadparwaiz1/cmp_luasnip {:after :nvim-cmp})
                 (pack :lukas-reineke/cmp-under-comparator {:module :cmp-under-comparator})
                 (pack :L3MON4D3/LuaSnip {:event :InsertEnter
                                          :wants :friendly-snippets
                                          :config (load-file "luasnip")
                                          :requires [(pack :rafamadriz/friendly-snippets
                                                           {:opt false})]})]}]

   ;; aesthetics
   [:RRethy/nvim-base16 {:config (load-file "base16")}]
   [:rcarriga/nvim-notify {:config (load-file "notify")}]
   [:Pocco81/TrueZen.nvim {:cmd     "TZAtaraxis"
                           :config (load-file "truezen")}]
   [:norcalli/nvim-colorizer.lua
     {:config (load-file "colorizer")
      :event [:BufRead :BufNewFile]}]])

;; Call `startup` with prepaired callback.
(packer.startup (lambda [use]
                  (each [_ x (pairs plugins)]
                    (use (pack (unpack x))))))
