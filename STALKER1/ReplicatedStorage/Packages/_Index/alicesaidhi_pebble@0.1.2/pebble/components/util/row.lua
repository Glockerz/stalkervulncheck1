-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local container = require(script.Parent.container)
local create = vide.create
local read = vide.read

return function(p1) --[[ layout | Line: 24 | Upvalues: container (copy), create (copy), read (copy) ]]
	return container({
		Size = UDim2.fromScale(1, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		create("UIListLayout")({
			Padding = function() --[[ Padding | Line: 31 | Upvalues: read (ref), p1 (copy) ]]
				local v1 = read(p1.spacing)

				if typeof(v1) == "number" then
					return UDim.new(0, v1)
				end

				if typeof(v1) == "UDim" then
					return v1
				end

				if typeof(v1) == "nil" then
					return UDim.new(0, 8)
				end

				return error("incorrect spacing type")
			end,
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalFlex = p1.justifycontent,
			ItemLineAlignment = p1.alignitems,
			Wraps = p1.wraps
		}),
		unpack(p1)
	})
end