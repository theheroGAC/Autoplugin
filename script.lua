--[[ 
	Autoinstall plugin
	
	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

--Show splash ...
splash.zoom("resources/splash.png")

back = image.load("resources/back.png")

color.loadpalette()

if os.access() == 0 then
	if back then back:blit(0,0) end
	screen.flip()
	os.message("UNSAFE MODE is required for this Homebrew !!!")
	os.exit()
end

local wstrength = wlan.strength()
if wstrength then
	if wstrength > 55 then dofile("git/updater.lua") end
end

dofile("scripts/tai.lua")
dofile("scripts/commons.lua")
dofile("scripts/autoplugin.lua")
dofile("scripts/pmanager.lua")
dofile("scripts/npdrm.lua")

local menu = {
	"Install Plugins",
	"Uninstall Plugins",
	"Install plugin npdrm free from Qwik (Adrenaline)",
	"Install ux0:pkgi/config.txt for PKGJ v0.31+",
	"Exit"
}
local scrollm,sel = newScroll(menu,#menu),1

change = false
buttons.interval(10,10)
while true do
	if change then buttons.homepopup(0) else buttons.homepopup(1) end
	buttons.read()
	if back then back:blit(0,0) end

	screen.print(480,20,"Autoplugin",1,color.green, 0x0, __ACENTER)

	local y = 190
	for i=scrollm.ini, scrollm.lim do
		if i == scrollm.sel then draw.fillrect(0,y-6,960,28,color.green:a(90)) end
		screen.print(480,y,menu[i],1.2,color.white, 0x0, __ACENTER)
		y+=35
	end

	screen.flip()

	--Controls
	if buttons.up or buttons.analogly < -60 then scrollm:up() end
	if buttons.down or buttons.analogly > 60 then scrollm:down() end

	if buttons.cross then
		if scrollm.sel == 1 then autoplugin()
		elseif scrollm.sel == 2 then pluginsmanager()
		elseif scrollm.sel == 3 then npdrm_free()
		elseif scrollm.sel == 4 then
			if back then back:blit(0,0) end
			files.copy("resources/pkgj/config.txt", "ux0:pkgi")
			message_wait("ux0:pkgi/config.txt for pkgj have been installed !!!")
			os.delay(2000)
		elseif scrollm.sel == 5 then
			if change then
				os.message("Your PSVita will restart")
				os.delay(250)
				buttons.homepopup(1)
				power.restart()
			end
			break
		end
	end

end
