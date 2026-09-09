-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"))
local console = v1.console
local Array = v1.Array
local ReactSharedInternals = require(script.Parent:WaitForChild("ReactSharedInternals"))
local v2 = nil
local t = {
	warn = function(p1, ...) --[[ Line: 24 | Upvalues: v2 (ref) ]]
		if not _G.__DEV__ then
			return
		end

		v2("warn", p1, { ... })
	end,
	error = function(p1, ...) --[[ Line: 29 | Upvalues: v2 (ref) ]]
		if not _G.__DEV__ then
			return
		end

		v2("error", p1, { ... })
	end
}

v2 = function(p1, p2, p3) --[[ printWarning | Line: 35 | Upvalues: ReactSharedInternals (copy), Array (copy), console (copy) ]]
	if not _G.__DEV__ then
		return
	end

	local v1 = ReactSharedInternals.ReactDebugCurrentFrame.getStackAddendum()

	if v1 ~= "" then
		local v2 = Array.slice(p3, 1)

		table.insert(v2, v1)
		p3, p2 = v2, p2 .. "%s"
	end

	local v3 = Array.map(p3, tostring)

	table.insert(v3, 1, "Warning: " .. p2)
	console[p1](unpack(v3))
end

return t