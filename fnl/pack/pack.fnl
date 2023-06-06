;; Helpers.

(macro call-setup [name config]
  "To config a plugin: call the setup function."
  `(λ []
      ((. (require ,name) :setup)
       ,config)))

(macro load-file [name]
  "To config a plugin: load a file from pack/ folder."
  `#(require ,(.. "pack." name)))

(λ gh [x] (.. "https://github.com/" x ".git"))

;; Describe plugins.

(local lisp-filetypes ["fennel" "clojure" "lisp" "racket" "scheme"])

(local plugins
  [;; Set and document keymaps
   {:url (gh "folke/which-key.nvim") :config true}

   ;; Tim Pope
   {:url "https://tpope.io/vim/eunuch.git"}
   {:url "https://tpope.io/vim/rsi.git"}

   {:url "https://tpope.io/vim/unimpaired.git"
    :keys [["["]
           ["]"]
           {1 "<leader>k" 2 "[" :remap true :desc "Unimpared prev"}
           {1 "<leader>j" 2 "]" :remap true :desc "Unimpared next"}]
    :config #(let [wk (require "which-key")]
               ; TODO sort them out
               (wk.register {"[d" [vim.diagnostic.goto_prev "Previous diagnostic"]
                             "]d" [vim.diagnostic.goto_next "Next diagnostic"]
                             "[c" ["<cmd>Gitsigns prev_hunk<cr>" "prev hunk"]
                             "]c" ["<cmd>Gitsigns next_hunk<cr>" "next hunk"]}
                            {:noremap false}))}

   {:url "https://tpope.io/vim/fugitive.git"
    :cmd ["G" "Git"]
    :keys [{1 "<leader>g" :desc "git"}]
    :config #(let [wk (require "which-key")]
               (wk.register
                 {"<leader>g" {"s" ["<cmd>vert Git<cr>" "Git"]
                               "a" ["<cmd>Gwrite<cr>" "Stage file"]
                               "p" ["<cmd>10sp +term\\ git\\ push<cr>" "Git push"]
                               "P" ["<cmd>G push --force-with-lease<cr>" "Git push f"]
                               "m" ["<cmd>GitMessenger<cr>"]}}))}

   ;; Follow conventions
   ["https://tpope.io/vim/sleuth.git"]

   ;; Lisps
   {:url (gh "rktjmp/hotpot.nvim")} ;; in sync with init.lua
   {:url (gh "gpanders/nvim-parinfer")}
   {:url (gh "Olical/conjure")
    :event ["BufReadPre *.fnl" "BufReadPre *.clj"]
    :init (tset vim.g "conjure#extract#tree_sitter#enabled" true)
    :config #(let [wk (require "which-key")]
               (wk.register {"<localleader>E" "eval motion"
                             "<localleader>e" "execute"
                             "<localleader>l" "log"
                             "<localleader>r" "reset"
                             "<localleader>t" "test"}))}

   {:url (gh "fladson/vim-kitty" ):ft "kitty"}
   [:mbbill/undotree]

   ;; Pairs
   {:url (gh "windwp/nvim-autopairs" ):opts {:disable_filetype lisp-filetypes}}

   [(gh "tommcdo/vim-exchange")]

   ;; Motion
   {:url (gh "ggandor/leap.nvim")
    :keys (let [_ #{1 $1 2 $2 :mode [:n :x :o]}]
            [(_ "l" "<Plug>(leap-forward-to)")
             (_ "h" "<Plug>(leap-backward-to)")
             (_ "L" "<Plug>(leap-forward-till)")
             (_ "H" "<Plug>(leap-backward-till)")
             (_ "gs" "<Plug>(leap-cross-window)")])}

   {:url (gh "ggandor/flit.nvim")
    :opts {:keys {:f "t" :t "T" ; forward
                  :F "f" :T "F"}}}

   {:url (gh "echasnovski/mini.nvim")
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
   (require "pack.lualine")

   ;; Fzf
   {:url (gh "ibhagwan/fzf-lua")
    :branch :main
    :opts {:border "single"}
    :cmd "FzfLua"
    :keys [["<leader>f"]]
    :dependencies [{:url (gh "junegunn/fzf") :build ":call fzf#install()"}
                   {:url (gh "folke/which-key.nvim")
                    :config #(let [wk (require "which-key")
                                   fzf (λ [method ?opts]
                                          [#((. (require "fzf-lua") method) ?opts)
                                           method])
                                   keys {:name "fzf"
                                         "f" (fzf :git_files)
                                         "F" (fzf :files {:fd-opts "--no-ignore --hidden"})
                                         "s" (fzf :git_status)
                                         "g" (fzf :live_grep)
                                         "h" (fzf :help_tags)
                                         "H" (fzf :command_history)
                                         "c" (fzf :commands)
                                         "," (fzf :builtin)
                                         "k" (fzf :keymaps)
                                         "." (fzf :resume)
                                         "w" (fzf :grep_cword)
                                         "W" (fzf :grep_cWORD)
                                         "/" (fzf :lines)
                                         "l" (fzf :buffers)}]
                               (wk.register {"<leader>f" keys
                                             "<leader>/" (fzf :blines)}))}]}

   ;; Neorg
   {:url (gh "nvim-neorg/neorg")
    :ft "norg"
    :build ":Neorg sync-parsers"
    :opts {:load {:core.defaults {}
                  :core.dirman {:config {:workspaces {:knowledge "~/10-19-Computer/14-Notes"
                                                      :gtd "~/10-19-Computer/15-GTD"}}}}}
    :dependencies [{:url (gh "nvim-lua/plenary.nvim")}
                   {:url (gh "nvim-treesitter/nvim-treesitter")}]}

   ;; Treesitter
   (require "pack.treesitter")

   ;; LSP
   {:url (gh "neovim/nvim-lspconfig")
    :config (load-file "lsp")
    :dependencies {:url (gh "j-hui/fidget.nvim")
                   :config true}}

   ;; Autocompletion
   {:url (gh "ms-jpq/coq_nvim")
    :branch "coq"
    :build ":COQdeps"
    :dependencies ["nvim-lspconfig"]
    :event "InsertEnter"
    :config (λ [] (vim.cmd ":COQnow -s"))}

   ;; Trouble
   {:url (gh "folke/trouble.nvim")
    :cmd "Trouble"
    :opts {:icons false}}

   {:url (gh "akinsho/toggleterm.nvim")
    :opts {:direction "float"
           :float_opts {:width vim.o.columns
                        :height vim.o.lines}}
    :keys [["<c-z>" "<cmd>1ToggleTerm<cr>"]
           {1 "<c-z>" 2 "" :mode "t"}
           ["<leader>tf" "<cmd>1ToggleTerm<cr>"]
           ["<leader>ts" "<cmd>2ToggleTerm<cr>"]]}

   ;; Look
   {:url (gh "catppuccin/nvim")
    :name "catpuccin"
    :lazy false
    :priority 1000
    :config (λ []
               ((call-setup :catppuccin
                            {:custom_highlights {:MatchParen {:fg "#FE640B"
                                                              :bg "#000000"
                                                              :style ["bold"]}}}))
               (vim.cmd "colorscheme catppuccin-frappe"))}

   {:url (gh "folke/noice.nvim")
    :lazy false
    :dependencies [{:url (gh "rcarriga/nvim-notify")}
                   {:url (gh "MunifTanjim/nui.nvim")}]
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

   {:url (gh "rcarriga/nvim-notify")
    :config (λ []
               (set vim.notify (require :notify))
               ((call-setup "notify" {:stages :fade_in_slide_out
                                      :fps 60
                                      :icons {:ERROR ""
                                              :WARN ""
                                              :INFO ""
                                              :DEBUG ""
                                               :TRACE "✎"}})))}

   {:url (gh "Pocco81/TrueZen.nvim")
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


   {:url (gh "norcalli/nvim-colorizer.lua")
    :event [:BufRead :BufNewFile]
    :config (call-setup "colorizer" ["*"] {:RGB true
                                           :RRGGBB true
                                           :names true
                                           :RRGGBBAA true
                                           :rgb_fn true
                                           :hsl_fn true
                                           :mode :foreground})}

   ;; Folds
   {:url (gh "kevinhwang91/nvim-ufo")
    :event "BufRead"
    :dependencies [["kevinhwang91/promise-async"]]
    :opts {:provider_selector (λ [bufnr filetype buftype]
                                 ["treesitter" "indent"])}}

   {:url (gh "dstein64/vim-startuptime")
    :cmd "StartupTime"
    :config (λ [] (set vim.g.startuptime_tries 10))}

   ;; Git
   {:url (gh "lewis6991/gitsigns.nvim")
    :config true
    :dependencies [{:url (gh "nvim-lua/plenary.nvim")}]}])

;; Call `setup` with the plugins described.
(let [lazy (require :lazy)]
  (lazy.setup plugins {:defaluts {:lazy true}}))
