--[[ 
	Autoinstall plugin

	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Dev: TheHeroeGAC
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

local hencore_found = false
local hencore_patched = false
	
local convertimgsplash_callback = function ()
	customimgsplash()
end

local config_callback = function ()
	config_pkgj()
end

function qencore(path, mount)
	if os.message(LANGUAGE["MENU_QENCORE_ASK"].." "..mount.." ?", 1) == 1 then
		game.umount()
			game.mount(path)
			if files.extract("resources/qencore/sdat.zip", path) == 1 then
				hencore_patched, change = true,true
				if back then back:blit(0,0) end
					message_wait(LANGUAGE["MENU_INSTALLED_QENCORE"].." "..mount)
				os.delay(1500)
			else
				if back then back:blit(0,0) end
					message_wait(LANGUAGE["MENU_NOT_INSTALLED_QENCORE"].." "..mount)
				os.delay(1500)
			end
		game.umount()
	end
end

local qencore_callback = function ()

	hencore_found = false
	hencore_patched = false

	local QEpath = "user/00/savedata/PCSG90096"

	if back then back:blit(0,0) end
	message_wait()
	os.delay(1000)

	for i=1,#PMounts do
		if files.exists(PMounts[i]..QEpath) then
			hencore_found = true
			if PMounts[i] == "ux0:" then qencore("ux0:user/00/savedata/PCSG90096", PMounts[i])
			else
				--Move to ux0:
				files.rename(PMounts[i].."user/00/savedata/PCSG90096", "PCSG90096G")
				files.copy(PMounts[i].."user/00/savedata/PCSG90096G", "ux0:user/00/savedata/")
				files.delete(PMounts[i].."user/00/savedata/PCSG90096G")
				--Patched!!!
				qencore("ux0:user/00/savedata/PCSG90096G", PMounts[i])
				--Restore
				files.copy("ux0:user/00/savedata/PCSG90096G", PMounts[i].."user/00/savedata")
				files.delete("ux0:user/00/savedata/PCSG90096G")
				files.rename(PMounts[i].."user/00/savedata/PCSG90096G", "PCSG90096")
			end
		end
	end

	if hencore_found then
		if hencore_patched then
			if back then back:blit(0,0) end
			message_wait(LANGUAGE["MENU_QENCORE_PATCHED"].."\n\n"..LANGUAGE["STRING_PSVITA_RESTART"])
			os.delay(2500)
			buttons.homepopup(1)
			power.restart()
		else
			os.message(LANGUAGE["MENU_QENCORE_NOT_PATCHED"])
		end
	else
		os.message(LANGUAGE["MENU_QENCORE_NOGAME"])
	end
end

local customwarning_callback = function ()

	local pathCW = "ur0:tai/"
	if files.exists("ux0:tai/custom_warning.txt") then pathCW = "ux0:tai/" end

	local text = osk.init(LANGUAGE["INSTALLP_OSK_TITLE"], LANGUAGE["INSTALLP_OSK_TEXT"])
	if not text then return end

	local fp = io.open(pathCW.."custom_warning.txt", "wb")
	if fp then
		fp:write(string.char(0xFF)..string.char(0xFE))
		fp:write(os.toucs2(text))
		fp:close()
			
		if back then back:blit(0,0) end
			message_wait(LANGUAGE["CUSTOMWARNING_MESSAGE"])
		os.delay(1500)

		if os.message(LANGUAGE["RESTART_QUESTION"],1) == 1 then
			if back then back:blit(0,0) end
			message_wait(LANGUAGE["STRING_PSVITA_RESTART"])
			os.delay(1500)
			buttons.homepopup(1)
			power.restart()
		end

	end
end

local translate_callback = function ()
	translate()
end

function extras()

	local menuext = {
		{ text = LANGUAGE["MENU_QENCORE"],			 desc = LANGUAGE["MENU_QENCORE_DESC"],				funct = qencore_callback },
		{ text = LANGUAGE["PKGJ_TITLE"],	 		 desc = LANGUAGE["MENU_CUSTOM_CONFIG_DESC"],		funct = config_callback },
		{ text = LANGUAGE["MENU_CONVERTBOOTSPLASH"], desc = LANGUAGE["INSTALLP_DESC_CUSTOMBOOTSPLASH"],	funct = convertimgsplash_callback },
		{ text = LANGUAGE["MENU_CUSTOMWARNING"],	 desc = LANGUAGE["INSTALLP_DESC_CUSTOMWARNING"],	funct = customwarning_callback },
		{ text = LANGUAGE["MENU_TRANSLATE"],         desc = LANGUAGE["MENU_TRANSLATE_DESC"],            funct = translate_callback}
	}
	local scrollex = newScroll(menuext,#menuext)

	local x_scrext = 20
    while true do
		buttons.read()
		if change then buttons.homepopup(0) else buttons.homepopup(1) end

		if back then back:blit(0,0) end

        screen.print(480,20,LANGUAGE["MENU_EXTRAS"],1.3,color.green, 0x0, __ACENTER)

        local y = 160
        for i=scrollex.ini, scrollex.lim do
            if i == scrollex.sel then draw.offsetgradrect(0,y-10,960,32,color.shine:a(55),color.shine:a(105),0x0,0x0,21) end
            screen.print(480,y,menuext[i].text,1.2,color.white, 0x0, __ACENTER)
            y+=38
        end

		if screen.textwidth(menuext[scrollex.sel].desc) > 935 then
			x_scrext = screen.print(x_scrext, 520, menuext[scrollex.sel].desc,1,color.white,color.orange,__SLEFT,935)
		else
			screen.print(480, 520, menuext[scrollex.sel].desc,1,color.white,color.orange,__ACENTER)
		end

        screen.flip()

        --Controls
        if buttons.up or buttons.analogly < -60 then
			if scrollex:up() then x_scrext = 20 end
		end
        if buttons.down or buttons.analogly > 60 then
			if scrollex:down() then x_scrext = 20 end
		end

		if buttons[cancel] then break end
        if buttons[accept] then menuext[scrollex.sel].funct() end

    end

end
