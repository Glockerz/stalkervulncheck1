-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__

require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

return function(p1, p2, p3) --[[ Line: 10 | Upvalues: __DEV__ (copy) ]]
	if __DEV__ then
		if typeof(p1) ~= "table" then
			error(string.format("Array.forEach called on %s", (typeof(p1))))
		end

		if typeof(p2) ~= "function" then
			error("callback is not a function")
		end
	end

	local count = 1
	local v1 = #p1

	while count <= v1 do
		local v2 = p1[count]

		if p3 == nil then
			p2(v2, count, p1)
		else
			p2(p3, v2, count, p1)
		end

		if #p1 < v1 then
			v1 = #p1
		end

		count = count + 1
	end
end