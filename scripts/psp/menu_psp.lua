--[[ 
	Autoinstall plugin

	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Dev: TheHeroeGAC
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

function menu_psp()

	local npdrm_callback = function ()
		npdrm_free()
	end

	local psp_ctrls_callback = function ()
		psp_ctrls()
	end

	local menup = {
		{ text = MENU_INSTALL_NPDRMFREE,		desc = NPDRMFREE_DESC,	funct = npdrm_callback },
		{ text = MENU_INSTALL_REMASTERED_CTRLS,	desc = PSPCTRLS_DESC,	funct = psp_ctrls_callback },
	}
	local scrollpsp = newScroll(menup,#menup)

	local x_scrp = 25
	while true do
		buttons.read()
		if change then buttons.homepopup(0) else buttons.homepopup(1) end

		if back then back:blit(0,0) end
		if adr then adr:blit(0,64,65) end

		screen.print(480,25,MENU_TITLE_PSP,1.3,color.green, 0x0, __ACENTER)

		local y = 200
		for i=scrollpsp.ini, scrollpsp.lim do
			if i == scrollpsp.sel then draw.offsetgradrect(0,y-10,960,32,color.shine:a(55),color.shine:a(105),0x0,0x0,21) end
			screen.print(480,y,menup[i].text,1.2,color.white, 0x0, __ACENTER)
			y+=40
		end

		if screen.textwidth(menup[scrollpsp.sel].desc) > 935 then
			x_scrp = screen.print(x_scrp, 520, menup[scrollpsp.sel].desc,1,color.white,color.orange,__SLEFT,935)
		else
			screen.print(480, 520, menup[scrollpsp.sel].desc,1,color.white,color.orange,__ACENTER)
		end

		screen.flip()

		--Controls
		if buttons.up or buttons.analogly < -60 then
			if scrollpsp:up() then x_scrp = 25 end
		end
		if buttons.down or buttons.analogly > 60 then
			if scrollpsp:down() then x_scrp = 25 end
		end

		if buttons[cancel] then break end
		if buttons[accept] then menup[scrollpsp.sel].funct() end

	end
end

