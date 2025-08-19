-- ~/.config/nvim/lua/pack_daily.lua
local M = {}
local stamp = vim.fn.stdpath("state") .. "/pack_last_update.txt"

function M.maybe_update()
	local today = os.date("%Y-%m-%d")
	local last = (vim.fn.filereadable(stamp) == 1) and (vim.fn.readfile(stamp)[1] or "") or ""
	if last == today then return end
	-- Only do this in an interactive session
	if #vim.api.nvim_list_uis() == 0 then return end
	vim.schedule(function() pcall(vim.pack.update) end) -- opens the review tab
	vim.fn.writefile({ today }, stamp)
end

return M
