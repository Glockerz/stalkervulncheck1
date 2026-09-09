-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local None = require(script.Parent:WaitForChild("None"))

require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1, p2, p3, p4, ...) --[[ Line: 12 | Upvalues: None (copy) ]]
	if p2 ~= nil and typeof(p2) == "table" then
		for k, v in pairs(p2) do
			if v == None then
				p1[k] = nil

				continue
			end

			p1[k] = v
		end
	end

	if p3 ~= nil and typeof(p3) == "table" then
		for k, v in pairs(p3) do
			if v == None then
				p1[k] = nil

				continue
			end

			p1[k] = v
		end
	end

	if p4 ~= nil and typeof(p4) == "table" then
		for k, v in pairs(p4) do
			if v == None then
				p1[k] = nil

				continue
			end

			p1[k] = v
		end
	end

	for i = 1, select("#", ...) do
		local v1 = select(i, ...)

		if v1 ~= nil and typeof(v1) == "table" then
			for k, v in pairs(v1) do
				if v == None then
					p1[k] = nil

					continue
				end

				p1[k] = v
			end
		end
	end

	return p1
end