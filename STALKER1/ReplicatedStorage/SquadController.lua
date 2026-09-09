-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local SquadRemotes = ReplicatedStorage:WaitForChild("SquadRemotes")
local t = {
	_squad = nil,
	_listeners = {},
	_invite = nil,
	_inviteListeners = {},
	_initialized = false
}

local function broadcast() --[[ broadcast | Line: 15 | Upvalues: t (copy) ]]
	for i, v in ipairs(t._listeners) do
		task.spawn(v, t._squad)
	end
end

local function broadcastInvite() --[[ broadcastInvite | Line: 20 | Upvalues: t (copy) ]]
	for i, v in ipairs(t._inviteListeners) do
		task.spawn(v, t._invite)
	end
end

function t.GetSquad(p1) --[[ GetSquad | Line: 26 ]]
	return p1._squad
end
function t.IsLeader(p1) --[[ IsLeader | Line: 29 | Upvalues: LocalPlayer (copy) ]]
	return p1._squad and p1._squad.leader_id == LocalPlayer.UserId
end
function t.IsInSquad(p1) --[[ IsInSquad | Line: 32 ]]
	return p1._squad ~= nil
end
function t.GetMemberIds(p1) --[[ GetMemberIds | Line: 35 ]]
	if not p1._squad then
		return {}
	end

	local t = {}

	for k in pairs(p1._squad.members) do
		table.insert(t, k)
	end

	return t
end
function t.GetMembersInSamePlace(p1) --[[ GetMembersInSamePlace | Line: 43 ]]
	if not p1._squad then
		return {}
	end

	local t = {}

	for k, v in pairs(p1._squad.members) do
		if v.current_place == game.PlaceId then
			table.insert(t, k)
		end
	end

	return t
end
function t.OnChanged(p1, p2) --[[ OnChanged | Line: 53 ]]
	table.insert(p1._listeners, p2)
	task.spawn(p2, p1._squad)
end
function t.GetPendingInvite(p1) --[[ GetPendingInvite | Line: 57 ]]
	return p1._invite
end
function t.OnInviteChanged(p1, p2) --[[ OnInviteChanged | Line: 60 ]]
	table.insert(p1._inviteListeners, p2)
	task.spawn(p2, p1._invite)
end
function t.Invite(p1, p2) --[[ Invite | Line: 66 | Upvalues: SquadRemotes (copy) ]]
	return SquadRemotes.Invite:InvokeServer(p2)
end
function t.AcceptInvite(p1) --[[ AcceptInvite | Line: 69 | Upvalues: SquadRemotes (copy), broadcastInvite (copy) ]]
	if not p1._invite then
		return {
			ok = false,
			error = "no_invite"
		}
	end

	local v1 = SquadRemotes.AcceptInvite:InvokeServer(p1._invite.squadId)

	if v1 and v1.ok then
		p1._invite = nil
		broadcastInvite()
	end

	return v1
end
function t.DeclineInvite(p1) --[[ DeclineInvite | Line: 79 | Upvalues: SquadRemotes (copy), broadcastInvite (copy) ]]
	if p1._invite then
		SquadRemotes.DeclineInvite:FireServer()
		p1._invite = nil
		broadcastInvite()
	end
end
function t.Leave(p1) --[[ Leave | Line: 85 | Upvalues: SquadRemotes (copy) ]]
	return SquadRemotes.Leave:InvokeServer()
end
function t.Kick(p1, p2) --[[ Kick | Line: 88 | Upvalues: SquadRemotes (copy) ]]
	return SquadRemotes.Kick:InvokeServer(p2)
end
function t.Init(p1) --[[ Init | Line: 92 | Upvalues: SquadRemotes (copy), broadcast (copy), t (copy), broadcastInvite (copy), LocalPlayer (copy) ]]
	if not p1._initialized then
		p1._initialized = true
		SquadRemotes.OnSquadUpdated.OnClientEvent:Connect(function(p12) --[[ Line: 96 | Upvalues: p1 (copy), broadcast (ref), t (ref) ]]
			if p12 and p12._cleared then
				p1._squad = nil
				broadcast()

				if p12._toast and t._toastFn then
					t._toastFn(p12.text)
				end
			elseif p12 and p12._toast then
				if t._toastFn then
					t._toastFn(p12.text)
				end
			else
				p1._squad = p12
				broadcast()
			end
		end)
		SquadRemotes.OnInviteOffered.OnClientEvent:Connect(function(p12) --[[ Line: 113 | Upvalues: p1 (copy), broadcastInvite (ref) ]]
			local v1 = p1
			local t = {
				squadId = p12.id,
				squadIdRaw = p12.id
			}

			t.fromName = p12.fromName or p12.leaderName or "Someone"
			t.leaderName = p12.leaderName
			t.memberCount = p12.memberCount
			t.maxMembers = p12.maxMembers
			t.expires_at = os.time() + 60
			v1._invite = t
			broadcastInvite()

			local _invite = p1._invite

			task.delay(60, function() --[[ Line: 126 | Upvalues: p1 (ref), _invite (copy), broadcastInvite (ref) ]]
				if p1._invite ~= _invite then
					return
				end

				p1._invite = nil
				broadcastInvite()
			end)
		end)
		SquadRemotes.OnMemberPlaceChanged.OnClientEvent:Connect(function(p12, p2) --[[ Line: 134 | Upvalues: p1 (copy), broadcast (ref) ]]
			if not (p1._squad and p1._squad.members[p12]) then
				return
			end

			p1._squad.members[p12].current_place = p2
			broadcast()
		end)
		task.spawn(function() --[[ Line: 142 | Upvalues: SquadRemotes (ref), p1 (copy), broadcast (ref) ]]
			local v1 = SquadRemotes.RequestSquadState:InvokeServer()

			if not v1 then
				return
			end

			p1._squad = v1.squad
			broadcast()
		end)
		task.spawn(function() --[[ Line: 151 | Upvalues: SquadRemotes (ref), p1 (copy), broadcast (ref) ]]
			while true do
				task.wait(60)
				pcall(function() --[[ Line: 154 | Upvalues: SquadRemotes (ref), p1 (ref), broadcast (ref) ]]
					local v1 = SquadRemotes.RequestSquadState:InvokeServer()

					if not v1 then
						return
					end

					p1._squad = v1.squad
					broadcast()
				end)
			end
		end)
		LocalPlayer.CharacterAdded:Connect(function() --[[ Line: 165 | Upvalues: SquadRemotes (ref), p1 (copy), broadcast (ref) ]]
			task.spawn(function() --[[ Line: 166 | Upvalues: SquadRemotes (ref), p1 (ref), broadcast (ref) ]]
				local v1 = SquadRemotes.RequestSquadState:InvokeServer()

				if not v1 then
					return
				end

				p1._squad = v1.squad
				broadcast()
			end)
		end)
	end
end
function t.SetToastHandler(p1, p2) --[[ SetToastHandler | Line: 177 | Upvalues: t (copy) ]]
	t._toastFn = p2
end
function t.ShowToast(p1, p2) --[[ ShowToast | Line: 181 | Upvalues: t (copy) ]]
	if not t._toastFn then
		return
	end

	t._toastFn(p2)
end

return t