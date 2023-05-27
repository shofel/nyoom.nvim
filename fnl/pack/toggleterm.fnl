(local {: setup} (require :toggleterm))
(local {: Terminal} (require :toggleterm.terminal))

(local keymaps (require :pack/which-key))

;;

(setup {:direction "float"
        :float_opts {:width vim.o.columns
                     :height vim.o.lines}})

(let [first (Terminal:new)
      second (Terminal:new)]
  (keymaps.set-toggleterm-keys! first second))
