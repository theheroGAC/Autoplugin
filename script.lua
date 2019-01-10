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
	os.message(STRING_UNSAFE_MODE)
	os.exit()
end

-- Utilities
dofile("scripts/utilities/commons.lua")
dofile("scripts/utilities/plugins.lua")
dofile("scripts/utilities/tai.lua")

-- Main Menu
dofile("scripts/menus/main/exit.lua")
dofile("scripts/menus/main/installp.lua")
dofile("scripts/menus/main/uninstallp.lua")
dofile("scripts/menus/main/updatep.lua")

-- Extras Menu
dofile("scripts/menus/extras/customsplash.lua")
dofile("scripts/menus/extras/menu.lua")
dofile("scripts/menus/extras/npdrm.lua")
dofile("scripts/menus/extras/pspctrls.lua")
dofile("scripts/menus/extras/qencore.lua")
dofile("scripts/menus/extras/sd2vita.lua")

dofile("scripts/menus/main/menu.lua")--Main Cycle
