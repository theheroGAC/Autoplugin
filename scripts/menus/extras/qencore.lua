function qencore()
    if back then back:blit(0, 0) end

    local hencore_found = false
    local hencore_patched = false

    local mounts = { "ux0", "uma0", "ur0" }

    for i = 1, #mounts do
        if files.exists(mounts[i] .. ":user/00/savedata/PCSG90096") then
            hencore_found = true
            if os.message(MENU_QENCORE_ASK1 .. mounts[i] .. MENU_QENCORE_ASK2, 1) == 1 then
                game.umount()
                game.mount(mounts[i] .. ":user/00/savedata/PCSG90096/")
                files.extract("resources/qencore/sdat.zip", mounts[i] .. ":user/00/savedata/PCSG90096")
                hencore_patched = true
                os.message(MENU_INSTALLED_QENCORE .. mounts[i])
                game.umount()
            end
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