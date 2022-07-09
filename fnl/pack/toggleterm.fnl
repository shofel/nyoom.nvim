(local {: setup} (require :toggleterm))
(local {: Terminal} (require :toggleterm.terminal))

(local keymaps (require :pack/which-key))

;;

(setup {:direction "float"})

(let [first (Terminal:new {:cmd "fish" :hidden false})
      second (Terminal:new {:cmd "fish"})]
  (keymaps.set-toggleterm-keys! first second))
