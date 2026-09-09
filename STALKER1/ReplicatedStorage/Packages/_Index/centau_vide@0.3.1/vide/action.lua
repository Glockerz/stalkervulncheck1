-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = table.freeze({})

local function is_action(p1) --[[ is_action | Line: 8 | Upvalues: v1 (copy) ]]
	return getmetatable(p1) == v1
end

local function action(p1, p2) --[[ action | Line: 12 | Upvalues: v1 (copy) ]]
	local t = {
		priority = p2 or 1,
		callback = p1
	}

	setmetatable(t, v1)

	return table.freeze(t)
end

return function() --[[ Line: 23 | Upvalues: action (copy), is_action (copy) ]]
	return action, is_action
end