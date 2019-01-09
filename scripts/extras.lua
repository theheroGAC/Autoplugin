-- Extras menu containing plugin configuration scripts

function extras()

    local sd2vita_callback = function ()
        sd2vita()
    end

    local convertimgsplash_callback = function ()
        customimgsplash()
    end

    local npdrm_callback = function ()
        npdrm_free()
    end

    local config_callback = function ()
        if back then back:blit(0,0) end
        files.copy("resources/pkgj/config.txt", "ux0:pkgi")
        message_wait(MENU_INSTALLED_CONFIG)
        os.delay(2000)
    end

    local psp_ctrls_callback = function ()
        psp_ctrls()
    end

    local qencore_callback = function ()
        if back then back:blit(0,0) end

        local hencore_found = false
        local hencore_patched = false

        if files.exists("uma0:user/00/savedata/PCSG90096") then
            hencore_found = true
            if os.message(MENU_QENCORE_ASKUMA0, 1) == 1 then
                game.umount()
                game.mount("uma0:user/00/savedata/PCSG90096/")
                files.extract("resources/qencore/sdat.zip", "uma0:user/00/savedata/PCSG90096")
                hencore_patched = true
                os.message(MENU_INSTALLED_QENCORE)
                game.umount()
            end
        end

        if files.exists("ur0:user/00/savedata/PCSG90096") then
            hencore_found = true

            if os.message(MENU_QENCORE_ASKUR0, 1) == 1 then
                game.umount()
                game.mount("ur0:user/00/savedata/PCSG90096/")
                files.extract("resources/qencore/sdat.zip", "ur0:user/00/savedata/PCSG90096")
                hencore_patched = true
                os.message(MENU_INSTALLED_QENCORE)
                game.umount()
            end
        end

        if files.exists("ux0:user/00/savedata/PCSG90096") then
            hencore_found = true

            if os.message(MENU_QENCORE_ASKUX0, 1) == 1 then
                game.umount()
                game.mount("ur0:user/00/savedata/PCSG90096/")
                files.extract("resources/qencore/sdat.zip", "ur0:user/00/savedata/PCSG90096")
                hencore_patched = true
                os.message(MENU_INSTALLED_QENCORE)
                game.umount()
            end
        end

        if hencore_found then
            if hencore_patched then
                os.message(STRING_PSVITA_RESTART)
                os.delay(250)
                power.restart()
            else
                os.message(MENU_QENCORE_NOTPATCHED)
            end
        else
            os.message(MENU_QENCORE_NOGAME)
        end
    end

    local back_callback = function ()
        back_selected = true
    end

    local menu = {
        	{ text = MENU_INSTALL_SD2VITA,			funct = sd2vita_callback },
        	{ text = MENU_CONVERTBOOTSPLASH,		funct = convertimgsplash_callback },
        	{ text = MENU_INSTALL_CONFIG,			funct = config_callback },

        	{ text = MENU_INSTALL_NPDRMFREE,		funct = npdrm_callback },
        	{ text = MENU_INSTALL_REMASTERED_CTRLS,	funct = psp_ctrls_callback },

        --Online plugins

        --Q-encore install
        	{ text = MENU_QENCORE,			        funct = qencore_callback },
            { text = MENU_BACK,						funct = back_callback }


    }
    local scrollm,sel = newScroll(menu,#menu),1

    change = false
    buttons.interval(10,10)
    while true do
        if back_selected then
            back_selected = false
            return
        end
        if change then buttons.homepopup(0) else buttons.homepopup(1) end
        buttons.read()
        if back then back:blit(0,0) end

        screen.print(480,25,MENU_EXTRAS,1.3,color.green, 0x0, __ACENTER)

        local y = 135
        for i=scrollm.ini, scrollm.lim do
            if i == scrollm.sel then draw.fillrect(0,y-7,960,29,color.green:a(90)) end
            screen.print(480,y,menu[i].text,1.2,color.white, 0x0, __ACENTER)
            y+=35
        end

        screen.flip()

        --Controls
        if buttons.up or buttons.analogly < -60 then scrollm:up() end
        if buttons.down or buttons.analogly > 60 then scrollm:down() end

        if buttons[accept] then menu[scrollm.sel].funct() end

    end


end