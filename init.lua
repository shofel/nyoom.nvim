-- Bootstrap hotpot and lazy.

-- @thanks @datwaft https://github.com/datwaft/nvim.conf/blob/93fcc61044797bab33a76ee46e55d0b0f190c4d9/init.lua

require[[utils.assure_plugin]](
  "hotpot.nvim",
  "https://github.com/rktjmp/hotpot.nvim.git")

require[[utils.assure_plugin]](
  "lazy.nvim",
  "https://github.com/folke/lazy.nvim.git")

-- load/cache config
require [[hotpot]].setup({provide_require_fennel = true})
require [[init]]

