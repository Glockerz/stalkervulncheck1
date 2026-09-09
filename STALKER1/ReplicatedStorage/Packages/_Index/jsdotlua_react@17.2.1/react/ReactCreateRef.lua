-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent:WaitForChild("shared"))

local v1 = require(script.Parent:WaitForChild("ReactBinding.roblox"))

return {
	createRef = function() --[[ Line: 24 | Upvalues: v1 (copy) ]]
		local v12, _ = v1.create(nil)
		local t = {}

		if _G.__DEV__ then
			v12._source = debug.traceback("Ref created at:", 1)
		end

		local t2 = {
			__index = function(p1, p2) --[[ __index | Line: 42 | Upvalues: v12 (copy) ]]
				if p2 == "current" then
					return v12:getValue()
				end

				return v12[p2]
			end,
			__newindex = function(p1, p2, p3) --[[ __newindex | Line: 49 | Upvalues: v1 (ref), v12 (copy) ]]
				if p2 == "current" then
					v1.update(v12, p3)
				end

				v12[p2] = p3
			end,
			__tostring = function(p1) --[[ __tostring | Line: 60 | Upvalues: v12 (copy) ]]
				return string.format("Ref(%s)", (tostring(v12:getValue())))
			end
		}

		setmetatable(t, t2)

		return t
	end
}