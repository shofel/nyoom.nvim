-- [nfnl] Compiled from fnl/core/options.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils.options")
local set_opt_21 = _local_1_["set-opt!"]
local set_opts_21 = _local_1_["set-opts!"]
vim.g.mapleader = " "
vim.g.maplocalleader = ","
set_opt_21("shell", "fish")
set_opts_21({hidden = true, list = true, timeoutlen = 500, shortmess = "filnxtToOFatsc", inccommand = "nosplit", cmdheight = 0})
set_opt_21("completeopt", {"menu", "menuone", "preview", "noinsert", "noselect"})
set_opt_21("clipboard", "unnamedplus")
set_opt_21("mouse", "a")
set_opts_21({backupcopy = "yes", updatetime = 20, undofile = true, backup = false, swapfile = false})
set_opt_21("ruler", false)
set_opt_21("number", false)
set_opt_21("termguicolors", true)
set_opt_21("signcolumn", "yes:1")
set_opt_21("fillchars", {eob = " ", horiz = "\226\148\129", horizup = "\226\148\187", horizdown = "\226\148\179", vert = "\226\148\131", vertleft = "\226\148\171", vertright = "\226\148\163", verthoriz = "\226\149\139", fold = " ", diff = "\226\148\128", msgsep = "\226\128\190", foldsep = "\226\148\130", foldopen = "\226\150\190", foldclose = "\226\150\184"})
set_opts_21({foldcolumn = "1", foldlevel = 99, foldlevelstart = 99, foldenable = true})
set_opt_21("smartcase", true)
set_opt_21("ignorecase", true)
set_opts_21({copyindent = true, smartindent = true, preserveindent = true, tabstop = 2, shiftwidth = 2, softtabstop = 2, expandtab = true})
set_opt_21("conceallevel", 2)
set_opts_21({splitbelow = true, splitright = false})
set_opt_21("scrolloff", 0)
set_opt_21("guicursor", ("n-v-ve:block-Cursor/lCursor," .. "i-c-ci-cr:ver100-Cursor/lCursor," .. "o-r:hor100-Cursor/lCursor"))
set_opt_21("keymap", "russian-dvorak")
return set_opt_21("iminsert", 0)
