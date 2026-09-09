-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local console = require(script.Parent.Parent:WaitForChild("luau-polyfill")).console

local function onlyInTestError(p1) --[[ onlyInTestError | Line: 26 | Upvalues: console (copy) ]]
	return function() --[[ Line: 27 | Upvalues: console (ref), p1 (copy) ]]
		console.error(p1 .. " is only available in tests, not in production")
	end
end

local ReactCurrentDispatcher = require(script:WaitForChild("ReactCurrentDispatcher"))
local ReactCurrentBatchConfig = require(script:WaitForChild("ReactCurrentBatchConfig"))
local ReactCurrentOwner = require(script:WaitForChild("ReactCurrentOwner"))
local ReactDebugCurrentFrame = require(script:WaitForChild("ReactDebugCurrentFrame"))
local t = {
	ReactCurrentDispatcher = ReactCurrentDispatcher,
	ReactCurrentBatchConfig = ReactCurrentBatchConfig,
	ReactCurrentOwner = ReactCurrentOwner,
	IsSomeRendererActing = require(script:WaitForChild("IsSomeRendererActing"))
}

t.ReactDebugCurrentFrame = if _G.__DEV__ then ReactDebugCurrentFrame else {
	setExtraStackFrame = function(p1) --[[ setExtraStackFrame | Line: 50 ]] end
}

return t