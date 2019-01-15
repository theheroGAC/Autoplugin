--[[ 
	Autoinstall plugin

	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Dev: TheHeroeGAC
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

lenw1 = screen.textwidth(SD2VITA_1_WARNING)
lenw2 = screen.textwidth(SD2VITA_2_WARNING)
lenw3 = screen.textwidth(SD2VITA_3_WARNING)
lenw4 = screen.textwidth(SD2VITA_4_WARNING)
lenw5 = screen.textwidth(SD2VITA_5_WARNING)

function sd2vita()

	local flag = false
	local x_lenw1,x_lenw2,x_lenw3,x_lenw4,x_lenw5 = 25,25,25,25,25
	while true do
		buttons.read()
		if back then back:blit(0,0) end

		screen.print(480,18,MENU_TITLE_SD2VITA,1.2,color.white, 0x0, __ACENTER)

		if lenw1 > 935 then
			x_lenw1 = screen.print(x_lenw1, 80, SD2VITA_1_WARNING,1,color.green, color.black, __SLEFT,935)
		else
			screen.print(25,80,SD2VITA_1_WARNING,1,color.green, color.black, __ALEFT)
		end

		if lenw2 > 935 then
			x_lenw2 = screen.print(x_lenw2, 110, SD2VITA_2_WARNING,1,color.green, color.black, __SLEFT,935)
		else
			screen.print(25,110,SD2VITA_2_WARNING,1,color.white, color.black,  __ALEFT)
		end

		if lenw3 > 935 then
			x_lenw3 = screen.print(x_lenw3, 150, SD2VITA_3_WARNING,1,color.green, color.black, __SLEFT,935)
		else
			screen.print(25,150,SD2VITA_3_WARNING,1,color.red, color.black,  __ALEFT)
		end

		if lenw4 > 935 then
			x_lenw4 = screen.print(x_lenw4, 175, SD2VITA_4_WARNING,1,color.green, color.black, __SLEFT,935)
		else
			screen.print(25,175,SD2VITA_4_WARNING,1,color.red, color.black,  __ALEFT)
		end

		if lenw5 > 935 then
			x_lenw5 = screen.print(x_lenw5, 210, SD2VITA_5_WARNING,1,color.green, color.black, __SLEFT,935)
		else
			screen.print(25,210,SD2VITA_5_WARNING,1,color.white, color.black,  __ALEFT)
		end

		if files.exists("gro0:") then
			local device_info = os.devinfo("gro0:")
			if device_info then
				flag = true
				screen.print(480,250,SD2VITA_GAMECARD_DETECTED,1.5,color.white, color.orange, __ACENTER)
				screen.print(480,280,SD2VITA_GAMECARD_REMOVED,1.3,color.white, color.orange, __ACENTER)
			else
				flag = false
			end
		end

		if not flag then
			if buttonskey then buttonskey:blitsprite(10,448,saccept) end
			screen.print(35,450,SD2VITA_INSTALL,1,color.white, color.blue, __ALEFT)
		end

		if buttonskey then buttonskey:blitsprite(10,523,scancel) end
		screen.print(35,525,SD2VITA_CANCEL,1,color.white, color.blue, __ALEFT)

		if buttonskey2 then buttonskey2:blitsprite(930,523,1) end
		screen.print(925,525,STRING_CLOSE,1,color.white,color.red, __ARIGHT)

		screen.flip()

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

		if buttons[cancel] then return
		elseif buttons[accept] then
			if not flag then break else os.message(SD2VITA_GAMECARD_DETECTED) end
		end

	end

	--No ur0:tai/config.txt
	if not tai[__UR0].exist then

		if tai[__UX0].exist then files.copy(tai[__UX0].path, "ur0:tai/") --If exist ux0:tai/config.txt copy to ur0:tai
		else
			files.copy("resources/config/config.txt", "ur0:tai/")
		end

		--Update configs
		tai.load()
	end

	--delete if plugin gamesd.skprx
	if tai[__UR0].gameid[ "KERNEL" ] then
		tai.del(__UR0, "KERNEL", "gamesd.skprx")
		--Write
		tai.sync(__UR0)
	end

	--Update configs
	tai.load()

	-- Delete ux0:tai/config.txt
	if tai[__UX0].exist then files.delete(tai[__UX0].path) end

	if files.exists(tai[__UR0].path) then

		--Install plugin to tai folder
		files.copy(path_plugins.."storagemgr.skprx", "ur0:tai")
		files.copy(path_plugins.."storage_config.txt", "ur0:tai")

		--Insert plugin to Config
		tai.put(__UR0, "KERNEL", "ur0:tai/storagemgr.skprx", 1)

		--Write
		tai.sync(__UR0)

		change = true
		buttons.homepopup(0)

		if back then back:blit(0,0) end
		message_wait("PSVita-StorageMgr by CelesteBlue".."\n\n"..STRING_INSTALLED)
		os.delay(2000)

		os.message(STRING_PSVITA_RESTART)
		os.delay(150)
		buttons.homepopup(1)
		power.restart()

	else
		os.message(STRING_MISSING_CONFIG)
	end

end
