-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local HttpService = game:GetService("HttpService")
local charCodeAt = require(script.Parent.Parent:WaitForChild("string")).charCodeAt
local Error = require(script.Parent:WaitForChild("Error"))

return function(p1) --[[ encodeURIComponent | Line: 8 | Upvalues: charCodeAt (copy), Error (copy), HttpService (copy) ]]
	local v1 = utf8.len(p1)

	if v1 == 0 or v1 == nil then
		return ""
	end

	local v2 = charCodeAt(p1, 1)

	if v1 == 1 then
		if v2 == 55296 then
			error(Error.new("URI malformed"))
		end

		if v2 == 57343 then
			error(Error.new("URI malformed"))
		end
	end

	if not (v2 >= 56320 and v2 < 57343) then
		return HttpService:UrlEncode(p1):gsub("%%2D", "-"):gsub("%%5F", "_"):gsub("%%2E", "."):gsub("%%21", "!"):gsub("%%7E", "~"):gsub("%%2A", "*"):gsub("%%27", "\'"):gsub("%%28", "("):gsub("%%29", ")")
	end

	error(Error.new("URI malformed"))
end