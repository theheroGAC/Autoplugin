------Autoinstall plugin
-------------------Resource-----------

color.loadpalette() -- Load Defaults colors
back = image.load("resources/back.png")

while true do
	buttons.read()
	if back then back:blit(0,0) end
	
	screen.print(10,20,"Autoplugin : Installer les plugins en un seul click",1,color.red)
	screen.print(10,50,"Liste de plugins prêt à installer :",1,color.white)
	screen.print(25,80,"-> DownloadEnabler par TheFl0w\n-> NoNpDrm par TheFl0w\n-> NoPsmDrm par frangarcj\n-> Shellbat par nowrep\n-> Vitabright par devnoname120\n-> pngshot par xyzz\n-> Kuio by Rinnegatamante\n-> PSV-VSH MENU by joel16\n-> Vflux by Applelo\n-> Repatch by dots-tb\n-> NoAVLS by SilicaAndPina",1,color.green)
	
	
	screen.print(25,420,"Appuyer sur X pour installer les plugins dans ux0:tai.",1,color.white,color.blue)
    screen.print(25,440,"Appuyer sur Cercle pour installer les  plugins dans ur0:tai.",1,color.white,color.black)
    screen.print(25,460,"Appuyer sur TRIANGLE pour installer les  plugins dans ux0:tai (PSTV uniquement).",1,color.white,color.green)
	screen.print(25,480,"Appuyer sur Carré restauré votre propre fichier config.txt.",1,color.white,color.blue)
	screen.print(25,500,"Appuyer sur START pour quitter.",1,color.white,color.red)

	screen.flip() -- Show Buff

	if buttons.cross then
              if files.exists("ux0:tai/config.txt") then files.rename("ux0:tai/config.txt", "config_backup.txt") end
		files.extract("resources/autoplugin.zip","ux0:/tai")
              files.extract("resources/config.zip","ux0:/tai")
		os.message("\nLes plugins ont été installer, votre console va redémarrée pour\n\nappliquer les changements. Le fichier config.txt original a été\n\nsauvegardé et renommé en 'config_backup.txt'",0)
		os.delay(2500)
	buttons.homepopup(1)
	power.restart()
end

	if buttons.circle then
           if files.exists("ur0:tai/config.txt") then files.rename("ur0:tai/config.txt", "config_backup.txt") end
		files.extract("resources/autoplugin.zip","ur0:/tai")
              files.extract("resources/config2.zip","ur0:/tai")
		os.message("\nLes plugins ont été installer, votre console va redémarrée pour\n\nappliquer les changements. Le fichier config.txt original a été\n\nsauvegardé et renommé en 'config_backup.txt'",0)
		os.delay(2500)
	buttons.homepopup(1)
	power.restart()
end


	if buttons.triangle then
		if files.exists("ux0:tai/config.txt") then files.rename("ux0:tai/config.txt", "config_backup.txt") end
		files.extract("resources/autoplugin2.zip","ux0:/tai")
              files.extract("resources/config.zip","ux0:/tai")
		os.message("\nLes plugins ont été installer, votre console va redémarrée pour\n\nappliquer les changements. Le fichier config.txt original a été\n\nsauvegardé et renommé en 'config_backup.txt'",0)
		os.delay(2500)
	buttons.homepopup(1)
	power.restart()
end


	if buttons.square then
           if files.exists("ux0:tai/config_backup.txt") then files.rename("ux0:tai/config_backup.txt", "config.txt") end
    	os.message("\nVotre fichier config.txt a été restauré, la console va redémarrée\n\npour appliquer les changements. Le fichier config_backup.txt\n\nd'Autoplugins a été supprimé !",0)
		os.delay(2500)
	buttons.homepopup(1)
	power.restart()
end

	if buttons.released.start then break end -- Exit
end
