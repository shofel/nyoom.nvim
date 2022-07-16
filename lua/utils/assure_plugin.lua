-- A function that verifies if the plugin passed as a parameter is installed,
-- if it isn't it will be installed
---@param plugin string #the plugin, must follow the format `username/repository`
---@param branch string #the branch of the plugin
return function (plugin, branch)
    local _, _, plugin_name = string.find(plugin, [[%S+/(%S+)]])

    local plugin_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/" .. plugin_name

    if vim.fn.empty(vim.fn.glob(plugin_path)) ~= 0 then
        print("An essential plugin not found: " .. plugin .. "\n" ..
              "It will be installed at path " .. plugin_path)

        vim.fn.system({
            "git", "clone",
            "--depth", "1",
            "https://github.com/" .. plugin,
            "--branch", branch,
            plugin_path,
        })
    end
end
