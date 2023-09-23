-- [nfnl] Compiled from fnl/pack/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local function install_gcc()
  local gcc = require("home-managed/gcc-path")
  local ts_install = require("nvim-treesitter.install")
  do end (ts_install)["compilers"] = {gcc}
  return nil
end
local function setup_treesitter(opts)
  _G.assert((nil ~= opts), "Missing argument opts on /home/slava/10-19-Computer/12-Tooling/13.03-nyoom.nvim/fnl/pack/treesitter.fnl:8")
  local _let_1_ = require("nvim-treesitter.configs")
  local setup = _let_1_["setup"]
  return setup(opts)
end
local function gh(x)
  _G.assert((nil ~= x), "Missing argument x on /home/slava/10-19-Computer/12-Tooling/13.03-nyoom.nvim/fnl/pack/treesitter.fnl:12")
  return ("https://github.com/" .. x .. ".git")
end
local dependencies = {{url = gh("nvim-treesitter/playground"), cmd = "TSPlayground", keys = {{"<Leader>tp", "<cmd>TSPlayground<cr>"}, {"<Leader>th", "<cmd>TSHighlightCapturesUnderCursor<cr>"}}}, {url = gh("nvim-treesitter/nvim-treesitter-refactor")}, {url = gh("nvim-treesitter/nvim-treesitter-textobjects")}, {url = gh("RRethy/nvim-treesitter-textsubjects")}, {url = gh("RRethy/nvim-treesitter-endwise")}}
local opts = {ensure_installed = {"javascript", "typescript", "html", "scss", "css", "json", "json5", "jsdoc", "vue", "bash", "fish", "git_config", "git_rebase", "markdown", "markdown_inline", "norg", "regex", "nix", "terraform", "hcl", "python", "clojure", "fennel", "jsonnet"}, ignore_install = {}, highlight = {enable = true, use_languagetree = true, additional_vim_regex_highlighting = true}, indent = {enable = true}, rainbow = {enable = true, extended_mode = true}, endwise = {enable = true}, refactor = {highlight_definitions = {enable = true}, highlight_current_scope = {enable = false}, smart_rename = {enable = true, keymaps = {smart_rename = "grr"}}, navigation = {enable = true, keymaps = {goto_definition = "gd", list_definitions = "gD", list_definitions_toc = "gO", goto_next_usage = "<M-8>", goto_previous_usage = "<M-3>"}}}, textobjects = {select = {enable = true, lookahead = true, keymaps = {af = "@function.outer", ["if"] = "@function.inner", ac = "@class.outer", ic = "@class.inner"}}, move = {enable = true, set_jumps = true, goto_next_start = {["]m"] = "@function.outer", ["]]"] = "@class.outer"}, goto_next_end = {["]M"] = "@function.outer", ["]["] = "@class.outer"}, goto_previous_start = {["[m"] = "@function.outer", ["[["] = "@class.outer"}, goto_previous_end = {["[M"] = "@function.outer", ["[]"] = "@class.outer"}}}}
local function _2_()
  install_gcc()
  return setup_treesitter(opts)
end
local function _3_()
  install_gcc()
  return vim.cmd(":TSUpdate")
end
return {url = gh("nvim-treesitter/nvim-treesitter"), dependencies = dependencies, config = _2_, build = _3_}
