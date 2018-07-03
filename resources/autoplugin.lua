------Autoinstall plugin
-------------------Resources-----------
--Init load configs
__UX0, __UR0 = 1,2
tai.load()

if not files.exists("ux0:tai/config.txt") and not files.exists("ur0:tai/config.txt") then
	if tostring(os.swversion()) == "3.60" then files.copy("resources/config_360/config.txt", "ur0:tai/")
	elseif tostring(os.swversion()) == "3.65" then files.copy("resources/config_365/config.txt", "ur0:tai/") 
       elseif tostring(os.swversion()) == "3.68" then files.copy("resources/config_368/config.txt", "ur0:tai/")end
	tai.load()
end

--Backups
tai.sync(__UX0, "ux0:tai/config_backup.txt")
tai.sync(__UR0, "ur0:tai/config_backup.txt")

if back then back:blit(0,0) end
	message_wait("Creating Config_backups.txt")
os.delay(1500)

local change, multi, path_plugins = false,false, "resources/plugins/"
local locations = { "ux0:", "ur0:", }

local loc, toinstall = 1,0
if tai[__UR0].exist then loc = 2 end

plugins = {

	{ name = "Gamesd by xyzz (Only in ur0:tai/config.txt)", path = "gamesd.skprx", section = "KERNEL" },
	{ name = "PSVita-StorageMgr by CelesteBlue (Only in ur0:tai/config.txt)", path = "storagemgr.skprx", section = "KERNEL" },
	{ name = "NoNpDrm by TheFloW", path = "nonpdrm.skprx", section = "KERNEL" },

	{ name = "NoPsmDrm by frangarcj", path = "nopsmdrm.skprx", section = "KERNEL" },
	{ name = "Vitabright by devnoname120(only for 3.60)", path = "vitabright.skprx", section = "KERNEL", configuration = "vitabright_lut.txt" },
	{ name = "NoAVLS by SilicaAndPina", path = "noavls.skprx", section = "KERNEL" },
	{ name = "Repatch by dots", path = "repatch.skprx", section = "KERNEL" },
	{ name = "ds3vita by xerpi", path = "ds3vita.skprx", section = "KERNEL" },
	{ name = "ds4vita by xerpi", path = "ds4vita.skprx", section = "KERNEL" },
	{ name = "Kuio by Rinnegatamante", path = "kuio.skprx", section = "KERNEL" },
	{ name = "Adrenaline by TheFloW(fix double touch)", path = "ux0:app/PSPEMUCFW/sce_module/adrenaline_kernel.skprx", section = "KERNEL" },

	{ name = "DownloadEnabler by TheFloW", path = "download_enabler.suprx", section = "main" },
	{ name = "Shellbat by nowrep", path = "shellbat.suprx", section = "main" },
       { name = "Shellsecbat by OperationNT414C", path = "shellsecbat.suprx", section = "main" },
	{ name = "pngshot by xyzz", path = "pngshot.suprx", section = "main" },
	{ name = "Vflux by Applelo", path = "vFlux.suprx", section = "main" },

	{ name = "PSV-VSH MENU by joel16", path = "vsh.suprx", section = "ALL" },-- Need kuio.skprx

}

function install_plugins(nplugin, partition)

	local path_config = locations[partition].."tai/config.txt"
	local path_tai = locations[partition].."tai/"

	--Copy Extra-plugins or configurations
	if nplugin == 5 then
		files.copy(path_plugins..plugins[nplugin].configuration, path_tai)
	elseif nplugin == 17 then
		files.copy(path_plugins..plugins[10].path, path_tai)
	end

	--Install plugin to TAI folder
	if nplugin == 13 then
		files.copy(path_plugins..plugins[nplugin].path, "ux0:tai/")								--Shellbat.suprx work in ux0
	else
		files.copy(path_plugins..plugins[nplugin].path, path_tai)
	end

	--Insert plugin to Config
	if nplugin == 1 then
		tai.put(partition, plugins[nplugin].section, path_tai..plugins[nplugin].path, 1)		--Gamesd.skprx first
	elseif nplugin == 11 then																	--Adrenaline ux0:app
		tai.put(partition, plugins[nplugin].section, plugins[nplugin].path )
	elseif nplugin == 13 then
		tai.put(partition, plugins[nplugin].section, "ux0:tai/"..plugins[nplugin].path )
	elseif nplugin == 17 then																	--VSH menu need kuio.skprx
		tai.put(partition, plugins[nplugin].section, path_tai..plugins[nplugin].path)
		tai.put(partition, plugins[10].section, path_tai..plugins[10].path)
	else
		tai.put(partition, plugins[nplugin].section, path_tai..plugins[nplugin].path)
	end

	tai.sync(partition)
	change = true
	buttons.homepopup(0)
	if not multi then os.message(plugins[nplugin].name.."\n\nhave been installed") end

end

function Reload_ur0_config()
	loc = __UR0

	if not tai[__UR0].exist then
		if tai[__UX0].exist then files.copy(tai[__UX0].path, "ur0:tai/")
		else
			if tostring(os.swversion()) == "3.60" then files.copy("resources/config_360/config.txt", "ur0:tai/")
			elseif tostring(os.swversion()) == "3.65" then files.copy("resources/config_365/config.txt", "ur0:tai/") 
                    elseif tostring(os.swversion()) == "3.68" then files.copy("resources/config_368/config.txt", "ur0:tai/")end
		end
	end

	--Update configs
	tai.load()

	if tai[__UX0].exist then files.delete(tai[__UX0].path) end

end

function plugins_installation(sel)
	if sel == 1 then						--gamesd only in ur0:tai/config.txt and not ux0:tai/config.txt
		Reload_ur0_config()
	end

	if sel == 5 and tostring(os.swversion()) != "3.60" then os.message("Vitabright only for 3.60")
	else
		if files.exists(tai[loc].path) then
			install_plugins(sel, loc)
		else
			os.message("Missing config")
		end
	end
end

local limit = 14
local scroll = newScroll(plugins,limit)

buttons.interval(10,10)
while true do
	buttons.read()
	if back then back:blit(0,0) end

	screen.print(480,20,"Autoplugin Install the plugins with a click",1,color.red, 0x0, __ACENTER)
	screen.print(10,50,"List of plugins ready to install:",1,color.white)

	screen.print(10,440,"Press X to Install the plugin(s)",1,color.white,color.black)
       screen.print(10,460,"Press Square to select the plugin (s) to install",1,color.white,color.black)
	screen.print(10,480,"Press Triangle to Install ALL the plugins",1,color.white,color.black)
       screen.print(10,500,"Press Select to clean selected plugins",1,color.white,color.black)
	screen.print(10,522,"Press START to exit",1,color.white,color.red)

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

		screen.print(30,y, plugins[i].name,1.0,color.white,color.blue,__ALEFT)

		if plugins[i].inst then
			screen.print(5,y,"->",1,color.white,color.green)
		end

		y+=26
	end

	---- Draw Scroll Bar
	local ybar,hbar = 80, (limit*26)-2
	draw.fillrect(950,ybar-2,8,hbar,color.shine)
	if scroll.maxim >= limit then -- Draw Scroll Bar
		local pos_height = math.max(hbar/scroll.maxim, limit)
		--Bar Scroll
		draw.fillrect(950, ybar-2 + ((hbar-pos_height)/(scroll.maxim-1))*(scroll.sel-1), 8, pos_height, color.new(0,255,0))
	end

	screen.print(955,500,"Plugins: "..toinstall,1,color.white,color.blue, __ARIGHT)

	screen.flip()

	--------------------------	Controls	--------------------------
	if buttons.up or buttons.analogly < -60 then scroll:up() end
	if buttons.down or buttons.analogly > 60 then scroll:down() end

	if buttons.released.l or buttons.released.r then
		if tai[__UX0].exist and tai[__UR0].exist then
			if loc == __UX0 then loc = __UR0 else loc = __UX0 end
		end
	end

	--if buttons.triangle then update_adrenaline(change) end

	--Install selected plugins
	if buttons.cross then
		if toinstall <= 1 then
			plugins_installation(scroll.sel)
		else
			for i=1, scroll.maxim do
				if plugins[i].inst then	plugins_installation(i)	end
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
		multi=true
		for i=1,scroll.maxim do
			plugins_installation(i)
		end
	end

	--Exit
	if buttons.released.start then
		if change then
			os.message("Your PSVita will restart.\n\nThe config.txt backup has been saved to\n\n"..locations[loc].."tai/tai_backup/config.txt",0)
			os.delay(250)
			power.restart()
		end
		break
	end

end
