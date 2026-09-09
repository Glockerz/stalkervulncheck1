-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function provide(p1, p2) --[[ provide | Line: 23 ]]
	return function(p12) --[[ Line: 24 | Upvalues: p1 (copy), p2 (copy) ]]
		local v1 = coroutine.running()
		local v2 = p1._values[v1]

		p1._values[v1] = p12

		local ok, result = pcall(p2)

		p1._values[v1] = v2

		if not ok then
			error(("provided callback errored with \"%*\""):format(result), 2)
		end

		return result
	end
end

local function consume(p1) --[[ consume | Line: 42 ]]
	return p1._values[coroutine.running()] or p1.default_value
end

return function(p1) --[[ create_context | Line: 47 | Upvalues: provide (copy), consume (copy) ]]
	return {
		default_value = p1,
		_values = {},
		provide = provide,
		consume = consume
	}
end