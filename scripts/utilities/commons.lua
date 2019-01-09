--[[ 
	CallBacks LUA

	Autoinstall plugin
	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/

	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

path_plugins = "resources/plugins/"
__UX0, __UR0, loc = 1,2,1
locations = { "ux0:", "ur0:" }
folder_tai, path_tai = false, locations[loc].."tai/"
version = tostring(os.swversion())

--Buttons Assign
accept,cancel = "cross","circle"
STRING_BACK = STRING_CIRCLE_BACK
STRING_SD2VITA_CANCEL = SD2VITA_CIRCLE_CANCEL

STRING_CONFIRM_PLUGIN = STRING_CROSS_INSTALL
STRING_CONFIRM_SPLASH = CUSTOMBOOTSPLASH_CROSS_CONVERT
STRING_CONFIRM_UNINSTALLP = UNINSTALLP_CROSS_INSTALL

if buttons.assign()==0 then
	accept,cancel = "circle","cross"
	STRING_BACK = STRING_CROSS_BACK
	STRING_SD2VITA_CANCEL = SD2VITA_CROSS_CANCEL

	STRING_CONFIRM_PLUGIN = STRING_CIRCLE_INSTALL
	STRING_CONFIRM_SPLASH = CUSTOMBOOTSPLASH_CIRCLE_CONVERT
	STRING_CONFIRM_UNINSTALLP = UNINSTALLP_CIRCLE_INSTALL

end

--functions--
function img_fixed(img)
	local w,h = img:getw(), img:geth()

	if w > 960 or h > 544 then
		return img:copyscale(960, 544)
	end

	local px,py = (960/2)-(w/2), (544/2)-(h/2)
	local sheet = image.new(960, 544, 0x0)
	for y=0,h-1 do
		for x=0,w-1 do
			local c = img:pixel(x,y)
			if c:a() == 0 then c = 0x0 end 
			sheet:pixel(px+x, py+y, c)
		end
	end
	return sheet
end

function message_wait(message)
	local mge = (message or STRING_PLEASE_WAIT)
	local titlew = string.format(mge)
	local w,h = screen.textwidth(titlew,1) + 30,70
	local x,y = 480 - (w/2), 242 - (h/2)

	draw.fillrect(x,y,w,h, color.shine)
	draw.rect(x,y,w,h,color.white)
		screen.print(480,y+13, titlew,1,color.white,color.black,__ACENTER)
	screen.flip()
end


--For Decryted (from vitashell)
if files.exists("modules/kernel.skprx") then
	if os.requirek("modules/kernel.skprx")==1 then __kernel = true end
else
	if os.requirek("ux0:VitaShell/module/kernel.skprx")==1 then	__kernel = true end
end

if files.exists("modules/user.suprx") then
	if os.requireu("modules/user.suprx")==1 then __user = true end
else
	if os.requireu("ux0:VitaShell/module/user.suprx")==1 then __user = true end
end

--[[
	## Library Scroll ##
	Designed By DevDavis (Davis Nuñez) 2011 - 2016.
	Based on library of Robert Galarga.
	Create a obj scroll, this is very usefull for list show
	]]
function newScroll(a,b,c)
	local obj = {ini=1,sel=1,lim=1,maxim=1,minim = 1}

	function obj:set(tab,mxn,modemintomin) -- Set a obj scroll
		obj.ini,obj.sel,obj.lim,obj.maxim,obj.minim = 1,1,1,1,1
		if(type(tab)=="number")then
			if tab > mxn then obj.lim=mxn else obj.lim=tab end
			obj.maxim = tab
		else
			if #tab > mxn then obj.lim=mxn else obj.lim=#tab end
			obj.maxim = #tab
		end
		if modemintomin then obj.minim = obj.lim end
	end

	function obj:max(mx)
		obj.maxim = #mx
	end

	function obj:up()
		if obj.sel>obj.ini then obj.sel=obj.sel-1 return true
		elseif obj.sel==obj.ini then obj.sel=obj.lim return true
		elseif obj.ini-1>=obj.minim then
			obj.ini,obj.sel,obj.lim=obj.ini-1,obj.sel-1,obj.lim-1
			return true
		end
	end

	function obj:down()
		if obj.sel<obj.lim then obj.sel=obj.sel+1 return true
		elseif obj.sel==obj.lim then obj.sel=obj.ini return true
		elseif obj.lim+1<=obj.maxim then
			obj.ini,obj.sel,obj.lim=obj.ini+1,obj.sel+1,obj.lim+1
			return true
		end
	end

	function obj:up_menu()
		if obj.sel>obj.ini then
			obj.sel-=1

			if obj.sel==1 then 
				if obj.lim-obj.ini>=limit then obj.lim-=1 end
			else obj.ini-=1
				if obj.lim-obj.ini>=limit+1 then obj.lim-=1 end
			end
			return true
		end
	end

	function obj:down_menu()
		if obj.sel<obj.lim then
			obj.sel+=1

			if obj.sel-1==1 then
				if obj.lim+1<=obj.maxim then obj.lim+=1 end
			else obj.ini+=1
				if obj.lim+1<=obj.maxim then obj.lim+=1 end
			end
			return true
		end
	end

	if a and b then
		obj:set(a,b,c)
	end

	return obj

end
