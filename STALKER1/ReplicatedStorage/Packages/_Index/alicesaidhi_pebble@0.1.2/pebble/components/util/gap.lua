-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local container = require(script.Parent.container)
local read = vide.read

return function(p1) --[[ Line: 14 | Upvalues: read (copy), container (copy) ]]
	local function direction() --[[ direction | Line: 16 | Upvalues: read (ref), p1 (copy) ]]
		return read(p1.direction) or "x"
	end

	return container({
		Size = function() --[[ Size | Line: 22 | Upvalues: read (ref), p1 (copy) ]]
			if (read(p1.direction) or "x") == "x" then
				return UDim2.new(0, read(p1.gap), 1, 0)
			end

			return UDim2.new(1, 0, 0, read(p1.gap))
		end
	})
end