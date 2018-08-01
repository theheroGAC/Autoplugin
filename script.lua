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

-- Loading language file
files.mkdir("ux0:data/AUTOPLUGIN/lang/")
__LANG = os.language()
__STRINGS		= 44
if files.exists("ux0:data/AUTOPLUGIN/lang/"..__LANG..".txt") then
	dofile("ux0:data/AUTOPLUGIN/lang/"..__LANG..".txt")
else
	dofile("lang/english_us.txt")
end

if os.access() == 0 then
	if back then back:blit(0,0) end
	screen.flip()
	os.message(STRING_UNSAFE_MODE)
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
dofile("scripts/sd2vita.lua")

dofile("scripts/menu.lua")--Main Cycle
