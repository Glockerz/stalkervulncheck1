-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function unimplemented(p1) --[[ unimplemented | Line: 13 ]]
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: " .. tostring(p1))
	error("FIXME (roblox): " .. p1 .. " is unimplemented", 2)
end

local CollectionService = game:GetService("CollectionService")
local v1 = require(script.Parent.Parent.Parent:WaitForChild("luau-polyfill"))
local inspect = v1.util.inspect
local console = require(script.Parent.Parent.Parent:WaitForChild("shared")).console

require(script.Parent:WaitForChild("ReactRobloxHostTypes.roblox"))

local ReactRobloxComponentTree = require(script.Parent:WaitForChild("ReactRobloxComponentTree"))
local precacheFiberNode = ReactRobloxComponentTree.precacheFiberNode
local uncacheFiberNode = ReactRobloxComponentTree.uncacheFiberNode
local updateFiberProps = ReactRobloxComponentTree.updateFiberProps
local ReactRobloxComponent = require(script.Parent:WaitForChild("ReactRobloxComponent"))
local setInitialProperties = ReactRobloxComponent.setInitialProperties
local diffProperties = ReactRobloxComponent.diffProperties
local updateProperties = ReactRobloxComponent.updateProperties
local cleanupHostComponent = ReactRobloxComponent.cleanupHostComponent
local enableCreateEventHandleAPI = require(script.Parent.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.enableCreateEventHandleAPI

local function recursivelyUncacheFiberNode(p1) --[[ recursivelyUncacheFiberNode | Line: 204 | Upvalues: uncacheFiberNode (copy) ]]
	if typeof(p1) ~= "Instance" then
		return
	end

	uncacheFiberNode(p1)

	for v1, v2 in p1:GetDescendants() do
		uncacheFiberNode(v2)
	end
end

local t = {}

v1.Object.assign(t, require(script.Parent.Parent.Parent:WaitForChild("shared")).ReactFiberHostConfig.WithNoPersistence)
function t.getRootHostContext(p1) --[[ Line: 225 ]]
	return p1.ClassName
end
function t.getChildHostContext(p1, p2, p3) --[[ Line: 263 ]]
	return p1
end
function t.getPublicInstance(p1) --[[ Line: 284 ]]
	return p1
end
function t.prepareForCommit(p1) --[[ Line: 288 | Upvalues: enableCreateEventHandleAPI (copy) ]]
	if not enableCreateEventHandleAPI then
		return nil
	end

	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: " .. tostring("enableCreateEventHandleAPI"))
	error("FIXME (roblox): enableCreateEventHandleAPI is unimplemented", 2)
end
function t.beforeActiveInstanceBlur() --[[ Line: 303 | Upvalues: enableCreateEventHandleAPI (copy) ]]
	if not enableCreateEventHandleAPI then
		return
	end

	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: " .. tostring("enableCreateEventHandleAPI"))
	error("FIXME (roblox): enableCreateEventHandleAPI is unimplemented", 2)
end
function t.afterActiveInstanceBlur() --[[ Line: 312 | Upvalues: enableCreateEventHandleAPI (copy) ]]
	if not enableCreateEventHandleAPI then
		return
	end

	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: " .. tostring("enableCreateEventHandleAPI"))
	error("FIXME (roblox): enableCreateEventHandleAPI is unimplemented", 2)
end
function t.resetAfterCommit(p1) --[[ Line: 321 ]] end
function t.createInstance(p1, p2, p3, p4, p5) --[[ Line: 329 | Upvalues: precacheFiberNode (copy), updateFiberProps (copy) ]]
	local v1 = Instance.new(p1)

	if p5.key then
		v1.Name = p5.key
	else
		local return_ = p5.return_

		while true do
			if not return_ then
				precacheFiberNode(p5, v1)
				updateFiberProps(v1, p2)

				return v1
			end

			if return_.key then
				break
			end

			return_ = return_.return_
		end

		v1.Name = return_.key
	end

	precacheFiberNode(p5, v1)
	updateFiberProps(v1, p2)

	return v1
end
function t.appendInitialChild(p1, p2) --[[ Line: 396 ]]
	p2.Parent = p1
end
function t.finalizeInitialChildren(p1, p2, p3, p4, p5) --[[ Line: 401 | Upvalues: setInitialProperties (copy) ]]
	setInitialProperties(p1, p2, p3, p4)

	return false
end
function t.prepareUpdate(p1, p2, p3, p4, p5, p6) --[[ prepareUpdate | Line: 413 | Upvalues: diffProperties (copy) ]]
	return diffProperties(p1, p2, p3, p4, p5)
end
function t.shouldSetTextContent(p1, p2) --[[ Line: 440 ]]
	return false
end
function t.createTextInstance(p1, p2, p3, p4) --[[ Line: 456 ]]
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: " .. tostring("createTextInstance"))
	error("FIXME (roblox): createTextInstance is unimplemented", 2)
end
t.isPrimaryRenderer = true
t.warnsIfNotActing = true
t.scheduleTimeout = v1.setTimeout
t.cancelTimeout = v1.clearTimeout
t.noTimeout = -1
t.supportsMutation = true
function t.commitMount(p1, p2, p3, p4) --[[ Line: 482 ]]
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: " .. tostring("commitMount"))
	error("FIXME (roblox): commitMount is unimplemented", 2)
end
function t.commitUpdate(p1, p2, p3, p4, p5, p6) --[[ Line: 504 | Upvalues: updateFiberProps (copy), updateProperties (copy) ]]
	updateFiberProps(p1, p5)
	updateProperties(p1, p2, p4)
end

local function checkTags(p1) --[[ checkTags | Line: 533 | Upvalues: console (copy), inspect (copy), CollectionService (copy) ]]
	if typeof(p1) ~= "Instance" then
		console.warn("Could not check tags on non-instance %s.", inspect(p1))

		return
	end

	if p1:IsDescendantOf(game) or not (#CollectionService:GetTags(p1) > 0) then
		return
	end

	console.warn("Tags applied to orphaned %s \"%s\" cannot be accessed via CollectionService:GetTagged. If you\'re relying on tag behavior in a unit test, consider mounting your test root into the DataModel.", p1.ClassName, p1.Name)
end

function t.appendChild(p1, p2) --[[ Line: 552 | Upvalues: checkTags (copy) ]]
	p2.Parent = p1

	if not _G.__DEV__ then
		return
	end

	checkTags(p2)
end
function t.appendChildToContainer(p1, p2) --[[ Line: 561 | Upvalues: t (copy) ]]
	t.appendChild(p1, p2)
end
function t.insertBefore(p1, p2, p3) --[[ Line: 591 | Upvalues: checkTags (copy) ]]
	p2.Parent = p1

	if not _G.__DEV__ then
		return
	end

	checkTags(p2)
end
function t.insertInContainerBefore(p1, p2, p3) --[[ Line: 601 | Upvalues: t (copy) ]]
	t.insertBefore(p1, p2, p3)
end
function t.removeChild(p1, p2) --[[ Line: 639 | Upvalues: uncacheFiberNode (copy), cleanupHostComponent (copy) ]]
	if typeof(p2) == "Instance" then
		uncacheFiberNode(p2)

		for v1, v2 in p2:GetDescendants() do
			uncacheFiberNode(v2)
		end
	end

	cleanupHostComponent(p2)
	p2.Parent = nil
	p2:Destroy()
end
function t.removeChildFromContainer(p1, p2) --[[ Line: 651 | Upvalues: t (copy) ]]
	t.removeChild(p1, p2)
end
function t.clearSuspenseBoundary(p1, p2) --[[ Line: 663 ]]
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: " .. tostring("clearSuspenseBoundary"))
	error("FIXME (roblox): clearSuspenseBoundary is unimplemented", 2)
end
function t.clearSuspenseBoundaryFromContainer(p1, p2) --[[ Line: 701 ]]
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: " .. tostring("clearSuspenseBoundaryFromContainer"))
	error("FIXME (roblox): clearSuspenseBoundaryFromContainer is unimplemented", 2)
end
function t.hideInstance(p1) --[[ Line: 715 ]]
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: " .. tostring("hideInstance"))
	error("FIXME (roblox): hideInstance is unimplemented", 2)
end
function t.hideTextInstance(p1) --[[ Line: 729 ]]
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: " .. tostring("hideTextInstance"))
	error("FIXME (roblox): hideTextInstance is unimplemented", 2)
end
function t.unhideInstance(p1, p2) --[[ Line: 734 ]]
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: " .. tostring("unhideInstance"))
	error("FIXME (roblox): unhideInstance is unimplemented", 2)
end
function t.unhideTextInstance(p1, p2) --[[ Line: 748 ]]
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	print("UNIMPLEMENTED ERROR: " .. tostring("unhideTextInstance"))
	error("FIXME (roblox): unhideTextInstance is unimplemented", 2)
end
function t.clearContainer(p1) --[[ Line: 753 | Upvalues: t (copy) ]]
	for v1, v2 in p1:GetChildren() do
		t.removeChild(p1, v2)
	end
end
function t.preparePortalMount(p1) --[[ Line: 1196 ]] end

return t