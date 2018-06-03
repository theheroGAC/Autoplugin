--Principal Script

pathini="ux0:/app/TTFTP0001/resources/CONFIG.INI" 
files.mkdir("ux0:/app/TTFTP0001/resources") 

if files.exists("ux0:/app/TTFTP0001/resources/LANG.LUA") then dofile("ux0:/app/TTFTP0001/resources/LANG.LUA")
else dofile("resources/explorer/ING.LUA") end -- cargamos el lenguaje de acuerdo a existencia.

mimes = image.load("resources/explorer/ICONS.PNG",16,16)--Sprites icons

--[[1 CustomColor
	2 Background]]
config = {0xffffff,"BACK.PNG"}

if files.exists(pathini) then dofile(pathini) else write_ini(pathini, config) end

accept,cancel = "cross","circle"
if buttons.assign()==0 then accept,cancel = "circle","cross" end

if buttons.assign() then _button = "X" else _button = "O" end

BarColor = color.new(0,255,0,95)

-- Create two scrolls :P
scroll = {
	list = newScroll(),
	menu = newScroll(),
}

Root = {"ux0:/","ur0:/"}
if link_state then
	Root[2] = "host0:/"
end
Dev=1
backl,slide_open = {},{false,false}
update_opts_txt()
divsect = 1
buttons.interval(10,6)

while true do
	buttons.read()
	if wall then wall:blit(0,0) end

	if divsect == 1 then -- List
		show_explorer_list() -- regla siempre el draw
		ctrls_explorer_list()
		if buttons.triangle then
			BackExpl = screen.buffertoimage()
			divsect, slide_open = 2, {true,true}
		end
	elseif divsect == 2 then -- Menu
		if BackExpl then BackExpl:blit(0,0) end
		main_explorer_menu()
	end

	screen.flip()
       power.tick(__POWER_TICK_SUSPEND)
	if buttons.start then break end--test
end
