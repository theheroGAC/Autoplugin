-- Loading language file

LANGUAGE = {}
CURRENT_TRANSLATION = {}
CUSTOM_TRANSLATION = {}

function update_language(newlang)
	for k, v in pairs(newlang) do
		LANGUAGE[k] = v
	end
end

function load_language(recive, slang)

	if slang == "JAPANESE" then
		if not JAPANESE then JAPANESE = {} end
		update_language(JAPANESE)
		recive=JAPANESE
	elseif slang == "ENGLISH_US" then
		if not ENGLISH_US then ENGLISH_US = {} end
		recive=ENGLISH_US
	elseif slang == "FRENCH" then
		if not FRENCH then FRENCH = {} end
		update_language(FRENCH)
		recive=FRENCH
	elseif slang == "SPANISH" then
		if not SPANISH then SPANISH = {} end
		update_language(SPANISH)
		recive=SPANISH
	elseif slang == "GERMAN" then
		if not GERMAN then GERMAN = {} end
		update_language(GERMAN)
		recive=GERMAN
	elseif slang == "ITALIAN" then
		if not ITALIAN then ITALIAN = {} end
		update_language(ITALIAN)
		recive=ITALIAN
	elseif slang == "DUTCH" then
		if not DUTCH then DUTCH = {} end
		update_language(DUTCH)
		recive=DUTCH
	elseif slang == "PORTUGUESE" then
		if not PORTUGUESE then PORTUGUESE = {} end
		update_language(PORTUGUESE)
		recive=PORTUGUESE
	elseif slang == "RUSSIAN" then
		if not RUSSIAN then RUSSIAN = {} end
		update_language(RUSSIAN)
		recive=RUSSIAN
	elseif slang == "KOREAN" then
		if not KOREAN then KOREAN = {} end
		update_language(KOREAN)
		recive=KOREAN
	elseif slang == "CHINESE_S" then
		if not CHINESE_S then CHINESE_S = {} end
		update_language(CHINESE_S)
		recive=CHINESE_S
	elseif slang == "CHINESE_T" then
		if not CHINESE_T then CHINESE_T = {} end
		update_language(CHINESE_T)
		recive=CHINESE_T
	elseif slang == "FINNISH" then
		if not FINNISH then FINNISH = {} end
		update_language(FINNISH)
		recive=FINNISH
	elseif slang == "SWEDISH" then
		if not SWEDISH then SWEDISH = {} end
		update_language(SWEDISH)
		recive=SWEDISH
	elseif slang == "NORWEGIAN" then
		if not NORWEGIAN then NORWEGIAN = {} end
		update_language(NORWEGIAN)
		recive=NORWEGIAN
	elseif slang == "POLISH" then
		if not POLISH then POLISH = {} end
		update_language(POLISH)
		recive=POLISH
	elseif slang == "PORTUGUESE_BR" then
		if not PORTUGUESE_BR then PORTUGUESE_BR = {} end
		update_language(PORTUGUESE_BR)
		recive=PORTUGUESE_BR
	elseif slang == "ENGLISH_GB" then
		if not ENGLISH_GB then ENGLISH_GB = {} end
		update_language(ENGLISH_GB)
		recive=ENGLISH_GB
	elseif slang == "TURKISH" then
		if not TURKISH then TURKISH = {} end
		update_language(TURKISH)
		recive=TURKISH
	end

end

dofile("lang/ENGLISH_US.lua")
update_language(ENGLISH_US)

-- Official Translations
if files.exists("lang/"..__LANG..".lua") then
	dofile("lang/"..__LANG..".lua")
	load_language(CURRENT_TRANSLATION, __LANG)
end

-- User Translations
files.mkdir("ux0:data/AUTOPLUGIN/lang/")
if files.exists("ux0:data/AUTOPLUGIN/lang/"..__LANG..".lua") then
	dofile("ux0:data/AUTOPLUGIN/lang/"..__LANG..".lua")
	if __LANG == "ENGLISH_US" then update_language(CUSTOM_ENGLISH_US) end
	load_language(CUSTOM_TRANSLATION, __LANG)
end
