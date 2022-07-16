(local {: setup} (require :nvim-treesitter.configs))
(local parsers (require :nvim-treesitter.parsers))

;;; Extra parsers
(local parser-config (parsers.get_parser_configs))

;; neorg treesitter parsers 
(set parser-config.norg {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg"
                                        :files [:src/parser.c :src/scanner.cc]
                                        :branch :main}})

(set parser-config.norg_meta
     {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-meta"
                     :files [:src/parser.c]
                     :branch :main}})

(set parser-config.norg_table
     {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-table"
                     :files [:src/parser.c]
                     :branch :main}})

;; the usual
(setup {:ensure_installed ["bash"
                           "clojure"
                           "comment"
                           "commonlisp"
                           "css"
                           "dockerfile"
                           "fennel"
                           "fish"
                           "html"
                           "http"
                           "javascript"
                           "jsdoc"
                           "json"
                           "json5"
                           "lua"
                           "markdown"
                           "ninja"
                           "nix"
                           "perl"
                           "python"
                           "regex"
                           "ruby"
                           "scss"
                           "toml"
                           "tsx"
                           "typescript"
                           "vim"
                           "vue"
                           "yaml"]
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
