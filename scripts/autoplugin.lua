--Here more plugins!!!!
plugins = {

--Desc, Name_plugin, secction, Position in the config.txt, Plugin Extra, Configuration Extra

--Kernel
--{ name = "Gamesd by xyzz					 (Only in ur0:tai/config.txt)", path = "gamesd.skprx",   section = "KERNEL", pos = 1,  path2 = false, section2 = false, config = false },
{ name = "PSVita-StorageMgr by CelesteBlue v2.1", path = "storagemgr.skprx", section = "KERNEL", pos = 1,  path2 = false, section2 = false, config = "storage_config.txt" },

{ name = "NoNpDrm by TheOfficialFloW", path = "nonpdrm.skprx", section = "KERNEL", pos = false,  path2 = false, section2 = false, config = false },
{ name = "NoPsmDrm by frangarcj", path = "nopsmdrm.skprx", section = "KERNEL", pos = false,  path2 = false, section2 = false, config = false },
{ name = "Vitabright by devnoname120(only for 3.60)", path = "vitabright.skprx", section = "KERNEL", pos = false,  path2 = false, section2 = false, config = "vitabright_lut.txt" },
{ name = "NoAVLS by SilicaAndPina", path = "noavls.skprx", section = "KERNEL", pos = false,  path2 = false, section2 = false, config = false },
{ name = "Repatch by dots v2.71", path = "repatch.skprx", section = "KERNEL", pos = false,  path2 = false, section2 = false, config = false },
{ name = "ds3vita by xerpi Beta3", path = "ds3vita.skprx", section = "KERNEL", pos = false,  path2 = false, section2 = false, config = false },
{ name = "ds4vita by xerpi v1.2", path = "ds4vita.skprx", section = "KERNEL", pos = false,  path2 = false, section2 = false, config = false },
{ name = "Kuio by Rinnegatamante", path = "kuio.skprx", section = "KERNEL", pos = false,  path2 = false, section2 = false, config = false },
{ name = "Adrenaline by TheOfficialFloW (Fix double touch)", path = "adrenaline_kernel.skprx", section = "KERNEL", pos = false,  path2 = false, section2 = false, config = false },

--Main
{ name = "Download Enabler by TheOfficialFloW (VitaTweaks)", path = "download_enabler.suprx", section = "main", pos = false,  path2 = false, section2 = false, config = false },
{ name = "NoLockScreen by TheOfficialFloW (VitaTweaks)", path = "nolockscreen.suprx", section = "main", pos = false,  path2 = false, section2 = false, config = false },
{ name = "NoTrophyMsg by TheOfficialFloW (VitaTweaks)", path = "notrophymsg.suprx", section = "main", pos = false,  path2 = false, section2 = false, config = false },
{ name = "Shellbat by nowrep v0.9", path = "shellbat.suprx", section = "main", pos = false,  path2 = false, section2 = false, config = false },
{ name = "Shellsecbat by OperationNT414C v0.8", path = "shellsecbat.suprx", section = "main", pos = false,  path2 = false, section2 = false, config = false },
{ name = "pngshot by xyzz v1.2", path = "pngshot.suprx", section = "main", pos = false,  path2 = false, section2 = false, config = false },
{ name = "Vflux by Applelo v0.5", path = "vFlux.suprx", section = "main", pos = false,  path2 = false, section2 = false, config = false },

--All
{ name = "PSV-VSH MENU by joel16 v3.4", path = "vsh.suprx", section = "ALL", pos = false,  path2 = "kuio.skprx", section2 = "KERNEL", config = false },-- Need kuio.skprx
{ name = "Oclock Vita by frangarcj v1.2.1", path = "oclockvita.suprx", section = "ALL", pos = false,  path2 = false, section2 = false, config = false },

}

local path_plugins = "resources/plugins/"
loc, toinstall = 1,0

--Init load configs
tai.load()

if not files.exists(tai_ux0_path) and not files.exists(tai_ur0_path) then
	if version == "3.60" then files.copy("resources/config_360/config.txt", "ur0:tai/")
		elseif version == "3.65" then files.copy("resources/config_365/config.txt", "ur0:tai/") 
			elseif version == "3.68" then files.copy("resources/config_368/config.txt", "ur0:tai/")	end
	tai.load()
end
if tai[__UR0].exist then loc = 2 end

--Backups
tai.sync(__UX0, "ux0:tai/config_backup.txt")
tai.sync(__UR0, "ur0:tai/config_backup.txt")

if back then back:blit(0,0) end
	message_wait("Creating Config_backups.txt")
os.delay(1500)

function plugins_installation(sel)

	if plugins[sel].path == "vitabright.skprx" and version != "3.60" then os.message("Vitabright only for 3.60")
	else

		--Pos = 1 Plugins SD2Vita
		if plugins[sel].pos == 1 then			--Plugins for SD2VITA in ur0:tai/config.txt and not ux0:tai/config.txt
			loc = __UR0

			--No ur0:tai/config.txt
			if not tai[__UR0].exist then

				if tai[__UX0].exist then files.copy(tai[__UX0].path, "ur0:tai/") --If exist ux0:tai/config.txt copy to ur0:tai
				else
					if version == "3.60" then files.copy("resources/config_360/config.txt", "ur0:tai/")	--Copy defect for config.txt
					else files.copy("resources/config_365/config.txt", "ur0:tai/") end					--3.65/3.67/3.68 same config.txt
				end

			end

			--delete if plugin gamesd.skprx
			if tai[loc].gameid[ "KERNEL" ] then
				tai.del(loc, "KERNEL", "gamesd.skprx")
				--Write
				tai.sync(loc)
			end

			--Update configs
			tai.load()

			-- Delete ux0:tai/config.txt
			if tai[__UX0].exist then files.delete(tai[__UX0].path) end

		end

		if files.exists(tai[loc].path) then

			local path_tai = locations[loc].."tai/"

			--Install plugin to tai folder
			files.copy(path_plugins..plugins[sel].path, path_tai)

			--Install Extra Plugin
			if plugins[sel].path2 then files.copy(path_plugins..plugins[sel].path2, path_tai) end

			--Install Especial Config for the plugin
			if plugins[sel].config then files.copy(path_plugins..plugins[sel].config, path_tai) end

			--Insert plugin to Config
			local path_in_config = path_tai..plugins[sel].path
			if plugins[sel].path == "adrenaline_kernel.skprx" then path_in_config = "ux0:app/PSPEMUCFW/sce_module/adrenaline_kernel.skprx" end

			if plugins[sel].pos then
				tai.put(loc, plugins[sel].section, path_in_config, 1)				--Sd2VITA first
			else
				if plugins[sel].section2 then
					tai.put(loc, plugins[sel].section2, path_tai..plugins[sel].path2)
					tai.put(loc, plugins[sel].section,  path_in_config)
				else
					tai.put(loc, plugins[sel].section, path_in_config)
				end
			end

			if plugins[sel].path == "vsh.suprx" then files.delete("ur0:/data:/vsh/") end
			
			--Write
			tai.sync(loc)

			change = true
			buttons.homepopup(0)

			if back then back:blit(0,0) end
			message_wait(plugins[sel].name.."\n\nhave been installed")
			os.delay(1000)

		else
			os.message("Missing config.txt")
		end
	end

end

limit = 13
scroll = newScroll(plugins,limit)
function autoplugin()

	--Init load configs
	loc = 1
	tai.load()
	if tai[__UR0].exist then loc = 2 end

	buttons.interval(10,10)
	while true do
		buttons.read()
		if back then back:blit(0,0) end

		screen.print(480,20,"Autoplugin Install the plugins with a click",1,color.red, 0x0, __ACENTER)
		screen.print(10,50,"List of plugins ready to install:",1,color.white)

		screen.print(10,440,"Press X to Install the plugin(s)",1,color.white,color.black)
		screen.print(10,460,"Press Square to select the plugin(s) to install",1,color.white,color.black)
		screen.print(10,480,"Press Triangle to Install ALL the plugins",1,color.white,color.black)
		screen.print(10,500,"Press Select to clean selected plugins",1,color.white,color.black)
		screen.print(10,520,"Press L/R to swap ux0<->ur0",1,color.white,color.black)

		--Partitions
		local xRoot = 750
		local w = (955-xRoot)/#locations
		for i=1, #locations do
			if loc == i then
				draw.fillrect(xRoot,36,w,36, color.green:a(90))
			end
			screen.print(xRoot+(w/2), 45, locations[i], 1, color.white, color.blue, __ACENTER)
			xRoot += w
		end

		--List of Plugins
		local y = 80
		for i=scroll.ini,scroll.lim do

			if i == scroll.sel then	draw.fillrect(0,y-2,945,23,color.green:a(90)) end

			screen.print(35,y, plugins[i].name, 1.0,color.white,color.blue,__ALEFT)

			if plugins[i].inst then
				screen.print(3,y,"-->",1,color.white,color.green)
			end

			y+=26
		end

		---- Draw Scroll Bar
		local ybar,hbar = 80, (limit*26)-2
		draw.fillrect(950,ybar-2,8,hbar,color.shine)
		if scroll.maxim >= limit then
			local pos_height = math.max(hbar/scroll.maxim, limit)
			--Bar Scroll
			draw.fillrect(950, ybar-2 + ((hbar-pos_height)/(scroll.maxim-1))*(scroll.sel-1), 8, pos_height, color.new(0,255,0))
		end

		screen.print(955,500,"Plugins: "..toinstall,1,color.white,color.blue, __ARIGHT)
		screen.print(955,522,"Press START to close",1,color.white,color.red, __ARIGHT)

		screen.flip()

		--------------------------	Controls	--------------------------
		if buttons.up or buttons.analogly < -60 then scroll:up() end
		if buttons.down or buttons.analogly > 60 then scroll:down() end

		if buttons.circle then break end

		--Exit
		if buttons.start then
			if change then
				os.message("Your PSVita will restart")
				os.delay(250)
				buttons.homepopup(1)
				power.restart()
			end
			os.exit()
		end

		if buttons.released.l or buttons.released.r then
			if tai[__UX0].exist and tai[__UR0].exist then
				if loc == __UX0 then loc = __UR0 else loc = __UX0 end
			end
		end

		--Install selected plugins
		if buttons.cross then
			if toinstall <= 1 then
				plugins_installation(scroll.sel)
			else
				for i=1, scroll.maxim do
					if plugins[i].inst then
						plugins_installation(i)
					end
				end
				os.delay(50)
			end
		end

		--Mark/Unmark
		if buttons.square then
			plugins[scroll.sel].inst = not plugins[scroll.sel].inst
			if plugins[scroll.sel].inst then toinstall+=1 else toinstall-=1 end
		end

		--Clean selected
		if buttons.select then
			for i=1,scroll.maxim do
				plugins[i].inst = false
				if toinstall >= 1 then toinstall-=1 end
			end
		end

		--Install ALL plugins
		if buttons.triangle then
			for i=1,scroll.maxim do
				plugins_installation(i)
			end
		end
	end

end
