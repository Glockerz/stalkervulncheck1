-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent:WaitForChild("luau-polyfill"))
require(script.Parent:WaitForChild("ReactInternalTypes"))

local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"))
local HostComponent = ReactWorkTags.HostComponent
local LazyComponent = ReactWorkTags.LazyComponent
local SuspenseComponent = ReactWorkTags.SuspenseComponent
local SuspenseListComponent = ReactWorkTags.SuspenseListComponent
local FunctionComponent = ReactWorkTags.FunctionComponent
local IndeterminateComponent = ReactWorkTags.IndeterminateComponent
local ForwardRef = ReactWorkTags.ForwardRef
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent
local ClassComponent = ReactWorkTags.ClassComponent
local ReactComponentStackFrame = require(script.Parent.Parent:WaitForChild("shared")).ReactComponentStackFrame
local describeBuiltInComponentFrame = ReactComponentStackFrame.describeBuiltInComponentFrame
local describeFunctionComponentFrame = ReactComponentStackFrame.describeFunctionComponentFrame
local describeClassComponentFrame = ReactComponentStackFrame.describeClassComponentFrame

local function describeFiber(p1) --[[ describeFiber | Line: 37 | Upvalues: HostComponent (copy), describeBuiltInComponentFrame (copy), LazyComponent (copy), SuspenseComponent (copy), SuspenseListComponent (copy), FunctionComponent (copy), IndeterminateComponent (copy), SimpleMemoComponent (copy), describeFunctionComponentFrame (copy), ForwardRef (copy), ClassComponent (copy), describeClassComponentFrame (copy) ]]
	local v1 = nil

	if _G.__DEV__ then
		local _debugOwner = p1._debugOwner

		if _debugOwner then
			v1 = _debugOwner.type
		end
	end

	local v2 = if _G.__DEV__ then p1._debugSource else nil

	if p1.tag == HostComponent then
		return describeBuiltInComponentFrame(p1.type, v2, v1)
	end

	if p1.tag == LazyComponent then
		return describeBuiltInComponentFrame("Lazy", v2, v1)
	end

	if p1.tag == SuspenseComponent then
		return describeBuiltInComponentFrame("Suspense", v2, v1)
	end

	if p1.tag == SuspenseListComponent then
		return describeBuiltInComponentFrame("SuspenseList", v2, v1)
	end

	if p1.tag == FunctionComponent or (p1.tag == IndeterminateComponent or p1.tag == SimpleMemoComponent) then
		return describeFunctionComponentFrame(p1.type, v2, v1)
	end

	if p1.tag == ForwardRef then
		return describeFunctionComponentFrame(p1.type.render, v2, v1)
	end

	if p1.tag == ClassComponent then
		return describeClassComponentFrame(p1.type, v2, v1)
	end

	return ""
end

return {
	getStackByFiberInDevAndProd = function(p1) --[[ getStackByFiberInDevAndProd | Line: 75 | Upvalues: describeFiber (copy) ]]
		local ok, result = pcall(function() --[[ Line: 76 | Upvalues: p1 (copy), describeFiber (ref) ]]
			local v1 = p1
			local v2 = ""

			repeat
				v2 = v2 .. describeFiber(v1)
				v1 = v1.return_
			until v1 == nil

			return v2
		end)

		if ok then
			return result
		end

		if typeof(result) == "table" and (result.message and result.stack) then
			return "\nError generating stack: " .. result.message .. "\n" .. tostring(result.stack)
		end

		return "\nError generating stack: " .. tostring(result)
	end
}