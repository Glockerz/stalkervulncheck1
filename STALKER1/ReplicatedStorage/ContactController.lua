-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SocialService = game:GetService("SocialService")
local LocalPlayer = Players.LocalPlayer
local ContactRemotes = ReplicatedStorage:WaitForChild("ContactRemotes")
local t = {
	_record = {
		schema_version = 1,
		contacts = {}
	},
	_listeners = {},
	_canInvite = false,
	_initialized = false
}

local function broadcast() --[[ broadcast | Line: 15 | Upvalues: t (copy) ]]
	for i, v in ipairs(t._listeners) do
		task.spawn(v, t._record)
	end
end

function t.GetRecord(p1) --[[ GetRecord | Line: 21 ]]
	return p1._record
end
function t.GetContacts(p1, p2) --[[ GetContacts | Line: 25 ]]
	local t = {}

	for k, v in pairs(p1._record.contacts) do
		if not p2 or v.type == p2 then
			table.insert(t, v)
		end
	end

	table.sort(t, function(p1, p2) --[[ Line: 33 ]]
		return (p2.lastSeenAt or (p2.lastInteractedAt or (p2.addedAt or 0))) < (p1.lastSeenAt or (p1.lastInteractedAt or (p1.addedAt or 0)))
	end)

	return t
end
function t.GetContact(p1, p2) --[[ GetContact | Line: 41 ]]
	return p1._record.contacts[p2]
end
function t.OnChanged(p1, p2) --[[ OnChanged | Line: 45 ]]
	table.insert(p1._listeners, p2)
	task.spawn(p2, p1._record)
end
function t.CanInviteFriends(p1) --[[ CanInviteFriends | Line: 50 ]]
	return p1._canInvite
end
function t.SetToastHandler(p1, p2) --[[ SetToastHandler | Line: 54 ]]
	p1._toastFn = p2
end
function t.PromptInviteFriends(p1) --[[ PromptInviteFriends | Line: 58 | Upvalues: SocialService (copy), LocalPlayer (copy) ]]
	if not p1._canInvite then
		return
	end

	local ok, result = pcall(function() --[[ Line: 60 | Upvalues: SocialService (ref), LocalPlayer (ref) ]]
		SocialService:PromptGameInvite(LocalPlayer)
	end)

	if ok then
		return
	end

	warn("[ContactController] PromptGameInvite failed: " .. tostring(result))
end

local function refreshCanInvite() --[[ refreshCanInvite | Line: 68 | Upvalues: SocialService (copy), LocalPlayer (copy), t (copy) ]]
	local ok, result = pcall(function() --[[ Line: 69 | Upvalues: SocialService (ref), LocalPlayer (ref) ]]
		return SocialService:CanSendGameInviteAsync(LocalPlayer)
	end)

	if not ok then
		return
	end

	t._canInvite = result and true or false
end

function t.Init(p1) --[[ Init | Line: 77 | Upvalues: ContactRemotes (copy), broadcast (copy), SocialService (copy), LocalPlayer (copy), t (copy) ]]
	if not p1._initialized then
		p1._initialized = true
		task.spawn(function() --[[ Line: 82 | Upvalues: ContactRemotes (ref), p1 (copy), broadcast (ref) ]]
			local ok, result = pcall(function() --[[ Line: 83 | Upvalues: ContactRemotes (ref) ]]
				return ContactRemotes.RequestContactList:InvokeServer()
			end)

			if not (ok and result) then
				return
			end

			p1._record = result
			broadcast()
		end)
		ContactRemotes.OnContactsUpdated.OnClientEvent:Connect(function(p12) --[[ Line: 93 | Upvalues: p1 (copy), broadcast (ref) ]]
			if p12 and p12._toast then
				if not p1._toastFn then
					return
				end

				p1._toastFn(p12.text)
			else
				if not p12 then
					return
				end

				p1._record = p12
				broadcast()
			end
		end)
		task.spawn(function() --[[ Line: 105 | Upvalues: SocialService (ref), LocalPlayer (ref), t (ref) ]]
			local ok, result = pcall(function() --[[ Line: 69 | Upvalues: SocialService (ref), LocalPlayer (ref) ]]
				return SocialService:CanSendGameInviteAsync(LocalPlayer)
			end)

			if ok then
				t._canInvite = result and true or false
			end

			while true do
				local v3, v4

				repeat
					task.wait(60)
					v3, v4 = pcall(function() --[[ Line: 69 | Upvalues: SocialService (ref), LocalPlayer (ref) ]]
						return SocialService:CanSendGameInviteAsync(LocalPlayer)
					end)
				until v3

				t._canInvite = v4 and true or false
			end
		end)
	end
end

return t