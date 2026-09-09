-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"))
local inspect = v1.util.inspect
local setTimeout = v1.setTimeout
local v2 = require(script.Parent.Parent:WaitForChild("shared"))
local console = v2.console
local errorToString = v2.errorToString

require(script.Parent:WaitForChild("ReactInternalTypes"))
require(script.Parent:WaitForChild("ReactCapturedValue"))

local showErrorDialog = require(script.Parent:WaitForChild("ReactFiberErrorDialog")).showErrorDialog
local ClassComponent = require(script.Parent:WaitForChild("ReactWorkTags")).ClassComponent
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName

return {
	logCapturedError = function(p1, p2) --[[ Line: 32 | Upvalues: showErrorDialog (copy), ClassComponent (copy), console (copy), getComponentName (copy), inspect (copy), setTimeout (copy), errorToString (copy) ]]
		local ok, result = pcall(function() --[[ Line: 33 | Upvalues: showErrorDialog (ref), p1 (copy), p2 (copy), ClassComponent (ref), console (ref), getComponentName (ref), inspect (ref) ]]
			if showErrorDialog(p1, p2) == false then
				return nil
			end

			local value = p2.value

			if _G.__DEV__ then
				local source = p2.source

				if value ~= nil and value._suppressLogging then
					if p1.tag == ClassComponent then
						return
					end

					console.error(value)
				end

				local v2 = if source == nil then nil else getComponentName(source.type)
				local v4 = if v2 then "The above error occurred in the <" .. tostring(v2) .. "> component:" else "The above error occurred in one of your React components:"
				local v5 = getComponentName(p1.type)

				console.error(v4 .. "\n" .. (p2.stack or "") .. "\n\n" .. (if v5 then "React will try to recreate this component tree from scratch " .. "using the error boundary you provided, " .. v5 .. "." else "Consider adding an error boundary to your tree to customize error handling behavior.\nVisit https://reactjs.org/link/error-boundaries to learn more about error boundaries."))
			else
				console.error(inspect(value))
			end

			return nil
		end)

		if ok then
			return
		end

		warn("failed to error with error: " .. inspect(result))
		setTimeout(function() --[[ Line: 124 | Upvalues: errorToString (ref), result (copy) ]]
			error(errorToString(result))
		end)
	end
}