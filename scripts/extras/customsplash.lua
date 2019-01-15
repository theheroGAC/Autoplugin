--[[ 
	Autoinstall plugin
	
	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/

	Dev: TheHeroeGAC
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

function img2splashbin(path2img, img)

	if not img then	img = image.load(path2img) end

	if img then
		if img:getw() != 960 and img:geth() != 544 then img = img_fixed(img) end
			local data_img = image.data(img)
			if data_img then
				local fp = io.open("ur0:tai/boot_splash.bin","w+")
				if fp then
					fp:write(data_img)
					fp:close()
					os.message(INSTALLP_DESC_BOOTSPLASHDONE)
					return 1
				end
			end
		--else
		--	os.message(INSTALLP_DESC_SPLASHGH)
		--end
	end
	return 0
end

function customimgsplash()

	local png, splash = files.listfiles("ux0:CustomBootsplash/"), {}

	if png then
		if #png > 0 then
			for i=1,#png do
				if png[i].ext:upper() == "PNG" then
					table.insert(splash, { name = png[i].name, path = png[i].path })
				end
			end
		end
	end
	table.insert(splash, { name = "henkaku.png", path = "resources/boot_splash.png" })

	table.sort(splash,function(a,b) return string.lower(a.name)<string.lower(b.name) end)

	local limcs = 10
	local scrollcs =  newScroll(splash,limcs)
	while true do
		buttons.read()

		if back then back:blit(0,0) end

		screen.print(480,25,CUSTOMBOOTSPLASH__TITLE,1.3,color.green, 0x0, __ACENTER)

		if scrollcs.maxim > 0 then

			local y = 75
			for i=scrollcs.ini, scrollcs.lim do

				if i == scrollcs.sel then
					draw.fillrect(14,y-3,680,25,color.green:a(100))

					if not preview then
						preview = image.load(splash[i].path)
						if preview then
							preview:resize(252,151)
						end
					end
				end
				screen.print(20,y,splash[i].name,1.0,color.white,color.blue,__ALEFT)
				y += 32
			end

			--Bar Scroll
			local ybar, h = 70, (limcs*32)-2
			draw.fillrect(3, ybar-2, 8, h, color.shine)
			if scrollcs.maxim >= limcs then -- Draw Scroll Bar
				local pos_height = math.max(h/scrollcs.maxim, limcs)
				draw.fillrect(3, ybar-2 + ((h-pos_height)/(scrollcs.maxim-1))*(scrollcs.sel-1), 8, pos_height, color.new(0,255,0))
			end

			if preview then
				preview:blit(700,84)
			end

			if buttonskey then buttonskey:blitsprite(10,448,saccept) end
			screen.print(40,450, CUSTOMBOOTSPLASH_CONVERT, 1, color.white,color.black, __ALEFT)

			if buttonskey2 then buttonskey2:blitsprite(5,472,0) end
			screen.print(40,475, CUSTOMBOOTSPLASH_IMPORT, 1, color.white,color.black, __ALEFT)

		else
			screen.print(480,230, CUSTOMBOOTSPLASH_NOPNG_FOUND, 1, color.white, color.red, __ACENTER)
		end

		if buttonskey then buttonskey:blitsprite(10,523,scancel) end
		screen.print(35,525,STRING_BACK,1,color.white,color.black, __ALEFT)
		
		if buttonskey2 then buttonskey2:blitsprite(930,523,1) end
		screen.print(925,525,STRING_CLOSE,1,color.white,color.red, __ARIGHT)

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

		if scrollcs.maxim > 0 then

			if (buttons.up or buttons.analogly < -60) then
				if scrollcs:up() then preview = nil end
			end

			if (buttons.down or buttons.analogly > 60) then
				if scrollcs:down() then preview = nil end
			end

			if buttons[accept] then
				local res = img2splashbin(splash[scrollcs.sel].path)
				if res == 1 then

					if back then back:blit(0,0) end
					message_wait(CUSTOMBOOTSPLASH__MESSAGE)
					os.delay(1500)

					if os.message(RESTART_QUESTION,1) == 1 then
						if back then back:blit(0,0) end
						message_wait(STRING_PSVITA_RESTART)
						os.delay(1500)
						buttons.homepopup(1)
						power.restart()
					end
				end
				if back then back:blit(0,0) end
				--message_wait(CUSTOMBOOTSPLASH__MESSAGE)
				os.delay(150)
			end

			if buttons.select then
				local tmpimg, typeimg = image.import()
				if tmpimg then
					if typeimg == 2 then
						if img2splashbin("", tmpimg) == 1 then

							if back then back:blit(0,0) end
							message_wait(CUSTOMBOOTSPLASH__MESSAGE)
							os.delay(1500)

							if os.message(RESTART_QUESTION,1) == 1 then
								if back then back:blit(0,0) end
								message_wait(STRING_PSVITA_RESTART)
								os.delay(1500)
								buttons.homepopup(1)
								power.restart()
							end
						end
					else
						os.message(CUSTOMBOOTSPLASH_NOPNG)
					end
				end
			end

		end--maxim>0

	end--while

end
