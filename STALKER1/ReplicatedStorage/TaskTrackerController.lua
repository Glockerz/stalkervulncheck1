-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local v1 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
local v2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
local v3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular)
local v4 = Color3.fromRGB(255, 200, 90)
local v5 = Color3.fromRGB(220, 220, 220)
local v6 = Color3.fromRGB(150, 150, 150)
local v7 = Color3.fromRGB(140, 200, 120)
local v8 = Color3.fromRGB(225, 95, 95)
local v9 = Color3.fromRGB(20, 22, 20)
local t = {
	_panel = nil,
	_timeLbl = nil,
	_current = nil
}

local function formatTime(p1) --[[ formatTime | Line: 25 ]]
	if p1 <= 0 then
		return "00:00:00"
	end

	return string.format("%02d:%02d:%02d", math.floor(p1 / 3600), math.floor(p1 % 3600 / 60), p1 % 60)
end

function t._build(p1) --[[ _build | Line: 33 | Upvalues: LocalPlayer (copy), v9 (copy) ]]
	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
	local TaskTrackerGui = PlayerGui:FindFirstChild("TaskTrackerGui")
	local TaskTrackerGui2, Panel, v1, v2, v3, v4

	if TaskTrackerGui then
		TaskTrackerGui:Destroy()
	end

	TaskTrackerGui2 = Instance.new("ScreenGui")
	TaskTrackerGui2.Name = "TaskTrackerGui"
	TaskTrackerGui2.ResetOnSpawn = false
	TaskTrackerGui2.IgnoreGuiInset = false
	TaskTrackerGui2.DisplayOrder = 6
	TaskTrackerGui2.Parent = PlayerGui
	Panel = Instance.new("Frame")
	Panel.Name = "Panel"
	Panel.AnchorPoint = Vector2.new(1, 0)
	Panel.Position = UDim2.new(1, -16, 0, 16)
	Panel.Size = UDim2.fromOffset(260, 40)
	Panel.AutomaticSize = Enum.AutomaticSize.Y
	Panel.BackgroundColor3 = v9
	Panel.BackgroundTransparency = 0.2
	Panel.BorderSizePixel = 0
	Panel.Visible = false
	Panel.Parent = TaskTrackerGui2
	v1 = Instance.new("UICorner")
	v1.CornerRadius = UDim.new(0, 4)
	v1.Parent = Panel
	v2 = Instance.new("UIStroke")
	v2.Color = Color3.fromRGB(70, 75, 70)
	v2.Thickness = 1
	v2.Parent = Panel
	v3 = Instance.new("UIPadding")
	v3.PaddingTop = UDim.new(0, 8)
	v3.PaddingBottom = UDim.new(0, 8)
	v3.PaddingLeft = UDim.new(0, 10)
	v3.PaddingRight = UDim.new(0, 10)
	v3.Parent = Panel
	v4 = Instance.new("UIListLayout")
	v4.FillDirection = Enum.FillDirection.Vertical
	v4.SortOrder = Enum.SortOrder.LayoutOrder
	v4.Padding = UDim.new(0, 3)
	v4.Parent = Panel
	p1._panel = Panel
end
function t._clear(p1) --[[ _clear | Line: 72 ]]
	for i, v in ipairs(p1._panel:GetChildren()) do
		if v:IsA("TextLabel") then
			v:Destroy()
		end
	end

	p1._timeLbl = nil
end
function t._updateTime(p1, p2) --[[ _updateTime | Line: 79 | Upvalues: v8 (copy), v6 (copy) ]]
	if not p1._timeLbl then
		return
	end

	local v1 = if p2 then p2.timing and p2.timing.deadline_at else p2

	if not v1 then
		p1._timeLbl.Text = ""

		return
	end

	local v2 = v1 - os.time()

	p1._timeLbl.Text = "\226\167\150 " .. (if v2 <= 0 then "00:00:00" else string.format("%02d:%02d:%02d", math.floor(v2 / 3600), math.floor(v2 % 3600 / 60), v2 % 60))
	p1._timeLbl.TextColor3 = v2 < 300 and v8 or v6
end
function t._render(p1, p2) --[[ _render | Line: 88 | Upvalues: v2 (copy), v6 (copy), v1 (copy), v4 (copy), v7 (copy), v5 (copy), v3 (copy) ]]
	if not p1._panel then
		return
	end

	if not p2 then
		p1._panel.Visible = false
		p1._current = nil

		return
	end

	p1._current = p2
	p1._panel.Visible = true
	p1:_clear()

	local count = 0

	local function nextOrder() --[[ nextOrder | Line: 96 | Upvalues: count (ref) ]]
		count = count + 1

		return count
	end

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, 0, 0, 12)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v2
	TextLabel.TextSize = 10
	TextLabel.TextColor3 = v6
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Text = "TRACKING"
	count = count + 1
	TextLabel.LayoutOrder = count
	TextLabel.Parent = p1._panel

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Size = UDim2.new(1, 0, 0, 18)
	TextLabel2.AutomaticSize = Enum.AutomaticSize.Y
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v1
	TextLabel2.TextSize = 15
	TextLabel2.TextColor3 = v4
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.TextWrapped = true
	TextLabel2.Text = p2.title or "Task"
	count = count + 1
	TextLabel2.LayoutOrder = count
	TextLabel2.Parent = p1._panel

	local v12 = ipairs

	for v32, v42 in v12(p2.objectives or {}) do
		local TextLabel3 = Instance.new("TextLabel")

		TextLabel3.Size = UDim2.new(1, 0, 0, 14)
		TextLabel3.AutomaticSize = Enum.AutomaticSize.Y
		TextLabel3.BackgroundTransparency = 1
		TextLabel3.FontFace = v2
		TextLabel3.TextSize = 13
		TextLabel3.TextColor3 = v42.complete and v7 or v5
		TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel3.TextWrapped = true

		local v62 = if v42.complete then "\226\156\147" else "\226\128\162"
		local v72 = v42.text or ""

		if v42.target and v42.progress ~= nil then
			v72 = v72 .. string.format(" [%d/%d]", v42.progress, v42.target)
		end

		TextLabel3.Text = v62 .. " " .. v72
		count = count + 1
		TextLabel3.LayoutOrder = count
		TextLabel3.Parent = p1._panel
	end

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Size = UDim2.new(1, 0, 0, 14)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v3
	TextLabel3.TextSize = 12
	TextLabel3.TextColor3 = v6
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
	count = count + 1
	TextLabel3.LayoutOrder = count
	TextLabel3.Parent = p1._panel
	p1._timeLbl = TextLabel3
	p1:_updateTime(p2)
end
function t.Init(p1) --[[ Init | Line: 155 | Upvalues: ReplicatedStorage (copy) ]]
	p1:_build()

	local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"))

	local function refresh() --[[ refresh | Line: 158 | Upvalues: p1 (copy), TaskController (copy) ]]
		p1:_render(TaskController:GetPinnedTask())
	end

	TaskController:OnPinnedChanged(refresh)
	TaskController:OnChanged(refresh)

	if TaskController.OnMainChanged then
		TaskController:OnMainChanged(refresh)
	end

	task.spawn(function() --[[ Line: 168 | Upvalues: p1 (copy) ]]
		while true do
			repeat
				task.wait(1)
			until p1._current and (p1._timeLbl and p1._timeLbl.Parent)

			p1:_updateTime(p1._current)
		end
	end)
	print("[TaskTrackerController] initialized")
end

return t