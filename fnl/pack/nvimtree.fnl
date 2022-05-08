(import-macros {: let!} :macros.option-macros)
(import-macros {: lazy-require} :macros.package-macros)

(let! :g.nvim_tree_show_icons {:git 0 :folders 1 :files 0 :folder_arrows 0})

(local {: setup} (lazy-require :nvim-tree))
(setup {:view {:width 30 :side :left :hide_root_folder true}
        :hijack_cursor true
        :update_cwd true
        :renderer {:indent_markers {:enable true}
                   :icons {:webdev_colors false}}
        :hijack_directories {:enable true :auto_open true}})
