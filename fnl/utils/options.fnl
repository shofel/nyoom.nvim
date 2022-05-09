;;; Utils to customize neovim options.

(lambda set-opt! [name value]
  "Set a neovim option"
  (tset vim.opt name value))

(lambda set-opts! [opts]
  "Set more than one nvim option at once"
  (each [name value (pairs opts)]
    (set-opt! name value)))


{: set-opt!
 : set-opts!}
