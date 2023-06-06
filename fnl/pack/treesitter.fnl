;; Use nix's gcc to compile parsers.
;; @see https://www.reddit.com/r/neovim/comments/vyqcny/comment/ig3s444/
(λ install-gcc []
  (let [gcc (require :home-managed/gcc-path)
        ts-install (require :nvim-treesitter.install)]
    (tset ts-install :compilers [gcc])))

(λ setup-treesitter [opts]
   (let [{: setup} (require :nvim-treesitter.configs)]
     (setup opts)))

(λ gh [x] (.. "https://github.com/" x ".git"))

(local dependencies
       [{:url (gh "nvim-treesitter/playground")
         :cmd :TSPlayground
         :keys [["<Leader>tp" "<cmd>TSPlayground<cr>"]
                ["<Leader>th" "<cmd>TSHighlightCapturesUnderCursor<cr>"]]}
        {:url (gh "nvim-treesitter/nvim-treesitter-refactor")}
        {:url (gh "nvim-treesitter/nvim-treesitter-textobjects")}
        {:url (gh "RRethy/nvim-treesitter-textsubjects")}
        {:url (gh "RRethy/nvim-treesitter-endwise")}
        {:url (gh "simrat39/symbols-outline.nvim") :config true}])

(local opts {:ensure_installed ["javascript" "typescript" "html" "scss" "css" "json" "json5" "jsdoc" "vue"
                                "bash" "fish" "git_config" "git_rebase"
                                "markdown" "markdown_inline" 
                                "norg" "regex" "nix" "terraform" "hcl" "python" "clojure" "fennel"]
             :ignore_install []
             :highlight {:enable true
                         :use_languagetree true
                         :additional_vim_regex_highlighting true}
             :indent {:enable true}
             :rainbow {:enable true :extended_mode true}
             :endwise {:enable true}
             :refactor {:highlight_definitions {:enable true}
                        :highlight_current_scope {:enable false}
                        :smart_rename {:enable true
                                       :keymaps {:smart_rename :grr}}
                        :navigation {:enable true
                                     :keymaps {:goto_definition "gd"
                                               :list_definitions "gD"
                                               :list_definitions_toc "gO"
                                               :goto_next_usage "<M-8>" ; like *, which is <S-8>
                                               :goto_previous_usage "<M-3>"}}}
             :textobjects {:select {:enable true
                                    :lookahead true
                                    :keymaps {:af "@function.outer"
                                              :if "@function.inner"
                                              :ac "@class.outer"
                                              :ic "@class.inner"}}
                           :move {:enable true
                                  :set_jumps true
                                  :goto_next_start {"]m" "@function.outer"
                                                    "]]" "@class.outer"}
                                  :goto_next_end {"]M" "@function.outer"
                                                  "][" "@class.outer"}
                                  :goto_previous_start {"[m" "@function.outer"
                                                        "[[" "@class.outer"}
                                  :goto_previous_end {"[M" "@function.outer"
                                                      "[]" "@class.outer"}}}})



{:url (gh "nvim-treesitter/nvim-treesitter")
 : dependencies
 :config (λ []
           (setup-treesitter opts))
 :build (λ []
          (install-gcc)
          (vim.cmd ":TSUpdate"))}
