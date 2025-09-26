
local selected_or_hovered = ya.sync(function()
	local tab, paths = cx.active, {}
	for _, u in pairs(tab.selected) do
		paths[#paths + 1] = tostring(u)
	end
	if #paths == 0 and tab.current.hovered then
		paths[1] = tostring(tab.current.hovered.url)
	end
	return paths
end)

return {
    entry = function(_, job)
        local output = Command("git"):arg("status"):stderr(Command.PIPED):output()
        if output.stderr ~= "" then
            ya.notify({
                title = "git",
                content = "Not in a git directory",
                level = "warn",
                timeout = 5,
            })
        else
            local s = ya.target_family() == "windows" and " %*" or ' "$@"'
            local paths = selected_or_hovered()

            if #paths == 0 then
        		    return ya.notify({ title = "Git", content = "No file selected", level = "warn", timeout = 5 })
		        end

						local output, err = Command("git")
																:arg("add")
																:arg("-f")
																:args(paths)
																:output()
															
						if err_code ~= nil then
                ya.notify({
                    title = "Failed gitadd command",
                    content = "Status: " .. err_code,
                    level = "error",
                    timeout = 5,
                })
            elseif not output.status.success then
                ya.notify({
                    title = "git add failed, exit code " .. output.status.code,
                    content = output.stderr,
                    level = "error",
                    timeout = 5,
                })
            end
            	        
        end
    end,
}
