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

	local limit, scrollp = 10, {}
	if tai[partition].gameid[ section[sel_section] ] then
		scrollp = newScroll( tai[partition].gameid[ section[sel_section] ].prx, limit)
	else
		scrollp = newScroll( {}, limit)
	end

	buttons.interval(10,10)
	while true do
		buttons.read()
		if back then back:blit(0,0) end

		screen.print(480,20,UNINSTALLP_TITLE,1,color.red, 0x0, __ACENTER)

		if not tai[partition].exist then screen.print(480,270,UNINSTALLP_NOCONFIG_FOUND..locations[partition],1.3,color.red, 0x0, __ACENTER)
		else

			screen.print(10,460,UNINSTALLP_CROSS_INSTALL,1,color.white,color.black)
			screen.print(10,480,UNINSTALLP_LR_SWAP,1,color.white,color.black)
			screen.print(10,500,UNINSTALLP_LEFTRIGHT_SECTION,1,color.white,color.black)

			--Partitions
			local xRoot = 750
			local w = (955-xRoot)/#locations
			for i=1, #locations do
				if partition == i then
					draw.fillrect(xRoot,30,w,30, color.green:a(90))
				end
				screen.print(xRoot+(w/2), 35, locations[i], 1, color.white, color.blue, __ACENTER)
				xRoot += w
			end

			screen.print(15,40, "*"..section[sel_section],1,color.yellow, 0x0)

			if tai[partition].gameid[ section[sel_section] ] then

				local y,ccolor = 75,color.white

				for i=scrollp.ini, scrollp.lim do
					if i == scrollp.sel then
						draw.fillrect(15,y-4,945,24,color.green:a(90))
					end

					if not files.exists(tai[partition].gameid[ section[sel_section] ].prx[i].path) then ccolor = color.orange end
					screen.print(20,y, tai[partition].gameid[ section[sel_section] ].prx[i].path,1,ccolor,0x0)
					y+=27
				end
			end

			---- Draw Scroll Bar
			local ybar,hbar = 75, (limit*27)-2
			draw.fillrect(5,ybar-2,8,hbar,color.shine)
			if scrollp.maxim >= limit then
				local pos_height = math.max(hbar/scrollp.maxim, limit)
				--Bar Scroll
				draw.fillrect(5, ybar-2 + ((hbar-pos_height)/(scrollp.maxim-1))*(scrollp.sel-1), 8, pos_height, color.new(0,255,0))
			end

			screen.print(480,410,locations[partition].."tai/config.txt",1.3,color.green, 0x0, __ACENTER)
		end

		screen.print(10,522,STRING_CIRCLE_BACK,1,color.white,color.black)
		screen.print(955,522,STRING_START_CLOSE,1,color.white,color.red, __ARIGHT)

		screen.flip()

		--------------------------	Controls	--------------------------
		
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

		if scrollp.maxim > 0 then
			if buttons.up or buttons.analogly < -60 then scrollp:up() end
			if buttons.down or buttons.analogly > 60 then scrollp:down() end		

			if buttons.cross then
				if tai[partition].gameid[ section[sel_section] ] then

					table.remove(tai[partition].raw, tai[partition].gameid[section[sel_section]].prx[scrollp.sel].line)
					
					local name = files.nopath(tai[partition].gameid[ section[sel_section] ].prx[scrollp.sel].path:lower())

					tai.sync(partition)
					tai.load()

					--for i=1,#tb_cop do
					for i=#tb_cop,1,-1 do
						if name == tb_cop[i].path then
							if tb_cop[i].section2 and tai[partition].gameid[ tb_cop[i].section2 ] then
								tai.del(partition, tb_cop[i].section2, tb_cop[i].path2)
								--break
								tai.sync(partition)
								tai.load()
							end
						elseif name == tb_cop[i].path2 then
							if tb_cop[i].section and tai[partition].gameid[ tb_cop[i].section ] then
								tai.del(partition, tb_cop[i].section, tb_cop[i].path)
								--break
								tai.sync(partition)
								tai.load()
							end
						end
					end

					--update
					if tai[partition].gameid[ section[sel_section] ] then
						scrollp = newScroll( tai[partition].gameid[ section[sel_section] ].prx, limit)
					else
						scrollp = newScroll( {}, limit)
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
					scrollp = newScroll( tai[partition].gameid[ section[sel_section] ].prx, limit)
				else
					scrollp = newScroll( {}, limit)
				end
			end

			if buttons.released.left then
				sel_section -=1
				if sel_section < 1 then	sel_section = #section end
				if tai[partition].gameid[ section[sel_section] ] then
					scrollp = newScroll( tai[partition].gameid[ section[sel_section] ].prx, limit)
				else
					scrollp = newScroll( {}, limit)
				end
			end
		end

		if buttons.released.l or buttons.released.r then
			if partition == __UX0 then partition = __UR0 else partition = __UX0 end
			if tai[partition].exist then
				sel_section = 1
				if tai[partition].gameid[ section[sel_section] ] then
					scrollp = newScroll( tai[partition].gameid[ section[sel_section] ].prx, limit)
				else
					scrollp = newScroll( {}, limit)
				end
			end
		end

	end

end
