-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__

require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1, p2, p3) --[[ Line: 9 | Upvalues: __DEV__ (copy) ]]
	if __DEV__ then
		if typeof(p1) ~= "table" then
			error(string.format("Array.reduce called on %s", (typeof(p1))))
		end

		if typeof(p2) ~= "function" then
			error("callback is not a function")
		end
	end

	local v1 = #p1
	local v2, v3

	if p3 == nil then
		v2 = 2

		if v1 == 0 then
			error("reduce of empty array with no initial value")
		end

		v3 = p1[1]
	else
		v2 = 1
		v3 = p3
	end

	for i = v2, v1 do
		v3 = p2(v3, p1[i], i, p1)
	end

	return v3
end