local installp_callback = function ()
	autoplugin()
end

local uinstallp_callback = function ()
	pluginsmanager()
end

local onlineplugins_callback = function ()
	plugins_online()
end

local extras_callback = function ()
	extras_menu()
end

local exit_callback = function ()
	exit_autoplugin()
end

local menu = {
	{ text = MENU_INSTALL_PLUGINS,			funct = installp_callback },
	{ text = MENU_UNINSTALL_PLUGINS,		funct = uinstallp_callback },
	{ text = MENU_CHECK_ONLINEP,			funct = onlineplugins_callback },
	{ text = MENU_EXTRAS,					funct = extras_callback },
	{ text = MENU_EXIT,						funct = exit_callback }
}
local scrollm,sel = newScroll(menu,#menu),1

change = false
buttons.interval(10,10)
while true do
	if change then buttons.homepopup(0) else buttons.homepopup(1) end
	buttons.read()
	if back then back:blit(0,0) end

	screen.print(480,25,MENU_TITLE,1.3,color.green, 0x0, __ACENTER)

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
