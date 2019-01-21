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

local wstrength = wlan.strength()
if wstrength then
	if wstrength > 55 then dofile("git/updater.lua") end
end

-- Loading language file
files.mkdir("ux0:data/AUTOPLUGIN/lang/")
dofile("lang/english_us.txt")

if files.exists("ux0:data/AUTOPLUGIN/lang/"..os.language()..".txt") then
	dofile("ux0:data/AUTOPLUGIN/lang/"..os.language()..".txt")	
end
if files.exists("lang/"..os.language()..".txt") then
	dofile("lang/"..os.language()..".txt")
end

-- Loading font
files.mkdir("ux0:data/AUTOPLUGIN/font/")
if files.exists("ux0:data/AUTOPLUGIN/font/font.ttf") then
	fnt = font.load("ux0:data/AUTOPLUGIN/font/font.ttf")
elseif files.exists("ux0:data/AUTOPLUGIN/font/font.pgf") then
	fnt = font.load("ux0:data/AUTOPLUGIN/font/font.pgf")
elseif files.exists("ux0:data/AUTOPLUGIN/font/font.pvf") then
	fnt = font.load("ux0:data/AUTOPLUGIN/font/font.pvf")
end
if fnt then	font.setdefault(fnt) end

if os.access() == 0 then
	if back then back:blit(0,0) end
	screen.flip()
	os.message(language["STRING_UNSAFE_MODE"])
	os.exit()
end

dofile("scripts/tai.lua")
dofile("scripts/commons.lua")
dofile("scripts/installp.lua")
dofile("scripts/uninstallp.lua")
dofile("scripts/npdrm.lua")
dofile("scripts/pspctrls.lua")
dofile("scripts/sd2vita.lua")

dofile("menu.lua")--Main Cycle
