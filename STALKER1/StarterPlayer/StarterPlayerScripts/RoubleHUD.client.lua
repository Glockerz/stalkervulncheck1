-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
local BalanceChanged = Remotes:WaitForChild("BalanceChanged")
local RequestBalance = Remotes:WaitForChild("RequestBalance")
local LocalPlayer = Players.LocalPlayer
local RoubleDisplay = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("InventoryGui"):WaitForChild("MainFrame"):WaitForChild("InventoryFrame"):WaitForChild("RoubleDisplay")
local RoubleLabel = RoubleDisplay:WaitForChild("RoubleLabel")
local DropButton = RoubleDisplay:WaitForChild("DropButton")

local function render(p1) --[[ render | Line: 21 | Upvalues: RoubleLabel (copy) ]]
	RoubleLabel.Text = string.format("\226\130\189 %d", p1 or 0)
end

BalanceChanged.OnClientEvent:Connect(render)

local ok, result = pcall(function() --[[ Line: 28 | Upvalues: RequestBalance (copy) ]]
	return RequestBalance:InvokeServer()
end)

if ok then
	RoubleLabel.Text = string.format("\226\130\189 %d", result or 0)
end

local DropRoubles = Remotes:WaitForChild("DropRoubles")
local v1 = false
local v2 = nil
local v3 = 0
local v4 = nil
local v5 = 0

BalanceChanged.OnClientEvent:Connect(function(p1) --[[ Line: 42 | Upvalues: v3 (ref) ]]
	v3 = p1 or 0
end)

local function commitText(p1) --[[ commitText | Line: 46 | Upvalues: DropRoubles (copy) ]]
	local v1 = tonumber(p1)

	if not (v1 and v1 > 0) then
		return
	end

	DropRoubles:FireServer((math.floor(v1)))
end

local function resetToLabel() --[[ resetToLabel | Line: 53 | Upvalues: v1 (ref), v2 (ref), RoubleLabel (copy), DropButton (copy) ]]
	v1 = false

	if not v2 then
		RoubleLabel.Visible = true
		DropButton.Text = "DROP"

		return
	end

	v2:Destroy()
	v2 = nil
	RoubleLabel.Visible = true
	DropButton.Text = "DROP"
end

local function enterDropMode() --[[ enterDropMode | Line: 63 | Upvalues: v1 (ref), RoubleLabel (copy), v2 (ref), RoubleDisplay (copy), DropButton (copy), v4 (ref), v5 (ref), DropRoubles (copy) ]]
	if not v1 then
		v1 = true
		RoubleLabel.Visible = false
		v2 = Instance.new("TextBox")
		v2.Name = "RoubleDropInput"
		v2.AnchorPoint = RoubleLabel.AnchorPoint
		v2.Position = RoubleLabel.Position
		v2.Size = RoubleLabel.Size
		v2.BackgroundTransparency = 1
		v2.TextColor3 = Color3.fromRGB(240, 220, 130)
		v2.FontFace = RoubleLabel.FontFace
		v2.TextSize = RoubleLabel.TextSize
		v2.TextXAlignment = RoubleLabel.TextXAlignment
		v2.PlaceholderText = "Amount"
		v2.PlaceholderColor3 = Color3.fromRGB(140, 140, 140)
		v2.Text = ""
		v2.ClearTextOnFocus = false
		v2.ZIndex = 6
		v2.Parent = RoubleDisplay
		v2:CaptureFocus()
		DropButton.Text = "OK"
		v2.FocusLost:Connect(function(p1) --[[ Line: 87 | Upvalues: v4 (ref), v2 (ref), v5 (ref), DropRoubles (ref), v1 (ref), RoubleLabel (ref), DropButton (ref) ]]
			v4 = v2.Text
			v5 = os.clock()

			if not p1 then
				task.delay(0.12, function() --[[ Line: 98 | Upvalues: v2 (ref), v1 (ref), RoubleLabel (ref), DropButton (ref) ]]
					if not v2 then
						return
					end

					v1 = false

					if v2 then
						v2:Destroy()
						v2 = nil
					end

					RoubleLabel.Visible = true
					DropButton.Text = "DROP"
				end)

				return
			end

			local v22 = tonumber(v4)

			if v22 and v22 > 0 then
				DropRoubles:FireServer((math.floor(v22)))
			end

			v1 = false

			if not v2 then
				RoubleLabel.Visible = true
				DropButton.Text = "DROP"

				return
			end

			v2:Destroy()
			v2 = nil
			RoubleLabel.Visible = true
			DropButton.Text = "DROP"
		end)
	end
end

DropButton.MouseButton1Click:Connect(function() --[[ Line: 104 | Upvalues: v2 (ref), DropRoubles (copy), v1 (ref), RoubleLabel (copy), DropButton (copy), v4 (ref), v5 (ref), enterDropMode (copy) ]]
	if v2 then
		local v12 = tonumber(v2.Text)

		if v12 and v12 > 0 then
			DropRoubles:FireServer((math.floor(v12)))
		end
	else
		if not (v1 and (v4 and os.clock() - v5 < 0.2)) then
			enterDropMode()

			return
		end

		local v3 = tonumber(v4)

		if v3 and v3 > 0 then
			DropRoubles:FireServer((math.floor(v3)))
		end

		v4 = nil
	end

	v1 = false

	if not v2 then
		RoubleLabel.Visible = true
		DropButton.Text = "DROP"

		return
	end

	v2:Destroy()
	v2 = nil
	RoubleLabel.Visible = true
	DropButton.Text = "DROP"
end)
LocalPlayer.CharacterRemoving:Connect(function() --[[ Line: 123 | Upvalues: v1 (ref), v2 (ref), RoubleLabel (copy), DropButton (copy) ]]
	v1 = false

	if not v2 then
		RoubleLabel.Visible = true
		DropButton.Text = "DROP"

		return
	end

	v2:Destroy()
	v2 = nil
	RoubleLabel.Visible = true
	DropButton.Text = "DROP"
end)