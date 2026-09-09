-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

game:GetService("Workspace")

local PdaMapData = require(ReplicatedStorage:WaitForChild("PdaMapData"))
local PdaMapBlipFactory = require(ReplicatedStorage:WaitForChild("PdaMapBlipFactory"))
local TaskTargetResolver = require(ReplicatedStorage:WaitForChild("TaskTargetResolver"))
local SquadMapResolver = require(ReplicatedStorage:WaitForChild("SquadMapResolver"))
local PlaceConfig = require(ReplicatedStorage:WaitForChild("PlaceConfig"))
local LocalPlayer = Players.LocalPlayer
local t = {}
local t2 = {
	bandit = "rbxassetid://90929298556934",
	mutant = "rbxassetid://98949484501928",
	default = "rbxassetid://128212304073017"
}

local function plumsRoot() --[[ plumsRoot | Line: 51 | Upvalues: LocalPlayer (copy) ]]
	local v1 = LocalPlayer and LocalPlayer:FindFirstChild("PlayerScripts")

	if v1 then
		local PlumsMinimapV2 = v1:FindFirstChild("PlumsMinimapV2")

		if PlumsMinimapV2 then
			return PlumsMinimapV2
		end
	end

	local StarterPlayerScripts = game:GetService("StarterPlayer"):FindFirstChild("StarterPlayerScripts")

	if StarterPlayerScripts then
		return StarterPlayerScripts:FindFirstChild("PlumsMinimapV2")
	end

	return nil
end

local function applyPlumsSettings(p1) --[[ applyPlumsSettings | Line: 62 | Upvalues: plumsRoot (copy) ]]
	local v1 = plumsRoot()

	if not v1 then
		return
	end

	local GeneralSettings = v1:FindFirstChild("GeneralSettings")

	if not GeneralSettings then
		return
	end

	GeneralSettings.DontRotate.Value = true
	GeneralSettings.OpenFullMapWithClick.Value = false
	GeneralSettings.Zoom.Value = p1.DefaultZoom

	local Maps = v1:FindFirstChild("Maps")
	local v2 = if Maps then Maps:FindFirstChild(p1.PlumsMap) else Maps

	if not v2 then
		return
	end

	GeneralSettings.CurrentMap.Value = v2
end

local function computeMDN(p1) --[[ computeMDN | Line: 77 ]]
	local v1 = 2048

	for i, v in ipairs(p1:GetChildren()) do
		local Size = v:FindFirstChild("Size")

		if Size and Size:IsA("Vector3Value") then
			v1 = math.max(v1, Size.Value.X, Size.Value.Z)
		end
	end

	return math.max(1, v1 / 2048)
end

local function computeBounds(p1) --[[ computeBounds | Line: 94 ]]
	local v1 = (1 / 0)
	local v2 = (-1 / 0)
	local v3 = (1 / 0)
	local v4 = (-1 / 0)

	for i, v in ipairs(p1:GetChildren()) do
		local Position = v:FindFirstChild("Position")
		local Size = v:FindFirstChild("Size")

		if Position and (Position:IsA("Vector3Value") and (Size and Size:IsA("Vector3Value"))) then
			local v5 = Size.Value.X / 2
			local v6 = Size.Value.Z / 2

			v1, v2, v3, v4 = math.min(v1, Position.Value.X - v5), math.max(v2, Position.Value.X + v5), math.min(v3, Position.Value.Z - v6), math.max(v4, Position.Value.Z + v6)
		end
	end

	return {
		minX = v1 - 400,
		maxX = v2 + 400,
		minZ = v3 - 400,
		maxZ = v4 + 400
	}
end

local function buildControls(p1, p2) --[[ buildControls | Line: 115 ]]
	local MapControls = Instance.new("Frame")

	MapControls.Name = "MapControls"
	MapControls.AnchorPoint = Vector2.new(0, 1)
	MapControls.Position = UDim2.new(0, 8, 1, -8)
	MapControls.Size = UDim2.fromOffset(132, 40)
	MapControls.BackgroundColor3 = Color3.fromRGB(20, 22, 20)
	MapControls.BackgroundTransparency = 0.25
	MapControls.BorderSizePixel = 0
	MapControls.ZIndex = 1200
	MapControls.Parent = p1

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = MapControls

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = Color3.fromRGB(85, 80, 72)
	UIStroke.Thickness = 1
	UIStroke.Transparency = 0.2
	UIStroke.Parent = MapControls

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 4)
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.Parent = MapControls

	local UIPadding = Instance.new("UIPadding")

	UIPadding.PaddingLeft = UDim.new(0, 6)
	UIPadding.PaddingRight = UDim.new(0, 6)
	UIPadding.Parent = MapControls

	local function makeButton(p1, p2, p3) --[[ makeButton | Line: 145 | Upvalues: MapControls (copy) ]]
		local TextButton = Instance.new("TextButton")

		TextButton.Size = UDim2.fromOffset(32, 32)
		TextButton.BackgroundColor3 = Color3.fromRGB(40, 42, 40)
		TextButton.BackgroundTransparency = 0.1
		TextButton.BorderSizePixel = 0
		TextButton.Text = p1
		TextButton.TextSize = 22
		TextButton.TextColor3 = Color3.fromRGB(220, 220, 220)
		TextButton.Font = Enum.Font.SourceSansBold
		TextButton.AutoButtonColor = true
		TextButton.LayoutOrder = p2
		TextButton.ZIndex = 1201
		TextButton.Parent = MapControls

		local UICorner = Instance.new("UICorner")

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = TextButton
		TextButton.MouseButton1Click:Connect(p3)

		return TextButton
	end

	makeButton("\226\136\146", 1, p2.zoomOut)
	makeButton("+", 2, p2.zoomIn)
	makeButton("\226\151\137", 3, p2.recenter)
end

local function buildLocationOverlay(p1, p2) --[[ buildLocationOverlay | Line: 173 ]]
	local LocationOverlay = Instance.new("Frame")

	LocationOverlay.Name = "LocationOverlay"
	LocationOverlay.Size = UDim2.fromScale(1, 1)
	LocationOverlay.BackgroundTransparency = 1
	LocationOverlay.BorderSizePixel = 0
	LocationOverlay.ZIndex = 400
	LocationOverlay.ClipsDescendants = true
	LocationOverlay.Parent = p1

	local t = {}
	local v1 = ipairs

	for v3, v4 in v1(p2.Locations or {}) do
		local Frame = Instance.new("Frame")

		Frame.Name = v4.Name
		Frame.BackgroundTransparency = 1
		Frame.BorderSizePixel = 0
		Frame.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame.ZIndex = 400
		Frame.Parent = LocationOverlay

		local UICorner = Instance.new("UICorner")

		UICorner.CornerRadius = UDim.new(0.5, 0)
		UICorner.Parent = Frame

		local UIStroke = Instance.new("UIStroke")

		UIStroke.Color = Color3.fromRGB(255, 200, 90)
		UIStroke.Thickness = 2
		UIStroke.Transparency = 0.2
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.Parent = Frame

		local Label = Instance.new("TextLabel")

		Label.Name = "Label"
		Label.BackgroundTransparency = 1
		Label.AnchorPoint = Vector2.new(0.5, 0)
		Label.Position = UDim2.new(0.5, 0, 1, 2)
		Label.Size = UDim2.fromOffset(180, 14)
		Label.TextSize = 12
		Label.TextColor3 = Color3.fromRGB(255, 220, 160)
		Label.TextStrokeTransparency = 0.3
		Label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		Label.Font = Enum.Font.SourceSansSemibold
		Label.Text = string.upper(v4.Name)
		Label.ZIndex = 401
		Label.Parent = Frame
		table.insert(t, {
			ring = Frame,
			entry = v4,
			label = Label
		})
	end

	return LocationOverlay, t
end

local function buildTaskOverlay(p1) --[[ buildTaskOverlay | Line: 223 | Upvalues: TaskTargetResolver (copy) ]]
	local TaskTargetOverlay = Instance.new("Frame")

	TaskTargetOverlay.Name = "TaskTargetOverlay"
	TaskTargetOverlay.Size = UDim2.fromScale(1, 1)
	TaskTargetOverlay.BackgroundTransparency = 1
	TaskTargetOverlay.BorderSizePixel = 0
	TaskTargetOverlay.ClipsDescendants = true
	TaskTargetOverlay.ZIndex = 700
	TaskTargetOverlay.Parent = p1

	local t = {}

	for i = 1, 32 do
		local ImageLabel = Instance.new("ImageLabel")

		ImageLabel.Name = "TaskMarker" .. i
		ImageLabel.Size = UDim2.fromOffset(18, 18)
		ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.Image = "rbxassetid://128212304073017"
		ImageLabel.ImageColor3 = TaskTargetResolver.COLOR_KILL
		ImageLabel.ScaleType = Enum.ScaleType.Fit
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Visible = false
		ImageLabel.ZIndex = 700
		ImageLabel.Parent = TaskTargetOverlay
		t[i] = ImageLabel
	end

	return TaskTargetOverlay, t
end

local function buildSquadOverlay(p1) --[[ buildSquadOverlay | Line: 255 ]]
	local SquadOverlay = Instance.new("Frame")

	SquadOverlay.Name = "SquadOverlay"
	SquadOverlay.Size = UDim2.fromScale(1, 1)
	SquadOverlay.BackgroundTransparency = 1
	SquadOverlay.BorderSizePixel = 0
	SquadOverlay.ClipsDescendants = true
	SquadOverlay.ZIndex = 800
	SquadOverlay.Parent = p1

	local t = {}

	for i = 1, 8 do
		local ImageLabel = Instance.new("ImageLabel")

		ImageLabel.Name = "SquadMarker" .. i
		ImageLabel.Size = UDim2.fromOffset(18, 18)
		ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.Image = "rbxassetid://99845298560940"
		ImageLabel.ScaleType = Enum.ScaleType.Fit
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Visible = false
		ImageLabel.ZIndex = 800
		ImageLabel.Parent = SquadOverlay
		t[i] = ImageLabel
	end

	return SquadOverlay, t
end

function t.Build(p1) --[[ Build | Line: 287 | Upvalues: PlaceConfig (copy), LocalPlayer (copy), PdaMapData (copy), applyPlumsSettings (copy), CollectionService (copy), PdaMapBlipFactory (copy), plumsRoot (copy), computeMDN (copy), computeBounds (copy), buildLocationOverlay (copy), buildTaskOverlay (copy), buildSquadOverlay (copy), UserInputService (copy), buildControls (copy), RunService (copy), ReplicatedStorage (copy), TaskTargetResolver (copy), t2 (copy), SquadMapResolver (copy) ]]
	if not (p1 and p1:IsA("GuiObject")) then
		return
	end

	if p1:FindFirstChild("MapHost") then
		return
	end

	if not PlaceConfig.HasMapData then
		local MapHost = Instance.new("Frame")

		MapHost.Name = "MapHost"
		MapHost.Size = UDim2.fromScale(1, 1)
		MapHost.BackgroundColor3 = Color3.fromRGB(18, 20, 18)
		MapHost.BorderSizePixel = 0
		MapHost.Parent = p1

		local NoDataLabel = Instance.new("TextLabel")

		NoDataLabel.Name = "NoDataLabel"
		NoDataLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		NoDataLabel.Position = UDim2.fromScale(0.5, 0.48)
		NoDataLabel.Size = UDim2.fromOffset(360, 80)
		NoDataLabel.BackgroundTransparency = 1
		NoDataLabel.Text = "NO DATA"
		NoDataLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
		NoDataLabel.Font = Enum.Font.Code
		NoDataLabel.TextSize = 64
		NoDataLabel.TextXAlignment = Enum.TextXAlignment.Center
		NoDataLabel.TextYAlignment = Enum.TextYAlignment.Center
		NoDataLabel.Parent = MapHost

		local SubLabel = Instance.new("TextLabel")

		SubLabel.Name = "SubLabel"
		SubLabel.AnchorPoint = Vector2.new(0.5, 0)
		SubLabel.Position = UDim2.fromScale(0.5, 0.58)
		SubLabel.Size = UDim2.fromOffset(500, 22)
		SubLabel.BackgroundTransparency = 1
		SubLabel.Text = "MAP UNAVAILABLE IN STAGING AREA"
		SubLabel.TextColor3 = Color3.fromRGB(110, 110, 110)
		SubLabel.Font = Enum.Font.Gotham
		SubLabel.TextSize = 14
		SubLabel.TextXAlignment = Enum.TextXAlignment.Center
		SubLabel.Parent = MapHost

		return
	end

	local v1 = LocalPlayer:GetAttribute("Zone") or "Cordon"
	local v2 = PdaMapData.GetRegion(v1)

	applyPlumsSettings(v2)

	local MapHost = Instance.new("Frame")

	MapHost.Name = "MapHost"
	MapHost.Size = UDim2.fromScale(1, 1)
	MapHost.BackgroundColor3 = Color3.fromRGB(18, 20, 18)
	MapHost.BackgroundTransparency = 0
	MapHost.BorderSizePixel = 0
	MapHost.Active = true
	MapHost.Parent = p1
	CollectionService:AddTag(MapHost, "Minimap")
	PdaMapBlipFactory.Attach(MapHost)

	local v3 = plumsRoot()
	local v4 = if v3 then v3:WaitForChild("Maps", 5):WaitForChild(v2.PlumsMap, 5) else v3
	local v5 = v4 and computeMDN(v4) or 1
	local v6 = v4 and computeBounds(v4) or nil
	local _, v7 = buildLocationOverlay(MapHost, v2)
	local _2, v8 = buildTaskOverlay(MapHost)
	local _3, v9 = buildSquadOverlay(MapHost)
	local v10 = nil

	local function getCurrentFocus() --[[ getCurrentFocus | Line: 366 | Upvalues: v10 (ref), LocalPlayer (ref) ]]
		if v10 then
			return v10
		end

		local Character = LocalPlayer.Character
		local v1 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

		return if v1 then v1.Position or Vector3.new(0, 0, 0) else Vector3.new(0, 0, 0)
	end

	local function getZoom() --[[ getZoom | Line: 372 | Upvalues: MapHost (copy), v2 (copy) ]]
		return MapHost:GetAttribute("Zoom") or v2.DefaultZoom
	end

	local function clampFocus(p1) --[[ clampFocus | Line: 378 | Upvalues: v6 (copy), MapHost (copy), v2 (copy), v5 (copy) ]]
		if not v6 then
			return p1
		end

		local AbsoluteSize = MapHost.AbsoluteSize

		if AbsoluteSize.Y < 1 then
			return p1
		end

		local v22 = (MapHost:GetAttribute("Zoom") or v2.DefaultZoom) * 0.7002075382097097 * v5
		local v3 = v22 * (AbsoluteSize.X / AbsoluteSize.Y)

		return Vector3.new(if v6.maxX - v3 >= v6.minX + v3 then math.clamp(p1.X, v6.minX + v3, v6.maxX - v3) else (v6.minX + v6.maxX) / 2, p1.Y, if v6.maxZ - v22 >= v6.minZ + v22 then math.clamp(p1.Z, v6.minZ + v22, v6.maxZ - v22) else (v6.minZ + v6.maxZ) / 2)
	end

	local function setFocus(p1) --[[ setFocus | Line: 400 | Upvalues: clampFocus (copy), v10 (ref), MapHost (copy) ]]
		if p1 then
			local v1 = clampFocus(p1)

			v10 = v1
			MapHost:SetAttribute("FocusPoint", v1)
		else
			v10 = nil
			MapHost:SetAttribute("FocusPoint", nil)
		end
	end

	local function setZoom(p1) --[[ setZoom | Line: 410 | Upvalues: MapHost (copy), v10 (ref), clampFocus (copy) ]]
		MapHost:SetAttribute("Zoom", (math.clamp(p1, 100, 500)))

		if not v10 then
			return
		end

		local v1 = v10

		if v1 then
			local v2 = clampFocus(v1)

			v10 = v2
			MapHost:SetAttribute("FocusPoint", v2)

			return
		end

		v10 = nil
		MapHost:SetAttribute("FocusPoint", nil)
	end

	MapHost:SetAttribute("Zoom", (math.clamp(v2.DefaultZoom, 100, 500)))

	if v10 then
		local v11 = v10

		if v11 then
			local v12 = clampFocus(v11)

			v10 = v12
			MapHost:SetAttribute("FocusPoint", v12)
		else
			v10 = nil
			MapHost:SetAttribute("FocusPoint", nil)
		end
	end

	local v13 = if v3 then v3:WaitForChild("Internal", 5) and v3.Internal:WaitForChild("CameraUtils", 5) else v3
	local v14 = v13 and require(v13)
	local v15 = false
	local zero = Vector2.zero
	local v16 = false

	MapHost.InputBegan:Connect(function(p1) --[[ Line: 434 | Upvalues: v15 (ref), v16 (ref) ]]
		if p1.UserInputType ~= Enum.UserInputType.MouseButton1 then
			return
		end

		v15 = true
		v16 = true
	end)
	MapHost.InputEnded:Connect(function(p1) --[[ Line: 440 | Upvalues: v15 (ref) ]]
		if p1.UserInputType ~= Enum.UserInputType.MouseButton1 then
			return
		end

		v15 = false
	end)
	UserInputService.InputChanged:Connect(function(p1, p2) --[[ Line: 445 | Upvalues: MapHost (copy), v15 (ref), v16 (ref), zero (ref), v14 (copy), v5 (copy), v10 (ref), LocalPlayer (ref), clampFocus (copy) ]]
		if not (MapHost.Parent and v15) then
			return
		end

		if p1.UserInputType ~= Enum.UserInputType.MouseMovement then
			return
		end

		local v1 = Vector2.new(p1.Position.X, p1.Position.Y)

		if v16 then
			v16 = false
		else
			local v2 = MapHost:FindFirstChildWhichIsA("ViewportFrame", true)
			local v3 = if v2 then v2:FindFirstChildOfClass("Camera") else v2
			local AbsoluteSize = MapHost.AbsoluteSize

			if v3 and (v14 and (AbsoluteSize.X > 0 and AbsoluteSize.Y > 0)) then
				local AbsolutePosition = MapHost.AbsolutePosition
				local v52 = v3.CFrame
				local v6 = v14.ViewportPointToPlanePoint(v52, 70, zero - AbsolutePosition, AbsoluteSize, 0)
				local v7 = v14.ViewportPointToPlanePoint(v52, 70, v1 - AbsolutePosition, AbsoluteSize, 0)
				local v102 = Vector3.new(v6.X * v5, 0, v6.Z * v5)
				local v13 = v102 - Vector3.new(v7.X * v5, 0, v7.Z * v5)
				local v142

				if v10 then
					v142 = v10
				else
					local Character = LocalPlayer.Character
					local v152 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

					v142 = v152 and v152.Position or Vector3.new(0, 0, 0)
				end

				local v162 = v142 + v13

				if v162 then
					local v17 = clampFocus(v162)

					v10 = v17
					MapHost:SetAttribute("FocusPoint", v17)
				else
					v10 = nil
					MapHost:SetAttribute("FocusPoint", nil)
				end
			end
		end

		zero = v1
	end)
	MapHost.MouseWheelForward:Connect(function() --[[ Line: 474 | Upvalues: MapHost (copy), v2 (copy), v10 (ref), clampFocus (copy) ]]
		MapHost:SetAttribute("Zoom", (math.clamp((MapHost:GetAttribute("Zoom") or v2.DefaultZoom) - 75, 100, 500)))

		if not v10 then
			return
		end

		local v22 = v10

		if v22 then
			local v3 = clampFocus(v22)

			v10 = v3
			MapHost:SetAttribute("FocusPoint", v3)

			return
		end

		v10 = nil
		MapHost:SetAttribute("FocusPoint", nil)
	end)
	MapHost.MouseWheelBackward:Connect(function() --[[ Line: 475 | Upvalues: MapHost (copy), v2 (copy), v10 (ref), clampFocus (copy) ]]
		MapHost:SetAttribute("Zoom", (math.clamp((MapHost:GetAttribute("Zoom") or v2.DefaultZoom) + 75, 100, 500)))

		if not v10 then
			return
		end

		local v22 = v10

		if v22 then
			local v3 = clampFocus(v22)

			v10 = v3
			MapHost:SetAttribute("FocusPoint", v3)

			return
		end

		v10 = nil
		MapHost:SetAttribute("FocusPoint", nil)
	end)
	buildControls(MapHost, {
		zoomIn = function() --[[ zoomIn | Line: 479 | Upvalues: MapHost (copy), v2 (copy), v10 (ref), clampFocus (copy) ]]
			MapHost:SetAttribute("Zoom", (math.clamp((MapHost:GetAttribute("Zoom") or v2.DefaultZoom) - 150, 100, 500)))

			if not v10 then
				return
			end

			local v22 = v10

			if v22 then
				local v3 = clampFocus(v22)

				v10 = v3
				MapHost:SetAttribute("FocusPoint", v3)

				return
			end

			v10 = nil
			MapHost:SetAttribute("FocusPoint", nil)
		end,
		zoomOut = function() --[[ zoomOut | Line: 480 | Upvalues: MapHost (copy), v2 (copy), v10 (ref), clampFocus (copy) ]]
			MapHost:SetAttribute("Zoom", (math.clamp((MapHost:GetAttribute("Zoom") or v2.DefaultZoom) + 150, 100, 500)))

			if not v10 then
				return
			end

			local v22 = v10

			if v22 then
				local v3 = clampFocus(v22)

				v10 = v3
				MapHost:SetAttribute("FocusPoint", v3)

				return
			end

			v10 = nil
			MapHost:SetAttribute("FocusPoint", nil)
		end,
		recenter = function() --[[ recenter | Line: 481 | Upvalues: v10 (ref), MapHost (copy) ]]
			v10 = nil
			MapHost:SetAttribute("FocusPoint", nil)
		end
	})

	local v17 = nil

	v17 = RunService.RenderStepped:Connect(function() --[[ Line: 489 | Upvalues: MapHost (copy), v17 (ref), v14 (copy), v2 (copy), v5 (copy), v7 (copy), ReplicatedStorage (ref), TaskTargetResolver (ref), PdaMapBlipFactory (ref), v8 (copy), t2 (ref), SquadMapResolver (ref), v9 (copy) ]]
		if MapHost.Parent then
			local v1 = MapHost:FindFirstChildWhichIsA("ViewportFrame", true)
			local v22 = if v1 then v1:FindFirstChildOfClass("Camera") else v1

			if not (v1 and (v22 and v14)) then
				return
			end

			local AbsoluteSize = MapHost.AbsoluteSize

			if AbsoluteSize.X < 1 or AbsoluteSize.Y < 1 then
				return
			end

			local v3 = v22.CFrame
			local v52 = 2 * (MapHost:GetAttribute("Zoom") or v2.DefaultZoom) * 0.7002075382097097 * v5

			for i, v in ipairs(v7) do
				local WorldPos = v.entry.WorldPos
				local v92 = v14.PointToViewport(v3, 70, Vector3.new(WorldPos.X / v5, 0, WorldPos.Z / v5), AbsoluteSize)
				local v10 = v92.X / AbsoluteSize.X
				local v11 = v92.Y / AbsoluteSize.Y

				v.ring.Position = UDim2.fromScale(v10, v11)

				local v13 = math.max(math.max(v.entry.Size.X, v.entry.Size.Z) / v52 * AbsoluteSize.Y, 28)

				v.ring.Size = UDim2.fromOffset(v13, v13)
				v.ring.Visible = if v10 > -1 and (v10 < 2 and v11 > -1) then v11 < 2 else false
			end

			local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"))
			local v15 = TaskTargetResolver.GetTrackedTask()
			local list = {}

			if v15 then
				for i, v in ipairs(TaskTargetResolver.Resolve(v15)) do
					v.transparency = 0
					list[#list + 1] = v
				end
			end

			local v16 = TaskController:GetActiveTasks() or {}

			for i, v in ipairs(v16) do
				if v ~= v15 then
					for i2, v6 in ipairs(TaskTargetResolver.Resolve(v)) do
						v6.transparency = 0.65
						list[#list + 1] = v6
					end
				end
			end

			local t = {}
			local t3 = {}

			for i, v in ipairs(list) do
				if v.kind == "turnin" and v.npcId then
					t[v.npcId] = true
				end
			end

			for i, v in ipairs(v16) do
				if v.type == "exploration" and v.state == "active" then
					local v172 = false
					local v18 = ipairs

					for v20, v21 in v18(v.objectives or {}) do
						if v21.id == "visit" and v21.complete then
							v172 = true

							break
						end
					end

					if not v172 and (v.params and v.params.location_name) then
						local v222 = ipairs

						for v24, v25 in v222(v2.Locations or {}) do
							if v25.Name == v.params.location_name then
								t3[v.id] = {
									pos = v25.WorldPos,
									locationName = v25.Name
								}

								break
							end
						end
					end
				end
			end

			PdaMapBlipFactory.SetExplorationTargets(t3)

			local t4 = {}

			for i, v in ipairs(v16) do
				if v.type == "deposit" and v.state == "active" then
					local v26 = false
					local v27 = ipairs

					for v29, v30 in v27(v.objectives or {}) do
						if v30.id == "deposit" and v30.complete then
							v26 = true

							break
						end
					end

					local v31 = v.params and v.params.target_stash_pos

					if not v26 and v31 then
						local t5 = {}

						t5.pos = Vector3.new(v31.X or 0, v31.Y or 0, v31.Z or 0)
						t4[v.id] = t5
					end
				end
			end

			PdaMapBlipFactory.SetDepositTargets(t4)

			for i = 1, 32 do
				local v35 = list[i]
				local v36 = v8[i]

				if v35 and (v35.kind ~= "turnin" and (v35.kind ~= "explore" and v35.kind ~= "deposit")) then
					local v40 = v14.PointToViewport(v3, 70, Vector3.new(v35.pos.X / v5, 0, v35.pos.Z / v5), AbsoluteSize)
					local v41 = v40.X / AbsoluteSize.X
					local v42 = v40.Y / AbsoluteSize.Y

					if v41 >= 0 and (v41 <= 1 and (v42 >= 0 and v42 <= 1)) then
						v36.Position = UDim2.fromScale(v41, v42)

						local v43 = t2[v35.subject] or "rbxassetid://128212304073017"

						if v36.Image ~= v43 then
							v36.Image = v43
						end

						if v36.ImageColor3 ~= v35.color then
							v36.ImageColor3 = v35.color
						end

						if v36.ImageTransparency ~= v35.transparency then
							v36.ImageTransparency = v35.transparency
						end

						if not v36.Visible then
							v36.Visible = true
						end

						continue
					end

					if v36.Visible then
						v36.Visible = false
					end

					continue
				end

				if v36.Visible then
					v36.Visible = false
				end
			end

			local v44 = Color3.new(255/255, 255/255, 255/255)
			local v45 = next(t) ~= nil
			local v47 = TaskTargetResolver.COLOR_TURN_IN:Lerp(v44, (math.sin(os.clock() * math.pi * 4) + 1) * 0.5 * 0.5)

			for i, v in ipairs(MapHost:GetDescendants()) do
				if v:IsA("ImageLabel") then
					local v48 = v:GetAttribute("AnchorName")

					if v48 then
						local v49 = v48:find("_")
						local v50 = v48:find("_") and v48:sub(v49 + 1) or nil

						if v45 and (v50 and t[v50]) then
							v.ImageColor3 = v47

							continue
						end

						if v.ImageColor3 ~= v44 then
							v.ImageColor3 = v44
						end
					end
				end
			end

			local v51 = SquadMapResolver.Resolve()

			for j = 1, 8 do
				local v522 = v51[j]
				local v53 = v9[j]

				if v522 then
					local v57 = v14.PointToViewport(v3, 70, Vector3.new(v522.pos.X / v5, 0, v522.pos.Z / v5), AbsoluteSize)
					local v58 = v57.X / AbsoluteSize.X
					local v59 = v57.Y / AbsoluteSize.Y

					if v58 >= 0 and (v58 <= 1 and (v59 >= 0 and v59 <= 1)) then
						v53.Position = UDim2.fromScale(v58, v59)

						if not v53.Visible then
							v53.Visible = true
						end

						continue
					end

					if v53.Visible then
						v53.Visible = false
					end

					continue
				end

				if v53.Visible then
					v53.Visible = false
				end
			end
		else
			if not v17 then
				return
			end

			v17:Disconnect()
		end
	end)

	local v18 = nil

	v18 = LocalPlayer:GetAttributeChangedSignal("Zone"):Connect(function() --[[ Line: 663 | Upvalues: MapHost (copy), v18 (ref), applyPlumsSettings (ref), PdaMapData (ref), LocalPlayer (ref) ]]
		if MapHost and MapHost.Parent then
			applyPlumsSettings(PdaMapData.GetRegion(LocalPlayer:GetAttribute("Zone") or "Cordon"))

			return
		end

		if not v18 then
			return
		end

		v18:Disconnect()
	end)
end

return t