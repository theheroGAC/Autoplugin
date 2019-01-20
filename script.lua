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
if wlan.strength() > 55 then dofile("git/updater.lua") end

-- Loading language file
LANGUAGE = {}
CURRENT_TRANSLATION = {}
CUSTOM_TRANSLATION = {}

function update_language(newlang)
	for k, v in pairs(newlang) do
		LANGUAGE[k] = v
	end
end


dofile("lang/ENGLISH_US.lua")
update_language(ENGLISH_US)
-- Official Translations
if files.exists("lang/"..os.language()..".lua") then
	dofile("lang/"..os.language()..".lua")

	if os.language() == "CHINESE_S" then
		update_language(CHINESE_S)
		CURRENT_TRANSLATION=CHINESE_S
	elseif os.language() == "CHINESE_T" then
		update_language(CHINESE_T)
		CURRENT_TRANSLATION=CHINESE_T
	elseif os.language() == "ENGLISH_US" then
		CURRENT_TRANSLATION=ENGLISH_US
	elseif os.language() == "FRENCH" then
		update_language(FRENCH)
		CURRENT_TRANSLATION=FRENCH
	elseif os.language() == "GERMAN" then
		update_language(GERMAN)
		CURRENT_TRANSLATION=GERMAN
	elseif os.language() == "ITALIAN" then
		update_language(ITALIAN)
		CURRENT_TRANSLATION=ITALIAN
	elseif os.language() == "JAPANESE" then
		update_language(JAPANESE)
		CURRENT_TRANSLATION=JAPANESE
	elseif os.language() == "SPANISH" then
		update_language(SPANISH)
		CURRENT_TRANSLATION=SPANISH
	end
end

-- User Translations
files.mkdir("ux0:data/AUTOPLUGIN/lang/")
if files.exists("ux0:data/AUTOPLUGIN/lang/"..os.language()..".lua") then
	dofile("ux0:data/AUTOPLUGIN/lang/"..os.language()..".lua")

	if os.language() == "CHINESE_S" then
		update_language(CUSTOM_CHINESE_S)
		CUSTOM_TRANSLATION=CUSTOM_CHINESE_S
	elseif os.language() == "CHINESE_T" then
		update_language(CUSTOM_CHINESE_T)
		CUSTOM_TRANSLATION=CUSTOM_CHINESE_T
	elseif os.language() == "ENGLISH_US" then
		update_language(CUSTOM_ENGLISH_US)
		CUSTOM_TRANSLATION=CUSTOM_ENGLISH_US
	elseif os.language() == "FRENCH" then
		update_language(CUSTOM_FRENCH)
		CUSTOM_TRANSLATION=CUSTOM_FRENCH
	elseif os.language() == "GERMAN" then
		update_language(CUSTOM_GERMAN)
		CUSTOM_TRANSLATION=CUSTOM_GERMAN
	elseif os.language() == "ITALIAN" then
		update_language(CUSTOM_ITALIAN)
		CUSTOM_TRANSLATION=CUSTOM_ITALIAN
	elseif os.language() == "JAPANESE" then
		update_language(CUSTOM_JAPANESE)
		CUSTOM_TRANSLATION=CUSTOM_JAPANESE
	elseif os.language() == "SPANISH" then
		update_language(CUSTOM_SPANISH)
		CUSTOM_TRANSLATION=CUSTOM_SPANISH
	end

end

-- Loading font
files.mkdir("ux0:data/AUTOPLUGIN/font/")

if os.language() == "CHINESE_T" then
	if not files.exists("ux0:data/AUTOPLUGIN/font/font.pgf") then
		http.getfile("https://raw.githubusercontent.com/theheroGAC/Autoplugin/master/translations/font/font.pgf", "ux0:data/AUTOPLUGIN/font/font.pgf")
	end
end

fnt = font.load("ux0:data/AUTOPLUGIN/font/font.pgf") or font.load("ux0:data/AUTOPLUGIN/font/font.pvf") or font.load("ux0:data/AUTOPLUGIN/font/font.ttf")
if fnt then	font.setdefault(fnt) end

dofile("scripts/scroll.lua")
dofile("scripts/tai.lua")
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
