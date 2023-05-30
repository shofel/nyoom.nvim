(local {: set-opt! : set-opts!} (require :utils.options))

;; set leader keys
(set vim.g.mapleader " ")
(set vim.g.maplocalleader ",")

;; shell
(set-opt! :shell "fish")

;;; Global options
(set-opts! {:hidden true
            :list   true
            :timeoutlen 500
            :shortmess  "filnxtToOFatsc"
            :inccommand "nosplit"
            :cmdheight 0})

;; cmp options
(set-opt! :completeopt [:menu :menuone :preview :noinsert :noselect])

;; Use clipboard outside Neovim
(set-opt! :clipboard :unnamedplus)

;; Enable mouse input
(set-opt! :mouse :a)

;; Disable swapfiles and enable undofiles
(set-opts! {:backup false :backupcopy "yes"
            :swapfile false :updatetime 20
            :undofile true})

;;; UI-related options
(set-opt! :ruler false)

;; Numbering
(set-opt! :number false)

;; True-color
(set-opt! :termguicolors true)

;; Cols and chars
(set-opt! :signcolumn "yes:1")

(set-opt! :fillchars {:eob " "
                      :horiz "━"
                      :horizup "┻"
                      :horizdown "┳"
                      :vert "┃"
                      :vertleft "┫"
                      :vertright "┣"
                      :verthoriz "╋"
                      :fold " "
                      :diff "─"
                      :msgsep "‾"
                      :foldsep "│"
                      :foldopen "▾"
                      :foldclose "▸"})

;; Folding
(set-opts! {:foldcolumn "1"
            :foldlevel 99
            :foldlevelstart 99
            :foldenable true})

;; Smart search
(set-opt! :smartcase true)

;; Case-insensitive search
(set-opt! :ignorecase true)

;; Indentation
(set-opts! {:copyindent true
            :smartindent true
            :preserveindent true
            ; numbers
            :tabstop 2
            :shiftwidth 2
            :softtabstop 2
            ;
            :expandtab true})

;; Enable concealing
(set-opt! :conceallevel 2)

;; Default split directions
(set-opts! {:splitright false
            :splitbelow true})

;; Scroll off
(set-opt! :scrolloff 0)

;; Cursor
(set-opt! :guicursor (.. "n-v-ve:block-Cursor/lCursor,"
                         "i-c-ci-cr:ver100-Cursor/lCursor,"
                         "o-r:hor100-Cursor/lCursor"))

;; Russian keymap
(set-opt! :keymap "russian-dvorak")
(set-opt! :iminsert 0)
