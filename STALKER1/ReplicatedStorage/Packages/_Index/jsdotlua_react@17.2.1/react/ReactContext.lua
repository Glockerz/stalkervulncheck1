-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local console = require(script.Parent.Parent:WaitForChild("shared")).console
local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols
local REACT_PROVIDER_TYPE = ReactSymbols.REACT_PROVIDER_TYPE
local REACT_CONTEXT_TYPE = ReactSymbols.REACT_CONTEXT_TYPE

return {
	createContext = function(p1, p2) --[[ Line: 23 | Upvalues: REACT_CONTEXT_TYPE (copy), REACT_PROVIDER_TYPE (copy), console (copy) ]]
		local t = {
			["$$typeof"] = REACT_CONTEXT_TYPE,
			_calculateChangedBits = p2,
			_currentValue = p1,
			_currentValue2 = p1,
			_threadCount = 0,
			Provider = nil,
			Consumer = nil,
			displayName = nil,
			_currentRenderer = nil,
			_currentRenderer2 = nil
		}

		t.Provider = {
			["$$typeof"] = REACT_PROVIDER_TYPE,
			_context = t
		}

		local v1 = false

		if _G.__DEV__ then
			local t2 = {
				["$$typeof"] = REACT_CONTEXT_TYPE,
				_context = t,
				_calculateChangedBits = t._calculateChangedBits
			}
			local t3 = {
				__index = function(p1, p2) --[[ __index | Line: 68 | Upvalues: t (copy) ]]
					if p2 == "_currentValue" then
						return t._currentValue
					end

					if p2 == "_currentValue2" then
						return t._currentValue2
					end

					if p2 == "_threadCount" then
						return t._threadCount
					end

					if p2 == "displayName" then
						return t.displayName
					end

					return nil
				end,
				__newindex = function(p1, p2, p3) --[[ __newindex | Line: 81 | Upvalues: t (copy), v1 (ref), console (ref) ]]
					if p2 == "_currentValue" then
						t._currentValue = p3

						return
					end

					if p2 == "_currentValue2" then
						t._currentValue2 = p3

						return
					end

					if p2 == "_threadCount" then
						t._threadCount = p3

						return
					end

					if p2 ~= "displayName" or v1 then
						return
					end

					console.warn("Setting `displayName` on Context.Consumer has no effect. " .. "You should set it directly on the context with Context.displayName = " .. p3 .. ".")
					v1 = true
				end
			}

			setmetatable(t2, t3)
			t.Consumer = t2
		else
			t.Consumer = t
		end

		if _G.__DEV__ then
			t._currentRenderer = nil
			t._currentRenderer2 = nil
		end

		return t
	end
}