-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Workspace = game:GetService("Workspace")
local t = {}
local t2 = {
	PlayerNameplate = true,
	SquadNametag = true,
	CustomBubbleChat = true,
	NPCDebugOverlay = true
}
local v1 = nil
local v2 = nil
local v3 = nil

local function suppress(p1) --[[ suppress | Line: 35 | Upvalues: v1 (ref), v2 (ref) ]]
	if v1[p1] ~= nil then
		return
	end

	v1[p1] = p1.Enabled

	if p1.Enabled then
		p1.Enabled = false
	end

	v2[p1] = p1:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 45 | Upvalues: p1 (copy) ]]
		if not p1.Enabled then
			return
		end

		p1.Enabled = false
	end)
end

function t.Enter(p1, p2) --[[ Enter | Line: 50 | Upvalues: v1 (ref), v2 (ref), Workspace (copy), t2 (copy), suppress (copy), v3 (ref) ]]
	v1 = {}
	v2 = {}

	for i, v in ipairs(Workspace:GetDescendants()) do
		if v:IsA("BillboardGui") and t2[v.Name] then
			suppress(v)
		end
	end

	v3 = Workspace.DescendantAdded:Connect(function(p1) --[[ Line: 58 | Upvalues: t2 (ref), suppress (ref) ]]
		if not (p1:IsA("BillboardGui") and t2[p1.Name]) then
			return
		end

		suppress(p1)
	end)
end
function t.Exit(p1) --[[ Exit | Line: 63 | Upvalues: v3 (ref), v2 (ref), v1 (ref) ]]
	if v3 then
		v3:Disconnect()
		v3 = nil
	end

	if v2 then
		for k, v in pairs(v2) do
			pcall(function() --[[ Line: 68 | Upvalues: v (copy) ]]
				v:Disconnect()
			end)
		end

		v2 = nil
	end

	if not v1 then
		return
	end

	for k, v in pairs(v1) do
		if k.Parent then
			k.Enabled = v
		end
	end

	v1 = nil
end

return t