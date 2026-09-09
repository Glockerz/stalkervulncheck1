-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__

require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1, p2, p3) --[[ Line: 10 | Upvalues: __DEV__ (copy) ]]
	if __DEV__ then
		if typeof(p1) ~= "table" then
			error(string.format("Array.every called on %s", (typeof(p1))))
		end

		if typeof(p2) ~= "function" then
			error("callback is not a function")
		end
	end

	local count = 1

	while count <= #p1 do
		local v2
		local v3 = p1[count]

		if v3 ~= nil then
			v2 = if p3 == nil then p2(v3, count, p1) else p2(p3, v3, count, p1)

			if not v2 then
				return false
			end
		end

		count = count + 1
	end

	return true
end