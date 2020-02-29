dofile("git/shared.lua")

if files.exists("ux0:/app/ONEUPDATE") then
	game.delete("ONEUPDATE") -- Exists delete update app
end

UPDATE_PORT = channel.new("UPDATE_PORT")

local scr_flip = screen.flip
function screen.flip()
	scr_flip()
	if UPDATE_PORT:available() > 0 then
		local url = UPDATE_PORT:pop()

		if not url then return end

		update = image.load("git/updater/update.png")

		if update then update:blit(0,0)
		elseif back then back:blit(0,0) end
		screen.flip()

		local version = files.nopath(files.nofile(url))
		version = version:gsub("/","  ")
		if not version then version = "UNK" end

		if os.message("\n"..string.format("%s v %s", APP_PROJECT, version..(LANGUAGE["UPDATER_AVAILABLE"]).."\n\n"..(LANGUAGE["UPDATER_UPDATE"])), 1) == 1 then
			buttons.homepopup(0)

			if update then update:blit(0,0)
			elseif back then back:blit(0,0) end

			local path = "ux0:data/"..APP_PROJECT..".vpk"
			local onAppInstallOld = onAppInstall
			function onAppInstall(step, size_argv, written, file, totalsize, totalwritten)
				return 10 -- Ok code
			end
			local onNetGetFileOld = onNetGetFile
			function onNetGetFile(size,written,speed)

				if update then update:blit(0,0)
				elseif back then back:blit(0,0) end

				screen.print(10,10,"Downloading Update...")
				screen.print(10,30,"Size: "..tostring(size).." Written: "..tostring(written).." Speed: "..tostring(speed).."Kb/s")
				screen.print(10,50,"Percent: "..math.floor((written*100)/size).."%")
				draw.fillrect(0,520,((written*960)/size),24,color.new(0,255,0))
				screen.flip()
				buttons.read()
				if buttons.circle then return 0 end --Cancel or Abort
				return 1;
			end
			local res = http.download(url, path)
			if res and files.exists(path) then -- Success!
				files.mkdir("ux0:/data/1luapkg")
				files.copy("eboot.bin","ux0:/data/1luapkg")
				files.copy("git/updater/script.lua","ux0:/data/1luapkg/")
				files.copy("git/updater/update.png","ux0:/data/1luapkg/")
				files.copy("git/updater/param.sfo","ux0:/data/1luapkg/sce_sys/")
				game.installdir("ux0:/data/1luapkg")
				files.delete("ux0:/data/1luapkg")
				game.launch(string.format("ONEUPDATE&%s&%s", "AUTOPLUG2", path)) -- Goto installer extern!
			end
			onAppInstall = onAppInstallOld
			onNetGetFile = onNetGetFileOld
			buttons.homepopup(1)
		end
	end
end

THID = thread.new("git/thread_net.lua")
