--[[ 
	Autoinstall plugin

	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Dev: TheHeroeGAC
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

function insert_plugin(path)

	local nlinea, cont, _find, file_txt = 0,0,false, {}

	for line in io.lines(path) do
		cont += 1
		table.insert(file_txt,line)

		pathp,status = line:match("(.+) (.+)")

		if pathp then
			if pathp:lower() == "ms0:/seplugins/npdrm_free.prx" then
				_find = true
				nlinea = cont
			end
		end

	end

	if _find then
		file_txt[nlinea] = "ms0:/seplugins/npdrm_free.prx 1"
	else
		table.insert(file_txt, "ms0:/seplugins/npdrm_free.prx 1")
	end

	local fp = io.open(path, "w+")
	for s,t in pairs(file_txt) do
		fp:write(string.format('%s\n', tostring(t)))
	end
	fp:close()

end

function npdrm_free()

	local scroll_np,x_scr = newScroll( PMounts, #PMounts),5

	while true do
		buttons.read()
		if back then back:blit(0,0) end

		screen.print(480,18,LANGUAGE["NPDRMFREE_TITLE"],1.2,color.white, 0x0, __ACENTER)

		draw.fillrect(0,64,960,322,color.shine:a(25))

		local y = 72
		for i=scroll_np.ini, scroll_np.lim do

			if i == scroll_np.sel then draw.fillrect(3,y-4,952,26,color.green:a(105)) end
			screen.print(25,y, PMounts[i].."pspemu/seplugins/")

			if PMounts[i].inst then
				screen.print(3,y,"-->",1,color.white,color.green)
			end

			y+=28
		end

		if screen.textwidth(LANGUAGE["NPDRMFREE_DESC"]) > 935 then
			x_scr = screen.print(x_scr, 400, LANGUAGE["NPDRMFREE_DESC"],1,color.white,color.orange,__SLEFT,935)
		else
			screen.print(480, 400, LANGUAGE["NPDRMFREE_DESC"],1,color.white,color.orange,__ACENTER)
		end

		if buttonskey then buttonskey:blitsprite(10,498,saccept) end
		screen.print(40,500,LANGUAGE["NPDRMFREE_INSTALL"],1,color.white,color.black, __ALEFT)

		if buttonskey then buttonskey:blitsprite(10,523,scancel) end
		screen.print(40,525,LANGUAGE["STRING_BACK"],1,color.white,color.black, __ALEFT)

		if buttonskey2 then buttonskey2:blitsprite(930,523,1) end
		screen.print(925,525,LANGUAGE["STRING_CLOSE"],1,color.white,color.red, __ARIGHT)

		screen.flip()

		--------------------------	Controls	--------------------------

		if buttons.released[cancel] then break end

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

		if scroll_np.maxim > 0 then
			if buttons.up or buttons.analogly < -60 then scroll_np:up() end
			if buttons.down or buttons.analogly > 60 then scroll_np:down() end		

			--install plugin
			if buttons[accept] then
				
				files.copy("resources/pkgj/npdrm_free.prx", PMounts[scroll_np.sel].."pspemu/seplugins/")
				if files.exists(PMounts[scroll_np.sel].."pspemu/seplugins/npdrm_free.prx") then
					if back then back:blit(0,0) end
						message_wait(LANGUAGE["NPDRMFREE_INSTALLED"])
					os.delay(1500)
				end

				--Update vsh.txt
				if files.exists(PMounts[scroll_np.sel].."pspemu/seplugins/vsh.txt") then
					insert_plugin(PMounts[scroll_np.sel].."pspemu/seplugins/vsh.txt")
				else
					files.copy("resources/pkgj/vsh.txt", PMounts[scroll_np.sel].."pspemu/seplugins/")
				end
				if back then back:blit(0,0) end
					message_wait(LANGUAGE["NPDRMFREE_VSH_UPDATED"])
				os.delay(1500)

				--Update game.txt
				if files.exists(PMounts[scroll_np.sel].."pspemu/seplugins/game.txt") then
					insert_plugin(PMounts[scroll_np.sel].."pspemu/seplugins/game.txt")
							
				else
					files.copy("resources/pkgj/game.txt", PMounts[scroll_np.sel].."pspemu/seplugins/")
				end
				if back then back:blit(0,0) end
					message_wait(LANGUAGE["NPDRMFREE_GAME_UPDATED"])
				os.delay(1500)

			end

		end

	end

end
