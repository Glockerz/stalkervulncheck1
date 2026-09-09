-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local AssetService = game:GetService("AssetService")
local RunService = game:GetService("RunService")
local v1 = AssetService:CreateEditableMeshAsync(workspace:WaitForChild("SoapBubble").MeshContent)
local v2 = AssetService:CreateMeshPartAsync(Content.fromObject(v1))

v2.Parent = workspace
v2.Size = workspace.SoapBubble.Size
v2.Position = workspace.SoapBubble.Position + Vector3.new(25, 0, 0)
v2.Material = Enum.Material.Glass
v2.Transparency = 0.88
v2.Reflectance = 0.6
v2.CanCollide = false
v2.Anchored = true
v2.CastShadow = false
workspace.SoapBubble.SurfaceAppearance:Clone().Parent = v2

local t = {}

for i, v in ipairs((v1:GetVertices())) do
	local v4
	local v5 = v1:GetPosition(v)
	local Magnitude = v5.Magnitude
	local v6 = math.atan2(v5.Z, v5.X)

	v4 = Magnitude > 0 and math.acos((math.clamp(v5.Y / Magnitude, -1, 1))) or 0
	t[v] = {
		orig = v5,
		theta = v6,
		phi = v4,
		nId = v1:GetVertexNormals(v)[1]
	}
end

local function fbm(p1, p2, p3, p4) --[[ fbm | Line: 50 ]]
	local sum = 0
	local v1 = 1
	local v2 = 1

	for i = 1, p4 or 3 do
		sum = sum + math.noise(p1 * v1, p2 * v1, p3 * v1) * v2
		v1 = v1 * 2.1
		v2 = v2 * 0.5
	end

	return sum
end

RunService.Heartbeat:Connect(function() --[[ Line: 62 | Upvalues: t (copy), fbm (copy), v1 (copy) ]]
	local v12 = os.clock() * 0.5
	local v2 = math.sin(v12 * 0.7) * 0.15 + 1

	for k, v in pairs(t) do
		local orig = v.orig
		local v6 = orig + Vector3.new(math.noise(orig.X * 0.8, orig.Y * 0.8, v12 * 0.4) * 0.9, math.noise(orig.Y * 0.8, orig.Z * 0.8, v12 * 0.4 + 3.7) * 0.9, math.noise(orig.Z * 0.8, orig.X * 0.8, v12 * 0.4 + 7.3) * 0.9)
		local v7 = fbm(v6.X * 5.2 * 0.5 + v12 * 0.9, v6.Y * 5.2 * 0.5 + v12 * 0.9 * 0.7, v6.Z * 5.2 * 0.5, 3) * 1.1
		local v8 = math.noise(orig.X * 3.5 + v12 * 1.2, orig.Y * 3.5 - v12 * 0.9, orig.Z * 3.5 + v12 * 0.6) * 0.35
		local v9 = math.noise(v.phi * 1.8 + v12 * 0.5, v.theta * 1.8 - v12 * 0.3, v12 * 0.2) * 0.49500000000000005

		v1:SetPosition(k, orig * v2 + (orig.Magnitude > 0 and orig.Unit or v1:GetNormal(v.nId)) * (v7 + v8 + v9))
	end
end)