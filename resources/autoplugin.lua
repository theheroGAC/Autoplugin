------Autoinstall plugin
os.message("Press x to install the plugins or Press PS to return to the Livearea \n\nThe old file config.txt will be saved as config_backup.txt in ux0:tai",0)
if files.exists("ux0:tai/config.txt") then files.rename("ux0:tai/config.txt", "config_backup.txt") end
		files.extract("resources/autoplugin.zip","ur0:/tai")
              files.extract("resources/autoplugin.zip","ux0:/tai")
		files.extract("resources/config.zip","ux0:/tai")

		os.message("Your PSVita will restart...\nThe plugins have been installed\n\nThe old file config.txt has been saved to ux0:tai/config_backup.txt",0)
		os.delay(2500)
	buttons.homepopup(1)
	power.restart()