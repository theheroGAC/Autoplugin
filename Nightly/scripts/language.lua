-- Loading language file

LANGUAGE = {}
CURRENT_TRANSLATION = {}
CUSTOM_TRANSLATION = {}

function update_language(newlang)
	for k,v in pairs(newlang) do
		LANGUAGE[k] = v
	end
end

function update_translations(orig,dest)
	for k,v in pairs(orig) do dest[k] = v end
end

function load_language(slang,mode)

	if slang == "JAPANESE" then
		if mode == 1 then
			if not JAPANESE then JAPANESE = {} end
			update_language(JAPANESE)
			update_translations(JAPANESE,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_JAPANESE then CUSTOM_JAPANESE = {} end
			update_language(CUSTOM_JAPANESE)
			update_translations(CUSTOM_JAPANESE,CUSTOM_TRANSLATION)
		end
	elseif slang == "ENGLISH_US" then
		if mode == 1 then
			if not ENGLISH_US then ENGLISH_US = {} end
			--update_language(ENGLISH_US)
			update_translations(ENGLISH_US,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_ENGLISH_US then CUSTOM_ENGLISH_US = {} end
			update_language(CUSTOM_ENGLISH_US)
			update_translations(CUSTOM_ENGLISH_US,CUSTOM_TRANSLATION)
		end
	elseif slang == "FRENCH" then
		if mode == 1 then
			if not FRENCH then FRENCH = {} end
			update_language(FRENCH)
			update_translations(FRENCH,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_FRENCH then CUSTOM_FRENCH = {} end
			update_language(CUSTOM_FRENCH)
			update_translations(CUSTOM_FRENCH,CUSTOM_TRANSLATION)
		end
	elseif slang == "SPANISH" then
		if mode == 1 then
			if not SPANISH then SPANISH = {} end
			update_language(SPANISH)
			update_translations(SPANISH,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_SPANISH then CUSTOM_SPANISH = {} end
			update_language(CUSTOM_SPANISH)
			update_translations(CUSTOM_SPANISH,CUSTOM_TRANSLATION)
		end
	elseif slang == "GERMAN" then
		if mode == 1 then
			if not GERMAN then GERMAN = {} end
			update_language(GERMAN)
			update_translations(GERMAN,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_GERMAN then CUSTOM_GERMAN = {} end
			update_language(CUSTOM_GERMAN)
			update_translations(CUSTOM_GERMAN,CUSTOM_TRANSLATION)
		end
	elseif slang == "ITALIAN" then
		if mode == 1 then
			if not ITALIAN then ITALIAN = {} end
			update_language(ITALIAN)
			update_translations(ITALIAN,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_ITALIAN then CUSTOM_ITALIAN = {} end
			update_language(CUSTOM_ITALIAN)
			update_translations(CUSTOM_ITALIAN,CUSTOM_TRANSLATION)
		end
	elseif slang == "DUTCH" then
		if mode == 1 then
			if not DUTCH then DUTCH = {} end
			update_language(DUTCH)
			update_translations(DUTCH,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_DUTCH then CUSTOM_DUTCH = {} end
			update_language(CUSTOM_DUTCH)
			update_translations(CUSTOM_DUTCH,CUSTOM_TRANSLATION)
		end
	elseif slang == "PORTUGUESE" then
		if mode == 1 then
			if not PORTUGUESE then PORTUGUESE = {} end
			update_language(PORTUGUESE)
			update_translations(PORTUGUESE,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_PORTUGUESE then CUSTOM_PORTUGUESE = {} end
			update_language(CUSTOM_PORTUGUESE)
			update_translations(CUSTOM_PORTUGUESE,CUSTOM_TRANSLATION)
		end
	elseif slang == "RUSSIAN" then
		if mode == 1 then
			if not RUSSIAN then RUSSIAN = {} end
			update_language(RUSSIAN)
			update_translations(RUSSIAN,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_RUSSIAN then CUSTOM_RUSSIAN = {} end
			update_language(CUSTOM_RUSSIAN)
			update_translations(CUSTOM_RUSSIAN,CUSTOM_TRANSLATION)
		end
	elseif slang == "KOREAN" then
		if mode == 1 then
			if not KOREAN then KOREAN = {} end
			update_language(KOREAN)
			update_translations(KOREAN,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_KOREAN then CUSTOM_KOREAN = {} end
			update_language(CUSTOM_KOREAN)
			update_translations(CUSTOM_KOREAN,CUSTOM_TRANSLATION)
		end
	elseif slang == "CHINESE_S" then
		if mode == 1 then
			if not CHINESE_S then CHINESE_S = {} end
			update_language(CHINESE_S)
			update_translations(CHINESE_S,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_CHINESE_S then CUSTOM_CHINESE_S = {} end
			update_language(CUSTOM_CHINESE_S)
			update_translations(CUSTOM_CHINESE_S,CUSTOM_TRANSLATION)
		end
	elseif slang == "CHINESE_T" then
		if mode == 1 then
			if not CHINESE_T then CHINESE_T = {} end
			update_language(CHINESE_T)
			update_translations(CHINESE_T,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_CHINESE_T then CUSTOM_CHINESE_T = {} end
			update_language(CUSTOM_CHINESE_T)
			update_translations(CUSTOM_CHINESE_T,CUSTOM_TRANSLATION)
		end
	elseif slang == "FINNISH" then
		if mode == 1 then
			if not FINNISH then FINNISH = {} end
			update_language(FINNISH)
			update_translations(FINNISH,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_FINNISH then CUSTOM_FINNISH = {} end
			update_language(CUSTOM_FINNISH)
			update_translations(CUSTOM_FINNISH,CUSTOM_TRANSLATION)
		end
	elseif slang == "SWEDISH" then
		if mode == 1 then
			if not SWEDISH then SWEDISH = {} end
			update_language(SWEDISH)
			update_translations(SWEDISH,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_SWEDISH then CUSTOM_SWEDISH = {} end
			update_language(CUSTOM_SWEDISH)
			update_translations(CUSTOM_SWEDISH,CUSTOM_TRANSLATION)
		end
	elseif slang == "NORWEGIAN" then
		if mode == 1 then
			if not NORWEGIAN then NORWEGIAN = {} end
			update_language(NORWEGIAN)
			update_translations(NORWEGIAN,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_NORWEGIAN then CUSTOM_NORWEGIAN = {} end
			update_language(CUSTOM_NORWEGIAN)
			update_translations(CUSTOM_NORWEGIAN,CUSTOM_TRANSLATION)
		end
	elseif slang == "POLISH" then
		if mode == 1 then
			if not POLISH then POLISH = {} end
			update_language(POLISH)
			update_translations(POLISH,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_POLISH then CUSTOM_POLISH = {} end
			update_language(CUSTOM_POLISH)
			update_translations(CUSTOM_POLISH,CUSTOM_TRANSLATION)
		end
	elseif slang == "PORTUGUESE_BR" then
		if mode == 1 then
			if not PORTUGUESE_BR then PORTUGUESE_BR = {} end
			update_language(PORTUGUESE_BR)
			update_translations(PORTUGUESE_BR,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_PORTUGUESE_BR then CUSTOM_PORTUGUESE_BR = {} end
			update_language(CUSTOM_PORTUGUESE_BR)
			update_translations(CUSTOM_PORTUGUESE_BR,CUSTOM_TRANSLATION)
		end
	elseif slang == "ENGLISH_GB" then
		if mode == 1 then
			if not ENGLISH_GB then ENGLISH_GB = {} end
			update_language(ENGLISH_GB)
			update_translations(ENGLISH_GB,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_ENGLISH_GB then CUSTOM_ENGLISH_GB = {} end
			update_language(CUSTOM_ENGLISH_GB)
			update_translations(CUSTOM_ENGLISH_GB,CUSTOM_TRANSLATION)
		end
	elseif slang == "TURKISH" then
		if mode == 1 then
			if not TURKISH then TURKISH = {} end
			update_language(TURKISH)
			update_translations(TURKISH,CURRENT_TRANSLATION)
		elseif mode == 2 then
			if not CUSTOM_TURKISH then CUSTOM_TURKISH = {} end
			update_language(CUSTOM_TURKISH)
			update_translations(CUSTOM_TURKISH,CUSTOM_TRANSLATION)
		end
	end

end

dofile("lang/ENGLISH_US.lua")
update_language(ENGLISH_US)

-- Official Translations
if files.exists("lang/"..__LANG..".lua") then
	dofile("lang/"..__LANG..".lua")
	load_language(__LANG, 1)
end

-- User Translations
files.mkdir("ux0:data/AUTOPLUGIN/lang/")
if files.exists("ux0:data/AUTOPLUGIN/lang/"..__LANG..".lua") then
	dofile("ux0:data/AUTOPLUGIN/lang/"..__LANG..".lua")
	load_language(__LANG, 2)
end
