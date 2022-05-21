;; Speed up Neovim
(require :core.optimise-builtins)

;; Set vim options
(require :core.options)

;; TODO

;; Autocommands
; (require :core.events)

;; Colorscheme
; (require :core.highlights)

;; Statusline
; (require :utils.statusline)

;; load packer
(require :pack.pack)
(let [{: compiled?
       : load-compiled} (require :pack.pack)
      packer (require :packer)]
  (if (compiled?)
    (load-compiled)
    (packer.sync)))

;; Mappings
(require :core.keymaps)
