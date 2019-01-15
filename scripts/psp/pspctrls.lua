--[[ 
	Autoinstall plugin

	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Dev: TheHeroeGAC
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

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

	local selector,lim,toinstall,x_scr = 1,12,0,5
	local scroll_psp = newScroll(psp_plugins, #psp_plugins)

	for i=1,scroll_psp.maxim do
		psp_plugins[i].inst = false
	end

	while true do
		buttons.read()
		if back then back:blit(0,0) end

		screen.print(480,18,PSPCTRLS_TITLE,1.2,color.white, 0x0, __ACENTER)

		--Partitions
		local xRoot = 700
		local w = (955-xRoot)/#options
		for i=1, #options do
			if selector == i then
				draw.fillrect(xRoot,58,w,40, color.shine:a(105))
			end
			screen.print(xRoot+(w/2), 70, options[i], 1, color.white, color.blue, __ACENTER)
			xRoot += w
		end

		draw.fillrect(0,64,960,322,color.shine:a(25))

		--List of Plugins
		local y = 105
		for i=scroll_psp.ini, scroll_psp.lim do

			if i == scroll_psp.sel then
				if scroll_psp.maxim >= lim then draw.fillrect(3,y-4,943,26,color.green:a(105))
				else draw.fillrect(3,y-4,953,26,color.green:a(105)) end
			end
			--draw.fillrect(0,y-4,943,26,color.green:a(105)) end
			screen.print(35,y, psp_plugins[i].name)

			if psp_plugins[i].inst then
				screen.print(3,y,"-->",1,color.white,color.green)
			end

			y+=28
		end

		---- Draw Scroll Bar
		local ybar,hbar = 105, (lim*28)-2
		if scroll_psp.maxim >= lim then
			draw.fillrect(950,ybar-2,8,hbar,color.shine)
			local pos_height = math.max(hbar/scroll_psp.maxim, lim)
			--Bar Scroll
			draw.fillrect(950, ybar-2 + ((hbar-pos_height)/(scroll_psp.maxim-1))*(scroll_psp.sel-1), 8, pos_height, color.new(0,255,0))
		end

		if screen.textwidth(PSPCTRLS_DESC) > 935 then
			x_scr = screen.print(x_scr, 400, PSPCTRLS_DESC,1,color.white,color.orange,__SLEFT,935)
		else
			screen.print(480, 400, PSPCTRLS_DESC,1,color.white,color.orange,__ACENTER)
		end

		if buttonskey2 then buttonskey2:blitsprite(900,448,2) end
		if buttonskey2 then buttonskey2:blitsprite(930,448,3) end
		screen.print(895,450,PSPCTRLS_LR_SWAP,1,color.white,color.black,__ARIGHT)

		if buttonskey then buttonskey:blitsprite(10,448,__TRIANGLE) end
		screen.print(40,450,INSTALLP_ALL,1,color.white,color.black, __ALEFT)

		if buttonskey then buttonskey:blitsprite(10,472,__SQUARE) end
		screen.print(40,475,INSTALLP_MARK,1,color.white,color.black, __ALEFT)

		if buttonskey2 then buttonskey2:blitsprite(5,498,0) end
		screen.print(40,500,INSTALLP_CLEAN,1,color.white,color.black, __ALEFT)

		if buttonskey then buttonskey:blitsprite(10,523,scancel) end
		screen.print(40,525,STRING_BACK,1,color.white,color.black, __ALEFT)

		if buttonskey2 then buttonskey2:blitsprite(930,523,1) end
		screen.print(925,525,STRING_CLOSE,1,color.white,color.red, __ARIGHT)

		screen.flip()

		--------------------------	Controls	--------------------------

		if buttons.released[cancel] then break end

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

			if buttons.up or buttons.analogly < -60 then
				if scroll_psp:up() then x_scr = 5 end
			end
			if buttons.down or buttons.analogly > 60 then
				if scroll_psp:down() then x_scr = 5 end
			end

			if buttons[accept] then

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
					toinstall = 0
				end

				if back then back:blit(0,0) end
					message_wait(PSPCTRLS_GAME_UPDATED)
				os.delay(1500)

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
					toinstall = 0
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

				if back then back:blit(0,0) end
					message_wait(PSPCTRLS_GAME_UPDATED)
				os.delay(1500)
			end

		end

	end

end
