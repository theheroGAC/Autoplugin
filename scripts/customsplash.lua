--[[ 
	Autoinstall plugin
	
	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

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

	local limit, scroll  = 10, newScroll(splash,limit)
	buttons.interval(10,10)
	while true do
		buttons.read()

		if back then back:blit(0,0) end

		screen.print(480,25,CUSTOMBOOTSPLASH__TITLE,1.3,color.green, 0x0, __ACENTER)

		if scroll.maxim > 0 then

			local y = 75
			for i=scroll.ini, scroll.lim do

				if i == scroll.sel then
					draw.fillrect(14,y-3,680,25,color.green:a(100))

					if not preview then
						preview = image.load(splash[i].path)
						if preview then
							preview:resize(252,151)
							preview:setfilter(__IMG_FILTER_LINEAR, __IMG_FILTER_LINEAR)
						end
					end
				end
				screen.print(20,y,splash[i].name,1.0,color.white,color.blue,__ALEFT)
				y += 32
			end

			--Bar Scroll
			local ybar, h = 70, (limit*32)-2
			draw.fillrect(3, ybar-2, 8, h, color.shine)
			if scroll.maxim >= limit then -- Draw Scroll Bar
				local pos_height = math.max(h/scroll.maxim, limit)
				draw.fillrect(3, ybar-2 + ((h-pos_height)/(scroll.maxim-1))*(scroll.sel-1), 8, pos_height, color.new(0,255,0))
			end

			if preview then
				preview:blit(700,84)
			end

		else
			screen.print(480,230, CUSTOMBOOTSPLASH_NOPNG_FOUND, 1, color.white, color.red, __ACENTER)
		end

		screen.print(480,450, STRING_CONFIRM_SPLASH, 1, color.green, 0x0,__ACENTER)
		screen.print(10,522, STRING_BACK, 1, color.white,color.black, __ALEFT)
		screen.print(955,522, STRING_START_CLOSE, 1, color.white,color.red, __ARIGHT)

		screen.flip()

		--Controls
		if scroll.maxim > 0 then

			if (buttons.up or buttons.analogly < -60) then
				if scroll:up() then preview = nil end
			end

			if (buttons.down or buttons.analogly > 60) then
				if scroll:down() then preview = nil end
			end

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

			if buttons[accept] then
				local res = img2splashbin(splash[scroll.sel].path)
				if res == 1 then

					if back then back:blit(0,0) end
						message_wait(CUSTOMBOOTSPLASH__MESSAGE)
					os.delay(1500)

					if os.message(CUSTOMBOOTSPLASH_RESTART,1) == 1 then
						if back then back:blit(0,0) end
							message_wait(STRING_PSVITA_RESTART)
						os.delay(1500)
						buttons.homepopup(1)
						power.restart()
					end
				end
			end

		end--maxim>0

	end--while

end
