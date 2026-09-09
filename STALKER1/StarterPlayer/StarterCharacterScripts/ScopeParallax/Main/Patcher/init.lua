-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	modelDetectionMethod = nil,
	modelDetectionPath = nil,
	connections = {
		childAdded = nil,
		childRemoved = nil
	},
	parentingMethod = nil,
	glassMethod = nil,
	aimpartZOffset = 0.5,
	currentRootModel = nil,
	cleanupParts = {},
	interval = 0,
	timeout = 100
}
local CurrentCamera = workspace.CurrentCamera
local Activate = require(script.Parent:WaitForChild("Activate"))

function t.init() --[[ init | Line: 22 | Upvalues: t (copy) ]]
	t.update("Default")
end
function t.update(p1) --[[ update | Line: 26 | Upvalues: t (copy) ]]
	local v1 = require(script:FindFirstChild(p1))

	if t.connections.childAdded then
		t.connections.childAdded:Disconnect()
	end

	if not t.connections.childRemoved then
		t.modelDetectionPath = v1.modelDetectionPath()
		t.modelDetectionMethod = v1.modelDetectionMethod
		t.parentingMethod = v1.parentingMethod
		t.aimpartZOffset = v1.aimpartZOffset
		t.connections.childAdded = t.modelDetectionPath.ChildAdded:Connect(t.onChildAdded)
		t.connections.childRemoved = t.modelDetectionPath.ChildRemoved:Connect(t.onChildRemoved)

		return
	end

	t.connections.childRemoved:Disconnect()
	t.modelDetectionPath = v1.modelDetectionPath()
	t.modelDetectionMethod = v1.modelDetectionMethod
	t.parentingMethod = v1.parentingMethod
	t.aimpartZOffset = v1.aimpartZOffset
	t.connections.childAdded = t.modelDetectionPath.ChildAdded:Connect(t.onChildAdded)
	t.connections.childRemoved = t.modelDetectionPath.ChildRemoved:Connect(t.onChildRemoved)
end
function t.onChildAdded(p1) --[[ onChildAdded | Line: 46 | Upvalues: t (copy), Activate (copy) ]]
	local v1 = nil

	for i = 1, t.timeout do
		local v2 = t.modelDetectionMethod(p1)

		v1 = v2

		if v2 then
			break
		end

		task.wait(t.interval)
	end

	if not v1 then
		return
	end

	t.currentRootModel = p1
	t.cleanupParts = Activate.start(v1, t)
end
function t.onChildRemoved(p1) --[[ onChildRemoved | Line: 65 | Upvalues: t (copy) ]]
	if p1 ~= t.currentRootModel then
		return
	end

	for v1, v2 in t.cleanupParts do
		v2:Destroy()
	end

	t.currentRootModel = nil
end

return t