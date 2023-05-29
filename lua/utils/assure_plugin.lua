-- A function that verifies if the plugin passed as a parameter is installed,
-- if it isn't it will be installed
---@param name string
---@param url string
return function (name, url)
    local path = vim.fn.stdpath("data") .. "/lazy/" .. name

    if not vim.loop.fs_stat(vim.fn.glob(path)) then
        vim.notify("Bootstrapping " .. name .. "...", vim.log.levels.INFO)

        vim.fn.system({
            "git", "clone",
            "--single-branch",
            "--filter=blob:none",
            url, path,
        })
    end

    vim.opt.rtp:prepend(path)
end
