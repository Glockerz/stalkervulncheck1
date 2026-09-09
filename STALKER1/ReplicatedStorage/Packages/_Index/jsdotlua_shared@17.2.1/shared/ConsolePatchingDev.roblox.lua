-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local console = require(script.Parent:WaitForChild("console"))
local v1 = 0
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = nil

local function f9() --[[ Line: 31 ]] end

return {
	disabledLog = f9,
	disableLogs = function() --[[ Line: 40 | Upvalues: v1 (ref), v2 (ref), console (copy), v3 (ref), v4 (ref), v5 (ref), v6 (ref), v7 (ref), v8 (ref), f9 (copy) ]]
		if not _G.__DEV__ then
			return
		end

		if v1 == 0 then
			v2 = console.log
			v3 = console.info
			v4 = console.warn
			v5 = console.error
			v6 = console.group
			v7 = console.groupCollapsed
			v8 = console.groupEnd
			console.info = f9
			console.log = f9
			console.warn = f9
			console.error = f9
			console.group = f9
			console.groupCollapsed = f9
			console.groupEnd = f9
		end

		v1 = v1 + 1
	end,
	reenableLogs = function() --[[ Line: 64 | Upvalues: v1 (ref), console (copy), v2 (ref), v3 (ref), v4 (ref), v5 (ref), v6 (ref), v7 (ref), v8 (ref) ]]
		if not _G.__DEV__ then
			return
		end

		v1 = v1 - 1

		if v1 == 0 then
			console.log = v2
			console.info = v3
			console.warn = v4
			console.error = v5
			console.group = v6
			console.groupCollapsed = v7
			console.groupEnd = v8
		end

		if not (v1 < 0) then
			return
		end

		console.error("disabledDepth fell below zero. This is a bug in React. Please file an issue.")
	end
}