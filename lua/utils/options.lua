-- [nfnl] Compiled from fnl/utils/options.fnl by https://github.com/Olical/nfnl, do not edit.
local function set_opt_21(name, value)
  _G.assert((nil ~= value), "Missing argument value on /home/slava/10-19-Computer/12-Tooling/13.03-nyoom.nvim/fnl/utils/options.fnl:3")
  _G.assert((nil ~= name), "Missing argument name on /home/slava/10-19-Computer/12-Tooling/13.03-nyoom.nvim/fnl/utils/options.fnl:3")
  do end (vim.opt)[name] = value
  return nil
end
local function set_opts_21(opts)
  _G.assert((nil ~= opts), "Missing argument opts on /home/slava/10-19-Computer/12-Tooling/13.03-nyoom.nvim/fnl/utils/options.fnl:7")
  for name, value in pairs(opts) do
    set_opt_21(name, value)
  end
  return nil
end
return {["set-opt!"] = set_opt_21, ["set-opts!"] = set_opts_21}
