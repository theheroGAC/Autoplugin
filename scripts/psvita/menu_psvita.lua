--[[ 
	Autoinstall plugin

	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Dev: TheHeroeGAC
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

function menu_ps()

	local sd2vita_callback = function ()
		sd2vita()
	end

	local installp_callback = function ()
		autoplugin()
	end

	local uinstallp_callback = function ()
		pluginsmanager()
	end

	local onlineplugins_callback = function ()
		plugins_online()
	end

	if tai.find(__UR0, "KERNEL", "storagemgr.skprx") then
		LANGUAGE["MENU_INSTALL_SD2VITA"] = LANGUAGE["MENU_CONFIGURE_SD2VITA"]
		LANGUAGE["INSTALL_SD2VITA_DESC"] = LANGUAGE["CONFIG_SD2VITA_DESC"]
	end

	local menu_psvita = {
		{ text = LANGUAGE["MENU_INSTALL_PLUGINS"],		desc = LANGUAGE["INSTALL_PLUGINS_DESC"],	funct = installp_callback },
		{ text = LANGUAGE["MENU_UNINSTALL_PLUGINS"],	desc = LANGUAGE["UNINSTALL_PLUGINS_DESC"],	funct = uinstallp_callback },
		{ text = LANGUAGE["MENU_INSTALL_SD2VITA"],		desc = LANGUAGE["INSTALL_SD2VITA_DESC"],	funct = sd2vita_callback },
		{ text = LANGUAGE["MENU_CHECK_ONLINEP"],		desc = LANGUAGE["CHECK_ONLINEP_DESC"],		funct = onlineplugins_callback },
	}
	local scrollps = newScroll(menu_psvita,#menu_psvita)

	while true do
		buttons.read()
		if change then buttons.homepopup(0) else buttons.homepopup(1) end

		if back then back:blit(0,0) end
		if psvita then psvita:blit(0,64,45) end

		screen.print(480,25,LANGUAGE["MENU_TITLE_PSVITA"],1.3,color.green, 0x0, __ACENTER)

		local y = 160
		for i=scrollps.ini, scrollps.lim do
			if i == scrollps.sel then draw.offsetgradrect(0,y-10,960,32,color.shine:a(55),color.shine:a(105),0x0,0x0,21) end
			screen.print(480,y,menu_psvita[i].text,1.2,color.white, 0x0, __ACENTER)
			y+=38
		end

		if screen.textwidth(menu_psvita[scrollps.sel].desc) > 935 then
			x_scrp = screen.print(x_scrp, 520, menu_psvita[scrollps.sel].desc,1,color.white,color.orange,__SLEFT,935)
		else
			screen.print(480, 520, menu_psvita[scrollps.sel].desc,1,color.white,color.orange,__ACENTER)
		end

		screen.flip()

		--Controls
		if buttons.up or buttons.analogly < -60 then scrollps:up() end
		if buttons.down or buttons.analogly > 60 then scrollps:down() end

		if buttons[cancel] then break end
		if buttons[accept] then menu_psvita[scrollps.sel].funct() end

	end
end

