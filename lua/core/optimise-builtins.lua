-- [nfnl] Compiled from fnl/core/optimise-builtins.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils/options")
local set_opt_21 = _local_1_["set-opt!"]
set_opt_21("shadafile", "NONE")
local function _2_()
  set_opt_21("shadafile", (vim.fn.expand("$HOME") .. "/.local/share/nvim/shada/main.shada"))
  return vim.cmd(" silent! rsh ")
end
vim.schedule(_2_)
local built_ins = {"gzip", "zip", "zipPlugin", "tar", "tarPlugin", "getscript", "getscriptPlugin", "vimball", "vimballPlugin", "2html_plugin", "matchit", "matchparen", "logiPat", "rrhelper", "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers"}
local providers = {"perl", "node", "ruby", "python", "python3"}
for _, v in ipairs(built_ins) do
  local plugin = ("loaded_" .. v)
  do end (vim.g)[plugin] = 1
end
for _, v in ipairs(providers) do
  local provider = ("loaded_" .. v .. "_provider")
  do end (vim.g)[provider] = 0
end
return nil
