-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local console = require(script.Parent.Parent:WaitForChild("shared")).console
local inspect = require(script.Parent.Parent:WaitForChild("luau-polyfill")).util.inspect

require(script.Parent.Parent:WaitForChild("shared"))

local REACT_LAZY_TYPE = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols.REACT_LAZY_TYPE

function lazyInitializer(p1) --[[ lazyInitializer | Line: 71 | Upvalues: console (copy), inspect (copy) ]]
	if p1._status == -1 then
		local v1 = p1._result()

		p1._status = 0
		p1._result = v1
		v1:andThen(function(p12) --[[ Line: 79 | Upvalues: p1 (copy), console (ref), inspect (ref) ]]
			if p1._status ~= 0 then
				return
			end

			local default = p12.default

			if _G.__DEV__ and default == nil then
				console.error("lazy: Expected the result of a dynamic import() call. Instead received: `%s`\n\nYour code should look like: \n  local MyComponent = lazy(function() return reqquire(script.Parent.MyComponent) end)", inspect(p12))
			end

			local v1 = p1

			v1._status = 1
			v1._result = default
		end, function(p12) --[[ Line: 100 | Upvalues: p1 (copy) ]]
			if p1._status ~= 0 then
				return
			end

			local v1 = p1

			v1._status = 2
			v1._result = p12
		end)
	end

	if p1._status == 1 then
		return p1._result
	end

	error(p1._result)
end

return {
	lazy = function(p1) --[[ Line: 118 | Upvalues: REACT_LAZY_TYPE (copy), console (copy) ]]
		local t = {
			["$$typeof"] = REACT_LAZY_TYPE,
			_payload = {
				_status = -1,
				_result = p1
			},
			_init = lazyInitializer
		}

		if _G.__DEV__ then
			local v1 = nil
			local v2 = nil
			local t2 = {
				__index = function(p1, p2) --[[ __index | Line: 140 | Upvalues: v1 (ref), v2 (ref) ]]
					if p2 == "defaultProps" then
						return v1
					end

					if p2 == "propTypes" then
						return v2
					end
				end,
				__newindex = function(p1, p2, p3) --[[ __newindex | Line: 149 | Upvalues: console (ref), v1 (ref), v2 (ref) ]]
					if p2 == "defaultProps" then
						console.error("React.lazy(...): It is not supported to assign `defaultProps` to a lazy component import. Either specify them where the component is defined, or create a wrapping component around it.")
						v1 = p3
						setmetatable(p1, {
							__index = function() --[[ __index | Line: 160 ]] end,
							__newindex = function() --[[ __newindex | Line: 161 ]] end
						})
					end

					if p2 ~= "propTypes" then
						return
					end

					console.error("React.lazy(...): It is not supported to assign `propTypes` to a lazy component import. Either specify them where the component is defined, or create a wrapping component around it.")
					v2 = p3
					setmetatable(p1, {
						__index = function() --[[ __index | Line: 174 ]] end,
						__newindex = function() --[[ __newindex | Line: 175 ]] end
					})
				end
			}

			setmetatable(t, t2)
		end

		return t
	end
}