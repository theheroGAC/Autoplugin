--[[ 
	Autoinstall plugin

	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Dev: TheHeroeGAC
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

function plugins_installation(sel)

	if plugins[sel].path == "reF00D.skprx" and loc == __UX0 then os.message(LANGUAGE["INSTALLP_WARNING_REFOOD"])
	elseif plugins[sel].path == "custom_warning.suprx" and ( version == "3.67" or version == "3.68") then os.message(LANGUAGE["INSTALLP_CWARNING_360_365"])
	else

		if files.exists(tai[loc].path) then

			local install = true

			--Checking plugin Batt (only 1 of them)
			if plugins[sel].path == "shellbat.suprx" then
				local idx = tai.find(loc, "main", "shellsecbat.suprx")
				if idx then
					if os.message(LANGUAGE["INSTALLP_QUESTION_SHELLSECBAT"],1) == 1 then
						tai.del(loc, "main", "shellsecbat.suprx")
					else
						install = false
					end
				end
			elseif plugins[sel].path == "shellsecbat.suprx" then
				local idx = tai.find(loc, "main", "shellbat.suprx")
				if idx then
					if os.message(LANGUAGE["INSTALLP_QUESTION_SHELLBAT"],1) == 1 then
						tai.del(loc, "main", "shellbat.suprx")
					else
						install = false
					end
				end
			end

			if install then

				--Install plugin to tai folder
				files.copy(path_plugins..plugins[sel].path, path_tai)

				--Install Extra Plugin
				if plugins[sel].path2 then files.copy(path_plugins..plugins[sel].path2, path_tai) end

				--Install Especial Config for the plugin
				if plugins[sel].config then
					if plugins[sel].config == "custom_warning.txt" then
					
						if not files.exists(locations[loc].."tai/"..plugins[sel].config) then
							local text = osk.init(LANGUAGE["INSTALLP_OSK_TITLE"], LANGUAGE["INSTALLP_OSK_TEXT"])
							if not text or (string.len(text)<=0) then text = "" end--os.nick() end

							local fp = io.open(locations[loc].."tai/"..plugins[sel].config, "wb")
							if fp then
								fp:write(string.char(0xFF)..string.char(0xFE))
								fp:write(os.toucs2(text))
								fp:close()
							end
						end
					else
						if plugins[sel].configpath then
							files.copy(path_plugins..plugins[sel].config, plugins[sel].configpath)
						else
							files.copy(path_plugins..plugins[sel].config, locations[loc].."tai/")
						end
					end
				end

				--Insert plugin to Config
				local pathline_in_config = path_tai..plugins[sel].path

				if plugins[sel].path == "adrenaline_kernel.skprx" then pathline_in_config = "ux0:app/PSPEMUCFW/sce_module/adrenaline_kernel.skprx" end

				local idx = nil

				if plugins[sel].section2 then
					idx = tai.find(loc, plugins[sel].section2, path_tai..plugins[sel].path2)
					if idx then tai.del(loc, plugins[sel].section2, path_tai..plugins[sel].path2) end
					tai.put(loc, plugins[sel].section2, path_tai..plugins[sel].path2)
				end

				idx = tai.find(loc, plugins[sel].section, pathline_in_config)
				if idx then tai.del(loc, plugins[sel].section,  pathline_in_config) end

				tai.put(loc, plugins[sel].section,  pathline_in_config)

				--Write
				tai.sync(loc)

				--Extra
				if plugins[sel].path == "vsh.suprx" then files.delete("ur0:/data:/vsh/")
				elseif plugins[sel].path == "custom_boot_splash.skprx" and not files.exists("ur0:tai/boot_splash.bin") then--Custom Boot Splash
					img2splashbin("resources/boot_splash.png")
				elseif plugins[sel].path == "vitacheat.skprx" and not files.exists("ux0:vitacheat/db/") then--Vitacheat
					files.extract("resources/plugins/vitacheat.zip","ux0:")
				elseif plugins[sel].path == "AutoBoot.suprx" and not files.exists("ux0:data/AutoBoot/") then--AutoBoot
					files.extract("resources/plugins/AutoBoot.zip","ux0:")
				end

				if back then back:blit(0,0) end
				message_wait(plugins[sel].name.."\n\n"..LANGUAGE["STRING_INSTALLED"])
				os.delay(1500)

				change = true
				buttons.homepopup(0)

			end

		else
			os.message(LANGUAGE["STRING_MISSING_CONFIG"])
		end
	end

end

limit = 12
scr = newScroll(plugins,limit)
function autoplugin()

	local xscr1,toinstall = 5,0
	scr.ini,scr.lim,scr.sel = 1,limit,1

	--Init load configs
	loc = 1
	tai.load()
	if tai[__UR0].exist then loc = 2 end
	path_tai = locations[loc].."tai/"

	while true do
		buttons.read()
		if back then back:blit(0,0) end

		screen.print(10,15,LANGUAGE["INSTALLP_LIST_PLUGINS"].."  "..toinstall.."/"..#plugins,1,color.white)

		--Partitions
		local xRoot = 750
		local w = (960-xRoot)/#locations
		for i=1, #locations do
			if loc == i then
				draw.fillrect(xRoot,0,w,40, color.green:a(90))
			end
			screen.print(xRoot+(w/2), 12, locations[i], 1, color.white, color.blue, __ACENTER)
			xRoot += w
		end

		draw.fillrect(0,40,960,350,color.shine:a(25))

		--List of Plugins
		local y = 70
		for i=scr.ini,scr.lim do

			if i == scr.sel then
				draw.fillrect(3,y-5,943,25,color.green:a(105))
			end

			screen.print(35,y, plugins[i].name, 1.0,color.white,color.blue,__ALEFT)

			if plugins[i].inst then
				screen.print(5,y,"-->",1,color.white,color.green)
			end

			y+=27
		end

		---- Draw Scroll Bar
		local ybar,hbar = 70, (limit*27)-2
		draw.fillrect(950,ybar-2,8,hbar,color.shine)
		if scr.maxim >= limit then
			local pos_height = math.max(hbar/scr.maxim, limit)
			--Bar Scroll
			draw.fillrect(950, ybar-2 + ((hbar-pos_height)/(scr.maxim-1))*(scr.sel-1), 8, pos_height, color.new(0,255,0))
		end

		if screen.textwidth(plugins[scr.sel].desc) > 935 then
			xscr1 = screen.print(xscr1, 405, plugins[scr.sel].desc,1,color.white,color.orange,__SLEFT,935)
		else
			screen.print(480, 405, plugins[scr.sel].desc,1,color.white,color.orange,__ACENTER)
		end

		if tai[__UX0].exist and tai[__UR0].exist then
			if buttonskey2 then buttonskey2:blitsprite(900,448,2) end
			if buttonskey2 then buttonskey2:blitsprite(930,448,3) end
			screen.print(895,450,LANGUAGE["INSTALLP_LR_SWAP"],1,color.white,color.black,__ARIGHT)
		end

		if buttonskey then buttonskey:blitsprite(10,448,__SQUARE) end
		screen.print(40,450,LANGUAGE["INSTALLP_MARK"],1,color.white,color.black, __ALEFT)

		if buttonskey2 then buttonskey2:blitsprite(5,472,0) end
		screen.print(40,475,LANGUAGE["INSTALLP_CLEAN"],1,color.white,color.black, __ALEFT)

		if buttonskey then buttonskey:blitsprite(10,498,__TRIANGLE) end
		screen.print(40,500,LANGUAGE["INSTALLP_CUSTOM_PATH"]..": "..path_tai,1,color.white,color.black, __ALEFT)

		if buttonskey then buttonskey:blitsprite(10,523,scancel) end
		screen.print(40,525,LANGUAGE["STRING_BACK"],1,color.white,color.black, __ALEFT)

		if buttonskey2 then buttonskey2:blitsprite(930,523,1) end
		screen.print(925,525,LANGUAGE["STRING_CLOSE"],1,color.white,color.red, __ARIGHT)

		screen.flip()

		--------------------------	Controls	--------------------------

		if buttons.released[cancel] then
			--Clean
			for i=1,scr.maxim do
				plugins[i].inst = false
				toinstall = 0
			end
			os.delay(100)
			return
		end

		--Exit
		if buttons.start then
			if change then
				os.message(LANGUAGE["STRING_PSVITA_RESTART"])
				os.delay(250)
				buttons.homepopup(1)
				power.restart()
			end
			os.exit()
		end

		if scr.maxim > 0 then

			if buttons.up or buttons.analogly < -60 then
				if scr:up() then xscr1 = 5 end
			end
			if buttons.down or buttons.analogly > 60 then
				if scr:down() then xscr1 = 5 end
			end

			if buttons.released.l or buttons.released.r then
				if tai[__UX0].exist and tai[__UR0].exist then
					if loc == __UX0 then loc = __UR0 else loc = __UX0 end
				end
			end

			--Install selected plugins
			if buttons[accept] then

				if back then back:blit(0,0) end
				message_wait(LANGUAGE["STRING_PLEASE_WAIT"])
				os.delay(1000)

				if toinstall <= 1 then
					plugins_installation(scr.sel)
				else
					for i=1, scr.maxim do
						if plugins[i].inst then
							plugins_installation(i)
						end
					end
					os.delay(50)
				end

				for i=1,scr.maxim do
					plugins[i].inst = false
					toinstall = 0
				end

			end

			--Mark/Unmark
			if buttons.square then
				plugins[scr.sel].inst = not plugins[scr.sel].inst
				if plugins[scr.sel].inst then toinstall+=1 else toinstall-=1 end
			end

			--Clean selected
			if buttons.select then
				for i=1,scr.maxim do
					plugins[i].inst = false
					toinstall = 0
				end
			end

			--Customize install path for plugins
			if buttons.triangle then
				if folder_tai then
					folder_tai = false
					path_tai = locations[loc].."tai/"
				else
					folder_tai = true
					path_tai = locations[loc].."tai/plugins/"
				end
			end
		end
	end

end
