--CallBacks LUA
function onAppInstall(step, size_argv, written, file, totalsize, totalwritten)
    if step == 1 then -- Only msg of state
		if wall then wall:blit(0,0) end
		draw.fillrect(0,0,960,30, color.new(0,255,0,100))
		screen.print(10,10,"Search in vpk, unsafe or dangerous files!")
		screen.flip()
	elseif step == 2 then -- Alerta Vpk requiere confirmacion!
		while true do
			buttons.read()
			if buttons.cross then
				buttons.read() -- Flush
				return 10 -- Ok code
			elseif buttons.circle then
				buttons.read() -- Flush
				return 0; -- Any other code xD
			end
			if wall then wall:blit(0,0) end
			if size_argv == 1 then
				screen.print(10,10,"Extended permissions and personal info access required! \nUse caution with non trusted source packages! \nDo you want to install at your own risk?")
			elseif size_argv == 2 then
				screen.print(10,10,"Warning!!! High risk of bricking your device \nif this VPK is installed! \nUse caution with non trusted source packages! \nDo you want to install at your own risk?")
			end
			screen.print(10,520,"X: Accept | O: Cancel")
			screen.flip()
		end
	elseif step == 3 then -- Unpack :P
		if wall then wall:blit(0,0) end
		draw.fillrect(0,0,960,30, color.new(0,255,0,100))

		screen.print(10,10,"Extract...")
		screen.print(10,30,"File: "..tostring(file))
		screen.print(10,50,"Percent: "..math.floor((written*100)/size_argv).." %")
		screen.print(10,70,"Percent Total: "..math.floor((totalwritten*100)/totalsize).." %")
		screen.print(10,90,"Total size: "..tostring(totalsize).." ".."Total Bytes: "..tostring(totalwritten))
		
		draw.fillrect(0,544-30,(totalwritten*960)/totalsize,30, color.new(0,255,0))
		screen.flip()
	elseif step == 4 then -- Promote o install :P
		if wall then wall:blit(0,0) end
		draw.fillrect(0,0,960,30, color.new(0,255,0,100))
		screen.print(10,10,"Installing...")
		screen.flip()
	end
end

-- CallBack Extraction
function onExtractFiles(size,written,file,totalsize,totalwritten)

	if wall then wall:blit(0,0) end
	draw.fillrect(0,0,__DISPLAYW,30, BarColor)

	screen.print(10,10,strings.extraction)
	screen.print(10,30,strings.file..tostring(file))
	screen.print(10,50,strings.percent..math.floor((written*100)/size).." %")
	screen.print(10,70,strings.percent_total..math.floor((totalwritten*100)/totalsize).." %")
	screen.print(10,90,strings.total_size..tostring(totalsize).." "..strings.total_written..tostring(totalwritten))

	screen.flip()
	
	buttons.read()
	if buttons.circle then
		return 0;
	end
	return 1;
end

function onScanningFiles(file,unsize,position)
	if not bufftmp then	if wall then wall:blit(0,0) end
	else bufftmp:blit(0,0) end

	draw.fillrect(0,0,__DISPLAYW,30, BarColor)

	local x,y = (960-420)/2,(544-420)/2
	screen.print(__DISPLAYW/2,y+7,strings.file..tostring(file),1,color.white,color.black,__ACENTER)
	screen.print(__DISPLAYW/2,y+27,strings.size_unpk..tostring(unsize),1,color.white,color.black,__ACENTER)
	screen.print(__DISPLAYW/2,y+47,strings.offset..tostring(position),1,color.white,color.black,__ACENTER)

	draw.fillrect(x,y,420,420,color.shine)
	draw.rect(x,y,420,420,color.black)

	if not angle then angle = 0 end
	angle += 24
	if angle > 360 then angle = 0 end
	draw.framearc(__DISPLAYW/2, __DISPLAYH/2, 40, color.new(255,255,255), 0, 360, 20, 30);
	draw.framearc(__DISPLAYW/2, __DISPLAYH/2, 40, color.new(0,255,0), angle, 90, 20, 30);

	screen.print(__DISPLAYW/2,(__DISPLAYH/2)+30,strings.scanning,1,color.white,color.black,__ACENTER)

	screen.flip()
end

 -- CallBack CopyFiles
function onCopyFiles(size,written,file)
	if wall then wall:blit(0,0) end
	draw.fillrect(0,0,__DISPLAYW,30, BarColor)

	screen.print(10,10,strings.copyfile,0.9,color.white)
	screen.print(10,30,strings.file..tostring(file))
	screen.print(10,50,strings.percent..math.floor((written*100)/size).." %")

	screen.flip()
end

 -- CallBack DeleteFiles
function onDeleteFiles(file)
	if wall then wall:blit(0,0) end
	draw.fillrect(0,0,__DISPLAYW,30, BarColor)

	screen.print(10,10,strings.delfile,0.9,color.white)
	screen.print(10,30,strings.file..tostring(file))

	os.delay(10)
	screen.flip()
end

-- CallBack OnCompressZip
function onCompressZip(size,written,file)
	if wall then wall:blit(0,0) end
	draw.fillrect(0,0,__DISPLAYW,30, BarColor)

	screen.print(10,10, "Compress Zips", 0.9, color.white)
	screen.print(10,30, "File: "..tostring(file))
	screen.print(10,50,strings.percent..math.floor((written*100)/size).." %")

	screen.flip()

	buttons.read()
	if buttons.circle then
		return 0;
	end
	return 1;
end
