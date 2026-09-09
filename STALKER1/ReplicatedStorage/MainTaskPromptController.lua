-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local TextChatService = game:GetService("TextChatService")
local t = {
	_initialized = false,
	_prompt = nil,
	_promptId = nil,
	_wanted = nil,
	_retrying = false,
	_meetingNpc = nil,
	_tagConns = {}
}

local function sayInChat(p1) --[[ sayInChat | Line: 43 | Upvalues: TextChatService (copy) ]]
	if type(p1) == "string" and p1 ~= "" then
		task.spawn(function() --[[ Line: 45 | Upvalues: TextChatService (ref), p1 (copy) ]]
			local TextChannels = TextChatService:FindFirstChild("TextChannels")
			local v1 = TextChannels and (TextChannels:FindFirstChild("RBXGeneralChannel") or TextChannels:FindFirstChild("RBXGeneral"))

			if v1 then
				pcall(function() --[[ Line: 50 | Upvalues: v1 (copy), p1 (ref) ]]
					v1:SendAsync(p1)
				end)
			end
		end)
	end
end

local function hasTruce() --[[ hasTruce | Line: 59 | Upvalues: Players (copy) ]]
	local LocalPlayer = Players.LocalPlayer

	if not LocalPlayer then
		return false
	end

	return os.time() < (tonumber(LocalPlayer:GetAttribute("MT_TruceUntil")) or 0)
end

local function findMeetingNpc(p1) --[[ findMeetingNpc | Line: 82 ]]
	local PlayerCharacters = workspace:FindFirstChild("PlayerCharacters")
	local v1 = if PlayerCharacters then PlayerCharacters:FindFirstChild("HostileNPCs") else PlayerCharacters

	if not v1 then
		return nil
	end

	for i, v in ipairs(v1:GetChildren()) do
		if v:IsA("Model") and v:GetAttribute("NpcId") == p1 then
			local Humanoid = v:FindFirstChildOfClass("Humanoid")

			if Humanoid and (Humanoid.Health > 0 and v:FindFirstChild("Head")) then
				return v
			end
		end
	end

	return nil
end

local function findProp(p1) --[[ findProp | Line: 95 | Upvalues: CollectionService (copy) ]]
	for i, v in ipairs(CollectionService:GetTagged("MainTaskPrompt")) do
		if v:GetAttribute("PromptId") == p1 then
			return v
		end
	end

	return nil
end

local function hostPartOf(p1) --[[ hostPartOf | Line: 102 ]]
	if p1:IsA("BasePart") then
		return p1
	end

	if not p1:IsA("Model") then
		return nil
	end

	return p1.PrimaryPart or p1:FindFirstChildWhichIsA("BasePart")
end

function t._clear(p1) --[[ _clear | Line: 110 ]]
	if p1._prompt then
		p1._prompt:Destroy()
		p1._prompt = nil
	end

	p1._promptId = nil
end
function t._wantedMeetingId(p1) --[[ _wantedMeetingId | Line: 130 | Upvalues: Players (copy) ]]
	local v1 = if p1._tc and p1._tc.GetMainActive then p1._tc:GetMainActive() or nil else nil

	if not v1 then
		return nil
	end

	local LocalPlayer = Players.LocalPlayer

	if if LocalPlayer then os.time() < (tonumber(LocalPlayer:GetAttribute("MT_TruceUntil")) or 0) else false then
		return v1.meetingPromptId
	end

	return nil
end
function t._syncMeeting(p1) --[[ _syncMeeting | Line: 143 | Upvalues: findMeetingNpc (copy) ]]
	local v1 = p1:_wantedMeetingId()

	if not v1 then
		p1._meetingNpc = nil
		p1._meetingId = nil

		return nil
	end

	local v2 = findMeetingNpc(v1)

	p1._meetingNpc = v2
	p1._meetingId = if v2 and v1 then v1 else nil

	return v2
end
function t._settled(p1) --[[ _settled | Line: 159 ]]
	local _wanted = p1._wanted
	local v1 = if _wanted == nil then true else p1._prompt and (p1._prompt.Parent and (if p1._promptId == _wanted then true else false))
	local v2 = p1:_wantedMeetingId()

	return v1 and (if v2 == nil then true else p1._meetingNpc and (p1._meetingNpc.Parent and p1._meetingId == v2)) and true or false
end
function t._startRetry(p1) --[[ _startRetry | Line: 180 ]]
	if not p1._retrying then
		p1._retrying = true
		task.spawn(function() --[[ Line: 183 | Upvalues: p1 (copy) ]]
			while p1._retrying do
				task.wait(2)

				if p1:_settled() then
					break
				end

				local _wanted = p1._wanted

				p1._promptId = nil
				p1:_apply(_wanted)
			end

			p1._retrying = false
		end)
	end
end
function t._apply(p1, p2) --[[ _apply | Line: 198 | Upvalues: findProp (copy), Players (copy), TextChatService (copy), ReplicatedStorage (copy) ]]
	p1._wanted = p2
	p1:_syncMeeting()

	if p2 == p1._promptId and (p1._prompt and p1._prompt.Parent) then
		if p1:_settled() then
			return
		end

		p1:_startRetry()
	else
		p1:_clear()

		if not p2 then
			p1._retrying = false

			return
		end

		local v1 = findProp(p2)

		if not v1 then
			p1:_startRetry()

			return
		end

		local v2 = p1._tc and p1._tc.GetMainActive and p1._tc:GetMainActive() or nil
		local v3 = if v2 then v2.parley and (if v2.promptId == p2 then true else false) else v2

		if v3 then
			local LocalPlayer = Players.LocalPlayer

			if not (if LocalPlayer then os.time() < (tonumber(LocalPlayer:GetAttribute("MT_TruceUntil")) or 0) else false) then
				p1:_startRetry()

				return
			end
		end

		local v5 = if v1:IsA("BasePart") then v1 elseif v1:IsA("Model") then v1.PrimaryPart or v1:FindFirstChildWhichIsA("BasePart") else nil

		if v3 then
			local _meetingNpc = p1._meetingNpc

			if not (_meetingNpc and _meetingNpc.Parent) then
				p1:_startRetry()

				return
			end

			v5 = _meetingNpc:FindFirstChild("Head") or (_meetingNpc.PrimaryPart or (_meetingNpc:FindFirstChild("HumanoidRootPart") or (_meetingNpc:FindFirstChildWhichIsA("BasePart", true) or v5)))
		end

		if not v5 then
			warn(("[MainTaskPrompt] %s has no BasePart to host a prompt"):format(v1:GetFullName()))

			return
		end

		local MainTaskPrompt = Instance.new("ProximityPrompt")

		MainTaskPrompt.Name = "MainTaskPrompt"
		MainTaskPrompt.ActionText = v1:GetAttribute("PromptText") or "Search"
		MainTaskPrompt.ObjectText = ""
		MainTaskPrompt.HoldDuration = 0.5
		MainTaskPrompt.MaxActivationDistance = 10
		MainTaskPrompt.RequiresLineOfSight = false
		MainTaskPrompt.Style = Enum.ProximityPromptStyle.Custom
		MainTaskPrompt.Parent = v5
		MainTaskPrompt.Triggered:Connect(function() --[[ Line: 313 | Upvalues: p1 (copy), p2 (copy), TextChatService (ref), ReplicatedStorage (ref) ]]
			local v1 = if p1._tc and p1._tc.GetMainActive then p1._tc:GetMainActive() or nil else nil

			if v1 and v1.promptId == p2 then
				local promptSay = v1.promptSay

				if type(promptSay) == "string" and promptSay ~= "" then
					task.spawn(function() --[[ Line: 45 | Upvalues: TextChatService (ref), promptSay (copy) ]]
						local TextChannels = TextChatService:FindFirstChild("TextChannels")
						local v1 = TextChannels and (TextChannels:FindFirstChild("RBXGeneralChannel") or TextChannels:FindFirstChild("RBXGeneral"))

						if v1 then
							pcall(function() --[[ Line: 50 | Upvalues: v1 (copy), promptSay (ref) ]]
								v1:SendAsync(p1)
							end)
						end
					end)
				end

				if v1.parley then
					local function commas(p1) --[[ commas | Line: 336 ]]
						return tostring((math.floor(tonumber(p1) or 0))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
					end

					local function bestOffer(p1, p2) --[[ bestOffer | Line: 341 ]]
						local v1 = nil
						local v2 = ipairs

						for v4, v5 in v2(p1.offers or {}) do
							local v6 = true
							local v7 = ipairs

							for v9, v10 in v7(v5.requires or {}) do
								if not (p2 and p2[v10]) then
									v6 = false

									break
								end
							end

							local v11 = ipairs

							for v13, v14 in v11(v5.excludes or {}) do
								if p2 and p2[v14] then
									v6 = false

									break
								end
							end

							if v6 and (not v1 or (v5.cost or 0) < (v1.cost or 0)) then
								v1 = v5
							end
						end

						return if v1 then v1 else {
	cost = p1.cost or 0,
	text = p1.accept
}
					end

					local isParleySettled = v1.parleySettled == true
					local ok, result = pcall(require, ReplicatedStorage:WaitForChild("TalkController", 2))

					if ok and (result and result.OpenTurnIn) then
						p1._tc:ParleyPause(true)

						if result.Gui and not p1._pauseConn then
							p1._pauseConn = result.Gui:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 374 | Upvalues: result (copy), p1 (ref) ]]
								if result.Gui.Enabled then
									return
								end

								p1._tc:ParleyPause(false)

								if not p1._pauseConn then
									return
								end

								p1._pauseConn:Disconnect()
								p1._pauseConn = nil
							end)
						end

						local parley = v1.parley
						local squadPaid = parley.squadPaid
						local t2 = {}

						t2.intro = isParleySettled and squadPaid and squadPaid.line or parley.intro
						t2.topics = not isParleySettled and parley.topics or nil
						t2.accept = parley.accept
						t2.decline = parley.decline
						t2.close = parley.close
						t2.acceptRequires = not isParleySettled and parley.acceptRequires or nil
						t2.asked = v1.parleyAsked
						t2.resumeIntro = parley.resumeIntro
						t2.breakOff = parley.breakOff
						t2.breakSay = parley.breakSay
						t2.breakClose = parley.breakClose
						function t2.onBreak() --[[ onBreak | Line: 404 | Upvalues: p1 (ref) ]]
							p1._tc:BreakTruce()
						end
						function t2.onAsk(p12) --[[ onAsk | Line: 405 | Upvalues: p1 (ref) ]]
							p1._tc:ParleyAsk(p12)
						end
						function t2.resolveAccept(p1) --[[ resolveAccept | Line: 411 | Upvalues: isParleySettled (copy), squadPaid (copy), bestOffer (copy), parley (copy) ]]
							if isParleySettled then
								return if squadPaid then squadPaid.button or "Take it." else "Take it.", nil, 0
							end

							local v2 = bestOffer(parley, p1)
							local v3 = v2.cost or parley.cost or 0

							return ("Pay %s\226\130\189"):format((tostring((math.floor(tonumber(v3) or 0))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))), v2.text or parley.accept, v3
						end
						function t2.onTurnIn() --[[ onTurnIn | Line: 428 | Upvalues: p1 (ref) ]]
							return p1._tc:Parley()
						end

						if result:OpenTurnIn(nil, {
							DisplayName = "Sych"
						}, t2) then
							return
						end

						p1._tc:ParleyPause(false)

						if p1._pauseConn then
							p1._pauseConn:Disconnect()
							p1._pauseConn = nil
						end
					end
				end
			end

			local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
			local v6 = Remotes and Remotes:FindFirstChild("MainTaskPromptFire")

			if not v6 then
				return
			end

			v6:FireServer(p2)
		end)
		p1._prompt = MainTaskPrompt
		p1._promptId = p2

		if p1:_settled() then
			p1._retrying = false
		else
			p1:_startRetry()
		end
	end
end
function t.Init(p1) --[[ Init | Line: 458 | Upvalues: ReplicatedStorage (copy), Players (copy), CollectionService (copy) ]]
	if p1._initialized then
		return
	end

	p1._initialized = true

	local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"))

	p1._tc = TaskController

	local function sync() --[[ sync | Line: 465 | Upvalues: TaskController (copy), p1 (copy) ]]
		local v1 = if TaskController.GetMainActive then TaskController:GetMainActive() or nil else nil

		p1:_apply(if v1 then v1.promptId or nil else nil)
	end

	TaskController:OnMainChanged(function() --[[ Line: 470 | Upvalues: TaskController (copy), p1 (copy) ]]
		local v1 = if TaskController.GetMainActive then TaskController:GetMainActive() or nil else nil

		p1:_apply(if v1 then v1.promptId or nil else nil)
	end)

	local LocalPlayer = Players.LocalPlayer

	if LocalPlayer then
		local function onTruceChanged() --[[ onTruceChanged | Line: 483 | Upvalues: Players (ref), ReplicatedStorage (ref), TaskController (copy), p1 (copy) ]]
			local LocalPlayer = Players.LocalPlayer

			if not (if LocalPlayer then os.time() < (tonumber(LocalPlayer:GetAttribute("MT_TruceUntil")) or 0) else false) then
				local ok, result = pcall(require, ReplicatedStorage:FindFirstChild("TalkController"))

				if ok and (result and (result.IsOpen and result.Close)) then
					pcall(function() --[[ Line: 487 | Upvalues: result (copy) ]]
						result:Close()
					end)
				end
			end

			local v2 = if TaskController.GetMainActive then TaskController:GetMainActive() or nil else nil

			p1:_apply(if v2 then v2.promptId or nil else nil)
		end

		table.insert(p1._tagConns, LocalPlayer:GetAttributeChangedSignal("MT_TruceUntil"):Connect(onTruceChanged))
		table.insert(p1._tagConns, LocalPlayer:GetAttributeChangedSignal("MT_TruceGroup"):Connect(onTruceChanged))
	end

	table.insert(p1._tagConns, CollectionService:GetInstanceAddedSignal("MainTaskPrompt"):Connect(function() --[[ Line: 499 | Upvalues: TaskController (copy), p1 (copy) ]]
		local v1 = if TaskController.GetMainActive then TaskController:GetMainActive() or nil else nil

		p1:_apply(if v1 then v1.promptId or nil else nil)
	end))
	table.insert(p1._tagConns, CollectionService:GetInstanceRemovedSignal("MainTaskPrompt"):Connect(function(p12) --[[ Line: 501 | Upvalues: p1 (copy), TaskController (copy) ]]
		if p1._prompt and not p1._prompt.Parent then
			p1:_clear()
		end

		local v1 = if TaskController.GetMainActive then TaskController:GetMainActive() or nil else nil

		p1:_apply(if v1 then v1.promptId or nil else nil)
	end))

	local v5 = if TaskController.GetMainActive then TaskController:GetMainActive() or nil else nil

	p1:_apply(v5 and v5.promptId or nil)
end

return t