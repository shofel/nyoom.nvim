-- Bootstrap fennel and plugin management.

-- @thanks @datwaft https://github.com/datwaft/nvim.conf/blob/93fcc61044797bab33a76ee46e55d0b0f190c4d9/init.lua

require[[utils.assure_plugin]](
  "nfnl",
  "https://github.com/Olical/nfnl.git")

require[[utils.assure_plugin]](
  "lazy.nvim",
  "https://github.com/folke/lazy.nvim.git")

-- start
require('nfnl')['compile-all-files']()
require [[fnl-init]]
