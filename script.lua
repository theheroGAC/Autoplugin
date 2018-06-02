--[[ 
	AutoPlugin by theheroGAC
	Application, themes and files manager.
	
	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Onelua Designed By Gdljjrod & DevDavisNunez.
	
]]

dofile("git/shared.lua")
if __UPDATE == 1 then
	local wstrength = wlan.strength()
	if wstrength then
		if wstrength > 55 then dofile("git/updater.lua") end
	end
end

dofile("resources/autoplugin.lua")									