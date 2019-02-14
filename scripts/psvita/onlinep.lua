--[[ 
	Autoinstall plugin

	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Dev: TheHeroeGAC
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

function plugins_online()

	if not check_online() then os.message(LANGUAGE["UPDATE_WIFI_IS_ON"]) return	end

	local url_plugins = "https://raw.githubusercontent.com/theheroGAC/Autoplugin/master/plugins/db.lua"
	local path = "ux0:data/AUTOPLUGIN/tmp/db.lua"

	if back then back:blit(0,0) end
	message_wait(LANGUAGE["UPDATE_CHECK_DB"])
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
								message_wait(db[i].path.."\n\n"..LANGUAGE["UPDATE_PLUGIN"].." : "..db[i].stringversion)
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
		message_wait(LANGUAGE["UPDATE_ERROR_DB"])
		os.delay(1500)
	end

	if update then
		http.getfile(string.format("https://raw.githubusercontent.com/theheroGAC/Autoplugin/master/plugins/plugins.lua"), "scripts/psvita/plugins.lua")
		if files.exists("scripts/psvita/plugins.lua") then dofile("scripts/psvita/plugins.lua") end
		if #plugins > 0 then table.sort(plugins, function (a,b) return string.lower(a.name)<string.lower(b.name) end) end
	else
		if back then back:blit(0,0) end
		message_wait(LANGUAGE["UPDATE_NO_NEWS"])
		os.delay(1500)
	end

	os.delay(1500)
end
