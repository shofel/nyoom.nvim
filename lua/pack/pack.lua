-- [nfnl] Compiled from fnl/pack/pack.fnl by https://github.com/Olical/nfnl, do not edit.
local function gh(x)
  _G.assert((nil ~= x), "Missing argument x on /home/slava/10-19-Computer/12-Tooling/13.03-nyoom.nvim/fnl/pack/pack.fnl:12")
  return ("https://github.com/" .. x .. ".git")
end
local function wk_register(keys, _3fopts)
  _G.assert((nil ~= keys), "Missing argument keys on /home/slava/10-19-Computer/12-Tooling/13.03-nyoom.nvim/fnl/pack/pack.fnl:14")
  local wk = require("which-key")
  return wk.register(keys, _3fopts)
end
local lisp_filetypes = {"fennel", "clojure", "lisp", "racket", "scheme"}
local plugins
local function _1_()
  do end (require("which-key")).setup()
  wk_register({["<leader>"] = {s = {"<cmd>write<cr>", "Write buffer"}, n = {"<cmd>nohlsearch<cr>", "Clear search"}}})
  return vim.keymap.set("n", "<leader>e", ":", {desc = ":"})
end
local function _2_()
  return wk_register({["[d"] = {vim.diagnostic.goto_prev, "Previous diagnostic"}, ["]d"] = {vim.diagnostic.goto_next, "Next diagnostic"}, ["[c"] = {"<cmd>Gitsigns prev_hunk<cr>", "prev hunk"}, ["]c"] = {"<cmd>Gitsigns next_hunk<cr>", "next hunk"}}, {noremap = false})
end
local function _3_()
  return wk_register({["<leader>g"] = {s = {"<cmd>vert Git<cr>", "Git"}, p = {"<cmd>10sp +term\\ git\\ push<cr>", "Git push"}, P = {"<cmd>G push --force-with-lease<cr>", "Git push force"}}})
end
local function _4_()
  do end (require("gitsigns")).setup()
  local function _7_()
    local _ = require("gitsigns")
    local cmd
    local function _5_(cmd0)
      _G.assert((nil ~= cmd0), "Missing argument cmd on /home/slava/10-19-Computer/12-Tooling/13.03-nyoom.nvim/fnl/pack/pack.fnl:64")
      return {("<cmd>Gitsigns " .. cmd0 .. "<cr>"), cmd0}
    end
    cmd = _5_
    local cmd_
    local function _6_(cmd0)
      _G.assert((nil ~= cmd0), "Missing argument cmd on /home/slava/10-19-Computer/12-Tooling/13.03-nyoom.nvim/fnl/pack/pack.fnl:65")
      return {(":Gitsigns " .. cmd0 .. " "), cmd0}
    end
    cmd_ = _6_
    local function _8_()
      return _.setqflist("all")
    end
    return {["<leader>g"] = {name = "git", B = cmd_("change_base"), R = cmd("preview_hunk"), a = cmd("stage_hunk"), b = cmd("blame_line"), d = {_.diffthis, "diff"}, l = {_8_, "qflist"}, r = cmd("preview_hunk_inline"), u = cmd("reset_hunk"), w = cmd("stage_buffer")}}
  end
  return wk_register(_7_())
end
vim.g["conjure#extract#tree_sitter#enabled"] = true
local function _9_()
  return wk_register({["<localleader>E"] = "eval motion", ["<localleader>e"] = "execute", ["<localleader>l"] = "log", ["<localleader>r"] = "reset", ["<localleader>t"] = "test"})
end
local _10_
do
  local _
  local function _11_(_241, _242)
    return {_241, _242, mode = {"n", "x", "o"}}
  end
  _ = _11_
  _10_ = {_("l", "<Plug>(leap-forward-to)"), _("h", "<Plug>(leap-backward-to)"), _("L", "<Plug>(leap-forward-till)"), _("H", "<Plug>(leap-backward-till)"), _("gs", "<Plug>(leap-cross-window)")}
end
local function _12_()
  do end (require("mini.comment")).setup()
  do end (require("mini.surround")).setup({n_lines = 50, mappings = {add = "sa", delete = "sd", find = "st", find_left = "sf", highlight = "sh", replace = "sr", update_n_lines = "sn"}})
  local _ = require("mini.bufremove")
  return wk_register({["<leader>b"] = {name = "buffers", o = {"<cmd>only<cr>", "close others"}, k = {"<cmd>bwipeout<cr>", "delete buffer and close window"}, K = {"<cmd>bwipeout!<cr>", "delete! buffer and close window"}, d = {_.delete, "delete buffer"}, h = {_.unshow_in_window, "unshow buffer"}, c = {"<cmd>close<cr>", "close window"}}})
end
local function _13_()
  local fzf_opts = {border = "single"}
  local fzf = require("fzf-lua")
  local key
  local function _14_(method, _3fopts)
    _G.assert((nil ~= method), "Missing argument method on /home/slava/10-19-Computer/12-Tooling/13.03-nyoom.nvim/fnl/pack/pack.fnl:153")
    local function _15_()
      return fzf[method](_3fopts)
    end
    return {_15_, method}
  end
  key = _14_
  local keys = {name = "fzf", [","] = key("builtin"), ["."] = key("resume"), ["/"] = key("lines"), F = key("files", {["fd-opts"] = "--no-ignore --hidden"}), H = key("command_history"), W = key("grep_cWORD"), c = key("commands"), f = key("git_files"), g = {name = "git"}, gb = key("git_branches"), gc = key("git_bcommits"), gC = key("git_commits"), gf = key("git_files"), gs = key("git_status"), gz = key("git_stash"), h = key("help_tags"), k = key("keymaps"), l = key("live_grep"), r = key("registers"), s = key("git_status"), w = key("grep_cword")}
  fzf.setup(fzf_opts)
  wk_register({["<leader>f"] = keys, ["<leader>/"] = key("blines"), ["<leader>bl"] = key("buffers")})
  return wk_register({["<c-x><c-f>"] = key("complete_path")}, {mode = "i"})
end
local function _16_()
  do end (require("yanky")).setup()
  vim.keymap.set({"n", "x"}, "y", "<Plug>(YankyYank)")
  vim.keymap.set({"n", "x"}, "p", "<Plug>(YankyPutAfter)")
  vim.keymap.set({"n", "x"}, "P", "<Plug>(YankyPutBefore)")
  vim.keymap.set({"n", "x"}, "gp", "<Plug>(YankyGPutAfter)")
  vim.keymap.set({"n", "x"}, "gP", "<Plug>(YankyGPutBefore)")
  vim.keymap.set({"n"}, "<a-n>", "<Plug>(YankyCycleForward)")
  return vim.keymap.set({"n"}, "<a-p>", "<Plug>(YankyCycleBackward)")
end
local function _17_()
  return require("pack.lsp")
end
local function _18_()
  return vim.cmd(":COQnow -s")
end
local function _19_()
  do end (require("catppuccin")).setup({custom_highlights = {MatchParen = {fg = "#FE640B", bg = "#000000", style = {"bold"}}}})
  return vim.cmd("colorscheme catppuccin-frappe")
end
local function _20_()
  vim.notify = require("notify")
  return (require("notify")).setup({stages = "fade_in_slide_out", fps = 60, icons = {ERROR = "\239\129\151", WARN = "\239\129\170", INFO = "\239\129\154", DEBUG = "\239\134\136", TRACE = "\226\156\142"}})
end
local function _21_(bufnr, filetype, buftype)
  _G.assert((nil ~= buftype), "Missing argument buftype on /home/slava/10-19-Computer/12-Tooling/13.03-nyoom.nvim/fnl/pack/pack.fnl:313")
  _G.assert((nil ~= filetype), "Missing argument filetype on /home/slava/10-19-Computer/12-Tooling/13.03-nyoom.nvim/fnl/pack/pack.fnl:313")
  _G.assert((nil ~= bufnr), "Missing argument bufnr on /home/slava/10-19-Computer/12-Tooling/13.03-nyoom.nvim/fnl/pack/pack.fnl:313")
  return {"treesitter", "indent"}
end
local function _22_()
  vim.g.startuptime_tries = 10
  return nil
end
plugins = {{url = gh("folke/which-key.nvim"), config = _1_}, {url = "https://tpope.io/vim/eunuch.git"}, {url = "https://tpope.io/vim/repeat.git"}, {url = "https://tpope.io/vim/rsi.git"}, {url = "https://tpope.io/vim/unimpaired.git", keys = {{"["}, {"yo"}, {"]"}, {"<leader>k", "[", remap = true, desc = "Unimpaired prev"}, {"<leader>j", "]", remap = true, desc = "Unimpaired next"}}, config = _2_}, {url = "https://tpope.io/vim/fugitive.git", cmd = {"G", "Git", "Gread"}, keys = {{"<leader>g", desc = "git"}}, config = _3_}, {url = gh("lewis6991/gitsigns.nvim"), event = {"VeryLazy"}, dependencies = {{url = gh("nvim-lua/plenary.nvim")}}, config = _4_}, {"https://tpope.io/vim/sleuth.git"}, {url = gh("Olical/nfnl")}, {url = gh("gpanders/nvim-parinfer")}, {url = gh("Olical/conjure"), event = {"BufReadPre *.fnl", "BufReadPre *.clj"}, init = nil, config = _9_}, {url = gh("fladson/vim-kitty"), ft = "kitty"}, {url = gh("mbbill/undotree")}, {url = gh("bfrg/vim-jq"), ft = "jq"}, {url = gh("windwp/nvim-autopairs"), opts = {disable_filetype = lisp_filetypes}}, {gh("tommcdo/vim-exchange")}, {url = gh("ggandor/leap.nvim"), keys = _10_}, {url = gh("ggandor/flit.nvim"), opts = {keys = {f = "t", t = "T", F = "f", T = "F"}}}, {url = gh("echasnovski/mini.nvim"), config = _12_}, require("pack.lualine"), {url = gh("ibhagwan/fzf-lua"), branch = "main", cmd = "FzfLua", keys = {{"<leader>f"}, {"<leader>/"}, {"<leader>bl"}, {"<c-x><c-f>", mode = "i"}}, dependencies = {{url = gh("junegunn/fzf"), build = ":call fzf#install()"}}, config = _13_}, {url = gh("gbprod/yanky.nvim"), config = _16_}, {url = gh("AckslD/nvim-neoclip.lua"), opts = {}}, {url = gh("nvim-neorg/neorg"), ft = "norg", build = ":Neorg sync-parsers", opts = {load = {["core.defaults"] = {}, ["core.dirman"] = {config = {workspaces = {knowledge = "~/10-19-Computer/14-Notes", gtd = "~/10-19-Computer/15-GTD"}}}}}, dependencies = {{url = gh("nvim-lua/plenary.nvim")}, {url = gh("nvim-treesitter/nvim-treesitter")}}}, require("pack.treesitter"), {url = gh("neovim/nvim-lspconfig"), config = _17_, dependencies = {url = gh("j-hui/fidget.nvim"), config = true}}, {url = gh("ms-jpq/coq_nvim"), branch = "coq", build = ":COQdeps", dependencies = {"nvim-lspconfig"}, event = "InsertEnter", config = _18_}, {url = gh("folke/trouble.nvim"), opts = {icons = false}, cmd = "Trouble"}, {url = gh("akinsho/toggleterm.nvim"), opts = {direction = "float", float_opts = {width = vim.o.columns, height = vim.o.lines}}, keys = {{"<c-z>", "<cmd>1ToggleTerm<cr>"}, {"<c-z>", "\28\14", mode = "t"}, {"<leader>tf", "<cmd>1ToggleTerm<cr>"}, {"<leader>ts", "<cmd>2ToggleTerm<cr>"}}}, {url = gh("catppuccin/nvim"), name = "catpuccin", priority = 1000, config = _19_, lazy = false}, {url = gh("folke/noice.nvim"), dependencies = {{url = gh("rcarriga/nvim-notify")}, {url = gh("MunifTanjim/nui.nvim")}}, opts = {lsp = {override = {["vim.lsp.util.convert_input_to_markdown_lines"] = true, ["vim.lsp.util.stylize_markdown"] = true, ["cmp.entry.get_documentation"] = true}}, presets = {long_message_to_split = true, inc_rename = false, bottom_search = false, command_palette = false, lsp_doc_border = false}}, lazy = false}, {url = gh("rcarriga/nvim-notify"), config = _20_}, {url = gh("Pocco81/TrueZen.nvim"), cmd = "TZAtaraxis", keys = {{"<leader>tz", "<cmd>TZAtaraxis<cr>"}}, opts = {ui = {bottom = {cmdheight = 0, laststatus = 0, ruler = true, showmode = false, showcmd = false}, left = {signcolumn = "no", relativenumber = false, number = false}}, modes = {ataraxis = {left_padding = 32, right_padding = 32, top_padding = 1, bottom_padding = 1, ideal_writing_area_width = {0}, bg_configuration = true, auto_padding = false}, focus = {margin_of_error = 5, focus_method = "experimental"}}}}, {url = gh("norcalli/nvim-colorizer.lua"), event = {"BufRead", "BufNewFile"}, opts = {["*"] = {RGB = true, RRGGBB = true, names = true, RRGGBBAA = true, rgb_fn = true, hsl_fn = true, mode = "foreground"}}}, {url = gh("kevinhwang91/nvim-ufo"), event = "BufRead", dependencies = {{"kevinhwang91/promise-async"}}, opts = {provider_selector = _21_}}, {url = gh("dstein64/vim-startuptime"), cmd = "StartupTime", config = _22_}}
local lazy = require("lazy")
return lazy.setup(plugins, {defaluts = {lazy = true}})
