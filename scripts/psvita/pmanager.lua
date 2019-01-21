--[[ 
	Autoinstall plugin

	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Dev: TheHeroeGAC
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

function pluginsmanager()

	local tb_cop = {}
	tb_cop = plugins
	table.insert(tb_cop, { name = "Kuio by Rinnegatamante", path = "kuio.skprx", section = "KERNEL",  path2 = false, section2 = false })
	table.insert(tb_cop, { name = "MiniVitaTV by TheOfficialFloW vbeta0.2", path = "minivitatv.skprx", section = "KERNEL",  path2 = "ds3.skprx", section2 = "KERNEL" })
	local section, sel_section = { "KERNEL", "main", "ALL" },1

	--Init load configs
	tai.load()
	local partition = 0
	if tai[__UX0].exist then partition = __UX0
	elseif tai[__UR0].exist then partition = __UR0
	end

	local limtpm, scrollp = 12, {}
	if tai[partition].gameid[ section[sel_section] ] then
		scrollp = newScroll( tai[partition].gameid[ section[sel_section] ].prx, limtpm)
	else
		scrollp = newScroll( {}, limtpm)
	end

	while true do
		buttons.read()
		if back then back:blit(0,0) end

		screen.print(480,18,language["UNINSTALLP_TITLE"],1.2,color.white, 0x0, __ACENTER)

		if not tai[partition].exist then screen.print(480,270,language["UNINSTALLP_NOCONFIG_FOUND"]..locations[partition],1.3,color.red, 0x0, __ACENTER)
		else

			--Partitions
			local xRoot = 750
			local w = (960-xRoot)/#locations
			for i=1, #locations do
				if partition == i then
					draw.fillrect(xRoot,0,w,40, color.green:a(90))
				end
				screen.print(xRoot+(w/2), 12, locations[i], 1, color.white, color.blue, __ACENTER)
				xRoot += w
			end

			draw.fillrect(0,40,960,350,color.shine:a(25))

			screen.print(15,40, "*"..section[sel_section],1,color.yellow, 0x0)

			if tai[partition].gameid[ section[sel_section] ] then

				local y,ccolor = 72,color.white

				for i=scrollp.ini, scrollp.lim do
					if i == scrollp.sel then
						
						if scrollp.maxim >= limtpm then draw.fillrect(3,y-5,943,25,color.green:a(105))
						else draw.fillrect(3,y-5,953,25,color.green:a(105)) end
					end

					if not files.exists(tai[partition].gameid[ section[sel_section] ].prx[i].path) then ccolor = color.orange end
					screen.print(20,y, tai[partition].gameid[ section[sel_section] ].prx[i].path,1,ccolor,0x0)
					y+=27
				end
			end

			---- Draw Scroll Bar
			local ybar,hbar = 70, (limtpm*27)-2
			if scrollp.maxim >= limtpm then
				draw.fillrect(950,ybar-2,8,hbar,color.shine)
				local pos_height = math.max(hbar/scrollp.maxim, limtpm)
				--Bar Scroll
				draw.fillrect(950, ybar-2 + ((hbar-pos_height)/(scrollp.maxim-1))*(scrollp.sel-1), 8, pos_height, color.new(0,255,0))
			end

			screen.print(480,405,locations[partition].."tai/config.txt",1.3,color.green, 0x0, __ACENTER)
			
			if buttonskey then buttonskey:blitsprite(5,448,saccept) end
			screen.print(30,450,language["UNINSTALLP_PLUGIN"],1,color.white,color.black,__ALEFT)

			screen.print(10,475,language["UNINSTALLP_LEFTRIGHT_SECTION"],1,color.white,color.black,__ALEFT)

			if buttonskey2 then buttonskey2:blitsprite(5,498,2) end
			if buttonskey2 then buttonskey2:blitsprite(35,498,3) end
			screen.print(70,500,language["INSTALLP_LR_SWAP"],1,color.white,color.black,__ALEFT)

		end

		if buttonskey then buttonskey:blitsprite(10,523,scancel) end
		screen.print(35,525,language["STRING_BACK"],1,color.white,color.black, __ALEFT)
		
		if buttonskey2 then buttonskey2:blitsprite(930,523,1) end
		screen.print(925,525,language["STRING_CLOSE"],1,color.white,color.red, __ARIGHT)

		screen.flip()

		--------------------------	Controls	--------------------------
		
		if buttons.released[cancel] then break end

		--Exit
		if buttons.start then
			if change then
				os.message(language["STRING_PSVITA_RESTART"])
				os.delay(250)
				buttons.homepopup(1)
				power.restart()
			end
			os.exit()
		end

		if scrollp.maxim > 0 then
			if buttons.up or buttons.analogly < -60 then scrollp:up() end
			if buttons.down or buttons.analogly > 60 then scrollp:down() end		

			if buttons[accept] then
				if tai[partition].gameid[ section[sel_section] ] then

					table.remove(tai[partition].raw, tai[partition].gameid[section[sel_section]].prx[scrollp.sel].line)
					local name = files.nopath(tai[partition].gameid[ section[sel_section] ].prx[scrollp.sel].path:lower())

					if name != "adrenaline_kernel.skprx" then files.delete(tai[partition].gameid[ section[sel_section] ].prx[scrollp.sel].path) end

					tai.sync(partition)
					tai.load()

					for i=#tb_cop,1,-1 do
						if name == tb_cop[i].path then
							if tb_cop[i].section2 and tai[partition].gameid[ tb_cop[i].section2 ] then

								--delete plugin physical
								local idx = tai.find(partition, tb_cop[i].section2, tb_cop[i].path2)
								if idx then
									if name != "adrenaline_kernel.skprx" then files.delete(tai[partition].gameid[ tb_cop[i].section2 ].prx[idx].path) end
								end
		
								tai.del(partition, tb_cop[i].section2, tb_cop[i].path2)
								--break
								tai.sync(partition)
								tai.load()

							end
						elseif name == tb_cop[i].path2 then
							if tb_cop[i].section and tai[partition].gameid[ tb_cop[i].section ] then
							
								local idx = tai.find(partition, tb_cop[i].section, tb_cop[i].path)
								if idx then
									if name != "adrenaline_kernel.skprx" then files.delete(tai[partition].gameid[ tb_cop[i].section ].prx[idx].path) end
								end

								tai.del(partition, tb_cop[i].section, tb_cop[i].path)
								--break
								tai.sync(partition)
								tai.load()
								
							end
						end
					end

					--update
					if tai[partition].gameid[ section[sel_section] ] then
						scrollp = newScroll( tai[partition].gameid[ section[sel_section] ].prx, limtpm)
					else
						scrollp = newScroll( {}, limtpm)
					end
					change = true
					buttons.homepopup(0)
				end
			end

		end

		if tai[partition].exist then
			if buttons.released.right then
				sel_section +=1
				if sel_section > #section then sel_section = 1 end
				if tai[partition].gameid[ section[sel_section] ] then
					scrollp = newScroll( tai[partition].gameid[ section[sel_section] ].prx, limtpm)
				else
					scrollp = newScroll( {}, limtpm)
				end
			end

			if buttons.released.left then
				sel_section -=1
				if sel_section < 1 then	sel_section = #section end
				if tai[partition].gameid[ section[sel_section] ] then
					scrollp = newScroll( tai[partition].gameid[ section[sel_section] ].prx, limtpm)
				else
					scrollp = newScroll( {}, limtpm)
				end
			end
		end

		if buttons.released.l or buttons.released.r then
			if partition == __UX0 then partition = __UR0 else partition = __UX0 end
			if tai[partition].exist then
				sel_section = 1
				if tai[partition].gameid[ section[sel_section] ] then
					scrollp = newScroll( tai[partition].gameid[ section[sel_section] ].prx, limtpm)
				else
					scrollp = newScroll( {}, limtpm)
				end
			end
		end

	end

end
