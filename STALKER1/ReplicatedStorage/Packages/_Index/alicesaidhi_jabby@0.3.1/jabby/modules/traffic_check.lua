-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local t = {}
local t2 = {}
local v1, v2 = require(script.Parent.signal)()

function t.can_use_jabby(p1) --[[ Line: 19 ]]
	return game:GetService("RunService"):IsStudio()
end

local function communication_is_allowed(p1, p2, p3) --[[ communication_is_allowed | Line: 27 | Upvalues: t2 (copy), t (copy) ]]
	if p1 == "server" then
		return true
	end

	t2[p1] = t2[p1] or {}
	t2[p2] = t2[p2] or {}

	if not (t.can_use_jabby(p1) or t2[p1][p2]) then
		return false
	end

	if not p3 then
		t2[p2][p1] = p1
	end

	return true
end

local function check(p1, p2, p3) --[[ check | Line: 44 | Upvalues: communication_is_allowed (copy), v2 (copy) ]]
	if communication_is_allowed(p1, p2, p3) then
		return true
	end

	v2(p1)

	return false
end

local function check_no_wl(p1) --[[ check_no_wl | Line: 53 | Upvalues: t (copy), v2 (copy) ]]
	if p1 == "server" then
		return true
	end

	if t.can_use_jabby(p1) then
		return true
	end

	v2(p1)

	return false
end

local function _whitelist(p1, p2) --[[ _whitelist | Line: 64 | Upvalues: t2 (copy) ]]
	t2[p1] = t2[p1] or {}
	t2[p2] = t2[p2] or {}
	t2[p1][p2] = p1
end

t.communication_is_allowed = communication_is_allowed
t.check_no_wl = check_no_wl
t.check = check
t._whitelist = _whitelist
t.on_fail = v1
Players.PlayerRemoving:Connect(function(p1) --[[ Line: 78 | Upvalues: t2 (copy) ]]
	t2[p1] = nil
end)

return t