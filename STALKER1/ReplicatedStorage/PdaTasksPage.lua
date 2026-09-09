-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ok, result = pcall(function() --[[ Line: 4 | Upvalues: ReplicatedStorage (copy) ]]
	return require(ReplicatedStorage:WaitForChild("PdaSound", 5))
end)

local function sfx(p1) --[[ sfx | Line: 7 | Upvalues: ok (copy), result (copy) ]]
	if not (ok and result) then
		return
	end

	result.Play(p1)
end

local function click() --[[ click | Line: 10 | Upvalues: ok (copy), result (copy) ]]
	if not (ok and result) then
		return
	end

	result.PlayClick(5)
end

local v1 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold)
local v2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold)
local v3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular)
local v4 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic)
local v5 = Color3.fromRGB(255, 200, 90)
local v6 = Color3.fromRGB(220, 220, 220)
local v7 = Color3.fromRGB(170, 170, 170)
local v8 = Color3.fromRGB(120, 120, 120)
local v9 = Color3.fromRGB(50, 56, 48)
local v10 = Color3.fromRGB(120, 140, 80)
local v11 = Color3.fromRGB(60, 60, 60)
local v12 = Color3.fromRGB(225, 95, 95)
local v13 = Color3.fromRGB(190, 190, 190)
local t = {}

local function formatTime(p1) --[[ formatTime | Line: 31 ]]
	if p1 <= 0 then
		return "00:00:00"
	end

	return string.format("%02d:%02d:%02d", math.floor(p1 / 3600), math.floor(p1 % 3600 / 60), p1 % 60)
end

local function turnInReward() --[[ turnInReward | Line: 47 | Upvalues: ReplicatedStorage (copy) ]]
	local ok, result = pcall(function() --[[ Line: 48 | Upvalues: ReplicatedStorage (ref) ]]
		return require(ReplicatedStorage:WaitForChild("TaskController", 5))
	end)

	if ok and (result and result.GetDailyTurnIn) then
		local v1, _, v2 = result:GetDailyTurnIn()

		return v1, v2 or 1
	end

	return nil, 1
end

local function buildSidebar(p1, p2, p3) --[[ buildSidebar | Line: 59 | Upvalues: v9 (copy), v10 (copy), v2 (copy), v6 (copy), v7 (copy) ]]
	local Sidebar = Instance.new("Frame")

	Sidebar.Name = "Sidebar"
	Sidebar.Size = UDim2.new(0.2, 0, 1, 0)
	Sidebar.BackgroundTransparency = 1
	Sidebar.Parent = p1

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 6)
	UIListLayout.Parent = Sidebar

	for i, v in ipairs({
		{
			key = "operational",
			name = "OPERATIONAL\nTASKS"
		},
		{
			key = "main",
			name = "MAIN\nTASKS"
		},
		{
			key = "side",
			name = "SIDE\nTASKS"
		}
	}) do
		local v1 = if v.key == p2 then true else false
		local TextButton = Instance.new("TextButton")

		TextButton.Name = "Cat_" .. v.key
		TextButton.Size = UDim2.new(1, 0, 0, 64)
		TextButton.BackgroundColor3 = v9
		TextButton.BackgroundTransparency = if v1 then 0.25 else 1
		TextButton.BorderSizePixel = 0
		TextButton.AutoButtonColor = false
		TextButton.Text = ""
		TextButton.LayoutOrder = i
		TextButton.Parent = Sidebar

		if v1 then
			local UIStroke = Instance.new("UIStroke")

			UIStroke.Color = v10
			UIStroke.Thickness = 1
			UIStroke.Transparency = 0.3
			UIStroke.Parent = TextButton
		end

		local TextLabel = Instance.new("TextLabel")

		TextLabel.Size = UDim2.new(1, -20, 1, 0)
		TextLabel.Position = UDim2.fromOffset(16, 0)
		TextLabel.BackgroundTransparency = 1
		TextLabel.FontFace = v2
		TextLabel.TextSize = 15
		TextLabel.TextColor3 = v1 and v6 or v7
		TextLabel.Text = v.name
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel.TextYAlignment = Enum.TextYAlignment.Center
		TextLabel.LineHeight = 1.05
		TextLabel.Parent = TextButton
		TextButton.MouseButton1Click:Connect(function() --[[ Line: 107 | Upvalues: p3 (copy), v (copy) ]]
			if not p3 then
				return
			end

			p3(v.key)
		end)
	end
end

local function buildDailyCard(p1, p2, p3, p4, p5) --[[ buildDailyCard | Line: 116 | Upvalues: v9 (copy), v5 (copy), v10 (copy), v1 (copy), v7 (copy), v2 (copy), v6 (copy), v11 (copy), v4 (copy), v8 (copy), ReplicatedStorage (copy) ]]
	local TextButton = Instance.new("TextButton")

	TextButton.Name = "DailyCard_" .. tostring(p2.index or 0)
	TextButton.Size = UDim2.new(1, -4, 0, 108)
	TextButton.BackgroundColor3 = v9
	TextButton.BackgroundTransparency = if p4 then 0.05 else 0.15
	TextButton.BorderSizePixel = 0
	TextButton.LayoutOrder = p3
	TextButton.AutoButtonColor = false
	TextButton.Text = ""
	TextButton.Parent = p1

	if p5 then
		TextButton.MouseButton1Click:Connect(function() --[[ Line: 129 | Upvalues: p5 (copy), p2 (copy) ]]
			p5(p2)
		end)
	end

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = p4 and v5 or v10
	UIStroke.Thickness = if p4 then 1.5 else 1
	UIStroke.Transparency = if p4 then 0.2 else 0.4
	UIStroke.Parent = TextButton

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(0, 60, 0, 18)
	TextLabel.Position = UDim2.fromOffset(10, 8)
	TextLabel.BackgroundColor3 = v5
	TextLabel.BackgroundTransparency = 0.2
	TextLabel.FontFace = v1
	TextLabel.TextSize = 12
	TextLabel.TextColor3 = Color3.new(0/255, 0/255, 0/255)
	TextLabel.Text = "DAILY"
	TextLabel.Parent = TextButton

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.AnchorPoint = Vector2.new(1, 0)
	TextLabel2.Position = UDim2.new(1, -10, 0, 8)
	TextLabel2.Size = UDim2.new(0, 100, 0, 18)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v1
	TextLabel2.TextSize = 12
	TextLabel2.TextColor3 = v7
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Right
	TextLabel2.Parent = TextButton

	local function tickCardTimer() --[[ tickCardTimer | Line: 160 | Upvalues: TextLabel2 (copy) ]]
		local v1 = os.time()
		local v4 = (math.floor(v1 / 86400) + 1) * 86400 - v1

		TextLabel2.Text = "\226\167\150 " .. (if v4 <= 0 then "00:00:00" else string.format("%02d:%02d:%02d", math.floor(v4 / 3600), math.floor(v4 % 3600 / 60), v4 % 60))
	end

	local v62 = os.time()
	local v82 = (math.floor(v62 / 86400) + 1) * 86400 - v62

	TextLabel2.Text = "\226\167\150 " .. (if v82 <= 0 then "00:00:00" else string.format("%02d:%02d:%02d", math.floor(v82 / 3600), math.floor(v82 % 3600 / 60), v82 % 60))
	task.spawn(function() --[[ Line: 166 | Upvalues: TextLabel2 (copy) ]]
		while TextLabel2.Parent do
			local v1

			task.wait(1)

			if not TextLabel2.Parent then
				continue
			end

			local v2 = os.time()
			local v5 = (math.floor(v2 / 86400) + 1) * 86400 - v2

			v1 = if v5 <= 0 then "00:00:00" else string.format("%02d:%02d:%02d", math.floor(v5 / 3600), math.floor(v5 % 3600 / 60), v5 % 60)
			TextLabel2.Text = "\226\167\150 " .. v1
		end
	end)

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Size = UDim2.new(1, -20, 0, 22)
	TextLabel3.Position = UDim2.fromOffset(10, 30)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v2
	TextLabel3.TextSize = 16
	TextLabel3.TextColor3 = v6
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel3.Text = p2.objective or "Daily objective"
	TextLabel3.Parent = TextButton

	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, -20, 0, 6)
	Frame.Position = UDim2.new(0, 10, 0, 56)
	Frame.BackgroundColor3 = v11
	Frame.BorderSizePixel = 0
	Frame.Parent = TextButton

	local v13 = if p2.params and (p2.params.target and p2.params.target > 0) then math.clamp((p2.progress or 0) / p2.params.target, 0, 1) else 0
	local Frame2 = Instance.new("Frame")

	Frame2.Size = UDim2.new(v13, 0, 1, 0)
	Frame2.BackgroundColor3 = v5
	Frame2.BorderSizePixel = 0
	Frame2.Parent = Frame

	local TextLabel4 = Instance.new("TextLabel")

	TextLabel4.Size = UDim2.new(1, -20, 0, 20)
	TextLabel4.Position = UDim2.new(0, 10, 0, 68)
	TextLabel4.BackgroundTransparency = 1
	TextLabel4.FontFace = v4
	TextLabel4.TextSize = 12
	TextLabel4.TextColor3 = v7
	TextLabel4.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel4.TextTruncate = Enum.TextTruncate.AtEnd
	TextLabel4.Text = p2.briefing or ""
	TextLabel4.Parent = TextButton

	local v16, v17

	if p2.turned_in then
		v16 = v8
		v17 = "TURNED IN \226\128\148 come back tomorrow"
	elseif p2.completed then
		v16 = v5
		v17 = "READY \226\128\148 RETURN TO ECOLOGIST"
	else
		local ok, result = pcall(function() --[[ Line: 48 | Upvalues: ReplicatedStorage (ref) ]]
			return require(ReplicatedStorage:WaitForChild("TaskController", 5))
		end)
		local v18, v19

		if ok and (result and result.GetDailyTurnIn) then
			local v20, _, v21 = result:GetDailyTurnIn()

			v18 = v20
			v19 = v21 or 1
		else
			v18 = nil
			v19 = 1
		end

		v16 = v7
		v17 = v18 and string.format("IN PROGRESS   \226\128\162   +%s\226\130\189   \226\128\162   +%d Ecologist Rep", v18, v19) or string.format("IN PROGRESS   \226\128\162   +%d Ecologist Rep", v19)
	end

	local TextLabel5 = Instance.new("TextLabel")

	TextLabel5.Size = UDim2.new(1, -20, 0, 16)
	TextLabel5.Position = UDim2.new(0, 10, 0, 88)
	TextLabel5.BackgroundTransparency = 1
	TextLabel5.FontFace = v2
	TextLabel5.TextSize = 12
	TextLabel5.TextColor3 = v16
	TextLabel5.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel5.Text = v17
	TextLabel5.Parent = TextButton
end

local function buildTaskEntry(p1, p2, p3, p4, p5) --[[ buildTaskEntry | Line: 242 | Upvalues: v9 (copy), v10 (copy), v1 (copy), v5 (copy), v13 (copy), v2 (copy), v6 (copy), v3 (copy), v7 (copy), v12 (copy) ]]
	local TextButton = Instance.new("TextButton")

	TextButton.Name = "Task_" .. p2.id
	TextButton.Size = UDim2.new(1, -4, 0, 52)
	TextButton.BackgroundColor3 = v9
	TextButton.BackgroundTransparency = if p4 then 0.25 else 1
	TextButton.BorderSizePixel = 0
	TextButton.AutoButtonColor = false
	TextButton.Text = ""
	TextButton.LayoutOrder = p3
	TextButton.Parent = p1

	if p4 then
		local UIStroke = Instance.new("UIStroke")

		UIStroke.Color = v10
		UIStroke.Thickness = 1
		UIStroke.Transparency = 0.3
		UIStroke.Parent = TextButton

		local TextLabel = Instance.new("TextLabel")

		TextLabel.AnchorPoint = Vector2.new(0, 0.5)
		TextLabel.Position = UDim2.new(0, -12, 0.5, 0)
		TextLabel.Size = UDim2.fromOffset(14, 14)
		TextLabel.BackgroundTransparency = 1
		TextLabel.FontFace = v1
		TextLabel.TextColor3 = v5
		TextLabel.Text = "\226\150\182"
		TextLabel.TextSize = 16
		TextLabel.Parent = TextButton
	end

	local Frame = Instance.new("Frame")

	Frame.AnchorPoint = Vector2.new(0, 0.5)
	Frame.Position = UDim2.new(0, 12, 0.5, 0)
	Frame.Size = UDim2.fromOffset(7, 7)
	Frame.BackgroundColor3 = p4 and v5 or v13
	Frame.BorderSizePixel = 0
	Frame.Parent = TextButton

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = Frame

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Position = UDim2.fromOffset(28, 7)
	TextLabel.Size = UDim2.new(1, -130, 0, 22)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v2
	TextLabel.TextSize = 18
	TextLabel.TextColor3 = v6
	TextLabel.Text = p2.title or "Task"
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = TextButton

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Position = UDim2.fromOffset(28, 28)
	TextLabel2.Size = UDim2.new(1, -130, 0, 18)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v3
	TextLabel2.TextSize = 14
	TextLabel2.TextColor3 = v7
	TextLabel2.Text = p2.objective_location and p2.objective_location.zone or "?"
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Parent = TextButton

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.AnchorPoint = Vector2.new(1, 0)
	TextLabel3.Position = UDim2.new(1, -12, 0, 28)
	TextLabel3.Size = UDim2.fromOffset(100, 18)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v2
	TextLabel3.TextSize = 14
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Right
	TextLabel3.Parent = TextButton

	local function v() --[[ tick | Line: 314 | Upvalues: TextButton (copy), p2 (copy), TextLabel3 (copy), v12 (ref), p4 (copy), v5 (ref), v7 (ref) ]]
		if not TextButton.Parent then
			return
		end

		local v1 = if p2.timing then p2.timing.deadline_at or 0 else 0
		local v2 = v1 - os.time()

		TextLabel3.Text = "\226\167\150 " .. (if v2 <= 0 then "00:00:00" else string.format("%02d:%02d:%02d", math.floor(v2 / 3600), math.floor(v2 % 3600 / 60), v2 % 60))
		TextLabel3.TextColor3 = v2 < 300 and v12 or (p4 and v5 or v7)
	end

	if TextButton.Parent then
		local v52 = (p2.timing and p2.timing.deadline_at or 0) - os.time()

		TextLabel3.Text = "\226\167\150 " .. (if v52 <= 0 then "00:00:00" else string.format("%02d:%02d:%02d", math.floor(v52 / 3600), math.floor(v52 % 3600 / 60), v52 % 60))
		TextLabel3.TextColor3 = v52 < 300 and v12 or (p4 and v5 or v7)
	end

	task.spawn(function() --[[ Line: 321 | Upvalues: TextButton (copy), p2 (copy), TextLabel3 (copy), v12 (ref), p4 (copy), v5 (ref), v7 (ref) ]]
		while TextButton.Parent do
			local v1

			task.wait(1)

			if not TextButton.Parent then
				continue
			end

			local v2 = if p2.timing then p2.timing.deadline_at or 0 else 0
			local v3 = v2 - os.time()

			v1 = if v3 <= 0 then "00:00:00" else string.format("%02d:%02d:%02d", math.floor(v3 / 3600), math.floor(v3 % 3600 / 60), v3 % 60)
			TextLabel3.Text = "\226\167\150 " .. v1
			TextLabel3.TextColor3 = v3 < 300 and v12 or (p4 and v5 or v7)
		end
	end)

	if not p5 then
		return
	end

	TextButton.MouseButton1Click:Connect(function() --[[ Line: 326 | Upvalues: p5 (copy), p2 (copy) ]]
		p5(p2)
	end)
end

local function buildShareEntry(p1, p2, p3, p4, p5) --[[ buildShareEntry | Line: 331 | Upvalues: v9 (copy), v2 (copy), v6 (copy), v3 (copy), v1 (copy) ]]
	local v12 = p2.task or {}
	local v22 = Color3.fromRGB(140, 200, 120)
	local TextButton = Instance.new("TextButton")

	TextButton.Name = "Share_" .. tostring(v12.id)
	TextButton.Size = UDim2.new(1, -4, 0, 52)
	TextButton.BackgroundColor3 = v9
	TextButton.BackgroundTransparency = if p4 then 0.25 else 1
	TextButton.BorderSizePixel = 0
	TextButton.AutoButtonColor = false
	TextButton.Text = ""
	TextButton.LayoutOrder = p3
	TextButton.Parent = p1

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v22
	UIStroke.Thickness = 1
	UIStroke.Transparency = if p4 then 0.1 else 0.55
	UIStroke.Parent = TextButton

	local Frame = Instance.new("Frame")

	Frame.AnchorPoint = Vector2.new(0, 0.5)
	Frame.Position = UDim2.new(0, 12, 0.5, 0)
	Frame.Size = UDim2.fromOffset(7, 7)
	Frame.BackgroundColor3 = v22
	Frame.BorderSizePixel = 0
	Frame.Parent = TextButton

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = Frame

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Position = UDim2.fromOffset(28, 7)
	TextLabel.Size = UDim2.new(1, -130, 0, 22)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v2
	TextLabel.TextSize = 18
	TextLabel.TextColor3 = v6
	TextLabel.Text = v12.title or "Shared Task"
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = TextButton

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Position = UDim2.fromOffset(28, 28)
	TextLabel2.Size = UDim2.new(1, -130, 0, 18)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v3
	TextLabel2.TextSize = 14
	TextLabel2.TextColor3 = v22
	TextLabel2.Text = "\226\135\132 from " .. (p2.fromName or "a squadmate")
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.Parent = TextButton

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.AnchorPoint = Vector2.new(1, 0)
	TextLabel3.Position = UDim2.new(1, -12, 0, 7)
	TextLabel3.Size = UDim2.fromOffset(100, 18)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v1
	TextLabel3.TextSize = 12
	TextLabel3.TextColor3 = v22
	TextLabel3.Text = "NEW"
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Right
	TextLabel3.Parent = TextButton

	if not p5 then
		return
	end

	TextButton.MouseButton1Click:Connect(function() --[[ Line: 397 | Upvalues: p5 (copy), v12 (copy) ]]
		p5(v12)
	end)
end

local function buildMainCard(p1, p2, p3, p4, p5) --[[ buildMainCard | Line: 406 | Upvalues: v9 (copy), v5 (copy), v10 (copy), v1 (copy), v7 (copy), v2 (copy), v6 (copy), v3 (copy) ]]
	local v12 = if p2.stageCount == nil then false else true
	local TextButton = Instance.new("TextButton")

	TextButton.Name = "MainCard_" .. tostring(p2.id)
	TextButton.Size = UDim2.new(1, -4, 0, if v12 then 96 else 76)
	TextButton.BackgroundColor3 = v9
	TextButton.BackgroundTransparency = if p4 then 0.05 else 0.15
	TextButton.BorderSizePixel = 0
	TextButton.LayoutOrder = p3
	TextButton.AutoButtonColor = false
	TextButton.Text = ""
	TextButton.Parent = p1

	if p5 then
		TextButton.MouseButton1Click:Connect(function() --[[ Line: 421 | Upvalues: p5 (copy), p2 (copy) ]]
			p5(p2)
		end)
	end

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = p4 and v5 or v10
	UIStroke.Thickness = if p4 then 1.5 else 1
	UIStroke.Transparency = if p4 then 0.2 else 0.4
	UIStroke.Parent = TextButton

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(0, 54, 0, 18)
	TextLabel.Position = UDim2.fromOffset(10, 8)
	TextLabel.BackgroundColor3 = v5
	TextLabel.BackgroundTransparency = 0.2
	TextLabel.FontFace = v1
	TextLabel.TextSize = 12
	TextLabel.TextColor3 = Color3.new(0/255, 0/255, 0/255)
	TextLabel.Text = "STORY"
	TextLabel.Parent = TextButton

	if v12 then
		local TextLabel2 = Instance.new("TextLabel")

		TextLabel2.AnchorPoint = Vector2.new(1, 0)
		TextLabel2.Position = UDim2.new(1, -10, 0, 8)
		TextLabel2.Size = UDim2.new(0, 90, 0, 18)
		TextLabel2.BackgroundTransparency = 1
		TextLabel2.FontFace = v1
		TextLabel2.TextSize = 12
		TextLabel2.TextColor3 = v7
		TextLabel2.TextXAlignment = Enum.TextXAlignment.Right
		TextLabel2.Text = string.format("STEP %d / %d", p2.stageIndex or 1, p2.stageCount or 1)
		TextLabel2.Parent = TextButton
	end

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Size = UDim2.new(1, -20, 0, 22)
	TextLabel2.Position = UDim2.fromOffset(10, 30)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v2
	TextLabel2.TextSize = 16
	TextLabel2.TextColor3 = v6
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd
	TextLabel2.Text = p2.title or "Story task"
	TextLabel2.Parent = TextButton

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Size = UDim2.new(1, -20, 0, 34)
	TextLabel3.Position = UDim2.fromOffset(10, 54)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v3
	TextLabel3.TextSize = 14
	TextLabel3.TextColor3 = v12 and v5 or v7
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel3.TextYAlignment = Enum.TextYAlignment.Top
	TextLabel3.TextWrapped = true
	TextLabel3.Text = if v12 then p2.stageText or "" else "Available \226\128\148 speak to Crow"
	TextLabel3.Parent = TextButton
end

local function buildMainDetail(p1, p2) --[[ buildMainDetail | Line: 484 | Upvalues: v1 (copy), v6 (copy), v3 (copy), v7 (copy), v11 (copy), v8 (copy), v2 (copy), v5 (copy), ReplicatedStorage (copy), v9 (copy), ok (copy), result (copy) ]]
	local Detail = Instance.new("Frame")

	Detail.Name = "Detail"
	Detail.Position = UDim2.new(0.52, 8, 0, 0)
	Detail.Size = UDim2.new(0.48, -8, 1, 0)
	Detail.BackgroundTransparency = 1
	Detail.Parent = p1

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 8)
	UIListLayout.Parent = Detail

	local count = 0

	local function add(p1) --[[ add | Line: 498 | Upvalues: count (ref), Detail (copy) ]]
		count = count + 1
		p1.LayoutOrder = count
		p1.Parent = Detail

		return p1
	end

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, 0, 0, 28)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v1
	TextLabel.TextSize = 20
	TextLabel.TextColor3 = v6
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Text = p2.title or "Story task"
	count = count + 1
	TextLabel.LayoutOrder = count
	TextLabel.Parent = Detail

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Size = UDim2.new(1, 0, 0, 0)
	TextLabel2.AutomaticSize = Enum.AutomaticSize.Y
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v3
	TextLabel2.TextSize = 14
	TextLabel2.TextColor3 = v7
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
	TextLabel2.TextWrapped = true
	TextLabel2.Text = p2.summary or ""
	count = count + 1
	TextLabel2.LayoutOrder = count
	TextLabel2.Parent = Detail

	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, 0, 0, 1)
	Frame.BackgroundColor3 = v11
	Frame.BorderSizePixel = 0
	count = count + 1
	Frame.LayoutOrder = count
	Frame.Parent = Detail

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Size = UDim2.new(1, 0, 0, 18)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v1
	TextLabel3.TextSize = 12
	TextLabel3.TextColor3 = v8
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel3.Text = if p2.stageCount then "CURRENT OBJECTIVE" else "STATUS"
	count = count + 1
	TextLabel3.LayoutOrder = count
	TextLabel3.Parent = Detail

	local TextLabel4 = Instance.new("TextLabel")

	TextLabel4.Size = UDim2.new(1, 0, 0, 0)
	TextLabel4.AutomaticSize = Enum.AutomaticSize.Y
	TextLabel4.BackgroundTransparency = 1
	TextLabel4.FontFace = v2
	TextLabel4.TextSize = 15
	TextLabel4.TextColor3 = v5
	TextLabel4.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel4.TextYAlignment = Enum.TextYAlignment.Top
	TextLabel4.TextWrapped = true
	TextLabel4.Text = p2.stageCount and string.format("%s  (step %d of %d)", p2.stageText or "", p2.stageIndex or 1, p2.stageCount or 1) or "Crow is ready to brief you. Go and speak to him."
	count = count + 1
	TextLabel4.LayoutOrder = count
	TextLabel4.Parent = Detail

	if p2.reward and p2.reward.money then
		local TextLabel5 = Instance.new("TextLabel")

		TextLabel5.Size = UDim2.new(1, 0, 0, 20)
		TextLabel5.BackgroundTransparency = 1
		TextLabel5.FontFace = v2
		TextLabel5.TextSize = 14
		TextLabel5.TextColor3 = Color3.fromRGB(150, 200, 150)
		TextLabel5.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel5.Text = string.format("Reward: %d\226\130\189", p2.reward.money)
		count = count + 1
		TextLabel5.LayoutOrder = count
		TextLabel5.Parent = Detail
	end

	if not p2.stageCount then
		return
	end

	local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"))
	local v32 = "main:" .. tostring(p2.id)
	local v4 = if TaskController:GetPinnedId() == v32 then true else false
	local MainTrackBtn = Instance.new("TextButton")

	MainTrackBtn.Name = "MainTrackBtn"
	MainTrackBtn.Size = UDim2.new(0, 140, 0, 30)
	MainTrackBtn.BackgroundColor3 = v4 and v5 or v9
	MainTrackBtn.BackgroundTransparency = if v4 then 0.15 else 0.35
	MainTrackBtn.BorderSizePixel = 0
	MainTrackBtn.AutoButtonColor = false
	MainTrackBtn.FontFace = v1
	MainTrackBtn.TextSize = 13
	MainTrackBtn.TextColor3 = v4 and Color3.new(0/255, 0/255, 0/255) or v6
	MainTrackBtn.Text = if v4 then "\226\156\147 TRACKING" else "TRACK"
	count = count + 1
	MainTrackBtn.LayoutOrder = count
	MainTrackBtn.Parent = Detail
	MainTrackBtn.MouseButton1Click:Connect(function() --[[ Line: 593 | Upvalues: ok (ref), result (ref), TaskController (copy), v32 (copy) ]]
		if not (ok and result) then
			TaskController:SetPinned(v32)

			return
		end

		result.PlayClick(5)
		TaskController:SetPinned(v32)
	end)
end

local function buildSectionHeader(p1, p2, p3) --[[ buildSectionHeader | Line: 601 | Upvalues: v2 (copy), v8 (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(1, 0, 0, 24)
	Frame.BackgroundTransparency = 1
	Frame.LayoutOrder = p3
	Frame.Parent = p1

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Position = UDim2.fromOffset(8, 0)
	TextLabel.Size = UDim2.new(1, -16, 1, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v2
	TextLabel.TextSize = 12
	TextLabel.TextColor3 = v8
	TextLabel.Text = p2
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom
	TextLabel.Parent = Frame
end

local function buildTaskList(p1, p2, p3, p4, p5, p6) --[[ buildTaskList | Line: 620 | Upvalues: buildSectionHeader (copy), buildShareEntry (copy), ReplicatedStorage (copy), buildDailyCard (copy), buildMainCard (copy), buildTaskEntry (copy), v3 (copy), v8 (copy) ]]
	local TaskList = Instance.new("ScrollingFrame")

	TaskList.Name = "TaskList"
	TaskList.Position = UDim2.new(0.2, 8, 0, 0)
	TaskList.Size = UDim2.new(0.3, 0, 1, 0)
	TaskList.BackgroundTransparency = 1
	TaskList.BorderSizePixel = 0
	TaskList.ScrollBarThickness = 4
	TaskList.CanvasSize = UDim2.new(0, 0, 0, 0)
	TaskList.AutomaticCanvasSize = Enum.AutomaticSize.Y
	TaskList.ScrollingDirection = Enum.ScrollingDirection.Y
	TaskList.Parent = p1

	local UIListLayout = Instance.new("UIListLayout")

	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 4)
	UIListLayout.Parent = TaskList

	local count = 0

	if p4 == "side" and (p3 and #p3 > 0) then
		count = count + 1
		buildSectionHeader(TaskList, "INCOMING SHARES", count)

		for i, v in ipairs(p3) do
			count = count + 1
			buildShareEntry(TaskList, v, count, if v.task == nil then false elseif v.task.id == p5 then true else false, p6)
		end
	end

	local count2 = count + 1

	buildSectionHeader(TaskList, ({
		operational = "OPERATIONAL TASKS",
		main = "MAIN TASKS",
		side = "SIDE TASKS"
	})[p4] or "TASKS", count2)

	if p4 == "operational" then
		local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"))

		for i, v in ipairs(if TaskController.GetDailyTasks then TaskController:GetDailyTasks() or {} else {}) do
			count2 = count2 + 1
			buildDailyCard(TaskList, v, count2, p5 == "daily:" .. tostring(v.index or 0), function(p1) --[[ Line: 662 | Upvalues: p6 (copy) ]]
				if not p6 then
					return
				end

				local t = {}

				t.id = "daily:" .. tostring(p1.index or 0)
				t._daily = p1
				p6(t)
			end)
		end
	end

	local v6 = nil

	if p4 == "main" then
		local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"))
		local v7 = if TaskController.GetMain then TaskController:GetMain() or nil else nil
		local count3 = 0

		if v7 then
			if v7.active then
				count2 = count2 + 1
				count3 = count3 + 1
				buildMainCard(TaskList, v7.active, count2, p5 == "main:" .. v7.active.id, function(p1) --[[ Line: 679 | Upvalues: p6 (copy) ]]
					if not p6 then
						return
					end

					p6({
						id = "main:" .. p1.id,
						_main = p1
					})
				end)
			end

			local v10 = ipairs

			for v12, v13 in v10(v7.available or {}) do
				count2 = count2 + 1
				count3 = count3 + 1
				buildMainCard(TaskList, v13, count2, if p5 == "main:" .. v13.id then true else false, function(p1) --[[ Line: 685 | Upvalues: p6 (copy) ]]
					if not p6 then
						return
					end

					p6({
						id = "main:" .. p1.id,
						_main = p1
					})
				end)
			end
		end

		if count3 == 0 then
			v6 = if v7 and v7.nextRequirement then string.format("Crow doesn\'t trust you with the real work yet.\n\nSide tasks completed for him: %d / %d", v7.sideDone or 0, v7.nextRequirement) elseif v7 then "You\'ve done everything Crow has. For now." else "No main story tasks yet."
		end
	end

	local list = {}

	for i, v in ipairs(p2) do
		if (v.category or "side") == p4 then
			table.insert(list, v)
		end
	end

	if #list > 0 then
		for i, v in ipairs(list) do
			count2 = count2 + 1
			buildTaskEntry(TaskList, v, count2, if v.id == p5 then true else false, p6)
		end
	else
		if p4 == "main" and v6 == nil then
			return
		end

		local v19 = if v6 then v6 else ({
	operational = "No operational tasks. Daily tasks appear here.",
	main = "No main story tasks yet.",
	side = "No active tasks. Talk to a quest-giver for work."
})[p4] or "No tasks in this category."
		local TextLabel = Instance.new("TextLabel")

		TextLabel.Size = UDim2.new(1, 0, 0, 60)
		TextLabel.BackgroundTransparency = 1
		TextLabel.FontFace = v3
		TextLabel.TextSize = 14
		TextLabel.TextColor3 = v8
		TextLabel.TextWrapped = true
		TextLabel.LayoutOrder = count2 + 1
		TextLabel.Text = v19
		TextLabel.Parent = TaskList
	end
end

local function buildDailyDetail(p1, p2) --[[ buildDailyDetail | Line: 741 | Upvalues: v1 (copy), v5 (copy), v8 (copy), v7 (copy), v3 (copy), v6 (copy), v11 (copy), v2 (copy), ReplicatedStorage (copy), v4 (copy) ]]
	local DailyDetail = Instance.new("Frame")

	DailyDetail.Name = "DailyDetail"
	DailyDetail.Position = UDim2.new(0.5, 8, 0, 0)
	DailyDetail.Size = UDim2.new(0.5, -8, 1, 0)
	DailyDetail.BackgroundTransparency = 1
	DailyDetail.Parent = p1

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Position = UDim2.fromOffset(4, 6)
	TextLabel.Size = UDim2.new(1, -8, 0, 30)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v1
	TextLabel.TextSize = 22
	TextLabel.TextColor3 = v5
	TextLabel.Text = p2.objective or "Daily task"
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
	TextLabel.Parent = DailyDetail

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Position = UDim2.fromOffset(4, 38)
	TextLabel2.Size = UDim2.new(0, 80, 0, 20)
	TextLabel2.BackgroundColor3 = v5
	TextLabel2.BackgroundTransparency = 0.2
	TextLabel2.FontFace = v1
	TextLabel2.TextSize = 12
	TextLabel2.TextColor3 = Color3.new(0/255, 0/255, 0/255)
	TextLabel2.Text = "DAILY"
	TextLabel2.Parent = DailyDetail

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Position = UDim2.fromOffset(92, 38)
	TextLabel3.Size = UDim2.new(1, -230, 0, 20)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v1
	TextLabel3.TextSize = 12

	if p2.turned_in then
		TextLabel3.Text = "TURNED IN"
		TextLabel3.TextColor3 = v8
	elseif p2.completed then
		TextLabel3.Text = "READY \226\128\148 RETURN TO ECOLOGIST"
		TextLabel3.TextColor3 = v5
	else
		TextLabel3.Text = "IN PROGRESS"
		TextLabel3.TextColor3 = v7
	end

	TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel3.Parent = DailyDetail

	local TextLabel4 = Instance.new("TextLabel")

	TextLabel4.AnchorPoint = Vector2.new(1, 0)
	TextLabel4.Position = UDim2.new(1, -4, 0, 38)
	TextLabel4.Size = UDim2.new(0, 128, 0, 20)
	TextLabel4.BackgroundTransparency = 1
	TextLabel4.FontFace = v1
	TextLabel4.TextSize = 12
	TextLabel4.TextColor3 = v7
	TextLabel4.TextXAlignment = Enum.TextXAlignment.Right
	TextLabel4.Parent = DailyDetail

	local function tickDetailTimer() --[[ tickDetailTimer | Line: 802 | Upvalues: TextLabel4 (copy) ]]
		local v1 = os.time()
		local v4 = (math.floor(v1 / 86400) + 1) * 86400 - v1

		TextLabel4.Text = "\226\167\150 " .. (if v4 <= 0 then "00:00:00" else string.format("%02d:%02d:%02d", math.floor(v4 / 3600), math.floor(v4 % 3600 / 60), v4 % 60)) .. " \226\128\148 RESET"
	end

	local v12 = os.time()
	local v32 = (math.floor(v12 / 86400) + 1) * 86400 - v12

	TextLabel4.Text = "\226\167\150 " .. (if v32 <= 0 then "00:00:00" else string.format("%02d:%02d:%02d", math.floor(v32 / 3600), math.floor(v32 % 3600 / 60), v32 % 60)) .. " \226\128\148 RESET"
	task.spawn(function() --[[ Line: 808 | Upvalues: TextLabel4 (copy) ]]
		while TextLabel4.Parent do
			local v1

			task.wait(1)

			if not TextLabel4.Parent then
				continue
			end

			local v2 = os.time()
			local v5 = (math.floor(v2 / 86400) + 1) * 86400 - v2

			v1 = if v5 <= 0 then "00:00:00" else string.format("%02d:%02d:%02d", math.floor(v5 / 3600), math.floor(v5 % 3600 / 60), v5 % 60)
			TextLabel4.Text = "\226\167\150 " .. v1 .. " \226\128\148 RESET"
		end
	end)

	local TextLabel5 = Instance.new("TextLabel")

	TextLabel5.Position = UDim2.fromOffset(4, 70)
	TextLabel5.Size = UDim2.new(1, -8, 0, 16)
	TextLabel5.BackgroundTransparency = 1
	TextLabel5.FontFace = v1
	TextLabel5.TextSize = 12
	TextLabel5.TextColor3 = v8
	TextLabel5.Text = "BRIEFING"
	TextLabel5.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel5.Parent = DailyDetail

	local TextLabel6 = Instance.new("TextLabel")

	TextLabel6.Position = UDim2.fromOffset(4, 88)
	TextLabel6.Size = UDim2.new(1, -8, 0, 60)
	TextLabel6.BackgroundTransparency = 1
	TextLabel6.FontFace = v3
	TextLabel6.TextSize = 14
	TextLabel6.TextColor3 = v6
	TextLabel6.Text = p2.briefing or ""
	TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel6.TextYAlignment = Enum.TextYAlignment.Top
	TextLabel6.TextWrapped = true
	TextLabel6.Parent = DailyDetail

	local TextLabel7 = Instance.new("TextLabel")

	TextLabel7.Position = UDim2.fromOffset(4, 156)
	TextLabel7.Size = UDim2.new(1, -8, 0, 16)
	TextLabel7.BackgroundTransparency = 1
	TextLabel7.FontFace = v1
	TextLabel7.TextSize = 12
	TextLabel7.TextColor3 = v8
	TextLabel7.Text = "PROGRESS"
	TextLabel7.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel7.Parent = DailyDetail

	local Frame = Instance.new("Frame")

	Frame.Position = UDim2.fromOffset(4, 178)
	Frame.Size = UDim2.new(1, -80, 0, 10)
	Frame.BackgroundColor3 = v11
	Frame.BorderSizePixel = 0
	Frame.Parent = DailyDetail

	local v82 = p2.params and p2.params.target or 0
	local v9 = if v82 > 0 then math.clamp((p2.progress or 0) / v82, 0, 1) else 0
	local Frame2 = Instance.new("Frame")

	Frame2.Size = UDim2.new(v9, 0, 1, 0)
	Frame2.BackgroundColor3 = v5
	Frame2.BorderSizePixel = 0
	Frame2.Parent = Frame

	local TextLabel8 = Instance.new("TextLabel")

	TextLabel8.AnchorPoint = Vector2.new(1, 0)
	TextLabel8.Position = UDim2.new(1, -4, 0, 172)
	TextLabel8.Size = UDim2.fromOffset(70, 20)
	TextLabel8.BackgroundTransparency = 1
	TextLabel8.FontFace = v1
	TextLabel8.TextSize = 15
	TextLabel8.TextColor3 = v6
	TextLabel8.Text = string.format("%d / %d", p2.progress or 0, v82)
	TextLabel8.TextXAlignment = Enum.TextXAlignment.Right
	TextLabel8.Parent = DailyDetail

	local TextLabel9 = Instance.new("TextLabel")

	TextLabel9.Position = UDim2.fromOffset(4, 202)
	TextLabel9.Size = UDim2.new(1, -8, 0, 16)
	TextLabel9.BackgroundTransparency = 1
	TextLabel9.FontFace = v1
	TextLabel9.TextSize = 12
	TextLabel9.TextColor3 = v8
	TextLabel9.Text = "REWARD"
	TextLabel9.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel9.Parent = DailyDetail

	local TextLabel10 = Instance.new("TextLabel")

	TextLabel10.Position = UDim2.fromOffset(4, 220)
	TextLabel10.Size = UDim2.new(1, -8, 0, 22)
	TextLabel10.BackgroundTransparency = 1
	TextLabel10.FontFace = v2
	TextLabel10.TextSize = 16
	TextLabel10.TextColor3 = Color3.fromRGB(150, 210, 140)

	local ok, result = pcall(function() --[[ Line: 48 | Upvalues: ReplicatedStorage (ref) ]]
		return require(ReplicatedStorage:WaitForChild("TaskController", 5))
	end)
	local v122, v13

	if ok and (result and result.GetDailyTurnIn) then
		local v14, _, v15 = result:GetDailyTurnIn()

		v122 = v14
		v13 = v15 or 1
	else
		v122 = nil
		v13 = 1
	end

	TextLabel10.Text = v122 and string.format("%s \226\130\189   +%d Ecologist Rep", v122, v13) or string.format("+%d Ecologist Rep", v13)
	TextLabel10.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel10.Parent = DailyDetail

	local Frame3 = Instance.new("Frame")

	Frame3.Position = UDim2.new(0, 4, 0, 258)
	Frame3.Size = UDim2.new(1, -8, 0, 68)
	Frame3.BackgroundColor3 = Color3.fromRGB(40, 42, 45)
	Frame3.BackgroundTransparency = 0.15
	Frame3.BorderSizePixel = 0
	Frame3.Parent = DailyDetail

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = v5
	UIStroke.Thickness = 1
	UIStroke.Transparency = 0.5
	UIStroke.Parent = Frame3

	local TextLabel11 = Instance.new("TextLabel")

	TextLabel11.Position = UDim2.fromOffset(10, 6)
	TextLabel11.Size = UDim2.new(1, -20, 0, 16)
	TextLabel11.BackgroundTransparency = 1
	TextLabel11.FontFace = v1
	TextLabel11.TextSize = 12
	TextLabel11.TextColor3 = v5
	TextLabel11.Text = "TURN IN AT"
	TextLabel11.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel11.Parent = Frame3

	local TextLabel12 = Instance.new("TextLabel")

	TextLabel12.Position = UDim2.fromOffset(10, 24)
	TextLabel12.Size = UDim2.new(1, -20, 0, 20)
	TextLabel12.BackgroundTransparency = 1
	TextLabel12.FontFace = v1
	TextLabel12.TextSize = 18
	TextLabel12.TextColor3 = v6
	TextLabel12.Text = "Ecologist"
	TextLabel12.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel12.Parent = Frame3

	local TextLabel13 = Instance.new("TextLabel")

	TextLabel13.Position = UDim2.fromOffset(10, 46)
	TextLabel13.Size = UDim2.new(1, -20, 0, 16)
	TextLabel13.BackgroundTransparency = 1
	TextLabel13.FontFace = v4
	TextLabel13.TextSize = 12
	TextLabel13.TextColor3 = v7
	TextLabel13.Text = "Lobby \226\128\148 main hub"
	TextLabel13.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel13.Parent = Frame3
end

local function buildDetail(p1, p2, p3) --[[ buildDetail | Line: 958 | Upvalues: v3 (copy), v8 (copy), v1 (copy), v5 (copy), v7 (copy), v2 (copy), v6 (copy), v12 (copy), v11 (copy), ok (copy), result (copy), ReplicatedStorage (copy), v4 (copy), v9 (copy) ]]
	local v13 = p3 or {}
	local onShare = v13.onShare
	local onAbandon = v13.onAbandon
	local onAccept = v13.onAccept
	local onDecline = v13.onDecline
	local pending = v13.pending
	local Detail = Instance.new("Frame")

	Detail.Name = "Detail"
	Detail.Position = UDim2.new(0.51, 16, 0, 0)
	Detail.Size = UDim2.new(0.49, -16, 1, 0)
	Detail.BackgroundTransparency = 1
	Detail.Parent = p1

	if not p2 then
		local TextLabel = Instance.new("TextLabel")

		TextLabel.Size = UDim2.fromScale(1, 1)
		TextLabel.BackgroundTransparency = 1
		TextLabel.FontFace = v3
		TextLabel.TextSize = 16
		TextLabel.TextColor3 = v8
		TextLabel.Text = "Select a task to view details."
		TextLabel.Parent = Detail

		return
	end

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Position = UDim2.fromOffset(0, 0)
	TextLabel.Size = UDim2.new(0.6, 0, 0, 32)
	TextLabel.BackgroundTransparency = 1
	TextLabel.FontFace = v1
	TextLabel.TextSize = 24
	TextLabel.TextColor3 = v5
	TextLabel.Text = p2.title or "Task"
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = Detail

	local TextLabel2 = Instance.new("TextLabel")

	TextLabel2.Position = UDim2.fromOffset(0, 38)
	TextLabel2.Size = UDim2.new(0.6, 0, 0, 60)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.FontFace = v3
	TextLabel2.TextSize = 15
	TextLabel2.TextColor3 = v7
	TextLabel2.TextWrapped = true
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel2.TextYAlignment = Enum.TextYAlignment.Top
	TextLabel2.Text = p2.description or ""
	TextLabel2.Parent = Detail

	if p2.shared_from then
		local TextLabel3 = Instance.new("TextLabel")

		TextLabel3.Position = UDim2.fromOffset(0, 95)
		TextLabel3.Size = UDim2.new(0.6, 0, 0, 14)
		TextLabel3.BackgroundTransparency = 1
		TextLabel3.FontFace = v2
		TextLabel3.TextSize = 13
		TextLabel3.TextColor3 = Color3.fromRGB(140, 200, 120)
		TextLabel3.Text = "\226\135\132 Shared by " .. (p2.shared_from_name or "a squadmate")
		TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel3.Parent = Detail
	end

	local Frame = Instance.new("Frame")

	Frame.AnchorPoint = Vector2.new(1, 0)
	Frame.Position = UDim2.new(1, 0, 0, 0)
	Frame.Size = UDim2.fromOffset(170, 110)
	Frame.BackgroundTransparency = 1
	Frame.Parent = Detail

	local TextLabel3 = Instance.new("TextLabel")

	TextLabel3.Size = UDim2.new(1, 0, 0, 16)
	TextLabel3.BackgroundTransparency = 1
	TextLabel3.FontFace = v2
	TextLabel3.TextSize = 12
	TextLabel3.TextColor3 = v8
	TextLabel3.Text = "TIME LIMIT"
	TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel3.Parent = Frame

	local v22 = if pending then p2.timing and p2.timing.duration or 0 else p2.timing and (p2.timing.deadline_at and p2.timing.accepted_at) and p2.timing.deadline_at - p2.timing.accepted_at or 0
	local TextLabel4 = Instance.new("TextLabel")

	TextLabel4.Position = UDim2.fromOffset(0, 18)
	TextLabel4.Size = UDim2.new(1, 0, 0, 30)
	TextLabel4.BackgroundTransparency = 1
	TextLabel4.FontFace = v1
	TextLabel4.TextSize = 26
	TextLabel4.TextColor3 = v5
	TextLabel4.Text = "\226\167\150 " .. (if v22 <= 0 then "00:00:00" else string.format("%02d:%02d:%02d", math.floor(v22 / 3600), math.floor(v22 % 3600 / 60), v22 % 60))
	TextLabel4.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel4.Parent = Frame

	local TextLabel5 = Instance.new("TextLabel")

	TextLabel5.Position = UDim2.fromOffset(0, 56)
	TextLabel5.Size = UDim2.new(1, 0, 0, 16)
	TextLabel5.BackgroundTransparency = 1
	TextLabel5.FontFace = v2
	TextLabel5.TextSize = 12
	TextLabel5.TextColor3 = v8
	TextLabel5.Text = "REMAINING"
	TextLabel5.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel5.Parent = Frame

	local TextLabel6 = Instance.new("TextLabel")

	TextLabel6.Position = UDim2.fromOffset(0, 74)
	TextLabel6.Size = UDim2.new(1, 0, 0, 26)
	TextLabel6.BackgroundTransparency = 1
	TextLabel6.FontFace = v2
	TextLabel6.TextSize = 20
	TextLabel6.TextColor3 = v6
	TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel6.Parent = Frame

	if pending then
		TextLabel5.Text = "STARTS"
		TextLabel6.Text = "On accept"
		TextLabel6.TextColor3 = v7
	else
		local function tickRem() --[[ tickRem | Line: 1083 | Upvalues: TextLabel6 (copy), p2 (copy), v12 (ref), v6 (ref) ]]
			if not TextLabel6.Parent then
				return
			end

			local v1 = if p2.timing then p2.timing.deadline_at or 0 else 0
			local v2 = v1 - os.time()

			TextLabel6.Text = if v2 <= 0 then "00:00:00" else string.format("%02d:%02d:%02d", math.floor(v2 / 3600), math.floor(v2 % 3600 / 60), v2 % 60)
			TextLabel6.TextColor3 = v2 < 300 and v12 or v6
		end

		if TextLabel6.Parent then
			local v112 = (p2.timing and p2.timing.deadline_at or 0) - os.time()

			TextLabel6.Text = if v112 <= 0 then "00:00:00" else string.format("%02d:%02d:%02d", math.floor(v112 / 3600), math.floor(v112 % 3600 / 60), v112 % 60)
			TextLabel6.TextColor3 = v112 < 300 and v12 or v6
		end

		task.spawn(function() --[[ Line: 1090 | Upvalues: TextLabel6 (copy), p2 (copy), v12 (ref), v6 (ref) ]]
			while TextLabel6.Parent do
				local v1

				task.wait(1)

				if not TextLabel6.Parent then
					continue
				end

				local v2 = if p2.timing then p2.timing.deadline_at or 0 else 0
				local v3 = v2 - os.time()

				v1 = if v3 <= 0 then "00:00:00" else string.format("%02d:%02d:%02d", math.floor(v3 / 3600), math.floor(v3 % 3600 / 60), v3 % 60)
				TextLabel6.Text = v1
				TextLabel6.TextColor3 = v3 < 300 and v12 or v6
			end
		end)
	end

	local function metaCol(p1, p2, p3, p4, p5) --[[ metaCol | Line: 1097 | Upvalues: v2 (ref), v8 (ref), Detail (copy), v6 (ref) ]]
		local TextLabel = Instance.new("TextLabel")

		TextLabel.Position = UDim2.fromOffset(p1, 110)
		TextLabel.Size = UDim2.fromOffset(p2, 18)
		TextLabel.BackgroundTransparency = 1
		TextLabel.FontFace = v2
		TextLabel.TextSize = 12
		TextLabel.TextColor3 = v8
		TextLabel.Text = p3
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel.Parent = Detail

		local TextLabel2 = Instance.new("TextLabel")

		TextLabel2.Position = UDim2.fromOffset(p1, 130)
		TextLabel2.Size = UDim2.fromOffset(p2, 22)
		TextLabel2.BackgroundTransparency = 1
		TextLabel2.FontFace = v2
		TextLabel2.TextSize = 16
		TextLabel2.TextColor3 = if p5 then p5 else v6
		TextLabel2.Text = p4
		TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel2.Parent = Detail
	end

	local v20, v21

	if p2.giver then
		v20 = p2.giver.npcId

		if v20 then
			v21 = metaCol
		else
			v21 = metaCol
			v20 = "?"
		end
	else
		v21 = metaCol
		v20 = "?"
	end

	v21(0, 130, "GIVER", v20)

	local v25, v26

	if p2.objective_location then
		v25 = p2.objective_location.zone

		if v25 then
			v26 = metaCol
		else
			v26 = metaCol
			v25 = "?"
		end
	else
		v26 = metaCol
		v25 = "?"
	end

	v26(130, 180, "LOCATION", v25)

	local TextLabel7 = Instance.new("TextLabel")

	TextLabel7.Position = UDim2.fromOffset(310, 110)
	TextLabel7.Size = UDim2.new(1, -310, 0, 18)
	TextLabel7.BackgroundTransparency = 1
	TextLabel7.FontFace = v2
	TextLabel7.TextSize = 12
	TextLabel7.TextColor3 = v8
	TextLabel7.Text = "REWARD"
	TextLabel7.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel7.Parent = Detail

	local TextLabel8 = Instance.new("TextLabel")

	TextLabel8.Position = UDim2.fromOffset(310, 130)
	TextLabel8.Size = UDim2.new(1, -310, 0, 24)
	TextLabel8.BackgroundTransparency = 1
	TextLabel8.FontFace = v1
	TextLabel8.TextSize = 20
	TextLabel8.TextColor3 = v5
	TextLabel8.Text = (p2.rewards and p2.rewards.money or 0) .. "\226\130\189"
	TextLabel8.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel8.Parent = Detail

	local list = {}

	if p2.rewards and p2.rewards.rep then
		table.insert(list, "+ " .. p2.rewards.rep.amount .. " " .. (p2.rewards.rep.faction or "?") .. " rep")
	end

	if p2.rewards and p2.rewards.items then
		for i, v in ipairs(p2.rewards.items) do
			table.insert(list, "+ " .. (v.count or 1) .. "x " .. (v.name or "item"))
		end
	end

	for i, v in ipairs(list) do
		local TextLabel9 = Instance.new("TextLabel")

		TextLabel9.Position = UDim2.fromOffset(310, 156 + (i - 1) * 18)
		TextLabel9.Size = UDim2.new(1, -310, 0, 18)
		TextLabel9.BackgroundTransparency = 1
		TextLabel9.FontFace = v3
		TextLabel9.TextSize = 14
		TextLabel9.TextColor3 = v7
		TextLabel9.Text = v
		TextLabel9.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel9.Parent = Detail
	end

	local Frame2 = Instance.new("Frame")

	Frame2.Position = UDim2.fromOffset(0, 210)
	Frame2.Size = UDim2.new(1, 0, 0, 1)
	Frame2.BackgroundColor3 = v11
	Frame2.BorderSizePixel = 0
	Frame2.Parent = Detail

	local TextLabel9 = Instance.new("TextLabel")

	TextLabel9.Position = UDim2.fromOffset(0, 222)
	TextLabel9.Size = UDim2.new(1, 0, 0, 22)
	TextLabel9.BackgroundTransparency = 1
	TextLabel9.FontFace = v2
	TextLabel9.TextSize = 14
	TextLabel9.TextColor3 = v8
	TextLabel9.Text = "OBJECTIVES"
	TextLabel9.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel9.Parent = Detail

	for v32, v33 in ipairs(p2.objectives or {}) do
		local Frame3 = Instance.new("Frame")

		Frame3.Position = UDim2.fromOffset(0, 252 + (v32 - 1) * 40)
		Frame3.Size = UDim2.new(1, 0, 0, 34)
		Frame3.BackgroundTransparency = 1
		Frame3.Parent = Detail

		local Frame4 = Instance.new("Frame")

		Frame4.Position = UDim2.fromOffset(0, 4)
		Frame4.Size = UDim2.fromOffset(20, 20)
		Frame4.BackgroundColor3 = v33.complete and v5 or Color3.fromRGB(40, 40, 40)
		Frame4.BorderSizePixel = 0
		Frame4.Parent = Frame3

		local UIStroke = Instance.new("UIStroke")

		UIStroke.Color = v7
		UIStroke.Thickness = 1.5
		UIStroke.Parent = Frame4

		local TextLabel10 = Instance.new("TextLabel")

		TextLabel10.Position = UDim2.fromOffset(32, 0)
		TextLabel10.Size = UDim2.new(1, -40, 0, 24)
		TextLabel10.BackgroundTransparency = 1
		TextLabel10.FontFace = v2
		TextLabel10.TextSize = 17
		TextLabel10.TextColor3 = v33.complete and v8 or v6

		local v36 = v33.text or ""

		if v33.target and v33.progress then
			v36 = v36 .. string.format("  [%d/%d]", v33.progress, v33.target)
		end

		TextLabel10.Text = v36
		TextLabel10.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel10.Parent = Frame3
	end

	if pending then
		local TextButton = Instance.new("TextButton")

		TextButton.AnchorPoint = Vector2.new(0, 1)
		TextButton.Position = UDim2.new(0, 0, 1, -8)
		TextButton.Size = UDim2.fromOffset(150, 34)
		TextButton.BackgroundColor3 = Color3.fromRGB(140, 200, 120)
		TextButton.BorderSizePixel = 0
		TextButton.FontFace = v1
		TextButton.TextSize = 15
		TextButton.TextColor3 = Color3.fromRGB(20, 22, 20)
		TextButton.Text = "ACCEPT TASK"
		TextButton.Parent = Detail
		TextButton.MouseButton1Click:Connect(function() --[[ Line: 1235 | Upvalues: ok (ref), result (ref), onAccept (copy), p2 (copy) ]]
			if ok and result then
				result.PlayClick(5)
			end

			if not onAccept then
				return
			end

			onAccept(p2)
		end)

		local TextButton2 = Instance.new("TextButton")

		TextButton2.AnchorPoint = Vector2.new(1, 1)
		TextButton2.Position = UDim2.new(1, 0, 1, -8)
		TextButton2.Size = UDim2.fromOffset(120, 34)
		TextButton2.BackgroundColor3 = Color3.fromRGB(60, 45, 45)
		TextButton2.BackgroundTransparency = 0.1
		TextButton2.BorderSizePixel = 0
		TextButton2.FontFace = v2
		TextButton2.TextSize = 14
		TextButton2.TextColor3 = v6
		TextButton2.Text = "DECLINE"
		TextButton2.Parent = Detail
		TextButton2.MouseButton1Click:Connect(function() --[[ Line: 1252 | Upvalues: ok (ref), result (ref), onDecline (copy), p2 (copy) ]]
			if ok and result then
				result.PlayClick(5)
			end

			if not onDecline then
				return
			end

			onDecline(p2)
		end)

		return
	end

	local SquadController = require(ReplicatedStorage:WaitForChild("SquadController"))
	local v37 = if p2.type == "clearing" then true elseif p2.type == "mutant_hunting" then true else false
	local v38 = true

	for v41, v42 in ipairs(p2.objectives or {}) do
		if v42.id ~= "return" and (v42.id ~= "deliver" and not v42.complete) then
			v38 = false

			break
		end
	end

	local v43 = if v37 then not p2.shared_from and not v38 else v37

	if v43 and SquadController:GetSquad() then
		local TextButton = Instance.new("TextButton")

		TextButton.AnchorPoint = Vector2.new(0, 1)
		TextButton.Position = UDim2.new(0, 0, 1, -8)
		TextButton.Size = UDim2.fromOffset(180, 32)
		TextButton.BackgroundColor3 = v5
		TextButton.BorderSizePixel = 0
		TextButton.Text = "SHARE TO SQUAD"
		TextButton.FontFace = v1
		TextButton.TextSize = 14
		TextButton.TextColor3 = Color3.fromRGB(20, 20, 22)
		TextButton.Parent = Detail
		TextButton.MouseButton1Click:Connect(function() --[[ Line: 1288 | Upvalues: ok (ref), result (ref), onShare (copy), p2 (copy) ]]
			if ok and result then
				result.PlayClick(5)
			end

			if not onShare then
				return
			end

			onShare(p2)
		end)
	elseif v43 then
		local ShareHint = Instance.new("TextButton")

		ShareHint.Name = "ShareHint"
		ShareHint.AnchorPoint = Vector2.new(0, 1)
		ShareHint.Position = UDim2.new(0, 0, 1, -8)
		ShareHint.Size = UDim2.fromOffset(180, 32)
		ShareHint.BackgroundColor3 = Color3.fromRGB(52, 48, 38)
		ShareHint.BackgroundTransparency = 0.35
		ShareHint.BorderSizePixel = 0
		ShareHint.AutoButtonColor = false
		ShareHint.Text = "SHARE TO SQUAD"
		ShareHint.FontFace = v1
		ShareHint.TextSize = 14
		ShareHint.TextColor3 = Color3.fromRGB(150, 140, 115)
		ShareHint.Parent = Detail

		local UIStroke = Instance.new("UIStroke")

		UIStroke.Color = v5
		UIStroke.Thickness = 1
		UIStroke.Transparency = 0.6
		UIStroke.Parent = ShareHint

		local TextLabel10 = Instance.new("TextLabel")

		TextLabel10.AnchorPoint = Vector2.new(0, 1)
		TextLabel10.Position = UDim2.new(0, 0, 1, -44)
		TextLabel10.Size = UDim2.fromOffset(240, 16)
		TextLabel10.BackgroundTransparency = 1
		TextLabel10.Text = "Join a squad to share this contract"
		TextLabel10.FontFace = v4
		TextLabel10.TextSize = 12
		TextLabel10.TextColor3 = v8
		TextLabel10.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel10.Parent = Detail
	end

	local TextButton = Instance.new("TextButton")

	TextButton.AnchorPoint = Vector2.new(1, 1)
	TextButton.Position = UDim2.new(1, 0, 1, -8)
	TextButton.Size = UDim2.fromOffset(90, 24)
	TextButton.BackgroundTransparency = 1
	TextButton.Text = "Abandon"
	TextButton.FontFace = v4
	TextButton.TextSize = 13
	TextButton.TextColor3 = v8
	TextButton.Parent = Detail
	TextButton.MouseButton1Click:Connect(function() --[[ Line: 1337 | Upvalues: ok (ref), result (ref), onAbandon (copy), p2 (copy) ]]
		if ok and result then
			result.PlayClick(5)
		end

		if not onAbandon then
			return
		end

		onAbandon(p2)
	end)

	local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"))
	local TextButton2 = Instance.new("TextButton")

	TextButton2.AnchorPoint = Vector2.new(1, 1)
	TextButton2.Position = UDim2.new(1, -96, 1, -8)
	TextButton2.Size = UDim2.fromOffset(108, 24)
	TextButton2.BackgroundColor3 = v9
	TextButton2.BackgroundTransparency = 0.25
	TextButton2.BorderSizePixel = 0
	TextButton2.AutoButtonColor = true
	TextButton2.FontFace = v2
	TextButton2.TextSize = 13
	TextButton2.Parent = Detail

	local function refreshPin() --[[ refreshPin | Line: 1355 | Upvalues: TaskController (copy), p2 (copy), TextButton2 (copy), v5 (ref), v6 (ref) ]]
		local isId = TaskController:GetPinnedId() == p2.id

		TextButton2.Text = if isId then "\226\156\147 TRACKING" else "TRACK"
		TextButton2.TextColor3 = isId and v5 or v6
	end

	local isId = TaskController:GetPinnedId() == p2.id

	TextButton2.Text = if isId then "\226\156\147 TRACKING" else "TRACK"
	TextButton2.TextColor3 = isId and v5 or v6
	TextButton2.MouseButton1Click:Connect(function() --[[ Line: 1361 | Upvalues: ok (ref), result (ref), TaskController (copy), p2 (copy), TextButton2 (copy), v5 (ref), v6 (ref) ]]
		if ok and result then
			result.PlayClick(5)
		end

		TaskController:SetPinned(p2.id)

		local isId = TaskController:GetPinnedId() == p2.id

		TextButton2.Text = if isId then "\226\156\147 TRACKING" else "TRACK"
		TextButton2.TextColor3 = isId and v5 or v6
	end)
end

function t.Build(p1) --[[ Build | Line: 1368 | Upvalues: ReplicatedStorage (copy), v1 (copy), v6 (copy), buildSidebar (copy), buildTaskList (copy), ok (copy), result (copy), buildMainDetail (copy), buildDailyDetail (copy), buildDetail (copy) ]]
	local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"))
	local PageTitle = Instance.new("TextLabel")

	PageTitle.Name = "PageTitle"
	PageTitle.Position = UDim2.fromOffset(16, 4)
	PageTitle.Size = UDim2.new(0.3, 0, 0, 30)
	PageTitle.BackgroundTransparency = 1
	PageTitle.FontFace = v1
	PageTitle.TextSize = 24
	PageTitle.TextColor3 = v6
	PageTitle.Text = "Tasks"
	PageTitle.TextXAlignment = Enum.TextXAlignment.Left
	PageTitle.Parent = p1

	local Body = Instance.new("Frame")

	Body.Name = "Body"
	Body.Position = UDim2.fromOffset(16, 40)
	Body.Size = UDim2.new(1, -32, 1, -48)
	Body.BackgroundTransparency = 1
	Body.Parent = p1

	local v12 = "side"
	local v2 = nil

	local function v3() --[[ rebuild | Line: 1393 | Upvalues: Body (copy), TaskController (copy), v2 (ref), buildSidebar (ref), v12 (ref), v3 (copy), buildTaskList (ref), ok (ref), result (ref), buildMainDetail (ref), buildDailyDetail (ref), buildDetail (ref) ]]
		for i, v in ipairs(Body:GetChildren()) do
			v:Destroy()
		end

		local v1 = TaskController:GetActiveTasks()
		local v22 = TaskController:GetPendingShares()

		local function findPending(p1) --[[ findPending | Line: 1398 | Upvalues: v22 (copy) ]]
			for i, v in ipairs(v22) do
				if v.task and v.task.id == p1 then
					return v
				end
			end

			return nil
		end

		local function isDailyIdValid(p1) --[[ isDailyIdValid | Line: 1406 | Upvalues: TaskController (ref) ]]
			if type(p1) ~= "string" or p1:sub(1, 6) ~= "daily:" then
				return false
			end

			local v1 = tonumber(p1:sub(7))

			for i, v in ipairs(if TaskController.GetDailyTasks then TaskController:GetDailyTasks() or {} else {}) do
				if (v.index or 0) == v1 then
					return true
				end
			end

			return false
		end

		local function findMain(p1) --[[ findMain | Line: 1418 | Upvalues: TaskController (ref) ]]
			if type(p1) ~= "string" or p1:sub(1, 5) ~= "main:" then
				return nil
			end

			local v1 = p1:sub(6)
			local v2 = if TaskController.GetMain then TaskController:GetMain() or nil else nil

			if not v2 then
				return nil
			end

			if v2.active and v2.active.id == v1 then
				return v2.active
			end

			local v3 = ipairs

			for v5, v6 in v3(v2.available or {}) do
				if v6.id == v1 then
					return v6
				end
			end

			return nil
		end

		if v2 and not TaskController:GetTask(v2) then
			local v32 = v2
			local v4 = nil

			for i, v in ipairs(v22) do
				if v.task and v.task.id == v32 then
					v4 = v

					break
				end
			end

			if not (v4 or (isDailyIdValid(v2) or findMain(v2))) then
				v2 = nil
			end
		end

		buildSidebar(Body, v12, function(p1) --[[ Line: 1435 | Upvalues: v12 (ref), v3 (ref) ]]
			v12 = p1
			v3()
		end)
		buildTaskList(Body, v1, v22, v12, v2, function(p1) --[[ Line: 1439 | Upvalues: ok (ref), result (ref), v2 (ref), v3 (ref) ]]
			if not (ok and result) then
				v2 = p1.id
				v3()

				return
			end

			result.PlayClick(5)
			v2 = p1.id
			v3()
		end)

		local v5 = findMain(v2)

		if v5 then
			buildMainDetail(Body, v5)

			return
		end

		local v6 = nil

		if v2 and (type(v2) == "string" and v2:sub(1, 6) == "daily:") then
			local v9 = tonumber(v2:sub(7))

			for i, v in ipairs(if TaskController.GetDailyTasks then TaskController:GetDailyTasks() or {} else {}) do
				if (v.index or 0) == v9 then
					v6 = v

					break
				end
			end
		end

		if v6 then
			buildDailyDetail(Body, v6)

			return
		end

		local v11 = v2 and TaskController:GetTask(v2) or nil
		local v122 = nil

		if v11 or not v2 then
		else
			local v13 = v2

			for i, v in ipairs(v22) do
				if v.task and v.task.id == v13 then
					v122 = v

					break
				end
			end

			if not v122 then
				v122 = nil
			end
		end

		if v122 then
			buildDetail(Body, v122.task, {
				pending = true,
				onAccept = function(p1) --[[ onAccept | Line: 1470 | Upvalues: TaskController (ref), v2 (ref), v3 (ref) ]]
					local v1 = TaskController:AcceptShare(p1.id)

					if v1 and v1.ok then
						v2 = p1.id
						TaskController:ShowToast("Accepted: " .. (p1.title or "Task"))
					else
						TaskController:ShowToast(({
							share_expired = "That shared task is no longer available",
							share_gone = "That shared task is no longer available",
							task_cap_reached = "Too many active tasks"
						})[if v1 then v1.error or "unknown" else "unknown"] or "Couldn\'t accept shared task")
					end

					v3()
				end,
				onDecline = function(p1) --[[ onDecline | Line: 1485 | Upvalues: TaskController (ref), v2 (ref), v3 (ref) ]]
					TaskController:DeclineShare(p1.id)
					v2 = nil
					v3()
				end
			})
		else
			buildDetail(Body, v11, {
				onShare = function(p1) --[[ onShare | Line: 1493 | Upvalues: TaskController (ref) ]]
					local v1 = TaskController:Share(p1.id)

					if not (v1 and v1.ok) then
						TaskController:ShowToast("Couldn\'t share task")

						return
					end

					TaskController:ShowToast(if v1.recipients and v1.recipients > 0 then "Shared with " .. v1.recipients .. " squadmate(s)" or "No squadmates online to share with" else "No squadmates online to share with")
				end,
				onAbandon = function(p1) --[[ onAbandon | Line: 1503 | Upvalues: TaskController (ref) ]]
					TaskController:Abandon(p1.id)
				end
			})
		end
	end

	v3()
	TaskController:OnChanged(v3)
	TaskController:OnSharesChanged(v3)

	if TaskController.OnMainChanged then
		TaskController:OnMainChanged(function() --[[ Line: 1513 | Upvalues: v3 (copy) ]]
			v3()
		end)
	end

	TaskController:OnPinnedChanged(function() --[[ Line: 1516 | Upvalues: v3 (copy) ]]
		v3()
	end)

	if not TaskController.OnDailyChanged then
		return
	end

	TaskController:OnDailyChanged(function() --[[ Line: 1517 | Upvalues: v3 (copy) ]]
		v3()
	end)
end

return t