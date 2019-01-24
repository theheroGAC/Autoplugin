function save_translation()
    local t = "CUSTOM_"..__LANG.."={}\n\n"
    for k,v in pairs(CUSTOM_TRANSLATION) do
        local table = "CUSTOM_"..__LANG.."[\""..k.."\"] ="
        if v ~= "" then
            local tabs = 14 - math.floor((string.len(table) / 4))
            t = t..table..string.rep("\t", tabs).."\""..v.."\"\n"
        end
    end
    files.write("ux0:data/AUTOPLUGIN/lang/"..__LANG..".lua", t)
    os.message("\n"..LANGUAGE["TRANSLATION_SAVED_1"].."\n\nux0:data/AUTOPLUGIN/lang/"..os.language()..".lua\n\n"..LANGUAGE["TRANSLATION_SAVED_2"])
end

function translate()
    local t_need = {}
    local t_has = {}
    for k in pairs(ENGLISH_US) do
        if CURRENT_TRANSLATION[k] == nil or CURRENT_TRANSLATION[k] == "" then
            t_need[#t_need+1] = k
        else
            t_has[#t_has+1] = k
        end
    end

    for i=0,#t_has do
        t_need[#t_need+1] = t_has[i]
    end

    local limit = 4
    local scroll = newScroll(t_need, limit)
    local xscr1 = {}
    local xscr2 = {}
    local xscr3 = {}
    local unsaved_translation = false

    while true do
        buttons.read()
        if back then back:blit(0, 0) end

        screen.print(480, 18, LANGUAGE["MENU_TRANSLATE"], 1.2, color.white, 0x0, __ACENTER)

        if #t_need == 0 then
            screen.print(480, 75, LANGUAGE["NOTHING_TO_TRANSLATE"], 1, color.white,0x0, __ACENTER)
        end

        local y = 75
        for i=scroll.ini,scroll.lim do

            if i == scroll.sel then draw.offsetgradrect(0,y-7,946,90,color.green:a(120),color.green:a(90),0x0,0x0,15) end

			screen.clip(0,0,945,544)

				if i==scroll.sel and (screen.textwidth(LANGUAGE["TRANSLATE_ENGLISH_TITLE"]..string.gsub(ENGLISH_US[t_need[i]],"\n","\\n")) > 935) then
					if xscr1[i] == nil then xscr1[i] = 5 end
					xscr1[i] = screen.print(xscr1[i], y,LANGUAGE["TRANSLATE_ENGLISH_TITLE"]..string.gsub(ENGLISH_US[t_need[i]],"\n","\\n"),1,color.white,0x0,__SLEFT,935)
				else
					screen.print(5, y,LANGUAGE["TRANSLATE_ENGLISH_TITLE"]..string.gsub(ENGLISH_US[t_need[i]],"\n","\\n"),1,color.white,0x0,__ALEFT)
				end

				if CURRENT_TRANSLATION[t_need[i]] == nil then CURRENT_TRANSLATION[t_need[i]] = "" end
				if i==scroll.sel and (screen.textwidth(LANGUAGE["TRANSLATE_CURRENT_TITLE"]..string.gsub(CURRENT_TRANSLATION[t_need[i]],"\n","\\n")) > 935) then
					if xscr2[i] == nil then xscr2[i] = 5 end
					xscr2[i] = screen.print(xscr2[i], y+30,LANGUAGE["TRANSLATE_CURRENT_TITLE"]..string.gsub(CURRENT_TRANSLATION[t_need[i]],"\n","\\n"),1,color.white,0x0,__SLEFT,935)
				else
					screen.print(5, y+30,LANGUAGE["TRANSLATE_CURRENT_TITLE"]..string.gsub(CURRENT_TRANSLATION[t_need[i]],"\n","\\n"),1,color.white,0x0,__ALEFT)
				end

				if CUSTOM_TRANSLATION[t_need[i]] == nil then CUSTOM_TRANSLATION[t_need[i]] = "" end
				if i==scroll.sel and (screen.textwidth(LANGUAGE["TRANSLATE_YOUR_TITLE"]..string.gsub(CUSTOM_TRANSLATION[t_need[i]],"\n","\\n")) > 935) then
					if xscr3[i] == nil then xscr3[i] = 5 end
					xscr3[i] = screen.print(xscr3[i], y+60,LANGUAGE["TRANSLATE_YOUR_TITLE"]..string.gsub(CUSTOM_TRANSLATION[t_need[i]],"\n","\\n"),1,color.white,0x0,__SLEFT,935)
				else
					screen.print(5, y+60,LANGUAGE["TRANSLATE_YOUR_TITLE"]..string.gsub(CUSTOM_TRANSLATION[t_need[i]],"\n","\\n"),1,color.white,0x0,__ALEFT)
				end

			screen.clip()

            y += 90
        end

        ---- Draw Scroll Bar
        local ybar,hbar = 70, 355
        draw.fillrect(950,ybar-2,8,hbar,color.shine)
        if scroll.maxim >= limit then
            local pos_height = math.max(hbar/scroll.maxim, limit)
            --Bar Scroll
            draw.fillrect(950, ybar-2 + ((hbar-pos_height)/(scroll.maxim-1))*(scroll.sel-1), 8, pos_height, color.new(0,255,0))
        end

        if buttonskey then buttonskey:blitsprite(5, 448, saccept) end
        screen.print(30, 450, LANGUAGE["MENU_TRANSLATE"], 1, color.white, color.black, __ALEFT)

        if buttonskey then buttonskey:blitsprite(5, 473, scancel) end
        screen.print(30, 475, LANGUAGE["SD2VITA_CONFIG_CANCEL"], 1, color.white, color.black, __ALEFT)

        if buttonskey then buttonskey:blitsprite(5, 498, __TRIANGLE) end
        screen.print(30, 500, LANGUAGE["SAVE_TRANSLATIONS"], 1, color.white, color.black, __ALEFT)

        screen.flip()

        --Controls
        if buttons.up or buttons.analogly < -60 then
            if scroll:up() then xscr1,xscr2,xscr3 = {},{},{} end
        end

        if buttons.down or buttons.analogly > 60 then
            if scroll:down() then xscr1,xscr2,xscr3 = {},{},{} end
        end

        if buttons.triangle then
            save_translation()
            unsaved_translation = false
        end

        if buttons[accept] then

            local current = ENGLISH_US[t_need[scroll.sel]]
            if CUSTOM_TRANSLATION[t_need[scroll.sel]] ~= "" then
                current = CUSTOM_TRANSLATION[t_need[scroll.sel]]
            elseif CURRENT_TRANSLATION[t_need[scroll.sel]] ~= "" then
                current = CURRENT_TRANSLATION[t_need[scroll.sel]]
            end

            current = string.gsub(current, "\n", "\\n")

            local new = osk.init(string.gsub(ENGLISH_US[t_need[scroll.sel]], "\n", "\\n"), current)
			if new then
				if string.len(new)>0 or new != "" then
					new = string.gsub(new,"\n","\\n")
					new = string.gsub(new,'"',"")
					new = string.gsub(new,"'","")
					CUSTOM_TRANSLATION[t_need[scroll.sel]] = new
					LANGUAGE[t_need[scroll.sel]] = new
					unsaved_translation = true
				end
			end

        end

        if buttons[cancel] then
            if unsaved_translation then
                if os.message("\n"..LANGUAGE["EXIT_SAVE_TRANSLATIONS"], 1) == 1 then
                    save_translation()
                end
			else
				--Here Undo changes
            end
			return
        end

    end
end
