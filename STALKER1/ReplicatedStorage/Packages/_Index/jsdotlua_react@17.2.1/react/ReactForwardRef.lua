-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local console = require(script.Parent.Parent:WaitForChild("shared")).console
local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols

require(script.Parent.Parent:WaitForChild("shared"))

local REACT_FORWARD_REF_TYPE = ReactSymbols.REACT_FORWARD_REF_TYPE
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE

return {
	forwardRef = function(p1) --[[ Line: 27 | Upvalues: REACT_MEMO_TYPE (copy), console (copy), REACT_FORWARD_REF_TYPE (copy) ]]
		if _G.__DEV__ then
			if typeof(p1) == "table" and p1["$$typeof"] == REACT_MEMO_TYPE then
				console.error("forwardRef requires a render function but received a `memo` component. Instead of forwardRef(memo(...)), use memo(forwardRef(...)).")
			elseif typeof(p1) == "function" then
				local v1, _ = debug.info(p1, "a")

				if v1 ~= 0 and v1 ~= 2 then
					console.error("forwardRef render functions accept exactly two parameters: props and ref. %s", if v1 == 1 then "Did you forget to use the ref parameter?" else "Any additional parameter will be undefined.")
				end
			else
				console.error("forwardRef requires a render function but was given %s.", (typeof(p1)))
			end
		end

		local t = {
			["$$typeof"] = REACT_FORWARD_REF_TYPE,
			render = p1
		}

		if _G.__DEV__ then
			local v5 = nil
			local t2 = {
				__index = function(p1, p2) --[[ __index | Line: 84 | Upvalues: v5 (ref) ]]
					if p2 == "displayName" then
						return v5
					end

					return rawget(p1, p2)
				end,
				__newindex = function(p1, p2, p3) --[[ __newindex | Line: 90 | Upvalues: v5 (ref) ]]
					if p2 == "displayName" then
						v5 = p3
					else
						rawset(p1, p2, p3)
					end
				end
			}

			setmetatable(t, t2)
		end

		return t
	end
}