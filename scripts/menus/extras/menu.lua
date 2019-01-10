function extras_menu()
	local sd2vita_callback = function ()
		sd2vita()
	end

	local convertimgsplash_callback = function ()
		customimgsplash()
	end

	local npdrm_callback = function ()
		npdrm_free()
	end

	local psp_ctrls_callback = function ()
		psp_ctrls()
	end

	local qencore_callback = function ()
		qencore()
	end

	local back_callback = function ()
		back_selected = true
	end

	local menu = {
			{ text = MENU_INSTALL_SD2VITA,			funct = sd2vita_callback },
			{ text = MENU_CONVERTBOOTSPLASH,		funct = convertimgsplash_callback },
			{ text = MENU_INSTALL_NPDRMFREE,		funct = npdrm_callback },
			{ text = MENU_INSTALL_REMASTERED_CTRLS,	funct = psp_ctrls_callback },
			{ text = MENU_QENCORE,					funct = qencore_callback },
			{ text = MENU_BACK,						funct = back_callback }
	}
	local scrollm,sel = newScroll(menu,#menu),1

	change = false
	buttons.interval(10,10)
	while true do
		if change then buttons.homepopup(0) else buttons.homepopup(1) end
		buttons.read()
		if back then back:blit(0,0) end
		if back_selected or buttons[cancel] then
			back_selected = false
			return
		end

		screen.print(480,25,MENU_EXTRAS,1.3,color.green, 0x0, __ACENTER)

		local y = 135
		for i=scrollm.ini, scrollm.lim do
			if i == scrollm.sel then draw.fillrect(0,y-7,960,29,color.green:a(90)) end
			screen.print(480,y,menu[i].text,1.2,color.white, 0x0, __ACENTER)
			y+=35
		end

		screen.flip()

		--Controls
		if buttons.up or buttons.analogly < -60 then scrollm:up() end
		if buttons.down or buttons.analogly > 60 then scrollm:down() end

		if buttons[accept] then menu[scrollm.sel].funct() end

	end


end
