-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GridPack = require(ReplicatedStorage:WaitForChild("GridPack"):WaitForChild("GridPack"))

require(ReplicatedStorage:WaitForChild("LootConfig"))

local t = {}
local t2 = {}

local function pickSpawnPosition(p1, p2, p3) --[[ pickSpawnPosition | Line: 32 | Upvalues: t2 (ref) ]]
	local CurrentCamera = workspace.CurrentCamera
	local v1 = workspace.CurrentCamera and CurrentCamera.ViewportSize or Vector2.new(1280, 720)
	local count = 0

	for k in pairs(t2) do
		count = count + 1
	end

	local v2 = count * 28
	local MainFrame = p1:FindFirstChild("MainFrame")
	local v3, v4

	if MainFrame and MainFrame.AbsoluteSize.X > 0 then
		local AbsolutePosition = MainFrame.AbsolutePosition
		local AbsoluteSize = MainFrame.AbsoluteSize

		v3 = if p2 + 32 <= v1.X - (AbsolutePosition.X + AbsoluteSize.X) then AbsolutePosition.X + AbsoluteSize.X + 16 elseif p2 + 32 <= AbsolutePosition.X then AbsolutePosition.X - p2 - 16 else v1.X - p2 - 16
		v4 = AbsolutePosition.Y + 16
	else
		v3 = v1.X - p2 - 16
		v4 = 16
	end

	return UDim2.fromOffset(math.clamp(v3 + v2, 16, (math.max(16, v1.X - p2 - 16))), (math.clamp(v4 + v2, 16, (math.max(16, v1.Y - p3 - 16)))))
end

function t.Open(p1) --[[ Open | Line: 64 | Upvalues: Players (copy), t2 (ref), pickSpawnPosition (copy), GridPack (copy), ReplicatedStorage (copy), UserInputService (copy) ]]
	local tiedInstance = p1.tiedInstance

	if not tiedInstance then
		return nil
	end

	local InventoryGui = Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("InventoryGui")

	if not InventoryGui then
		return nil
	end

	if t2[tiedInstance] then
		t2[tiedInstance]:Close()
	end

	local v1 = p1.gridSize.X * 50 + 8
	local v2 = p1.gridSize.Y * 50 + 32 + 8
	local Frame = Instance.new("Frame")

	Frame.Name = "ContainerWindow_" .. tostring(tiedInstance)
	Frame.Size = UDim2.fromOffset(v1, v2)
	Frame.Position = pickSpawnPosition(InventoryGui, v1, v2)
	Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	Frame.BorderSizePixel = 0
	Frame.ZIndex = 40
	Frame.Active = true
	Frame.Parent = InventoryGui

	local TitleBar = Instance.new("TextButton")

	TitleBar.Name = "TitleBar"
	TitleBar.Size = UDim2.new(1, -24, 0, 24)
	TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	TitleBar.BorderSizePixel = 0
	TitleBar.Text = "  " .. (p1.title or "Container")
	TitleBar.TextColor3 = Color3.fromRGB(220, 220, 220)
	TitleBar.TextXAlignment = Enum.TextXAlignment.Left
	TitleBar.TextTruncate = Enum.TextTruncate.AtEnd
	TitleBar.Font = Enum.Font.GothamBold
	TitleBar.TextSize = 14
	TitleBar.AutoButtonColor = false
	TitleBar.ZIndex = 41
	TitleBar.Parent = Frame

	local CloseButton = Instance.new("TextButton")

	CloseButton.Name = "CloseButton"
	CloseButton.Size = UDim2.fromOffset(24, 24)
	CloseButton.AnchorPoint = Vector2.new(1, 0)
	CloseButton.Position = UDim2.new(1, 0, 0, 0)
	CloseButton.BackgroundColor3 = Color3.fromRGB(60, 25, 25)
	CloseButton.BorderSizePixel = 0
	CloseButton.Text = "X"
	CloseButton.TextColor3 = Color3.fromRGB(255, 200, 200)
	CloseButton.Font = Enum.Font.GothamBold
	CloseButton.TextSize = 14
	CloseButton.ZIndex = 42
	CloseButton.Parent = Frame

	local GridFrame = Instance.new("Frame")

	GridFrame.Name = "GridFrame"
	GridFrame.Size = UDim2.fromOffset(50, 50)
	GridFrame.Position = UDim2.new(0, 4, 0, 28)
	GridFrame.BackgroundTransparency = 1
	GridFrame.ZIndex = 41
	GridFrame.Parent = Frame

	local v3 = GridPack.createGrid({
		Visible = true,
		SlotAspectRatio = 1,
		Parent = GridFrame,
		Assets = {
			Slot = ReplicatedStorage.GridPack.Slot
		},
		GridSize = p1.gridSize,
		Size = UDim2.fromScale(p1.gridSize.X, p1.gridSize.Y),
		AnchorPoint = Vector2.new(0, 0),
		Position = UDim2.new(0, 0, 0, 0),
		Metadata = {
			TiedInstance = tiedInstance
		}
	})

	if p1.moveMiddleware then
		v3.MoveMiddleware = p1.moveMiddleware
	end

	local v4 = false
	local v5 = nil
	local v6 = nil

	TitleBar.MouseButton1Down:Connect(function() --[[ Line: 161 | Upvalues: v4 (ref), v5 (ref), UserInputService (ref), v6 (ref), Frame (copy) ]]
		v4 = true
		v5 = UserInputService:GetMouseLocation()
		v6 = Frame.Position
	end)

	local v7 = UserInputService.InputChanged:Connect(function(p1) --[[ Line: 172 | Upvalues: v4 (ref), UserInputService (ref), v5 (ref), v6 (ref), v1 (copy), Frame (copy) ]]
		if not v4 then
			return
		end

		if p1.UserInputType ~= Enum.UserInputType.MouseMovement and p1.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		local v12 = UserInputService:GetMouseLocation() - v5
		local CurrentCamera = workspace.CurrentCamera
		local v2 = CurrentCamera and CurrentCamera.ViewportSize or Vector2.new(1280, 720)

		Frame.Position = UDim2.new(v6.X.Scale, math.clamp(v6.X.Offset + v12.X, -v1 + 48, v2.X - 48), v6.Y.Scale, (math.clamp(v6.Y.Offset + v12.Y, 0, v2.Y - 28)))
	end)
	local v8 = UserInputService.InputEnded:Connect(function(p1) --[[ Line: 186 | Upvalues: v4 (ref) ]]
		if p1.UserInputType ~= Enum.UserInputType.MouseButton1 then
			return
		end

		v4 = false
	end)
	local t = {
		Close = function(p12) --[[ Close | Line: 193 | Upvalues: v7 (ref), v8 (ref), Frame (copy), t2 (ref), tiedInstance (copy), p1 (copy) ]]
			if v7 then
				v7:Disconnect()
				v7 = nil
			end

			if v8 then
				v8:Disconnect()
				v8 = nil
			end

			if Frame.Parent then
				Frame:Destroy()
			end

			t2[tiedInstance] = nil

			if not p1.onClose then
				return
			end

			p1.onClose()
		end
	}

	CloseButton.MouseButton1Click:Connect(function() --[[ Line: 200 | Upvalues: t (copy) ]]
		t:Close()
	end)
	t.Grid = v3
	t.TiedInstance = tiedInstance
	t.ParentTied = p1.parentTied
	t2[tiedInstance] = t

	return t, v3
end
function t.CloseAll() --[[ CloseAll | Line: 223 | Upvalues: t2 (ref) ]]
	local list = {}

	for k, v in pairs(t2) do
		list[#list + 1] = v
	end

	for i, v in ipairs(list) do
		v:Close()
	end

	t2 = {}
end
function t.CloseForParent(p1) --[[ CloseForParent | Line: 245 | Upvalues: t2 (ref) ]]
	if p1 == nil then
		return
	end

	local list = {}

	for k, v in pairs(t2) do
		if v.ParentTied ~= nil and v.ParentTied == p1 then
			list[#list + 1] = v
		end
	end

	for i, v in ipairs(list) do
		v:Close()
	end
end
function t.Close(p1) --[[ Close | Line: 257 | Upvalues: t2 (ref) ]]
	local v1 = t2[p1]

	if not v1 then
		return
	end

	v1:Close()
end
function t.GetOpen() --[[ GetOpen | Line: 263 | Upvalues: t2 (ref) ]]
	return t2
end

return t