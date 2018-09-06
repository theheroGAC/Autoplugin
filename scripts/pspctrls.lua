psp_plugins = {

--PSP game.txt
{ name = "Grand Theft Auto Remastered", path = "gta_remastered.prx" },
{ name = "Kingdom Hearts Remastered", path = "khbbs_remastered.prx" },
{ name = "Metal Gear Solid Remastered", path = "mgs_remastered.prx" },
{ name = "Prince Of Persia Remastered", path = "pop_remastered.prx" },
{ name = "Resistance Remastered", path = "resistance_remastered.prx" },
{ name = "SplinterCell Remastered", path = "splintercell_remastered.prx" },
{ name = "Tomb Raider Remastered", path = "tombraider_remastered.prx" },
{ name = "Warriors Remastered", path = "warriors_remastered.prx" },

}

function insert_psp_plugin(device,obj)

	--install plugin
	files.copy("resources/controls_psp/"..obj.path, device.."pspemu/seplugins/")
	if files.exists(device.."pspemu/seplugins/"..obj.path) then
		if back then back:blit(0,0) end
		message_wait(obj.name.."\n\n"..STRING_INSTALLED)
		os.delay(1500)
	end

	local nlinea, cont, _find, file_txt = 0,0,false, {}

	for line in io.lines(device.."pspemu/seplugins/game.txt") do
		cont += 1
		table.insert(file_txt,line)

		pathp,status = line:match("(.+) (.+)")

		if pathp then
			if pathp:lower() == "ms0:/seplugins/"..obj.path then
				_find = true
				nlinea = cont
			end
		end

	end

	if _find then
		file_txt[nlinea] = "ms0:/seplugins/"..obj.path.." 1"
	else
		table.insert(file_txt, "ms0:/seplugins/"..obj.path.." 1")
	end

	local fp = io.open(device.."pspemu/seplugins/game.txt", "w+")
	for s,t in pairs(file_txt) do
		fp:write(string.format('%s\n', tostring(t)))
	end
	fp:close()

end

function psp_ctrls()

	local partitions = { "ux0:", "ur0:", "uma0:", "imc0:", "xmc0:" }
	local options = {}

	for i=1,#partitions do
		if files.exists(partitions[i]) then
			local device_info = os.devinfo(partitions[i])
			if device_info then
				table.insert(options,partitions[i])
			end
		end
	end

	local selector,lim,toinstall,x_scr = 1,10,0,5
	local scroll_psp = newScroll(psp_plugins, #psp_plugins)

	buttons.interval(10,10)
	while true do
		buttons.read()
		if back then back:blit(0,0) end

		screen.print(480,10,PSPCTRLS_TITLE,1,color.red, 0x0, __ACENTER)

		--Partitions
		local xRoot = 500
		local w = (955-xRoot)/#options
		for i=1, #options do
			if selector == i then
				draw.fillrect(xRoot,55,w,28, color.shine:a(90))
			end
			screen.print(xRoot+(w/2), 60, options[i], 1, color.white, color.blue, __ACENTER)
			xRoot += w
		end

		--List of Plugins
		local y = 105
		for i=scroll_psp.ini, scroll_psp.lim do

			if i == scroll_psp.sel then draw.fillrect(0,y-4,943,26,color.green:a(90)) end
			screen.print(35,y, psp_plugins[i].name)

			if psp_plugins[i].inst then
				screen.print(3,y,"-->",1,color.white,color.green)
			end

			y+=28
		end

		---- Draw Scroll Bar
		local ybar,hbar = 105, (lim*26)-2
		draw.fillrect(950,ybar-2,8,hbar,color.shine)
		if scroll_psp.maxim >= lim then
			local pos_height = math.max(hbar/scroll_psp.maxim, lim)
			--Bar Scroll
			draw.fillrect(950, ybar-2 + ((hbar-pos_height)/(scroll_psp.maxim-1))*(scroll_psp.sel-1), 8, pos_height, color.new(0,255,0))
		end

		if screen.textwidth(PSPCTRLS_DESCP) > 935 then
			x_scr = screen.print(x_scr, 415, PSPCTRLS_DESCP,1,color.white,color.orange,__SLEFT,935)
		else
			screen.print(480, 400, PSPCTRLS_DESCP,1,color.white,color.orange,__ACENTER)
		end

		screen.print(10,440,PSPCTRLS_CROSS_INSTALL,1,color.white,color.black)
		screen.print(10,460,INSTALLP_TRIANGLE_ALL,1,color.white,color.black)
		screen.print(10,480,PSPCTRLS_LR_SWAP,1,color.white,color.black)
		screen.print(10,500,INSTALLP_SQUARE_MARK,1,color.white,color.black)
		screen.print(955,500,INSTALLP_SELECT_CLEAN,1,color.white,color.black, __ARIGHT)

		screen.print(10,522,STRING_CIRCLE_BACK,1,color.white,color.black)
		screen.print(955,522,STRING_START_CLOSE,1,color.white,color.red, __ARIGHT)

		screen.flip()

		--------------------------	Controls	--------------------------

		if buttons.circle then break end

		--L/R
		if buttons.released.l or buttons.released.r then
			if buttons.released.l then selector -= 1 else selector += 1 end
			if selector > #options then selector = 1
			elseif selector < 1 then selector = #options end
		end

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

		if scroll_psp.maxim > 0 then
			if buttons.up or buttons.analogly < -60 then scroll_psp:up() x_scr = 5 end
			if buttons.down or buttons.analogly > 60 then scroll_psp:down() x_scr = 5 end		

			if buttons.cross then

				if not files.exists(options[selector].."pspemu/seplugins/game.txt") then
					files.copy("resources/controls_psp/game.txt", options[selector].."pspemu/seplugins/")
				end

				if toinstall <= 1 then
					--Update game.txt
					if files.exists(options[selector].."pspemu/seplugins/game.txt") then
						insert_psp_plugin(options[selector], psp_plugins[scroll_psp.sel])
					end

				else
					for i=1, scroll_psp.maxim do
						if psp_plugins[i].inst then
							insert_psp_plugin(options[selector], psp_plugins[i])
						end
					end
					os.delay(50)
				end

				for i=1,scroll_psp.maxim do
					psp_plugins[i].inst = false
					if toinstall >= 1 then toinstall-=1 end
				end

				os.message(PSPCTRLS_GAME_UPDATED)

			end--cross
			
			--Mark/Unmark
			if buttons.square then
				psp_plugins[scroll_psp.sel].inst = not psp_plugins[scroll_psp.sel].inst
				if psp_plugins[scroll_psp.sel].inst then toinstall+=1 else toinstall-=1 end
			end

			--Clean selected
			if buttons.select then
				for i=1,scroll_psp.maxim do
					psp_plugins[i].inst = false
					if toinstall >= 1 then toinstall-=1 end
				end
			end

			--Install ALL plugins
			if buttons.triangle then
				if not files.exists(options[selector].."pspemu/seplugins/game.txt") then
					files.copy("resources/controls_psp/game.txt", options[selector].."pspemu/seplugins/")
				end

				for i=1,scroll_psp.maxim do
					insert_psp_plugin(options[selector], psp_plugins[i])
				end

				os.message(PSPCTRLS_GAME_UPDATED)
			end

		end

	end

end
