dofile("git/shared.lua")

UPDATE_PORT = channel.new("UPDATE_PORT")

files.delete("tmp")
http.download(string.format("https://github.com/%s/%s/releases/latest/", APP_REPO, APP_PROJECT),"tmp")

if files.exists("tmp") then
	local objh = html.parsefile("tmp")
	if objh then

		local links = objh:findall(html.TAG_A)
		if links then
			for i=1,#links do
				if links[i].href then
					if links[i].href:lower():find(string.lower(APP_PROJECT..".vpk"),1,true) then
						UPDATE_PORT:push("https://github.com"..links[i].href)
						break
					end
				end
			end
		end
	end
end
