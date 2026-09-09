-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = Color3.fromRGB(15, 15, 15)
local v2 = Color3.fromRGB(220, 220, 200)
local v3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Medium)
local v4 = UDim.new(0, 4)

local function suppressDefault(p1) --[[ suppressDefault | Line: 34 ]]
	p1.Enabled = false
	p1:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 36 | Upvalues: p1 (copy) ]]
		if not p1.Enabled then
			return
		end

		p1.Enabled = false
	end)
end

local BubbleChatConfiguration = TextChatService:WaitForChild("BubbleChatConfiguration")

BubbleChatConfiguration.Enabled = false
BubbleChatConfiguration:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 36 | Upvalues: BubbleChatConfiguration (copy) ]]
	if not BubbleChatConfiguration.Enabled then
		return
	end

	BubbleChatConfiguration.Enabled = false
end)
TextChatService.ChildAdded:Connect(function(p1) --[[ Line: 43 ]]
	if not p1:IsA("BubbleChatConfiguration") then
		return
	end

	p1.Enabled = false
	p1:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 36 | Upvalues: p1 (copy) ]]
		if not p1.Enabled then
			return
		end

		p1.Enabled = false
	end)
end)

local t = {}

local function ensureContainer(p1, p2) --[[ ensureContainer | Line: 51 | Upvalues: t (copy) ]]
	local v1 = if p1 then p1:FindFirstChild("HumanoidRootPart") else p1

	if not v1 then
		return nil
	end

	local v2 = t[p2]

	if v2 and (v2.gui.Parent and v2.gui.Adornee == v1) then
		return v2
	end

	local CustomBubbleChat, v3, v4

	if not (v2 and v2.gui) then
		CustomBubbleChat = Instance.new("BillboardGui")
		CustomBubbleChat.Name = "CustomBubbleChat"
		CustomBubbleChat.Adornee = v1
		CustomBubbleChat.Size = UDim2.fromOffset(360, 200)
		CustomBubbleChat.StudsOffset = Vector3.new(0, 4.6, 0)
		CustomBubbleChat.AlwaysOnTop = true
		CustomBubbleChat.LightInfluence = 0
		CustomBubbleChat.ClipsDescendants = false
		CustomBubbleChat.ResetOnSpawn = false
		CustomBubbleChat.Parent = v1
		v3 = Instance.new("UIListLayout")
		v3.FillDirection = Enum.FillDirection.Vertical
		v3.HorizontalAlignment = Enum.HorizontalAlignment.Center
		v3.VerticalAlignment = Enum.VerticalAlignment.Bottom
		v3.SortOrder = Enum.SortOrder.LayoutOrder
		v3.Padding = UDim.new(0, 4)
		v3.Parent = CustomBubbleChat
		v4 = {
			nextOrder = 0,
			gui = CustomBubbleChat,
			list = {}
		}
		t[p2] = v4

		return v4
	end

	v2.gui:Destroy()
	CustomBubbleChat = Instance.new("BillboardGui")
	CustomBubbleChat.Name = "CustomBubbleChat"
	CustomBubbleChat.Adornee = v1
	CustomBubbleChat.Size = UDim2.fromOffset(360, 200)
	CustomBubbleChat.StudsOffset = Vector3.new(0, 4.6, 0)
	CustomBubbleChat.AlwaysOnTop = true
	CustomBubbleChat.LightInfluence = 0
	CustomBubbleChat.ClipsDescendants = false
	CustomBubbleChat.ResetOnSpawn = false
	CustomBubbleChat.Parent = v1
	v3 = Instance.new("UIListLayout")
	v3.FillDirection = Enum.FillDirection.Vertical
	v3.HorizontalAlignment = Enum.HorizontalAlignment.Center
	v3.VerticalAlignment = Enum.VerticalAlignment.Bottom
	v3.SortOrder = Enum.SortOrder.LayoutOrder
	v3.Padding = UDim.new(0, 4)
	v3.Parent = CustomBubbleChat
	v4 = {
		nextOrder = 0,
		gui = CustomBubbleChat,
		list = {}
	}
	t[p2] = v4

	return v4
end

local function buildBubble(p1) --[[ buildBubble | Line: 83 | Upvalues: v1 (copy), v4 (copy), v2 (copy), v3 (copy) ]]
	local Frame = Instance.new("Frame")

	Frame.BackgroundColor3 = v1
	Frame.BackgroundTransparency = 1
	Frame.BorderSizePixel = 0
	Frame.AutomaticSize = Enum.AutomaticSize.XY
	Frame.Size = UDim2.fromOffset(0, 0)

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = v4
	UICorner.Parent = Frame

	local UIPadding = Instance.new("UIPadding")

	UIPadding.PaddingLeft = UDim.new(0, 10)
	UIPadding.PaddingRight = UDim.new(0, 10)
	UIPadding.PaddingTop = UDim.new(0, 6)
	UIPadding.PaddingBottom = UDim.new(0, 6)
	UIPadding.Parent = Frame

	local Text = Instance.new("TextLabel")

	Text.Name = "Text"
	Text.BackgroundTransparency = 1
	Text.TextColor3 = v2
	Text.TextSize = 18
	Text.FontFace = v3
	Text.TextTransparency = 1
	Text.TextWrapped = true
	Text.TextXAlignment = Enum.TextXAlignment.Center
	Text.AutomaticSize = Enum.AutomaticSize.XY
	Text.Size = UDim2.fromOffset(0, 0)

	local UISizeConstraint = Instance.new("UISizeConstraint")

	UISizeConstraint.MaxSize = Vector2.new(340, (1 / 0))
	UISizeConstraint.Parent = Text
	Text.Text = p1
	Text.Parent = Frame

	return Frame, Text
end

local function trim(p1) --[[ trim | Line: 119 ]]
	while #p1.list > 3 do
		local v1 = table.remove(p1.list, 1)

		if v1 then
			v1:Destroy()
		end
	end
end

local function spawnBubble(p1, p2) --[[ spawnBubble | Line: 126 | Upvalues: buildBubble (copy), trim (copy), TweenService (copy) ]]
	local v1, v2 = buildBubble(p2)

	p1.nextOrder = p1.nextOrder + 1
	v1.LayoutOrder = p1.nextOrder
	v1.Parent = p1.gui
	table.insert(p1.list, v1)
	trim(p1)

	local v3 = TweenService:Create(v1, TweenInfo.new(0.25), {
		BackgroundTransparency = 0.2
	})
	local v4 = TweenService:Create(v2, TweenInfo.new(0.25), {
		TextTransparency = 0
	})

	v3:Play()
	v4:Play()
	task.delay(8, function() --[[ Line: 136 | Upvalues: v1 (copy), TweenService (ref), v2 (copy), p1 (copy) ]]
		if not v1.Parent then
			return
		end

		local v12 = TweenService:Create(v1, TweenInfo.new(0.25), {
			BackgroundTransparency = 1
		})
		local v22 = TweenService:Create(v2, TweenInfo.new(0.25), {
			TextTransparency = 1
		})

		v12:Play()
		v22:Play()
		v12.Completed:Wait()

		if not v1.Parent then
			return
		end

		for i, v in ipairs(p1.list) do
			if v == v1 then
				table.remove(p1.list, i)

				break
			end
		end

		v1:Destroy()
	end)
end

local function onMessage(p1) --[[ onMessage | Line: 150 | Upvalues: Players (copy), ensureContainer (copy), ReplicatedStorage (copy), spawnBubble (copy) ]]
	if not (p1 and p1.TextSource) then
		return
	end

	local Status = p1.Status

	if Status == Enum.TextChatMessageStatus.InvalidTextChannelPermissions or (Status == Enum.TextChatMessageStatus.TextFilterFailed or Status == Enum.TextChatMessageStatus.Floodchecked) then
		return
	end

	local v1 = Players:GetPlayerByUserId(p1.TextSource.UserId)

	if not v1 then
		return
	end

	local Character = v1.Character

	if not Character then
		return
	end

	local Text = p1.Text

	if not Text or Text == "" then
		return
	end

	local v2 = ensureContainer(Character, v1.UserId)

	if not v2 then
		return
	end

	if v1 == Players.LocalPlayer then
		task.spawn(function() --[[ Line: 179 | Upvalues: ReplicatedStorage (ref), Text (copy), ensureContainer (ref), v1 (copy), spawnBubble (ref) ]]
			local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
			local v12 = Remotes and Remotes:FindFirstChild("FilterSelfChat")
			local v2 = Text

			if v12 then
				local ok, result = pcall(function() --[[ Line: 184 | Upvalues: v12 (copy), Text (ref) ]]
					return v12:InvokeServer(Text)
				end)

				if ok and typeof(result) == "string" and result ~= "" then
					v2 = result
				end
			end

			local v3 = ensureContainer(v1.Character, v1.UserId)

			if not v3 then
				return
			end

			spawnBubble(v3, v2)
		end)
	else
		spawnBubble(v2, Text)
	end
end

local function hookChannel(p1) --[[ hookChannel | Line: 199 | Upvalues: onMessage (copy) ]]
	if not p1:IsA("TextChannel") then
		return
	end

	p1.MessageReceived:Connect(onMessage)
end

local TextChannels = TextChatService:WaitForChild("TextChannels")

for i, v in ipairs(TextChannels:GetChildren()) do
	if v:IsA("TextChannel") then
		v.MessageReceived:Connect(onMessage)
	end
end

TextChannels.ChildAdded:Connect(hookChannel)
task.spawn(function() --[[ Line: 220 | Upvalues: ReplicatedStorage (copy), ensureContainer (copy), spawnBubble (copy) ]]
	local Remotes = ReplicatedStorage:WaitForChild("Remotes", 30)
	local v1 = if Remotes then Remotes:WaitForChild("SquadCallout", 30) else Remotes

	if v1 then
		v1.OnClientEvent:Connect(function(p1, p2) --[[ Line: 224 | Upvalues: ensureContainer (ref), spawnBubble (ref) ]]
			if typeof(p1) ~= "Instance" or not p1:IsA("Player") then
				return
			end

			if type(p2) ~= "string" or p2 == "" then
				return
			end

			local Character = p1.Character

			if not Character then
				return
			end

			local v1 = ensureContainer(Character, p1.UserId)

			if not v1 then
				return
			end

			spawnBubble(v1, p2)
		end)
	end
end)
Players.PlayerRemoving:Connect(function(p1) --[[ Line: 234 | Upvalues: t (copy) ]]
	local v1 = t[p1.UserId]

	if v1 and v1.gui then
		v1.gui:Destroy()
	end

	t[p1.UserId] = nil
end)
game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 241 | Upvalues: Players (copy), t (copy) ]]
	local Character = Players.LocalPlayer.Character
	local v1 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

	if not v1 then
		return
	end

	for k, v in pairs(t) do
		local v2 = v.gui and v.gui.Adornee

		if v2 then
			local Magnitude = (v2.Position - v1.Position).Magnitude

			if Magnitude >= 80 then
				v.gui.Enabled = false

				continue
			end

			v.gui.Enabled = true

			if Magnitude > 60 then
				local v3 = (Magnitude - 60) / 20

				for i, v4 in ipairs(v.list) do
					if v4 and v4.Parent then
						v4.BackgroundTransparency = 0.2 + 0.8 * v3

						local Text = v4:FindFirstChild("Text")

						if Text then
							Text.TextTransparency = v3
						end
					end
				end
			end
		end
	end
end)