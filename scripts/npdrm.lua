
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

	local options = { "ux0:", "ur0:", "uma0:", "imc0:", "xmc0:" }
	local scroll_np = newScroll( options, #options)

	buttons.interval(10,10)
	while true do
		buttons.read()
		if back then back:blit(0,0) end

		screen.print(480,20,NPDRMFREE_TITLE,1,color.red, 0x0, __ACENTER)

		screen.print(10,500,STRING_CONFIRM_PLUGIN,1,color.white,color.black)

		local y = 75
		for i=scroll_np.ini, scroll_np.lim do
			if i == scroll_np.sel then draw.fillrect(5,y-4,945,27,color.green:a(90)) end
			screen.print(25,y, options[i].."pspemu/seplugins/", 1.2)
			y+=32
		end

		screen.print(10,522,STRING_BACK,1,color.white,color.black)
		screen.print(955,522,STRING_START_CLOSE,1,color.white,color.red, __ARIGHT)

		screen.flip()

		--------------------------	Controls	--------------------------

		if buttons[cancel] then break end

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

		if scroll_np.maxim > 0 then
			if buttons.up or buttons.analogly < -60 then scroll_np:up() end
			if buttons.down or buttons.analogly > 60 then scroll_np:down() end		

			if buttons[accept] then
				--install plugin
				if files.exists(options[scroll_np.sel]) then
					local info = os.devinfo(options[scroll_np.sel])
					if info then

						--install plugin
						files.copy("resources/pkgj/npdrm_free.prx", options[scroll_np.sel].."pspemu/seplugins/")
						if files.exists(options[scroll_np.sel].."pspemu/seplugins/npdrm_free.prx") then
							os.message(NPDRMFREE_INSTALLED)
						end

						--Update vsh.txt
						if files.exists(options[scroll_np.sel].."pspemu/seplugins/vsh.txt") then
							insert_plugin(options[scroll_np.sel].."pspemu/seplugins/vsh.txt")
						else
							files.copy("resources/pkgj/vsh.txt", options[scroll_np.sel].."pspemu/seplugins/")
						end
						os.message(NPDRMFREE_VSH_UPDATED)

						--Update game.txt
						if files.exists(options[scroll_np.sel].."pspemu/seplugins/game.txt") then
							insert_plugin(options[scroll_np.sel].."pspemu/seplugins/game.txt")
							
						else
							files.copy("resources/pkgj/game.txt", options[scroll_np.sel].."pspemu/seplugins/")
						end
						os.message(NPDRMFREE_GAME_UPDATED)

					end
				else
					os.message(NPDRMFREE_NO_PARTITION)
				end
			end

		end

	end

end
