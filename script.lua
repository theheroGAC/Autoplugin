--[[ 
	Autoinstall plugin
	
	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

--Show splash ...
splash.zoom("resources/splash.png")

color.loadpalette()

local wstrength = wlan.strength()
if wstrength then
	if wstrength > 55 then dofile("git/updater.lua") end
end

back = image.load("resources/back.png")

dofile("resources/tai.lua")
dofile("resources/commons.lua")
dofile("resources/extra.lua")
dofile("resources/autoplugin.lua")--Main Cycle
