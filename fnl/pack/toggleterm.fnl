(local {: setup} (require :toggleterm))
(local {: Terminal} (require :toggleterm.terminal))

(local {: set-toggleterm-keymaps!} (require :core.keymaps))

;;

(setup {:direction "float"})

(let [first (Terminal:new {:cmd "fish" :hidden false})
      second (Terminal:new {:cmd "fish"})]
  (toggleterm-keymaps! first second))
