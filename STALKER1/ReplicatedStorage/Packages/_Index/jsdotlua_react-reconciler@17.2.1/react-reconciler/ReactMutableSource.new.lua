-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local console = require(script.Parent.Parent:WaitForChild("shared")).console
local t = {}

require(script.Parent.Parent:WaitForChild("shared"))
require(script.Parent:WaitForChild("ReactInternalTypes"))

local isPrimaryRenderer = require(script.Parent:WaitForChild("ReactFiberHostConfig")).isPrimaryRenderer
local t2 = {}
local v1 = if _G.__DEV__ then {} else nil

function t.markSourceAsDirty(p1) --[[ Line: 37 | Upvalues: t2 (copy) ]]
	table.insert(t2, p1)
end
function t.resetWorkInProgressVersions() --[[ Line: 41 | Upvalues: t2 (copy), isPrimaryRenderer (copy) ]]
	for v1, v2 in t2 do
		if isPrimaryRenderer then
			v2._workInProgressVersionPrimary = nil

			continue
		end

		v2._workInProgressVersionSecondary = nil
	end

	table.clear(t2)
end
function t.getWorkInProgressVersion(p1) --[[ Line: 53 | Upvalues: isPrimaryRenderer (copy) ]]
	if isPrimaryRenderer then
		return p1._workInProgressVersionPrimary
	end

	return p1._workInProgressVersionSecondary
end
function t.setWorkInProgressVersion(p1, p2) --[[ Line: 62 | Upvalues: isPrimaryRenderer (copy), t2 (copy) ]]
	if isPrimaryRenderer then
		p1._workInProgressVersionPrimary = p2
	else
		p1._workInProgressVersionSecondary = p2
	end

	table.insert(t2, p1)
end
function t.warnAboutMultipleRenderersDEV(p1) --[[ Line: 71 | Upvalues: isPrimaryRenderer (copy), v1 (ref), console (copy) ]]
	if not _G.__DEV__ then
		return
	end

	if isPrimaryRenderer then
		if p1._currentPrimaryRenderer == nil then
			p1._currentPrimaryRenderer = v1

			return
		end

		if p1._currentPrimaryRenderer ~= v1 then
			console.error("Detected multiple renderers concurrently rendering the same mutable source. This is currently unsupported.")
		end
	else
		if p1._currentSecondaryRenderer == nil then
			p1._currentSecondaryRenderer = v1

			return
		end

		if p1._currentSecondaryRenderer == v1 then
			return
		end

		console.error("Detected multiple renderers concurrently rendering the same mutable source. This is currently unsupported.")
	end
end
function t.registerMutableSourceForHydration(p1, p2) --[[ Line: 100 ]]
	local v1 = p2._getVersion(p2._source)

	if p1.mutableSourceEagerHydrationData ~= nil then
		return
	end

	p1.mutableSourceEagerHydrationData = { p2, v1 }
end

return t