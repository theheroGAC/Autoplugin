--[[ 
	Autoinstall plugin

	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Dev: TheHeroeGAC
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

--Activamos Paleta de Colores Precargados
color.loadpalette()

--Show splash
splash.zoom("resources/splash.png")

--Imagen de Fondo
back = image.load("resources/back.png")
adr = image.load("resources/adr.png")
psvita = image.load("resources/psvita.png")

--Sprites para Botones
buttonskey = image.load("resources/buttons.png",20,20)
buttonskey2 = image.load("resources/buttons2.png",30,20)

if os.access() == 0 then
	if back then back:blit(0,0) end
	screen.flip()
	os.message(LANGUAGE["STRING_UNSAFE_MODE"])
	os.exit()
end

--Updater
if check_online() then dofile("git/updater.lua") end

__LANG = os.language()

-- Loading font
files.mkdir("ux0:data/AUTOPLUGIN/font/")
if __LANG == "CHINESE_T" or __LANG == "CHINESE_S" then
	if not files.exists("ux0:data/AUTOPLUGIN/font/font.pgf") then
		message_wait(CHINESE_FONT_DOWNLOAD)
		http.getfile("https://raw.githubusercontent.com/theheroGAC/Autoplugin/master/translations/font/font.pgf", "ux0:data/AUTOPLUGIN/font/font.pgf")
	end
end

fnt = font.load("ux0:data/AUTOPLUGIN/font/font.pgf") or font.load("ux0:data/AUTOPLUGIN/font/font.pvf") or font.load("ux0:data/AUTOPLUGIN/font/font.ttf")
if fnt then	font.setdefault(fnt) end

dofile("scripts/scroll.lua")
dofile("scripts/tai.lua")
dofile("scripts/language.lua")
dofile("scripts/commons.lua")


--Funciones PSVITA
dofile("scripts/psvita/sd2vita.lua")
dofile("scripts/psvita/plugins.lua")
dofile("scripts/psvita/pmanager.lua")
dofile("scripts/psvita/autoplugin.lua")
dofile("scripts/psvita/onlinep.lua")
dofile("scripts/psvita/menu_psvita.lua")

--Funciones PSP
dofile("scripts/psp/npdrm.lua")
dofile("scripts/psp/pspctrls.lua")
dofile("scripts/psp/menu_psp.lua")

--Funciones EXTRAS
dofile("scripts/extras/customsplash.lua")
dofile("scripts/extras/menu_extras.lua")
dofile("scripts/extras/translate.lua")

--Main Cycle
dofile("menu.lua")
