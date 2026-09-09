-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ContextActionService = game:GetService("ContextActionService")
local t = {
	"Wear a gas mask AND a decent suit before entering high radiation zones.",
	"Bleed kills faster than bullets. Carry Field Dressings.",
	"Equipped vests, backpacks, and belts add internal grid space to your inventory.",
	"Tab opens your inventory. Drag items to rearrange them.",
	"Empty mags can be repacked from AmmoPack boxes.",
	"F talks to nearby NPCs. P opens your PDA.",
	"Iodine Pills flush absorbed radiation. Carry some before heading into hot zones.",
	"Anti-Rad Vials give 50%% rad resistance for 3 minutes.",
	"Your radiation chip turns red at 40 rad. That\'s when you start taking damage.",
	"Running low on money? Look for Crow, he\'s always in need of work getting done.",
	"Squad task sharing is combat only, task like fetching or delivery are solo only.",
	"L toggles your headlamp. Useful inside dark interiors and basements.",
	"Keys 1-4 draw/holster Primary, Secondary, Sidearm, and Melee.",
	"F1-F4 are quick-use slots for consumables drag from inventory to assign.",
	"Compass: red = enemy, yellow = quest turn-in, green = squadmate, orange = stalker.",
	"Camp markers point to the camp\'s center. Enemies spawn as you get closer.",
	"Hidden stashes hold the best loot... and the worst surroundings.",
	"Intact armor blocks bleeding. Once durability is gone, hits punch through.",
	"Magazines are physical items. Loading a new mag swaps the rounds in your weapon.",
	"Watch your weight, overloaded stalkers run slower and tire faster."
}
local v1 = true

ReplicatedFirst:RemoveDefaultLoadingScreen()
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local v2 = script:WaitForChild("LoadingGui"):Clone()

v2.Parent = PlayerGui

local TipLabel = v2.CanvasGroup:FindFirstChild("TipLabel")

local function pickRandomTip(p1) --[[ pickRandomTip | Line: 48 | Upvalues: t (copy) ]]
	local t2 = {}

	for i, v in ipairs(t) do
		if v ~= p1 then
			table.insert(t2, v)
		end
	end

	if #t2 == 0 then
		return t[1]
	end

	return t2[math.random(1, #t2)]
end

if TipLabel then
	local v3 = pickRandomTip()

	TipLabel.Text = "TIP: " .. v3
	task.spawn(function() --[[ Line: 60 | Upvalues: v1 (ref), pickRandomTip (copy), v3 (ref), TweenService (copy), TipLabel (copy) ]]
		while v1 do
			task.wait(4)

			if not v1 then
				break
			end

			local v12 = pickRandomTip(v3)

			TweenService:Create(TipLabel, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
				TextTransparency = 1
			}):Play()
			task.wait(0.35)

			if not v1 then
				break
			end

			TipLabel.Text = "TIP: " .. v12
			v3 = v12
			TweenService:Create(TipLabel, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
				TextTransparency = 0
			}):Play()
		end
	end)
end

local v4 = 0
local round = math.round
local v5 = game:GetDescendants()

local function CompleteLoading() --[[ CompleteLoading | Line: 79 | Upvalues: v1 (ref), ContextActionService (copy), StarterGui (copy), v2 (copy), v4 (ref), TweenService (copy) ]]
	if not v1 then
		return
	end

	v1 = false
	pcall(function() --[[ Line: 92 | Upvalues: ContextActionService (ref) ]]
		ContextActionService:UnbindAction("SkipLoading")
	end)
	task.wait(0.2)
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)

	local v12 = v2 and v2.Parent and v2:FindFirstChild("CanvasGroup")

	if v12 then
		v12.BarFrame.Bar:TweenSize(UDim2.new(v4 / 100, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.2)
		TweenService:Create(v12, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			GroupColor3 = Color3.fromRGB(0, 0, 0)
		}):Play()
		task.wait(0.6)
		TweenService:Create(v12, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			GroupTransparency = 0.5
		}):Play()
		task.wait(0.6)
	end

	if not v2 then
		return
	end

	v2:Destroy()
end

ContextActionService:BindAction("SkipLoading", function(p1, p2, p3) --[[ HandleAction | Line: 114 | Upvalues: CompleteLoading (copy), ContextActionService (copy) ]]
	if p1 ~= "SkipLoading" or p2 ~= Enum.UserInputState.Begin then
		return
	end

	CompleteLoading()
	print("SKIPPING LOADINGSCREEN")
	ContextActionService:UnbindAction("SkipLoading")
end, true, Enum.KeyCode.Space)

local v6 = tick()
local v7 = 0
local v8 = false

task.spawn(function() --[[ Line: 137 | Upvalues: ContentProvider (copy), v5 (copy), v7 (ref), v4 (ref), round (copy), v2 (copy), v8 (ref) ]]
	pcall(function() --[[ Line: 138 | Upvalues: ContentProvider (ref), v5 (ref), v7 (ref), v4 (ref), round (ref), v2 (ref) ]]
		ContentProvider:PreloadAsync(v5, function(p1, p2) --[[ Line: 139 | Upvalues: v7 (ref), v4 (ref), v5 (ref), round (ref), v2 (ref) ]]
			v7 = v7 + 1
			v4 = round(v7 / #v5 * 100)

			if not (v2 and v2.Parent) then
				return
			end

			v2.CanvasGroup.PercentLabel.Text = v4 .. "%"
			v2.CanvasGroup.BarFrame.Bar.Size = UDim2.new(v4 / 100, 0, 1, 0)
		end)
	end)
	v8 = true
end)

local sum = 0

while not v8 and sum < 45 do
	task.wait(0.1)
	sum = sum + 0.1
end

if not v8 then
	warn(string.format("[LoadingScreen] Asset preload timed out after %ds (%d/%d loaded). Proceeding anyway.", 45, v7, #v5))
end

v4 = 100

if v2 and v2.Parent then
	v2.CanvasGroup.PercentLabel.Text = "100%"
	v2.CanvasGroup.BarFrame.Bar.Size = UDim2.new(1, 0, 1, 0)
end

local v9 = 12 - (tick() - v6)

if v9 > 0 and (v2 and v2.Parent) then
	local LoadingLabel = v2.CanvasGroup:FindFirstChild("LoadingLabel")

	if LoadingLabel then
		LoadingLabel.Text = "DEPLOYING TO ZONE..."
	end

	task.wait(v9)
end

CompleteLoading()