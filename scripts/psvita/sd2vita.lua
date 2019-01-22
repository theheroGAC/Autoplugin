--[[ 
	Autoinstall plugin

	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Dev: TheHeroeGAC
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

function install()
	lenw1 = screen.textwidth(language["SD2VITA_1_WARNING"])
	lenw2 = screen.textwidth(language["SD2VITA_2_WARNING"])
	lenw3 = screen.textwidth(language["SD2VITA_3_WARNING"])
	lenw4 = screen.textwidth(language["SD2VITA_4_WARNING"])
	lenw5 = screen.textwidth(language["SD2VITA_5_WARNING"])

	local flag = false
	local x_lenw1, x_lenw2, x_lenw3, x_lenw4, x_lenw5 = 25, 25, 25, 25, 25
	while true do
		buttons.read()
		if back then back:blit(0, 0) end

		screen.print(480, 18, language["MENU_TITLE_SD2VITA"], 1.2, color.white, 0x0, __ACENTER)

		if lenw1 > 935 then
			x_lenw1 = screen.print(x_lenw1, 80, language["SD2VITA_1_WARNING"], 1, color.green, color.black, __SLEFT, 935)
		else
			screen.print(25, 80, language["SD2VITA_1_WARNING"], 1, color.green, color.black, __ALEFT)
		end

		if lenw2 > 935 then
			x_lenw2 = screen.print(x_lenw2, 110, language["SD2VITA_2_WARNING"], 1, color.green, color.black, __SLEFT, 935)
		else
			screen.print(25, 110, language["SD2VITA_2_WARNING"], 1, color.white, color.black, __ALEFT)
		end

		if lenw3 > 935 then
			x_lenw3 = screen.print(x_lenw3, 150, language["SD2VITA_3_WARNING"], 1, color.green, color.black, __SLEFT, 935)
		else
			screen.print(25, 150, language["SD2VITA_3_WARNING"], 1, color.red, color.black, __ALEFT)
		end

		if lenw4 > 935 then
			x_lenw4 = screen.print(x_lenw4, 175, language["SD2VITA_4_WARNING"], 1, color.green, color.black, __SLEFT, 935)
		else
			screen.print(25, 175, language["SD2VITA_4_WARNING"], 1, color.red, color.black, __ALEFT)
		end

		if lenw5 > 935 then
			x_lenw5 = screen.print(x_lenw5, 210, language["SD2VITA_5_WARNING"], 1, color.green, color.black, __SLEFT, 935)
		else
			screen.print(25, 210, language["SD2VITA_5_WARNING"], 1, color.white, color.black, __ALEFT)
		end

		if files.exists("gro0:") then
			local device_info = os.devinfo("gro0:")
			if device_info then
				flag = true
				screen.print(480, 250, language["SD2VITA_GAMECARD_DETECTED"], 1.5, color.white, color.orange, __ACENTER)
				screen.print(480, 280, language["SD2VITA_GAMECARD_REMOVED"], 1.3, color.white, color.orange, __ACENTER)
			else
				flag = false
			end
		end

		if not flag then
			if buttonskey then buttonskey:blitsprite(10, 448, saccept) end
			screen.print(35, 450, language["SD2VITA_INSTALL"], 1, color.white, color.blue, __ALEFT)
		end

		if buttonskey then buttonskey:blitsprite(10, 523, scancel) end
		screen.print(35, 525, language["SD2VITA_CANCEL"], 1, color.white, color.blue, __ALEFT)

		if buttonskey2 then buttonskey2:blitsprite(930, 523, 1) end
		screen.print(925, 525, language["STRING_CLOSE"], 1, color.white, color.red, __ARIGHT)

		screen.flip()

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

		if buttons[cancel] then return
		elseif buttons[accept] then
			if not flag then break else os.message(language["SD2VITA_GAMECARD_DETECTED"]) end
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
	if tai[__UR0].gameid["KERNEL"] then
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
		files.copy(path_plugins .. "storagemgr.skprx", "ur0:tai")
		files.copy(path_plugins .. "storage_config.txt", "ur0:tai")

		--Insert plugin to Config
		tai.put(__UR0, "KERNEL", "ur0:tai/storagemgr.skprx", 1)

		--Write
		tai.sync(__UR0)

		change = true
		buttons.homepopup(0)

		if back then back:blit(0, 0) end
		message_wait("PSVita-StorageMgr by CelesteBlue" .. "\n\n" .. language["STRING_INSTALLED"])
		os.delay(2000)

		configure()

		os.message(language["STRING_PSVITA_RESTART"])
		os.delay(150)
		buttons.homepopup(1)
		power.restart()

	else
		os.message(language["STRING_MISSING_CONFIG"])
	end
end

function configure()
	local original = read_storage_config()
	local mounts = {
		{ name = "none", friendly = language["MOUNT_NONE_FRIENDLY"], index = 1 },
		{ name = "ux0", friendly = language["MOUNT_UX0_FRIENDLY"], index = 2 },
		{ name = "xmc0", friendly = language["MOUNT_XMC0_FRIENDLY"], index = 3},
		{ name = "imc0", friendly = language["MOUNT_IMC0_FRIENDLY"], index = 4 },
		{ name = "uma0", friendly = language["MOUNT_UMA0_FRIENDLY"], index = 5 },
		{ name = "grw0", friendly = language["MOUNT_GRW0_FRIENDLY"], index = 6 },
	}
	local devices = {
		{ name = "MCD", friendly = language["SD2VITA_MCD_FRIENDLY"], mount = mounts[1] },
		{ name = "INT", friendly = language["SD2VITA_INT_FRIENDLY"], mount = mounts[1] },
		{ name = "GCD", friendly = language["SD2VITA_GCD_FRIENDLY"], mount = mounts[1] },
		{ name = "UMA", friendly = language["SD2VITA_UMA_FRIENDLY"], mount = mounts[1] }
	}

	devices = parse_mounts(devices, mounts, original)

	local scrollm = newScroll(devices, #devices)

	while true do
		buttons.read()
		if back then back:blit(0, 0) end

		screen.print(480, 18, language["SD2VITA_CONFIG_TITLE"], 1.2, color.white, 0x0, __ACENTER)

		screen.print(0, 80, language["SD2VITA_CONFIG_DEVICE"], 1, color.white, 0x0, __ALEFT)
		screen.print(480, 80, language["SD2VITA_CONFIG_MOUNT"], 1, color.white, 0x0, __ALEFT)

		local y = 120
		for i = scrollm.ini, scrollm.lim do
			if i == scrollm.sel then draw.fillrect(0, y - 7, 960, 29, color.green:a(90)) end
			screen.print(0, y, devices[i].name .. " (" .. devices[i].friendly .. ")", 1, color.white, 0x0, __ALEFT)
			screen.print(480, y, devices[i].mount.name .. " (" .. devices[i].mount.friendly .. ")", 1, color.white, 0x0, __ALEFT)
			y += 30
		end

		if buttonskey2 then buttonskey2:blitsprite(5, 448, 2) end
		if buttonskey2 then buttonskey2:blitsprite(35, 448, 3) end
		screen.print(70, 450, language["SD2VITA_CONFIG_CHANGE"], 1, color.white, color.black, __ALEFT)

		if buttonskey then buttonskey:blitsprite(5, 473, scancel) end
		screen.print(30, 475, language["SD2VITA_CONFIG_CANCEL"], 1, color.white, color.black, __ALEFT)

		if buttonskey then buttonskey:blitsprite(5, 498, __TRIANGLE) end
		screen.print(30, 500, language["SD2VITA_CONFIG_SAVE"], 1, color.white, color.black, __ALEFT)

		screen.flip()

		--Controls
		if buttons.up or buttons.analogly < -60 then scrollm:up() end
		if buttons.down or buttons.analogly > 60 then scrollm:down() end

		if buttons[cancel] then return end
		if buttons.triangle then check_storage_config(devices) end
		if buttons.released.l or buttons.released.left then
			devices[scrollm.sel].mount = mounts[new_mount(devices[scrollm.sel].mount.index, #mounts, false)]
		end
		if buttons.released.r or buttons.released.right then
			devices[scrollm.sel].mount = mounts[new_mount(devices[scrollm.sel].mount.index, #mounts, true)]
		end
	end
end

function new_mount(current, max, up)
	local newNumber = 0
	if up then
		newNumber = current + 1
	else
		newNumber = current - 1
	end

	if newNumber > max then
		newNumber = 1
	elseif newNumber < 1 then
		newNumber = max
	end

	return newNumber
end

function check_storage_config(devices)
	local valid = check_mount_duplicates(devices)

	if valid then valid = check_mount_ux0(devices) end

	if valid then
		save_storage_config(devices)
	else
		os.message(language["SD2VITA_INVALID_CONFIG"])
	end
end

function check_mount_duplicates(devices)
	local a={}
	for i=1,#devices do
		local current = devices[i].mount.index
		if current > 1 then
			for j=1,#a do
				if a[j] == current then
					return false
				end
			end
			a[#a+1] = current
		end
	end

	return true
end

function check_mount_ux0(devices)
	for i=1,#devices do
		if devices[i].mount.name == "ux0" then return true end
	end
	return false
end

function save_storage_config(devices)
	local d = ""
	for i=1,#devices do
		if devices[i].mount.index > 1 then
			d = d..devices[i].name.."="..devices[i].mount.name.."\n"
		end
	end
	files.write("ur0:tai/storage_config.txt", d)

	if back then back:blit(0, 0) end
	os.message(language["SD2VITA_UPDATED_CONFIG"])
	os.delay(2000)

	os.message(language["STRING_PSVITA_RESTART"])
	os.delay(150)
	buttons.homepopup(1)
	power.restart()
end

function read_storage_config()
	if files.exists("ur0:tai/storage_config.txt") then
		data = {}
		for line in io.lines("ur0:tai/storage_config.txt") do
			data[#data+1]=line
		end
	end
	return data
end

function parse_mounts(devices, mounts, original)
	for i=1,#original do
		for j=1,#devices do
			if original[i]:sub(1,3) == devices[j].name then
				for k=1,#mounts do
					if original[i]:sub(5) == mounts[k].name then
						devices[j].mount = mounts[k]
					end
				end
			end
		end
	end

	return devices
end

function sd2vita()
	if tai.find(__UR0, "KERNEL", "storagemgr.skprx") then
		configure()
	else
		install()
	end
end
