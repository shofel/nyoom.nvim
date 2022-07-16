;; Use nix's gcc to compile parsers.
;; @see https://www.reddit.com/r/neovim/comments/vyqcny/comment/ig3s444/
(require :pack.treesitter-set-gcc)

(local {: setup} (require :nvim-treesitter.configs))

(setup {:ensure_installed "all"
        :ignore_install []
        :highlight {:enable true
                    :use_languagetree true
                    :additional_vim_regex_highlighting true}
        :indent {:enable true}
        :rainbow {:enable true :extended_mode true}
        :endwise {:enable true}
        :refactor {:highlight_definitions {:enable false}
                   :highlight_current_scope {:enable true}
                   :smart_rename {:enable true
                                  :keymaps {:smart_rename :grr}}
                   :navigation {:enable true
                                :keymaps {:goto_definition "gd"
                                          :list_definitions "gD"
                                          :list_definitions_toc "gO"
                                          :goto_next_usage "<M-8>" ; like *, which is <S-8>
                                          :goto_previous_usage "<M-3>"}}}
        :textobjects {:select {:enable true}
                      :lookahead true
                      :keymaps {:af "@function.outer"
                                :if "@function.inner"
                                :ac "@class.outer"
                                :ic "@class.inner"}  
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
