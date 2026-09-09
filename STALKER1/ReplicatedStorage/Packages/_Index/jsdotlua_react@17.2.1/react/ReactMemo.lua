-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require(script.Parent.Parent:WaitForChild("shared"))
local console = v1.console
local v2 = require(script.Parent.Parent:WaitForChild("luau-polyfill"))
local Array = v2.Array
local Object = v2.Object
local inspect = v2.util.inspect
local ReactSymbols = v1.ReactSymbols
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE
local REACT_ELEMENT_TYPE = ReactSymbols.REACT_ELEMENT_TYPE
local isValidElementType = v1.isValidElementType
local getComponentName = v1.getComponentName

return {
	memo = function(p1, p2) --[[ Line: 37 | Upvalues: isValidElementType (copy), Object (copy), Array (copy), REACT_ELEMENT_TYPE (copy), getComponentName (copy), inspect (copy), console (copy), REACT_MEMO_TYPE (copy) ]]
		if _G.__DEV__ and not isValidElementType(p1) then
			local v1 = ""

			if p1 == nil or typeof(p1) == "table" and #Object.keys(p1) == 0 then
				v1 = v1 .. " You likely forgot to export your component from the file it\'s defined in, or you might have mixed up default and named imports."
			end

			local v2

			if p1 == nil then
				v2 = "nil"
			elseif Array.isArray(p1) then
				v2 = "array"
			elseif p1 == nil or (typeof(p1) ~= "table" or p1["$$typeof"] ~= REACT_ELEMENT_TYPE) then
				local v3 = typeof(p1)

				if p1 ~= nil then
					v1 = "\n" .. inspect(p1)
				end

				v2 = v3
			else
				v2, v1 = string.format("<%s />", getComponentName(p1.type) or "UNKNOWN"), " Did you accidentally export a JSX literal or Element instead of a component?"
			end

			console.error("memo: The first argument must be a component. Instead received: `%s`.%s", v2, v1)
		end

		local t = {
			["$$typeof"] = REACT_MEMO_TYPE,
			type = p1,
			compare = p2 or nil
		}

		if _G.__DEV__ then
			local v5 = nil
			local t2 = {
				__index = function(p1, p2) --[[ __index | Line: 103 | Upvalues: v5 (ref) ]]
					if p2 == "displayName" then
						return v5
					end

					return rawget(p1, p2)
				end,
				__newindex = function(p12, p2, p3) --[[ __newindex | Line: 109 | Upvalues: v5 (ref), p1 (copy) ]]
					if p2 == "displayName" then
						v5 = p3

						if typeof(p1) == "table" and p1.displayName == nil then
							p1.displayName = p3
						end
					else
						rawset(p12, p2, p3)
					end
				end
			}

			setmetatable(t, t2)
		end

		return t
	end
}