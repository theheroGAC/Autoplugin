function exit_autoplugin()
    if change then
        os.message(STRING_PSVITA_RESTART)
        os.delay(250)
        buttons.homepopup(1)
        power.restart()
    end
    os.exit()
end