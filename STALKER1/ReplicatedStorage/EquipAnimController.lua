-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")

game:GetService("RunService")

local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EquipAnimConfig = require(ReplicatedStorage:WaitForChild("EquipAnimConfig"))
local LocalPlayer = Players.LocalPlayer
local t = {
	_started = false,
	_suppressUntil = 0,
	_tracks = {},
	_conns = {},
	_activeTrack = nil,
	_lastEquipped = {},
	_pendingEntry = nil,
	_pendingType = nil,
	_pendingUnequip = false,
	_pendingRank = (1 / 0),
	_resolveScheduled = false,
	_soundMap = {},
	_hookedAnimators = setmetatable({}, {
		__mode = "k"
	}),
	_boundTracks = setmetatable({}, {
		__mode = "k"
	})
}

local function log(p1, ...) --[[ log | Line: 49 | Upvalues: EquipAnimConfig (copy) ]]
	if EquipAnimConfig.Debug then
		print("[EquipAnim] " .. string.format(p1, ...))
	end
end

local function isConfigured(p1) --[[ isConfigured | Line: 54 | Upvalues: EquipAnimConfig (copy) ]]
	return if type(p1) == "string" and p1 ~= EquipAnimConfig.PLACEHOLDER then p1:match("^rbxassetid://%d+$") ~= nil else false
end

function t._entryFor(p1, p2, p3) --[[ _entryFor | Line: 65 | Upvalues: EquipAnimConfig (copy) ]]
	if type(p2) ~= "string" then
		return nil
	end

	if not EquipAnimConfig.ByType[p2] then
		return nil
	end

	if p3 and EquipAnimConfig.ByItem[p3] then
		return EquipAnimConfig.ByItem[p3]
	end

	return EquipAnimConfig.ByType[p2]
end
function t._onEquipmentEvent(p1, p2, p3, p4) --[[ _onEquipmentEvent | Line: 81 | Upvalues: log (copy), EquipAnimConfig (copy) ]]
	if type(p2) ~= "string" or type(p3) ~= "string" then
		return
	end

	local v1 = if p3 == "unequip" then true else false

	if not v1 and p3 ~= "equip" then
		return
	end

	if v1 then
		local v2 = if p4 then p4 else p1._lastEquipped[p2]

		p1._lastEquipped[p2] = nil
		p4 = v2
	else
		p1._lastEquipped[p2] = p4
	end

	local v3 = p1:_entryFor(p2, p4)

	if not v3 then
		return
	end

	log("%s %s (%s)", p2, p3, (tostring(p4)))

	local v6 = (EquipAnimConfig.TypeRank[p2] or 99) + (if v1 then 100 else 0)

	if v6 < p1._pendingRank then
		p1._pendingRank = v6
		p1._pendingEntry = v3
		p1._pendingType = p2
		p1._pendingUnequip = v1
	end

	if p1._resolveScheduled then
		return
	end

	p1._resolveScheduled = true
	task.delay(EquipAnimConfig.CoalesceWindow, function() --[[ Line: 112 | Upvalues: p1 (copy) ]]
		p1:_resolvePending()
	end)
end
function t._resolvePending(p1) --[[ _resolvePending | Line: 118 | Upvalues: LocalPlayer (copy), log (copy), EquipAnimConfig (copy) ]]
	p1._resolveScheduled = false

	local _pendingEntry = p1._pendingEntry
	local _pendingType = p1._pendingType
	local _pendingUnequip = p1._pendingUnequip

	p1._pendingEntry = nil
	p1._pendingType = nil
	p1._pendingUnequip = false
	p1._pendingRank = (1 / 0)

	if not (_pendingEntry and _pendingType) then
		return
	end

	local Character = LocalPlayer.Character
	local v1 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

	if not v1 or v1.Health <= 0 then
		log("character dead or absent -- not animating")

		return
	end

	if os.clock() < p1._suppressUntil then
		log("inside spawn-suppress window -- not animating")

		return
	end

	local animId = _pendingEntry.animId

	if _pendingUnequip and _pendingEntry.unequipAnimId then
		animId = _pendingEntry.unequipAnimId
	end

	if if type(animId) == "string" and animId ~= EquipAnimConfig.PLACEHOLDER then animId:match("^rbxassetid://%d+$") ~= nil else false then
		log("PLAY %s %s -> %s", _pendingType, if _pendingUnequip then "unequip" else "equip", animId)
		p1:PlayEquipAnim(_pendingEntry, _pendingUnequip)
	else
		log("%s %s: no animation id configured yet", _pendingType, if _pendingUnequip then "unequip" else "equip")
	end
end
function t.StopAnim(p1) --[[ StopAnim | Line: 164 | Upvalues: EquipAnimConfig (copy) ]]
	for i, v in ipairs(p1._conns) do
		v:Disconnect()
	end

	table.clear(p1._conns)

	if not p1._activeTrack then
		return
	end

	p1._activeTrack:Stop(EquipAnimConfig.BlendTime)
	p1._activeTrack = nil
end
function t._bindCancels(p1, p2) --[[ _bindCancels | Line: 178 | Upvalues: LocalPlayer (copy) ]]
	local Character = LocalPlayer.Character
	local v1 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character

	if v1 then
		local _conns = p1._conns

		local function add(p1) --[[ add | Line: 184 | Upvalues: _conns (copy) ]]
			_conns[#_conns + 1] = p1
		end

		local Health = v1.Health

		_conns[#_conns + 1] = v1.HealthChanged:Connect(function(p12) --[[ Line: 195 | Upvalues: Health (ref), p1 (copy) ]]
			local v1 = p12 < Health

			Health = p12

			if not v1 then
				return
			end

			p1:StopAnim()
		end)
		_conns[#_conns + 1] = v1.Died:Connect(function() --[[ Line: 201 | Upvalues: p1 (copy) ]]
			p1:StopAnim()
		end)
		_conns[#_conns + 1] = p2.Stopped:Connect(function() --[[ Line: 205 | Upvalues: p1 (copy) ]]
			p1:StopAnim()
		end)
	end
end
function t.PlayEquipAnim(p1, p2, p3) --[[ PlayEquipAnim | Line: 215 | Upvalues: LocalPlayer (copy), EquipAnimConfig (copy) ]]
	local Character = LocalPlayer.Character
	local v1 = if Character then Character:FindFirstChildOfClass("Humanoid") else Character
	local v2 = v1 and v1:FindFirstChildOfClass("Animator")

	if not v2 then
		return
	end

	local animId = p2.animId
	local v3 = false

	if p3 then
		if p2.unequip == false then
			return
		end

		if p2.unequipAnimId then
			animId = p2.unequipAnimId
		else
			v3 = true
		end
	end

	local v4 = animId

	if not (if type(v4) == "string" and v4 ~= EquipAnimConfig.PLACEHOLDER then v4:match("^rbxassetid://%d+$") ~= nil else false) then
		return
	end

	p1:StopAnim()

	local v6 = p1._tracks[animId]

	if not v6 then
		local Animation = Instance.new("Animation")

		Animation.AnimationId = animId

		local ok, result = pcall(function() --[[ Line: 240 | Upvalues: v2 (copy), Animation (copy) ]]
			return v2:LoadAnimation(Animation)
		end)

		if not (ok and result) then
			warn(("[EquipAnim] failed to load %s"):format((tostring(animId))))

			return
		end

		p1._tracks[animId] = result
		v6 = result
	end

	v6.Priority = Enum.AnimationPriority.Action4
	v6.Looped = false

	local v7 = p2.speed or 1

	v6:Play(EquipAnimConfig.BlendTime)

	if v3 then
		v6.TimePosition = v6.Length
		v6:AdjustSpeed(-v7)
	else
		v6:AdjustSpeed(v7)
	end

	p1._activeTrack = v6
	p1:_bindCancels(v6)
end
function t._buildSoundMap(p1) --[[ _buildSoundMap | Line: 287 | Upvalues: EquipAnimConfig (copy) ]]
	local t = {}
	local t2 = {}

	local function addFor(p1, p2, p3) --[[ addFor | Line: 290 | Upvalues: EquipAnimConfig (ref), t (copy), t2 (copy) ]]
		if not (if type(p2) == "string" and p2 ~= EquipAnimConfig.PLACEHOLDER then if p2:match("^rbxassetid://%d+$") == nil then false else true else false) then
			return
		end

		if type(p3) ~= "table" or next(p3) == nil then
			return
		end

		if t[p2] and t[p2] ~= p3 then
			warn(("[EquipAnim] two entries share %s with different sounds (%s vs %s); %s wins"):format(p2, t2[p2], p1, p1))
		end

		t[p2] = p3
		t2[p2] = p1
	end

	local function addAll(p1, p2) --[[ addAll | Line: 304 | Upvalues: addFor (copy) ]]
		local list = {}

		for k in pairs(p1) do
			list[#list + 1] = k
		end

		table.sort(list)

		for i, v in ipairs(list) do
			local v1 = p1[v]

			if type(v1) == "table" then
				addFor(p2 .. "." .. v, v1.animId, v1.sounds)
				addFor(p2 .. "." .. v, v1.unequipAnimId, v1.sounds)
			end
		end
	end

	addAll(EquipAnimConfig.ByType, "ByType")
	addAll(EquipAnimConfig.ByItem, "ByItem")

	return t
end
function t._playMarkerSound(p1, p2, p3) --[[ _playMarkerSound | Line: 324 | Upvalues: EquipAnimConfig (copy) ]]
	if not (p3 and p3.Parent) then
		return
	end

	local v1

	if type(p2) == "table" then
		if #p2 == 0 then
			return
		end

		v1 = p2[math.random(#p2)]
	else
		v1 = p2
	end

	if type(v1) ~= "string" or v1 == "" then
		return
	end

	local v2 = p3:FindFirstChild("HumanoidRootPart") or (p3:FindFirstChild("Torso") or p3:FindFirstChildWhichIsA("BasePart"))

	if v2 then
		local Sound = Instance.new("Sound")

		Sound.SoundId = v1
		Sound.Volume = EquipAnimConfig.SoundVolume
		Sound.RollOffMaxDistance = EquipAnimConfig.SoundMaxDistance
		Sound.Parent = v2
		Sound:Play()
		Sound.Ended:Connect(function() --[[ Line: 349 | Upvalues: Sound (copy) ]]
			Sound:Destroy()
		end)
		game:GetService("Debris"):AddItem(Sound, 10)
	end
end
function t._bindMarkerSounds(p1, p2, p3, p4) --[[ _bindMarkerSounds | Line: 353 | Upvalues: EquipAnimConfig (copy) ]]
	if p1._boundTracks[p2] then
		return
	end

	p1._boundTracks[p2] = true

	for k, v in pairs(p3) do
		p2:GetMarkerReachedSignal(k):Connect(function() --[[ Line: 362 | Upvalues: p2 (copy), EquipAnimConfig (ref), p1 (copy), v (copy), p4 (copy) ]]
			if not (p2.Speed < 0) or EquipAnimConfig.SoundsOnUnequip then
				p1:_playMarkerSound(v, p4)
			end
		end)
	end
end
function t._hookAnimator(p1, p2, p3) --[[ _hookAnimator | Line: 371 ]]
	if p2 and not p1._hookedAnimators[p2] then
		p1._hookedAnimators[p2] = true
		p2.AnimationPlayed:Connect(function(p12) --[[ Line: 375 | Upvalues: p1 (copy), p3 (copy) ]]
			local v1 = if p12 then p12.Animation else p12
			local v2 = if v1 then v1.AnimationId else v1

			if not v2 then
				return
			end

			local v3 = p1._soundMap[v2]

			if v3 then
				p1:_bindMarkerSounds(p12, v3, p3)
			end
		end)
	end
end
function t._watchCharacter(p1, p2) --[[ _watchCharacter | Line: 387 ]]
	if not p2 then
		return
	end

	local v1 = p2:FindFirstChildOfClass("Humanoid") or p2:WaitForChild("Humanoid", 10)

	if not v1 then
		return
	end

	local v2 = v1:FindFirstChildOfClass("Animator") or v1:WaitForChild("Animator", 10)

	if v2 then
		p1:_hookAnimator(v2, p2)
	end
end
function t._watchPlayer(p1, p2) --[[ _watchPlayer | Line: 398 ]]
	if p2.Character then
		task.spawn(function() --[[ Line: 400 | Upvalues: p1 (copy), p2 (copy) ]]
			p1:_watchCharacter(p2.Character)
		end)
	end

	p2.CharacterAdded:Connect(function(p12) --[[ Line: 402 | Upvalues: p1 (copy) ]]
		task.spawn(function() --[[ Line: 403 | Upvalues: p1 (ref), p12 (copy) ]]
			p1:_watchCharacter(p12)
		end)
	end)
end
function t._preload(p1) --[[ _preload | Line: 412 | Upvalues: EquipAnimConfig (copy), log (copy), ContentProvider (copy) ]]
	local t = {}
	local t2 = {}

	local function addId(p1) --[[ addId | Line: 415 | Upvalues: EquipAnimConfig (ref), t (copy), t2 (copy) ]]
		if not (if type(p1) == "string" and p1 ~= EquipAnimConfig.PLACEHOLDER then if p1:match("^rbxassetid://%d+$") == nil then false else true else false) then
			return
		end

		if not t[p1] then
			t[p1] = true

			local Animation = Instance.new("Animation")

			Animation.AnimationId = p1
			t2[#t2 + 1] = Animation
		end
	end

	local function addEntry(p1) --[[ addEntry | Line: 424 | Upvalues: EquipAnimConfig (ref), t (copy), t2 (copy) ]]
		if type(p1) ~= "table" then
			return
		end

		local animId = p1.animId

		if (if type(animId) == "string" and animId ~= EquipAnimConfig.PLACEHOLDER then if animId:match("^rbxassetid://%d+$") == nil then false else true else false) and not t[animId] then
			t[animId] = true

			local Animation = Instance.new("Animation")

			Animation.AnimationId = animId
			t2[#t2 + 1] = Animation
		end

		local unequipAnimId = p1.unequipAnimId

		if not (if type(unequipAnimId) == "string" and unequipAnimId ~= EquipAnimConfig.PLACEHOLDER then if unequipAnimId:match("^rbxassetid://%d+$") == nil then false else true else false) then
			return
		end

		if not t[unequipAnimId] then
			t[unequipAnimId] = true

			local Animation = Instance.new("Animation")

			Animation.AnimationId = unequipAnimId
			t2[#t2 + 1] = Animation
		end
	end

	local function addSounds(p1) --[[ addSounds | Line: 430 | Upvalues: t (copy), t2 (copy) ]]
		if type(p1) ~= "table" then
			return
		end

		if type(p1.sounds) ~= "table" then
			return
		end

		for k, v in pairs(p1.sounds) do
			local v1

			v1 = if type(v) == "table" and v then v else { v }

			for i, v2 in ipairs(v1) do
				if type(v2) == "string" and (v2 ~= "" and not t[v2]) then
					t[v2] = true

					local Sound = Instance.new("Sound")

					Sound.SoundId = v2
					t2[#t2 + 1] = Sound
				end
			end
		end
	end

	for k, v in pairs(EquipAnimConfig.ByType) do
		if type(v) == "table" then
			local animId = v.animId

			if (if type(animId) == "string" and animId ~= EquipAnimConfig.PLACEHOLDER then if animId:match("^rbxassetid://%d+$") == nil then false else true else false) and not t[animId] then
				t[animId] = true

				local Animation = Instance.new("Animation")

				Animation.AnimationId = animId
				t2[#t2 + 1] = Animation
			end

			local unequipAnimId = v.unequipAnimId

			if (if type(unequipAnimId) == "string" and unequipAnimId ~= EquipAnimConfig.PLACEHOLDER then if unequipAnimId:match("^rbxassetid://%d+$") == nil then false else true else false) and not t[unequipAnimId] then
				t[unequipAnimId] = true

				local Animation = Instance.new("Animation")

				Animation.AnimationId = unequipAnimId
				t2[#t2 + 1] = Animation
			end
		end

		addSounds(v)
	end

	for k, v in pairs(EquipAnimConfig.ByItem) do
		if type(v) == "table" then
			local animId = v.animId

			if (if type(animId) == "string" and animId ~= EquipAnimConfig.PLACEHOLDER then if animId:match("^rbxassetid://%d+$") == nil then false else true else false) and not t[animId] then
				t[animId] = true

				local Animation = Instance.new("Animation")

				Animation.AnimationId = animId
				t2[#t2 + 1] = Animation
			end

			local unequipAnimId = v.unequipAnimId

			if (if type(unequipAnimId) == "string" and unequipAnimId ~= EquipAnimConfig.PLACEHOLDER then if unequipAnimId:match("^rbxassetid://%d+$") == nil then false else true else false) and not t[unequipAnimId] then
				t[unequipAnimId] = true

				local Animation = Instance.new("Animation")

				Animation.AnimationId = unequipAnimId
				t2[#t2 + 1] = Animation
			end
		end

		addSounds(v)
	end

	if #t2 == 0 then
		log("nothing to preload (all entries are placeholders)")
	else
		task.spawn(function() --[[ Line: 453 | Upvalues: ContentProvider (ref), t2 (copy), log (ref) ]]
			pcall(function() --[[ Line: 454 | Upvalues: ContentProvider (ref), t2 (ref) ]]
				ContentProvider:PreloadAsync(t2)
			end)
			log("preloaded %d animation(s)", #t2)
		end)
	end
end
function t.Init(p1) --[[ Init | Line: 461 | Upvalues: ReplicatedStorage (copy), EquipAnimConfig (copy), LocalPlayer (copy), Players (copy), log (copy) ]]
	if p1._started then
		return
	end

	p1._started = true

	local EquipAnimEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("EquipAnimEvent", 30)

	if not EquipAnimEvent then
		warn("[EquipAnim] Remotes.EquipAnimEvent never appeared -- is EquipAnimRelay running?")

		return
	end

	EquipAnimEvent.OnClientEvent:Connect(function(p12, p2, p3) --[[ Line: 472 | Upvalues: p1 (copy) ]]
		p1:_onEquipmentEvent(p12, p2, p3)
	end)

	local function onCharacter() --[[ onCharacter | Line: 476 | Upvalues: p1 (copy), EquipAnimConfig (ref) ]]
		p1._suppressUntil = os.clock() + EquipAnimConfig.SpawnSuppress
		p1:StopAnim()
		table.clear(p1._tracks)
		p1._activeTrack = nil
		table.clear(p1._lastEquipped)
	end

	if LocalPlayer.Character then
		p1._suppressUntil = os.clock() + EquipAnimConfig.SpawnSuppress
		p1:StopAnim()
		table.clear(p1._tracks)
		p1._activeTrack = nil
		table.clear(p1._lastEquipped)
	end

	LocalPlayer.CharacterAdded:Connect(onCharacter)
	p1._soundMap = p1:_buildSoundMap()

	if next(p1._soundMap) ~= nil then
		for i, v in ipairs(Players:GetPlayers()) do
			p1:_watchPlayer(v)
		end

		Players.PlayerAdded:Connect(function(p12) --[[ Line: 496 | Upvalues: p1 (copy) ]]
			p1:_watchPlayer(p12)
		end)

		local count = 0

		for k in pairs(p1._soundMap) do
			count = count + 1
		end

		log("marker sounds active for %d animation(s)", count)
	end

	p1:_preload()
	print("[EquipAnim] ready")
end

return t