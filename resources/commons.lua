--[[ 
	CallBacks LUA

	Autoinstall plugin
	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/

	Designed By Gdljjrod & DevDavisNunez.
	Collaborators: BaltazaR4 & Wzjk.
]]

function message_wait(message)
	local mge = (message or "Please wait...")
	local titlew = string.format(mge)
	local w,h = screen.textwidth(titlew,1) + 30,70
	local x,y = 480 - (w/2), 272 - (h/2)

	draw.fillrect(x,y,w,h, color.shine)
	draw.rect(x,y,w,h,color.white)
		screen.print(480,y+13, titlew,1,color.white,color.black,__ACENTER)
	screen.flip()
end

-- CallBack Extraction
function onExtractFiles(size,written,file,totalsize,totalwritten)

	if back then back:blit(0,0) end
	draw.fillrect(0,0,__DISPLAYW,30, color.shine)

	screen.print(10,10,"Extraction...")

	screen.print(925,10,"Percent Total: "..math.floor((totalwritten*100)/totalsize).." %",1.0,color.white, color.black, __ARIGHT)
	screen.print(10,70,"File: "..tostring(file),1.0,color.white, color.black)
	screen.print(10,90,"Percent: "..math.floor((written*100)/size).." %",1.0,color.white, color.black)

	screen.flip()
	
	buttons.read()
	return 1
end

-- CallBack CopyFiles
function onCopyFiles(size,written,file)

	if back then back:blit(0,0) end
	draw.fillrect(0,0,__DISPLAYW,30, color.shine)

	screen.print(10,10,"Copying: ")
	screen.print(945,10,math.floor((written*100)/size).." %",1.0,color.white, color.black, __ARIGHT)
	screen.print(10,70,"File: "..tostring(file),1.0,color.white, color.black)

	screen.flip()
end

-- CallBack DeleteFiles
function onDeleteFiles(file)

	if back then back:blit(0,0) end
	draw.fillrect(0,0,__DISPLAYW,30, color.shine)

	screen.print(10,10,"Deleting: ",1.0,color.white, color.black)
	screen.print(10,70,"File: "..tostring(file),1.0,color.white, color.black)

	screen.flip()

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
		elseif obj.ini-1>=obj.minim then
			obj.ini,obj.sel,obj.lim=obj.ini-1,obj.sel-1,obj.lim-1
			return true
		end
	end

	function obj:down()
		if obj.sel<obj.lim then obj.sel=obj.sel+1 return true
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
