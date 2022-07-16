-- assure the essential plugins are installed
require[[utils.assure_plugin]]("wbthomason/packer.nvim", "master")
require[[utils.assure_plugin]]("rktjmp/hotpot.nvim", "nightly")

-- load/cache config
require [[hotpot]].setup()
require [[init]]
