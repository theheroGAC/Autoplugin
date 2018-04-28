------Autoinstall plugin
-------------------Resource-----------

color.loadpalette() -- Load Defaults colors
back = image.load("resources/back.png")

while true do
	buttons.read()
	if back then back:blit(0,0) end
	
	screen.print(10,20,"Autoplugin  Install the plugins with a click",1,color.red)
       screen.print(10,50,"List of plugins ready to install:",1,color.white)
	screen.print(25,80,"-> DownloadEnabler by TheFl0w\n-> NoNpDrm by TheFl0w\n-> NoPsmDrm by frangarcj\n-> Shellbat by nowrep\n-> Vitabright by devnoname120\n-> pngshot by xyzz\n-> Kuio by Rinnegatamante\n-> PSV-VSH MENU by joel16\n-> Vflux by Applelo\n-> Repatch by dots-tb\n-> NoAVLS by SilicaAndPina\n-> ds3vita and ds4vita by xerpi",1,color.green)
	
	screen.print(25,420,"Press CROSS to install Plugins on ux0:tai",1,color.white,color.blue)
       screen.print(25,440,"Press CIRCLE to install Plugins on ur0:tai.",1,color.white,color.black)
       screen.print(25,460,"Press TRIANGLE to install Plugins on PSTV ONLY(ux0:tai).",1,color.white,color.green)
	screen.print(25,480,"Press SQUARE to restore the old config.txt file.",1,color.white,color.blue)
	screen.print(15,500,"Press START to exit.",1,color.white,color.red)

	screen.flip() -- Show Buff

	if buttons.cross then
              if files.exists("ux0:tai/config.txt") then files.rename("ux0:tai/config.txt", "config_backup.txt") end
		files.extract("resources/autoplugin.zip","ux0:/tai")
              files.extract("resources/config.zip","ux0:/tai")
		os.message("Your PSVita will restart...\nThe plugins have been installed\n\nThe old file config.txt has been saved to ux0:tai/config_backup.txt",0)
		os.delay(2500)
	buttons.homepopup(1)
	power.restart()
end

	if buttons.circle then
           if files.exists("ur0:tai/config.txt") then files.rename("ur0:tai/config.txt", "config_backup.txt") end
		files.extract("resources/autoplugin.zip","ur0:/tai")
              files.extract("resources/config2.zip","ur0:/tai")
		os.message("Your PSVita will restart...\nThe plugins have been installed\n\nThe old file config.txt has been saved to ur0:tai/config_backup.txt",0)
		os.delay(2500)
	buttons.homepopup(1)
	power.restart()
end


	if buttons.triangle then
		if files.exists("ux0:tai/config.txt") then files.rename("ux0:tai/config.txt", "config_backup.txt") end
		files.extract("resources/autoplugin2.zip","ux0:/tai")
              files.extract("resources/config.zip","ux0:/tai")
		os.message("Your VITATV will restart...\nThe plugins have been installed\n\nThe old file config.txt has been saved to ux0:tai/config_backup.txt",0)
		os.delay(2500)
	buttons.homepopup(1)
	power.restart()
end


	if buttons.square then
           if files.exists("ux0:tai/config_backup.txt") then files.rename("ux0:tai/config_backup.txt", "config.txt") end
	   if files.exists("ur0:tai/config_backup.txt") then files.rename("ur0:tai/config_backup.txt", "config.txt") end
    	os.message("\Your config.txt file has been restored, the console will restart\n\nto apply the changes. The config_backup.txt file\n\nof Autoplugins has been removed!",0)
		os.delay(2500)
	buttons.homepopup(1)
	power.restart()
end

	if buttons.released.start then break end -- Exit
end
