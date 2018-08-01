--Here more plugins!!!!
plugins = {

--Kernel
{ name = "NoNpDrm by TheOfficialFloW", path = "nonpdrm.skprx", section = "KERNEL", path2 = false, section2 = false, config = false, desc = INSTALLP_DESC_NONPDRM, },
{ name = "NoPsmDrm by frangarcj", path = "nopsmdrm.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, desc = INSTALLP_DESC_NOPSMDRM, },
{ name = "Vitabright by devnoname120(only for 3.60)", path = "vitabright.skprx", section = "KERNEL",  path2 = false, section2 = false, config = "vitabright_lut.txt", desc = INSTALLP_DESC_VITABRIGHT, },
{ name = "NoAVLS by SilicaAndPina", path = "noavls.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, desc = INSTALLP_DESC_NOAVLS, },
{ name = "Repatch by dots v2.71", path = "repatch.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, desc = INSTALLP_DESC_REPATCH, },
{ name = "ds3vita by xerpi Beta3", path = "ds3vita.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, desc = INSTALLP_DESC_DS3VITA, },
{ name = "ds4vita by xerpi v1.2", path = "ds4vita.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, desc = INSTALLP_DESC_DS4VITA, },
{ name = "udcd_uvc by xerpi [PoC v3]", path = "udcd_uvc.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, desc = INSTALLP_DESC_UDCDUVC, },
--{ name = "Kuio by Rinnegatamante", path = "kuio.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, desc = INSTALLP_DESC_KUIO, },
{ name = "Adrenaline by TheOfficialFloW (Fix double touch)", path = "adrenaline_kernel.skprx", section = "KERNEL",  path2 = false, section2 = false, config = false, desc = INSTALLP_DESC_ADRENALINE, },

--Main
{ name = "Download Enabler by TheOfficialFloW (VitaTweaks)", path = "download_enabler.suprx", section = "main",  path2 = false, section2 = false, config = false, desc = INSTALLP_DESC_DENABLER, },
{ name = "NoLockScreen by TheOfficialFloW (VitaTweaks)", path = "nolockscreen.suprx", section = "main",  path2 = false, section2 = false, config = false, desc = INSTALLP_DESC_NOLOCKSCREEN, },
{ name = "NoTrophyMsg by TheOfficialFloW (VitaTweaks)", path = "notrophymsg.suprx", section = "main",  path2 = false, section2 = false, config = false, desc = INSTALLP_DESC_NOTROPHYMSG, },
{ name = "Custom Warning by TheOfficialFloW (VitaTweaks)", path = "custom_warning.suprx", section = "main",  path2 = false, section2 = false, config = "custom_warning.txt", desc = INSTALLP_DESC_CUSTOMWARNING, },

{ name = "Shellbat by nowrep v0.9", path = "shellbat.suprx", section = "main",  path2 = false, section2 = false, config = false, desc = INSTALLP_DESC_SHELLBAT, },
{ name = "Shellsecbat by OperationNT414C v0.9", path = "shellsecbat.suprx", section = "main",  path2 = false, section2 = false, config = false, desc = INSTALLP_DESC_SHELLSECBAT, },
{ name = "pngshot by xyzz v1.2", path = "pngshot.suprx", section = "main",  path2 = false, section2 = false, config = false, desc = INSTALLP_DESC_PNGSHOT, },
{ name = "Vflux by Applelo v0.5", path = "vFlux.suprx", section = "main",  path2 = false, section2 = false, config = false, desc = INSTALLP_DESC_VFLUX, },

--All
{ name = "PSV-VSH MENU by joel16 v3.4", path = "vsh.suprx", section = "ALL",  path2 = "kuio.skprx", section2 = "KERNEL", config = false, desc = INSTALLP_DESC_VSHMENU, },-- Need kuio.skprx
{ name = "Oclock Vita by frangarcj v1.2.1", path = "oclockvita.suprx", section = "ALL",  path2 = false, section2 = false, config = false, desc = INSTALLP_DESC_OVERCLOCK, },

}

loc, toinstall = 1,0

--Init load configs
tai.load()

if not files.exists(tai_ux0_path) and not files.exists(tai_ur0_path) then
	if version == "3.60" then files.copy("resources/config_360/config.txt", "ur0:tai/")	--Copy defect for config.txt
	else files.copy("resources/config_365/config.txt", "ur0:tai/") end					--3.65/3.67/3.68 same config.txt
	tai.load()
end
if tai[__UR0].exist then loc = 2 end

--Backups
tai.sync(__UX0, "ux0:tai/config_backup.txt")
tai.sync(__UR0, "ur0:tai/config_backup.txt")

if back then back:blit(0,0) end
	message_wait(STRING_BACKUP_CONFIGS)
os.delay(1500)

function plugins_installation(sel)

	if plugins[sel].path == "vitabright.skprx" and version != "3.60" then os.message(INSTALLP_VITABRIGHT_360)
	elseif plugins[sel].path == "custom_warning.suprx" and ( version == "3.67" or version == "3.68") then os.message(INSTALLP_CWARNING_360_365)
	else

		if files.exists(tai[loc].path) then

			local install = true

			--Checking plugin Batt (only 1 of them)
			if plugins[sel].path == "shellbat.suprx" then
				local idx = tai.find(loc, "main", "shellsecbat.suprx")
				if idx then
					if os.message(INSTALLP_QUESTION_SHELLSECBAT,1) == 1 then
						tai.del(loc, "main", "shellsecbat.suprx")
					else
						install = false
					end
				end
			elseif plugins[sel].path == "shellsecbat.suprx" then
				local idx = tai.find(loc, "main", "shellbat.suprx")
				if idx then
					if os.message(INSTALLP_QUESTION_SHELLBAT,1) == 1 then
						tai.del(loc, "main", "shellbat.suprx")
					else
						install = false
					end
				end
			end

			if install then
				local path_tai = locations[loc].."tai/"

				--Install plugin to tai folder
				files.copy(path_plugins..plugins[sel].path, path_tai)

				--Install Extra Plugin
				if plugins[sel].path2 then files.copy(path_plugins..plugins[sel].path2, path_tai) end

				--Install Especial Config for the plugin
				if plugins[sel].config then
					if plugins[sel].config == "custom_warning.txt" then
						local text = osk.init(INSTALLP_OSK_TITLE, INSTALLP_OSK_TEXT)
						if not text or (string.len(text)<=0) then text = os.nick() end

						files.copy(path_plugins..plugins[sel].config, path_tai)

						local fp = io.open(path_tai..plugins[sel].config, "wb")
						if fp then
							fp:write(string.char(0xFF)..string.char(0xFE))
							fp:write(os.toucs2(text))
							fp:close()
						end
					else
						files.copy(path_plugins..plugins[sel].config, path_tai)
					end
				end

				--Insert plugin to Config
				local pathline_in_config = path_tai..plugins[sel].path

				if plugins[sel].path == "adrenaline_kernel.skprx" then pathline_in_config = "ux0:app/PSPEMUCFW/sce_module/adrenaline_kernel.skprx" end

				if plugins[sel].section2 then
					tai.put(loc, plugins[sel].section2, path_tai..plugins[sel].path2)
				end
				tai.put(loc, plugins[sel].section,  pathline_in_config)

				--Extra
				if plugins[sel].path == "vsh.suprx" then files.delete("ur0:/data:/vsh/") end

				--Write
				tai.sync(loc)

				change = true
				buttons.homepopup(0)

				if back then back:blit(0,0) end
				message_wait(plugins[sel].name.."\n\n"..STRING_INSTALLED)
				os.delay(1500)

			end

		else
			os.message(STRING_MISSING_CONFIG)
		end
	end

end

limit,xscr1 = 13,5
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

		screen.print(10,10,INSTALLP_LIST_PLUGINS.."  "..toinstall.."/"..#plugins,1,color.white)

		--Partitions
		local xRoot = 750
		local w = (955-xRoot)/#locations
		for i=1, #locations do
			if loc == i then
				draw.fillrect(xRoot,0,w,30, color.green:a(90))
			end
			screen.print(xRoot+(w/2), 7, locations[i], 1, color.white, color.blue, __ACENTER)
			xRoot += w
		end

		draw.fillrect(0,40,960,350,color.shine:a(25))

		--List of Plugins
		local y = 50
		for i=scroll.ini,scroll.lim do

			if i == scroll.sel then	draw.fillrect(0,y-3,945,24,color.green:a(90)) end

			screen.print(35,y, plugins[i].name, 1.0,color.white,color.blue,__ALEFT)

			if plugins[i].inst then
				screen.print(3,y,"-->",1,color.white,color.green)
			end

			y+=26
		end

		---- Draw Scroll Bar
		local ybar,hbar = 50, (limit*26)-2
		draw.fillrect(950,ybar-2,8,hbar,color.shine)
		if scroll.maxim >= limit then
			local pos_height = math.max(hbar/scroll.maxim, limit)
			--Bar Scroll
			draw.fillrect(950, ybar-2 + ((hbar-pos_height)/(scroll.maxim-1))*(scroll.sel-1), 8, pos_height, color.new(0,255,0))
		end

		if screen.textwidth(plugins[scroll.sel].desc) > 935 then
			xscr1 = screen.print(xscr1, 405, plugins[scroll.sel].desc,1,color.white,color.orange,__SLEFT,935)
		else
			screen.print(480, 405, plugins[scroll.sel].desc,1,color.white,color.orange,__ACENTER)
		end

		screen.print(10,450,INSTALLP_CROSS_INSTALL,1,color.white,color.black,__ALEFT)
		--screen.print(10,475,INSTALLP_TRIANGLE_ALL,1,color.white,color.black,__ALEFT)
		screen.print(10,475,INSTALLP_LR_SWAP,1,color.white,color.black,__ALEFT)

		screen.print(955,450,INSTALLP_SQUARE_MARK,1,color.white,color.black, __ARIGHT)
		screen.print(955,475,INSTALLP_SELECT_CLEAN,1,color.white,color.black, __ARIGHT)

		screen.print(10,522,STRING_CIRCLE_BACK,1,color.white,color.black, __ALEFT)
		screen.print(955,522,STRING_START_CLOSE,1,color.white,color.red, __ARIGHT)

		screen.flip()

		--------------------------	Controls	--------------------------
		if buttons.up or buttons.analogly < -60 then scroll:up() xscr1 = 5 end
		if buttons.down or buttons.analogly > 60 then scroll:down() xscr1 = 5 end

		if buttons.circle then break end

		--Exit
		if buttons.start then
			if change then
				os.message(STRING_PSVITA_RESTART)
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
			for i=1,scroll.maxim do
				plugins[i].inst = false
				if toinstall >= 1 then toinstall-=1 end
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

		--[[
		--Install ALL plugins
		if buttons.triangle then
			for i=1,scroll.maxim do
				plugins_installation(i)
			end
		end
		]]

	end

end
