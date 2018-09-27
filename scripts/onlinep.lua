
function plugins_online()

	local wstrength = wlan.strength()
	if wstrength then
		if wstrength < 55 then os.message(UPDATE_WIFI_LOW) return end
	elseif not wlan.isconnected() then -- Fix ethernet mode
		os.message(UPDATE_WIFI_IS_ON) return
	end

	local url_plugins = "https://raw.githubusercontent.com/theheroGAC/Autoplugin/master/plugins/db.lua"
	local path = "ux0:data/AUTOPLUGIN/tmp/db.lua"

	if back then back:blit(0,0) end
	message_wait(UPDATE_CHECK_DB)
	os.delay(1500)

	local update = false
	files.delete("ux0:data/AUTOPLUGIN/tmp/")
	if http.getfile(url_plugins, path) then
		if files.exists(path) then
			dofile(path)

			--check plugins
			for i=1,#db do
				for j=1,#plugins do
				
					if db[i].path:lower() == plugins[j].path:lower() then
						if tonumber(db[i].version) > tonumber(plugins[j].version) then
							if (http.getfile(string.format("https://raw.githubusercontent.com/theheroGAC/Autoplugin/master/plugins/%s", db[i].path), path_plugins)) then
								if back then back:blit(0,0) end
								message_wait(db[i].path.."\n\n"..UPDATE_PLUGIN.." : "..db[i].stringversion)
								os.delay(1500)
								update = true
							end
						end
					end
				end
			end

		end

	else
		if back then back:blit(0,0) end
		message_wait(UPDATE_ERROR_DB)
		os.delay(1500)
	end

	if update then
		http.getfile(string.format("https://raw.githubusercontent.com/theheroGAC/Autoplugin/master/plugins/plugins.lua"), "scripts/")
		if files.exists("scripts/plugins.lua") then dofile("scripts/plugins.lua") end
	else
		if back then back:blit(0,0) end
		message_wait(UPDATE_NO_NEWS)
	end
	os.delay(1500)
end