------Autoinstall pluign
		files.extract("resources/autoplugin.zip","ur0:/tai")
		files.extract("resources/config.zip","ur0:/tai")

		os.message("Your PSVita will restart...\nThe plugins have been installed",0)
		os.delay(2500)
	buttons.homepopup(1)
	power.restart()