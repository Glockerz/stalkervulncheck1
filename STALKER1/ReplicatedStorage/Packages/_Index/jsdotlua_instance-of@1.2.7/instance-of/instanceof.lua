-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local __DEV__ = _G.__DEV__

return function(p1, p2) --[[ instanceof | Line: 5 | Upvalues: __DEV__ (copy) ]]
	if __DEV__ then
		assert(typeof(p2) == "table", "Received a non-table as the second argument for instanceof")
	end

	if typeof(p1) ~= "table" then
		return false
	end

	local ok, result = pcall(function() --[[ Line: 14 | Upvalues: p2 (copy), p1 (ref) ]]
		return if p2.new == nil then false else p1.new == p2.new
	end)

	if ok and result then
		return true
	end

	local t = {
		[p1] = true
	}

	while p1 do
		if typeof(p1) ~= "table" then
			break
		end

		p1 = getmetatable(p1)

		if typeof(p1) == "table" then
			p1 = p1.__index

			if p1 == p2 then
				return true
			end
		end

		if typeof(p1) == "table" then
			if t[p1] then
				break
			end

			t[p1] = true
		end
	end

	return false
end