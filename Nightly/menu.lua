--[[ 
	Autoinstall plugin

	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Dev: TheHeroeGAC
	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

local psvita_callback = function ()
    menu_ps()
end

local psp_callback = function ()
	menu_psp()
end

local extras_callback = function ()
	extras()
end

local exit_callback = function ()
    if change then
		os.message(LANGUAGE["STRING_PSVITA_RESTART"])
		os.delay(250)
		buttons.homepopup(1)
		power.restart()
	end
	os.exit()
end

local menu = {
	{ text = LANGUAGE["MENU_PSVITA"],	funct = psvita_callback },
	{ text = LANGUAGE["MENU_PSP"],		funct = psp_callback },
	{ text = LANGUAGE["MENU_EXTRAS"],	funct = extras_callback },
	{ text = LANGUAGE["MENU_EXIT"],		funct = exit_callback }
}
local scrollm = newScroll(menu,#menu)

change = false
buttons.interval(10,10)
while true do
	buttons.read()
	if change then buttons.homepopup(0) else buttons.homepopup(1) end

	if back then back:blit(0,0) end

	screen.print(480,25,LANGUAGE["MENU_TITLE"],1.3,color.green, 0x0, __ACENTER)

	local y = 145
	for i=scrollm.ini, scrollm.lim do
		if i == scrollm.sel then draw.offsetgradrect(10,y-12,960-20,40,color.shine:a(75),color.shine:a(135),0x0,0x0,21) end
		screen.print(480,y,menu[i].text,1.2,color.white, 0x0, __ACENTER)
		y+=45
	end

	screen.flip()

	--Controls
	if buttons.up or buttons.analogly < -60 then scrollm:up() end
	if buttons.down or buttons.analogly > 60 then scrollm:down() end

	if buttons[accept] then menu[scrollm.sel].funct() end

end
