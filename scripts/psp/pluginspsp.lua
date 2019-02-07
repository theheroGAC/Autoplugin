--[[ 
	Autoinstall plugin

	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Dev: TheHeroeGAC
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

pluginsP = {

{	showname = "CXMB", name="cxmb.prx", path = "cxmb/", desc = LANGUAGE["CXMB_DESC"], txt = "vsh.txt", config = false },

--Freakler
{	showname = "Camera Patch Lite", name = "camera_patch_lite.prx",	path = "seplugins/", desc = LANGUAGE["CAMERA_PATCH_DESC"], txt = "game.txt", config = "camera_patch_lite.ini" },
{	showname = "Lang Swapper", name = "LangSwapper.prx",	path = "seplugins/", desc = LANGUAGE["LANGSWAPPER_DESC"], txt = "game.txt", config = false },
{	showname = "Category lite", name = "category_lite.prx",	path = "seplugins/", desc = LANGUAGE["CATEGORYLITE_DESC"], txt = "vsh.txt", config = false },
{	showname = "Kingdom Hearts: Birth By Sleep/Final Mix UNDUB", name = "bbsfmUndub.prx",	path = "seplugins/", desc = LANGUAGE["KHBBS_UNDUB_DESC"], txt = "game.txt", config = false },

}

function add_psp_plugin(device,obj)

	--install plugin
	files.copy("resources/plugins_psp/"..obj.name, device.."pspemu/"..obj.path)

	if obj.config then
		files.copy("resources/plugins_psp/"..obj.config, device.."pspemu/"..obj.path)
	end

	--add vsh.txt&game.txt
	local nlinea, cont, _find, file_txt = 0,0,false, {}

	for line in io.lines(device.."pspemu/seplugins/"..obj.txt) do
		cont += 1
		table.insert(file_txt,line)

		pathp,status = line:match("(.+) (.+)")

		if pathp then
			if pathp:lower() == "ms0:/"..obj.path..obj.name then
				_find = true
				nlinea = cont
			end
		end

	end

	if _find then
		file_txt[nlinea] = "ms0:/"..obj.path..obj.name.." 1"
	else
		table.insert(file_txt, "ms0:/"..obj.path..obj.name.." 1")
	end

	local fp = io.open(device.."pspemu/seplugins/"..obj.txt, "w+")
	for s,t in pairs(file_txt) do
		fp:write(string.format('%s\n', tostring(t)))
	end
	fp:close()

end

function pluginsPSP()

	local selector,lim,toinstall,x_scr = 1,12,0,5
	local scroll_psp = newScroll(pluginsP, #pluginsP)

	for i=1,scroll_psp.maxim do
		pluginsP[i].inst = false
	end

	while true do
		buttons.read()
		if back then back:blit(0,0) end

		screen.print(480,18,LANGUAGE["PLUGINS_PSP_TITLE"],1.2,color.white, 0x0, __ACENTER)

		--Partitions
		local xRoot = 700
		local w = (955-xRoot)/#PMounts
		for i=1, #PMounts do
			if selector == i then
				draw.fillrect(xRoot,58,w,40, color.shine:a(105))
			end
			screen.print(xRoot+(w/2), 70, PMounts[i], 1, color.white, color.blue, __ACENTER)
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
			screen.print(35,y, pluginsP[i].showname)

			if pluginsP[i].inst then
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

		if screen.textwidth(pluginsP[scroll_psp.sel].desc) > 935 then
			x_scr = screen.print(x_scr, 400, pluginsP[scroll_psp.sel].desc,1,color.white,color.orange,__SLEFT,935)
		else
			screen.print(480, 400, pluginsP[scroll_psp.sel].desc,1,color.white,color.orange,__ACENTER)
		end

		if buttonskey2 then buttonskey2:blitsprite(900,448,2) end
		if buttonskey2 then buttonskey2:blitsprite(930,448,3) end
		screen.print(895,450,LANGUAGE["PSPCTRLS_LR_SWAP"],1,color.white,color.black,__ARIGHT)

		if buttonskey then buttonskey:blitsprite(10,448,__TRIANGLE) end
		screen.print(40,450,LANGUAGE["INSTALLP_ALL"],1,color.white,color.black, __ALEFT)

		if buttonskey then buttonskey:blitsprite(10,472,__SQUARE) end
		screen.print(40,475,LANGUAGE["INSTALLP_MARK"],1,color.white,color.black, __ALEFT)

		if buttonskey2 then buttonskey2:blitsprite(5,498,0) end
		screen.print(40,500,LANGUAGE["INSTALLP_CLEAN"],1,color.white,color.black, __ALEFT)

		if buttonskey then buttonskey:blitsprite(10,523,scancel) end
		screen.print(40,525,LANGUAGE["STRING_BACK"],1,color.white,color.black, __ALEFT)

		if buttonskey2 then buttonskey2:blitsprite(930,523,1) end
		screen.print(925,525,LANGUAGE["STRING_CLOSE"],1,color.white,color.red, __ARIGHT)

		screen.flip()

		--------------------------	Controls	--------------------------

		if buttons.released[cancel] then break end

		--L/R
		if buttons.released.l or buttons.released.r then
			if buttons.released.l then selector -= 1 else selector += 1 end
			if selector > #PMounts then selector = 1
			elseif selector < 1 then selector = #PMounts end
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

		if scroll_psp.maxim > 0 then

			if buttons.up or buttons.analogly < -60 then
				if scroll_psp:up() then x_scr = 5 end
			end
			if buttons.down or buttons.analogly > 60 then
				if scroll_psp:down() then x_scr = 5 end
			end

			if buttons[accept] then

				if not files.exists(PMounts[selector].."pspemu/seplugins/vsh.txt") then
					files.new(PMounts[selector].."pspemu/seplugins/vsh.txt")
				end
				if not files.exists(PMounts[selector].."pspemu/seplugins/game.txt") then
					files.new(PMounts[selector].."pspemu/seplugins/game.txt")
				end

				if toinstall <= 1 then
					add_psp_plugin(PMounts[selector], pluginsP[scroll_psp.sel])
					if back then back:blit(0,0) end
						message_wait(pluginsP[scroll_psp.sel].showname.."\n\n"..LANGUAGE["STRING_INSTALLED"])
					os.delay(750)
				else
					for i=1, scroll_psp.maxim do
						if pluginsP[i].inst then
							add_psp_plugin(PMounts[selector], pluginsP[i])
							if back then back:blit(0,0) end
								message_wait(pluginsP[i].showname.."\n\n"..LANGUAGE["STRING_INSTALLED"])
							os.delay(750)
						end
					end
				end

				for i=1,scroll_psp.maxim do
					pluginsP[i].inst = false
					toinstall = 0
				end

			end--cross
			
			--Mark/Unmark
			if buttons.square then
				pluginsP[scroll_psp.sel].inst = not pluginsP[scroll_psp.sel].inst
				if pluginsP[scroll_psp.sel].inst then toinstall+=1 else toinstall-=1 end
			end

			--Clean selected
			if buttons.select then
				for i=1,scroll_psp.maxim do
					pluginsP[i].inst = false
					toinstall = 0
				end
			end

			--Install ALL plugins
			if buttons.triangle then

				if not files.exists(PMounts[selector].."pspemu/seplugins/vsh.txt") then
					files.new(PMounts[selector].."pspemu/seplugins/vsh.txt")
				end
				if not files.exists(PMounts[selector].."pspemu/seplugins/game.txt") then
					files.new(PMounts[selector].."pspemu/seplugins/game.txt")
				end

				for i=1,scroll_psp.maxim do
					add_psp_plugin(PMounts[selector], pluginsP[i])
					if back then back:blit(0,0) end
						message_wait(pluginsP[i].showname.."\n\n"..LANGUAGE["STRING_INSTALLED"])
					os.delay(750)
				end

			end

		end

	end

end
