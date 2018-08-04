--Plugins for SD2VITA in ur0:tai/config.txt


function sd2vita()

	splash.zoom("resources/SD2VITA.png")
	
	local flag = false
	while true do
		buttons.read()
		if back then back:blit(0,0) end
		screen.print(480,30,SD2VITA_1_WARNING,1.1,color.green, color.black, __ACENTER)
				
		screen.print(480,60,SD2VITA_2_WARNING,1,color.white, color.black, __ACENTER)
		screen.print(480,80,SD2VITA_3_WARNING,1,color.white, color.black, __ACENTER)
		screen.print(480,120,SD2VITA_4_WARNING,1,color.red, color.red, __ACENTER)
		screen.print(480,140,SD2VITA_5_WARNING,1,color.white, color.black, __ACENTER)
		screen.print(480,160,SD2VITA_6_WARNING,1,color.white, color.black, __ACENTER)
		
		if files.exists("gro0:") then
			local device_info = os.devinfo("gro0:")
			if device_info then
				flag = true
				screen.print(480,230,SD2VITA_GAMECARD_DETECTED,1.5,color.white, color.orange, __ACENTER)
				screen.print(480,270,SD2VITA_GAMECARD_REMOVED,1.3,color.white, color.orange, __ACENTER)
			else
				flag = false
			end
		end

		if not flag then
			screen.print(480,450,SD2VITA_TRIANGLE_INSTALL,1.1,color.white, color.blue, __ACENTER)
		end
		screen.print(480,490,SD2VITA_CIRCLE_CANCEL,1.1,color.white, color.blue, __ACENTER)

		screen.flip()

		if buttons.circle then return
		elseif buttons.triangle then
			if not flag then break else os.message(SD2VITA_GAMECARD_DETECTED) end
		end

	end

	--No ur0:tai/config.txt
	if not tai[__UR0].exist then

		if tai[__UX0].exist then files.copy(tai[__UX0].path, "ur0:tai/") --If exist ux0:tai/config.txt copy to ur0:tai
		else
			if version == "3.60" then files.copy("resources/config_360/config.txt", "ur0:tai/")	--Copy defect for config.txt
			else files.copy("resources/config_365/config.txt", "ur0:tai/") end					--3.65/3.67/3.68 same config.txt
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
