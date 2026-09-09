-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Internal = script.Parent.Parent.Internal

require(Internal.GoodSignal)

local Janitor = require(Internal.Janitor)
local BorderSnap = require(Internal.BorderSnap)
local CameraUtils = require(Internal.CameraUtils)
local GeneralSettings = script.Parent.Parent.GeneralSettings
local CollectionService = game:GetService("CollectionService")
local MinimapRenderer = require(script.Parent.MinimapRenderer)
local t = {
	InitializationPriority = 3,
	Signals = {}
}

local function getAngleAboutYAxis(p1) --[[ getAngleAboutYAxis | Line: 36 ]]
	local _, _2, _3, v1, _4, v2, _5, _6, _7, v3, _8, v4 = p1:components()

	return math.atan2(v2 - v3, v1 + v4)
end

function t.InitializeFrame(p1, p2, p3) --[[ InitializeFrame | Line: 46 | Upvalues: Janitor (copy), GeneralSettings (copy), CollectionService (copy), CameraUtils (copy), MinimapRenderer (copy), BorderSnap (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.fromScale(1, 1)
	Frame.BackgroundTransparency = 1
	Frame.Parent = p1
	Frame.ZIndex = 501

	local CanvasGroup = Instance.new("CanvasGroup")

	CanvasGroup.Size = UDim2.fromScale(1, 1)
	CanvasGroup.BackgroundTransparency = 1
	CanvasGroup.Parent = p1
	CanvasGroup.ZIndex = 501
	CanvasGroup.ClipsDescendants = true

	local UICorner = p1:FindFirstChildOfClass("UICorner")

	if UICorner then
		UICorner:Clone().Parent = CanvasGroup
	end

	p2.BlipHolder = Frame
	p2.BlipHolderClip = CanvasGroup
	p2.Blips = {}

	for v1, v2 in script.Parent.Parent.Blips:GetChildren() do
		if not v2:FindFirstChild("Rotate") then
			error("No Rotate BoolValue was provided in the blip data " .. v2:GetFullName())
		end

		if not v2:FindFirstChild("SnapToBorder") then
			error("No SnapToBorder BoolValue was provided in the blip data " .. v2:GetFullName())
		end

		if not v2:FindFirstChildOfClass("Decal") then
			error("No Decal was provided in the blip data " .. v2:GetFullName())
		end

		local function BlipAdded(p1) --[[ BlipAdded | Line: 83 | Upvalues: p3 (copy), Janitor (ref), GeneralSettings (ref), Frame (copy), v2 (copy), CanvasGroup (copy), p2 (copy) ]]
			if not p1:IsA("BasePart") then
				return
			end

			local v1 = p3:Add(Janitor.new())
			local v22 = v1:Add(GeneralSettings:WaitForChild("Blip"):Clone())

			v22.AnchorPoint = Vector2.new(0.5, 0.5)
			v22.Parent = Frame
			v22.Image = v2.Decal.Texture
			v22:SetAttribute("AnchorName", p1.Name)

			local SnapToBorder = v2.SnapToBorder.Value

			if not SnapToBorder then
				v22.Parent = CanvasGroup
			end

			p2.Blips[p1] = {
				Instance = p1,
				SnapToBorder = SnapToBorder,
				Rotate = v2.Rotate.Value,
				Object = v22,
				Janitor = v1
			}
		end

		p3:Add(CollectionService:GetInstanceAddedSignal(v2.Name):Connect(BlipAdded))

		for v3, v4 in CollectionService:GetTagged(v2.Name) do
			BlipAdded(v4)
		end

		p3:Add(CollectionService:GetInstanceRemovedSignal(v2.Name):Connect(function(p1) --[[ Line: 119 | Upvalues: p2 (copy) ]]
			if not p2.Blips[p1] then
				return
			end

			p2.Blips[p1].Janitor:Destroy()
			p2.Blips[p1] = nil
		end))
	end

	p3:Add(p2.CalculatedCFrame:Connect(function(p12, p22) --[[ Line: 127 | Upvalues: p2 (copy), CameraUtils (ref), MinimapRenderer (ref), p1 (copy), BorderSnap (ref), GeneralSettings (ref) ]]
		local AbsoluteSize = p2.BlipHolder.AbsoluteSize

		for v1, v2 in p2.Blips do
			local v5 = CameraUtils.PointToViewport(p12, 70, MinimapRenderer.WorldToMap(v2.Position or v2.Instance.Position), AbsoluteSize)

			if v2.SnapToBorder then
				local v6 = UDim.new(0, 0)
				local UICorner = p1:FindFirstChildOfClass("UICorner")

				if UICorner then
					v6 = UICorner.CornerRadius
				end

				v5 = BorderSnap(v5, AbsoluteSize, v6)
			end

			if v2.Rotate then
				local _, _2, _3, v8, _4, v9, _5, _6, _7, v10, _8, v11 = v2.Instance.CFrame:components()
				local v12 = math.atan2(v9 - v10, v8 + v11)
				local v13 = p1:GetAttribute("DontRotate")

				if v13 == nil then
					v13 = GeneralSettings.DontRotate.Value
				end

				if v13 then
					v2.Object.Rotation = -math.deg(v12)
				else
					v2.Object.Rotation = math.deg(p22 - v12)
				end
			end

			v2.Object.Position = UDim2.fromScale(v5.X / AbsoluteSize.X, v5.Y / AbsoluteSize.Y)
		end
	end))
end
function t.CleanupFrame(p1) --[[ CleanupFrame | Line: 164 ]] end

return t