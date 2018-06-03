function write_ini(pathini, tb)
    local file = io.open(pathini, "w+")
	file:write("config = {\n")
	for s,t in pairs(tb) do
		if type(t) == "string" then
			file:write(string.format('"%s",\n', tostring(t)))
		else
			file:write(string.format('%s,\n', tostring(t)))
		end
	end
	file:write("}")
	file:close()
end

function save_config()
	if not files.exists("ux0:/ONEMENU/") then files.mkdir("ux0:/ONEMENU/") end
	write_ini(pathini, config)
end

function files.readlinesSFO(path)
	local sfo = game.info(path)
	local data = {}
	for k,v in pairs(sfo) do
		table.insert(data,tostring(k).." = "..tostring(v))
	end
	return data
end

function files.readlines(path,index) -- Lee un table o string si se especifica linea
	if files.exists(path) then
		local contenido = {}
		for linea in io.lines(path) do
			table.insert(contenido,linea)
		end
		if index == nil then
			return contenido -- tabla
		else
			return contenido[index] -- string
		end
	end
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
		--os.message(tostring(type(tab)))
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
		if obj.sel>obj.ini then obj.sel=obj.sel-1
		elseif obj.ini-1>=obj.minim then
			obj.ini,obj.sel,obj.lim=obj.ini-1,obj.sel-1,obj.lim-1
		end
	end

	function obj:down()
		if obj.sel<obj.lim then obj.sel=obj.sel+1
		elseif obj.lim+1<=obj.maxim then
			obj.ini,obj.sel,obj.lim=obj.ini+1,obj.sel+1,obj.lim+1
		end
	end

	function obj:test(x,y,h,tabla,high,low,size)
		local py = y
		for i=obj.ini,obj.lim do 
			if i==obj.sel then screen.print(x,py,tabla[i],size,high)
			else screen.print(x,py,tabla[i],size,low)
			end
			py += h
		end
	end

	if a and b then
		obj:set(a,b,c)
	end

	return obj

end

function files.listsort(path)
	local tmp1 = files.listdirs(path)

	if tmp1 then 
		table.sort(tmp1,function(a,b) return string.lower(a.name)<string.lower(b.name) end)
	else
		tmp1 = {}
	end

	local tmp2 = files.listfiles(path)

	if tmp2 then
		table.sort(tmp2,function(a,b) return string.lower(a.name)<string.lower(b.name) end)
		for s,t in pairs(tmp2) do
			t.size = files.sizeformat(t.size)
			table.insert(tmp1,t)-- esto es por que son subtablas, realmente no puedo hacer un cont con tmp2
		end
	end

	return tmp1

end

-- ## Explorer ## --
maxim_files=17
explorer = {} -- All explorer functions

function explorer.refresh()
	explorer.list = files.listsort(Root[Dev]) 
	scroll.list:set(explorer.list,maxim_files)
end

icons={1,pbp=2,prx=2,
png=3,gif=3,jpg=3,bmp=3,
mp3=4,s3m=4,wav=4,at3=4,
rar=5,zip=5,vpk=5,
cso=6,iso=6,dax=6
}

isopened = { png = color.green, jpg = color.green, gif = color.green, bmp = color.green,
pmf = color.blue, iso = color.orange, pbp = color.orange, cso = color.orange, dax = color.orange,
zip = color.red, rar = color.red, vpk = color.yellow
}

-- ## Explorer Drawer List ## --
function explorer.listshow()
	local h=30
	if scroll.list.maxim >= maxim_files then len_selector = __DISPLAYW-45 else len_selector = __DISPLAYW end

	for i=scroll.list.ini, scroll.list.lim do
		if i==scroll.list.sel then draw.fillrect(0, h-3, len_selector, 22, color.new(0,255,0,100)) end

		if explorer.list[i].size then
			if icons[explorer.list[i].ext] then mimes:blitsprite(5, h, icons[explorer.list[i].ext]) -- mime type
			else mimes:blitsprite(5, h, 0) end -- file unk
		else
			mimes:blitsprite(5, h, 1) -- folder xD
		end

		screen.print(25, h, explorer.list[i].name or "",1, isopened[explorer.list[i].ext] or color.white, color.black)
		screen.print(905-130, h, explorer.list[i].mtime.." "..explorer.list[i].mode, 0.9, color.white, color.black, __ARIGHT)
		screen.print(905, h, explorer.list[i].size or strings.dir, 1, color.white, color.black, __ARIGHT)
		h += 26
	end
end

function show_explorer_list()

	screen.print(5,5,Root[Dev],1,color.new(255,69,0),color.black)
	screen.print(940,5, scroll.list.maxim,1,color.new(255,69,0),color.black,__ARIGHT)

	local h=440
	if scroll.list.maxim > 0 then
		if scroll.list.maxim >= maxim_files then -- Draw Scroll Bar
			local pos_height = math.max(h/scroll.list.maxim, maxim_files)
			draw.fillrect(920, 28, 8, h, color.new(255,255,255,100))
			draw.fillrect(920, 28 + ((h-pos_height)/(scroll.list.maxim-1))*(scroll.list.sel-1), 8, pos_height, color.new(0,255,0))
		end
		explorer.listshow()
		screen.print(12,500,explorer.list[scroll.list.sel].path or "",1,color.new(255,69,0),color.black)
		screen.print(12,520,explorer.src or "",1,color.new(255,69,0),color.black)
	else
		screen.print(10,25,"...".."\n"..strings.back,1,color.white,color.black)
	end

end

function ctrls_explorer_list()

	if buttons[cancel] then -- return directory
		Root[Dev]=files.nofile(Root[Dev])
		explorer.refresh()
		if #backl>0 then
			if scroll.list.maxim == backl[#backl].maxim then
				scroll.list.ini = backl[#backl].ini
				scroll.list.lim = backl[#backl].lim
				scroll.list.sel = backl[#backl].sel
			end
			backl[#backl] = nil
		end
	end

	if scroll.list.maxim > 0 then -- Is exists any?
		if buttons.up or buttons.held.l or buttons.analogly < -60 then scroll.list:up() end
		if buttons.down or buttons.held.r or buttons.analogly > 60 then scroll.list:down() end

		if buttons[accept] then
			handle_files(explorer.list[scroll.list.sel])
			if not explorer.list[scroll.list.sel].size then 					-- Its Dir
				table.insert(backl, {maxim = scroll.list.maxim, ini = scroll.list.ini, sel = scroll.list.sel, lim = scroll.list.lim, })
				Root[Dev]=explorer.list[scroll.list.sel].path
				explorer.refresh()
			end
		end
		if buttons.square then
			local info = files.info(explorer.list[scroll.list.sel].path)
			local data = ""
			for k,v in pairs(info) do
				data = data .. tostring(k).." = "..tostring(v) .. "\n"
			end
			os.message(data)
		end
	end

	if (buttons.left or buttons.right) and not slide_open[2] then								-- Switch device
		if Dev == 1 then--and files.exists("ur0:/") then
			Dev = 2
			explorer.refresh()
		elseif Dev == 2 and files.exists("ux0:/") then
			Dev = 1
			explorer.refresh()
		end
	end

end

function handle_files(cnt)
	local extension = cnt.ext
	if extension == "png" or extension == "jpg" or extension == "bmp" or extension == "gif" then
		visorimg(cnt.path)
	elseif extension == "vpk" then
		if show_msg_vpk(cnt.path) then
			result = game.install(cnt.path, scan.realsize)
			os.message(strings.install_vpk..strings.result..result)
		end
	elseif extension == "pbp" or extension == "bin" then
		show_msg_pbp(cnt.path, cnt.ext)
	elseif extension == "mp3" or extension == "wav" or extension == "ogg" then
		MusicPlayer(cnt.path)
		--if snd then snd = nil end
		--snd = sound.load(cnt.path)
		--if snd then	 snd:play(1) end 
	elseif extension == "txt" or extension == "lua" or extension == "ini" or extension == "sfo" then
		local cont = nil
		if extension == "sfo" then cont = files.readlinesSFO(cnt.path)
		else cont = files.readlines(cnt.path) end
		local srcn = newScroll(cont,20)
		buttons.interval(8,5)
		while true do
			buttons.read()
			if buttons.circle then
				buttons.interval(10,6)
				break
			end
			if buttons.up or buttons.analogly < -60 then srcn:up() elseif buttons.down or buttons.analogly > 60 then srcn:down() end
			if wall then wall:blit(0,0) end

			screen.print(10,10,strings.visortxt.." "..cnt.path)
			local y = 40
			for i=srcn.ini,srcn.lim do
				if i == srcn.sel then 
					draw.fillrect(0,y,960,20,color.green:a(100))
				end
				screen.print(10,y,cont[i],1,color.white)
				y+=20
			end
			screen.flip()
		end
		buttons.read()
	end
	extension=nil
end

-- ## Music Player ##
function MusicPlayer(path)
	local isMp3 = ((files.ext(path) or "") == "mp3")
	local tags = nil;
	if isMp3 then
		tags = sound.getid3(path)
	end
	local snd = sound.load(path)
	if snd then
		snd:play(1)
		while true do
			if wall then wall:blit(0,0) end
			buttons.read()
	
			draw.fillrect(0,0,__DISPLAYW,40,color.new(255,255,255,100))
			screen.print(10,5,tostring(path),1.0,color.white,color.black)
			
			if tags and tags.cover then
				tags.cover:blit(950-tags.cover:getw(),45)
			end
			
			if snd:playing() then
				screen.print(10,60,"Playing",1.0,color.white,color.black)
			else
				screen.print(10,60,"Paused",1.0,color.white,color.black)
			end
			if isMp3 then -- Solo los mp3 tienen tiempos :P
				local str = "Time: " + tostring(snd:time()) + " / "
				if tags then
					str += tags.time or "xx:xx:xx"
				else
					str += "xx:xx:xx"
				end
				screen.print(10,80, str,1.0,color.white,color.black)
			end
			--screen.print(10,100,tostring(isMp3))
			local perc = snd:percent()
			draw.fillrect(10,105,((perc*480)/100),10,color.green)
			draw.rect(10,105,480,10,color.white)
			screen.print(10,140,string.format("perc %s",tostring(perc)),1.0,color.white,color.black)
			screen.flip()
			power.tick(__POWER_TICK_SUSPEND) -- reset a power timers only for block suspend..
			if buttons[accept] then
				--[[if snd:endstream() then
					snd:play()
				else]]
					snd:pause() -- pause/resume
				--end
			end
			if buttons[cancel] or snd:endstream() then break end
			if buttons.triangle then power.display(0) end -- Lock or Down the screen.
		end
		snd:stop()
		snd = nil
		collectgarbage("collect")
	else
		os.message("Error Sound Invalid")
	end
end

-- ## Photo-Viewer ## --
function visorimg(path)
	local tmp = image.load(path)
	if tmp then
		tmp:center()

		local infoimg = {}
		infoimg.name = files.nopath(path)
		infoimg.w,infoimg.h = image.getrealw(tmp),image.getrealh(tmp)
		local show_bar_upper = true

		bar=45
		if (infoimg.w>500 and infoimg.h>300) then bar=50 end 

		for i=0,bar,5 do
			tmp:blit(__DISPLAYW/2,__DISPLAYH/2)
			draw.fillrect(0,0,__DISPLAYW,i,color.new(255,255,255,100))
			--screen.flip()
		end

		while true do
			if wall then wall:blit(0,0) end
			buttons.read()
	
			tmp:blit(__DISPLAYW/2,__DISPLAYH/2)

			if show_bar_upper then
				draw.fillrect(0,0,__DISPLAYW,bar,color.new(255,255,255,100))

				screen.print(10,5,infoimg.name,1.0,color.white,color.black)
				screen.print(940,3,"w: "..infoimg.w,0.8,color.white,color.black,__ARIGHT)
				screen.print(940,24,"h: "..infoimg.h,0.8,color.white,color.black,__ARIGHT)

				if (infoimg.w>500 and infoimg.w>300) then
					screen.print(10,30,strings.background,0.7,color.white,color.black)
				end
			end

			screen.flip()

			if buttons.square then show_bar_upper = not show_bar_upper end

			if buttons.triangle then
				if (infoimg.w>500 and infoimg.h>300) then
					wall = image.load(path)
					if wall then 
						config[2] = path
						wall:resize(__DISPLAYW, __DISPLAYH)
						save_config()
					end
				end
			end

			if buttons[cancel] or buttons[accept] then break	end

		end

		tmp = nil
		collectgarbage("collect")
		barblit=false
	else
		os.message("Error")
	end
end

--tmp0.CATEGORY: ISO/CSO UG, PSN EG, HBs MG, PS1 ME
function show_msg_pbp(path, ext)
	local bufftmp = screen.buffertoimage()
	local x,y = (960-420)/2,(544-420)/2

	icon0,sfo = nil,nil
	if ext == "bin" then 
		icon0 = image.load(Root[Dev].."/sce_sys/icon0.png")
		sfo = game.info(Root[Dev].."/sce_sys/param.sfo")
	else icon0 = game.geticon0(path)
		sfo = game.info(path)
	end

	if (sfo and (sfo.CATEGORY == "EG" or sfo.CATEGORY == "ME")) or (ext == "bin") then		--Maybe work with PS1
		local res = false
		while true do
			bufftmp:blit(0,0)

			draw.fillrect(x,y,420,420,color.shine)
			draw.rect(x,y,420,420,color.white)

			if sfo then
				screen.print(960/2,y+15,strings.launchpbp,1,color.black,color.blue,__ACENTER)
				screen.print(960/2,y+40,tostring(sfo.TITLE),1,color.black,color.blue,__ACENTER)
				screen.print(960/2,y+60,sfo.DISC_ID or sfo.TITLE_ID,1,color.black,color.blue,__ACENTER)
			else
				screen.print(960/2,y+15,strings.launchbin,1,color.black,color.blue,__ACENTER)
				if Root[Dev]:sub(-1,-1) == "/" then ID = files.nopath(Root[Dev]):sub(1,-2) end
				if ID then
					screen.print(960/2,y+40,ID,1,color.black,color.blue,__ACENTER)
				else
					screen.print(960/2,y+40,files.nopath(Root[Dev]),1,color.black,color.blue,__ACENTER)
				end
			end

			if icon0 then
				icon0:setfilter(__IMG_FILTER_LINEAR, __IMG_FILTER_LINEAR)
				icon0:scale(150)
				icon0:center()
				icon0:blit(960/2,544/2)
			end

			screen.print(960/2,y+400,strings.confirm,1,color.black,color.blue,__ACENTER)
			screen.flip()

			buttons.read()

			if buttons.cross or buttons.circle then
				if buttons.cross then
					if sfo then
						if sfo.DISC_ID then game.launch(sfo.DISC_ID) end
						if sfo.TITLE_ID then game.launch(sfo.TITLE_ID) end
					elseif ID then game.launch(ID)
					end
				end
				break
			end

		end
	end

	bufftmp:blit(0,0)
	buttons.read()--flush xD
	return res
	
end

function show_msg_vpk(path)
	bufftmp = screen.buffertoimage()
	local x,y = (960-420)/2,(544-420)/2
	
	scan = files.scan(path)
	
	ebootbin,icon,sfo=-1,-1,-1
	if scan then
		for i=1,#scan do
			if scan[i].name:lower() == "sce_sys/icon0.png" then icon = scan[i].pos
			elseif scan[i].name:lower() == "sce_sys/param.sfo" then sfo = scan[i].pos
			elseif scan[i].name:lower() == "eboot.bin" then ebootbin = scan[i].pos end
		end
	end

	if icon != -1 then icon0vpk = game.geticon0(path, icon) else icon0vpk = game.geticon0(path) end
	if sfo != -1 then sfoPVK = game.info(path, sfo) else sfoPVK = game.info(path) end

	if ebootbin == -1 or sfo == -1 then return end

	if total_access and os.message(string.upper(files.nopath(path))..strings.warningvpk,1) == 0 then 
		bufftmp:blit(0,0)
		buttons.read()--flush xD
		return
	end

	local res = false
	local realsize = files.sizeformat(scan.realsize or 0)
	while true do
		bufftmp:blit(0,0)
		draw.fillrect(x,y,420,420,color.shine)
		draw.rect(x,y,420,420,color.black)
		screen.print(960/2,y+7,strings.installvpk,1,color.black,color.blue,__ACENTER)
	
		if sfoPVK then
			screen.print(960/2,y+30,tostring(sfoPVK.TITLE),1,color.black,color.blue,__ACENTER)
			screen.print(960/2,y+50,tostring(sfoPVK.TITLE_ID),1,color.black,color.blue,__ACENTER)
		end
		screen.print(960/2,y+85,strings.total_sizevpk..tostring(realsize),1,color.black,color.blue,__ACENTER)
		
		if icon0vpk then
			icon0vpk:setfilter(__IMG_FILTER_LINEAR, __IMG_FILTER_LINEAR)
			icon0vpk:scale(150)
			icon0vpk:center()
			icon0vpk:blit(960/2,544/2)
		end

		screen.print(960/2,y+400,strings.confirm,1,color.black,color.blue,__ACENTER)
		screen.flip()
		buttons.read()

		if buttons.cross or buttons.circle then	res = buttons.cross 	break end

	end
	bufftmp:blit(0,0)
	buttons.read()--flush xD
	return res
end

slide_x,slide_y,slide_h = 280,245,0 -- x,y se calculan apartir de los limites inferiores menos el tamaño + 10 de espaciado :P
slide_len, slide_sums = 205, 20
-- ## Explorer Drawer Menu ## --
function explorer.menushow()
	local h = slide_y + 5
	local i = scroll.menu.ini
	while i <= scroll.menu.lim do
		if i==scroll.menu.sel then cc=color.green else cc=color.shine end
		screen.print(slide_x+75,h,slide_opts_txt[i],1,cc,color.black,__ACENTER) 
		h,i=h+21, i+1 
	end
end

function show_explorer_menu()
	if slide_open[2] and slide_h < slide_len then slide_h+=slide_sums end 
	if not slide_open[2] and slide_h > 0 then slide_h-=slide_sums end
	if not slide_open[2] and slide_h < 2 then slide_open[1] = false end
	if not slide_open[1] and slide_h < 2 then divsect = 1 end
	draw.fillrect(slide_x-3,slide_y,155,slide_h,color.new(245,235,225,170)) 
	if slide_h > (slide_len-slide_sums) then explorer.menushow() end -- la pongo aqui pues de lo contrario no actuan los if
end


function copysrc()
	explorer.src = explorer.list[scroll.list.sel].path
	explorer.action = scroll.menu.sel
	slide_open[2]=false
	scroll.menu:set(slide_opts_txt,10)
end

function update_opts_txt()
	explorer.refresh()
	slide_opts_txt = {strings.copy,strings.move,strings.extract,strings.delete,strings.oslMakeDir,strings.rename,strings.ftp,
	strings.insvpkfromdir,strings.instheme,strings.cancel}
	scroll.menu:set(slide_opts_txt,#slide_opts_txt)
	explorer.action = 0
	explorer.src, explorer.dst = "",""
end

function ctrls_explorer_menu()

	if buttons.up or buttons.held.l then scroll.menu:up() end
	if buttons.down or buttons.held.r then scroll.menu:down() end

	if buttons[accept] then
		local numerador = 0
		if explorer.src == "" and scroll.menu.sel <= 3 then
			if #explorer.list > 0 then
				if scroll.menu.sel == 1 or scroll.menu.sel == 2 then		--Copy/Move
					slide_opts_txt = {strings.paste,strings.delete,strings.oslMakeDir,strings.rename,strings.ftp,strings.insvpkfromdir,strings.instheme,strings.cancel}
					copysrc()
				else														--Extract
					if explorer.list[scroll.list.sel].ext and (files.ext(explorer.list[scroll.list.sel].path):upper()=="ZIP" or
						files.ext(explorer.list[scroll.list.sel].path):upper()=="RAR" or
						files.ext(explorer.list[scroll.list.sel].path):upper()=="VPK") then
						slide_opts_txt = {strings.extractto,strings.delete,strings.oslMakeDir,strings.rename,strings.ftp,strings.insvpkfromdir,strings.instheme,strings.cancel}
						copysrc()
					end
				end
			end--#explorer.list > 0
		elseif string.len(explorer.src) > 0 then
			if scroll.menu.sel == 1 then
				explorer.dst = Root[Dev]
				screen.print(12,257,explorer.dst or "",0.9,color.new(255,69,0),color.black)
				if explorer.action == 1 then								--Paste from Copy
					files.copy(explorer.src,explorer.dst)
				elseif explorer.action == 2 then							--Paste from Move
					files.move(explorer.src,explorer.dst)
				elseif explorer.action == 3 then							--Extract
					if os.message(strings.pass,1)==1 then
						local pass = osk.init(strings.ospass,"")
						if pass then files.extract(explorer.src,explorer.dst,pass) end
					else
						result = files.extract(explorer.src,explorer.dst)
					end
				end
				slide_open[2]=false
				update_opts_txt()
			end
			numerador = 2
		end -- end of string len

		if scroll.menu.sel == (4 - numerador) and #explorer.list > 0 then		--Delete
			if os.message(strings.delete.." : "..explorer.list[scroll.list.sel].name.." ?",1) == 1 then
				files.delete(explorer.list[scroll.list.sel].path)
				slide_open[2]=false
				update_opts_txt()
			end
		end
		if scroll.menu.sel == (5 - numerador) then								--MakeDir
			local newfolder = osk.init(strings.creatfolder, strings.newfolder)
			if newfolder then
				local dest = Root[Dev].."/"..newfolder
				if Root[Dev]:sub(#Root[Dev]) == "/" then dest = Root[Dev]..newfolder end
				files.mkdir(dest)
				slide_open[2]=false
				update_opts_txt()
			end
		end
		if scroll.menu.sel == (6 - numerador) and #explorer.list > 0 then		--Rename
			local name = osk.init(strings.rename, files.nopath(explorer.list[scroll.list.sel].path))
			if name then
				files.rename(explorer.list[scroll.list.sel].path, name)
				slide_open[2]=false
				update_opts_txt()
			end
		end

		if scroll.menu.sel == (7-numerador) then								--FTP
			if not wlan.isconnected() then wlan.connect() end
			if wlan.isconnected() then ftp.init() end
			while ftp.state() do
				buttons.read()
				if wall then wall:blit(0,0) end
				screen.print(10,10,strings.serverftp..tostring(wlan.getip())..":1337",1,color.new(255,69,0),color.black)
				screen.print(10,50,strings.closeftp,1,color.new(255,69,0),color.black)
				screen.flip()

				if buttons.start then
					if wall then wall:blit(0,0) end
					screen.print(10,10,strings.serverftp..tostring(wlan.getip())..":1337",1,color.new(255,69,0),color.black)
					screen.print(10,50,strings.closeftp,1,color.new(255,69,0),color.black)
					screen.print(10,90,strings.loseftp,1,color.new(255,69,0),color.black)
					screen.flip()
					ftp.term()
					os.delay(150)
					slide_open[2]=false
					update_opts_txt()
				end
			end
		end

		if scroll.menu.sel == (8-numerador) and scroll.list.maxim > 0 then		--Install VPK fromdir (files)
			result = game.installdir(explorer.list[scroll.list.sel].path)
			os.message(strings.install_vpkdir..strings.result..result)
			slide_open[2]=false
			update_opts_txt()

		end

		if scroll.menu.sel == (9-numerador) and scroll.list.maxim > 0 then		--Install Theme from dir
			result = themes.install(explorer.list[scroll.list.sel].path)
			os.message(strings.instheme..strings.result..result)
			slide_open[2]=false
			update_opts_txt()
		end

		if scroll.menu.sel == (10-numerador) then								--Cancel
			slide_open[2]=false
			update_opts_txt()
		end

	end--if buttons[accept]
end

function main_explorer_menu()
	show_explorer_menu() -- correccion igual para el draw list
	if slide_h > (slide_len-slide_sums) then ctrls_explorer_menu() end -- evita uso de controles si se esta abriendo o cerrando
	if buttons.triangle or buttons[cancel] then slide_open[2]=false end
end
