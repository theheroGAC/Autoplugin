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
		os.message(STRING_PSVITA_RESTART)
		os.delay(250)
		buttons.homepopup(1)
		power.restart()
	end
	os.exit()
end

local menu = {
	{ text = MENU_PSVITA,	funct = psvita_callback },
	{ text = MENU_PSP,		funct = psp_callback },
	{ text = MENU_EXTRAS,	funct = extras_callback },
	{ text = MENU_EXIT,		funct = exit_callback }
}
local scrollm = newScroll(menu,#menu)

change = false
buttons.interval(10,10)
while true do
	buttons.read()
	if change then buttons.homepopup(0) else buttons.homepopup(1) end

	if back then back:blit(0,0) end

	screen.print(480,25,MENU_TITLE,1.3,color.green, 0x0, __ACENTER)

	local y = 160
	for i=scrollm.ini, scrollm.lim do
		if i == scrollm.sel then draw.offsetgradrect(0,y-15,960,40,color.shine:a(55),color.shine:a(105),0x0,0x0,21) end
		screen.print(480,y,menu[i].text,1.5,color.white, 0x0, __ACENTER)
		y+=45
	end

	screen.flip()

	--Controls
	if buttons.up or buttons.analogly < -60 then scrollm:up() end
	if buttons.down or buttons.analogly > 60 then scrollm:down() end

	if buttons[accept] then menu[scrollm.sel].funct() end

end
