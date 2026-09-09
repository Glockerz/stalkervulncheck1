-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")

game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local t = {
	_encounters = {},
	_listeners = {},
	_initialized = false,
	GetList = function(p1) --[[ GetList | Line: 16 ]]
		local v1 = os.time()

		for k, v in pairs(p1._encounters) do
			if v1 - v.lastSeen > 3600 then
				p1._encounters[k] = nil
			end
		end

		local t = {}

		for k, v in pairs(p1._encounters) do
			table.insert(t, {
				userId = k,
				name = v.name,
				displayName = v.displayName,
				lastSeen = v.lastSeen,
				lastDistance = v.lastDistance
			})
		end

		table.sort(t, function(p1, p2) --[[ Line: 35 ]]
			return p1.lastSeen > p2.lastSeen
		end)

		return t
	end,
	OnChanged = function(p1, p2) --[[ OnChanged | Line: 39 ]]
		table.insert(p1._listeners, p2)
		task.spawn(p2, p1:GetList())
	end
}

local function broadcast() --[[ broadcast | Line: 44 | Upvalues: t (copy) ]]
	local v1 = t:GetList()

	for i, v in ipairs(t._listeners) do
		task.spawn(v, v1)
	end
end

local function scan() --[[ scan | Line: 51 | Upvalues: LocalPlayer (copy), Players (copy), t (copy), broadcast (copy) ]]
	local Character = LocalPlayer.Character
	local v1 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

	if not v1 then
		return
	end

	local v2 = os.time()
	local v3 = false

	for i, v in ipairs(Players:GetPlayers()) do
		if v ~= LocalPlayer then
			local Character2 = v.Character
			local v4 = if Character2 then Character2:FindFirstChild("HumanoidRootPart") else Character2

			if v4 then
				local Magnitude = (v4.Position - v1.Position).Magnitude

				if Magnitude <= 100 then
					t._encounters[v.UserId] = {
						name = v.Name,
						displayName = v.DisplayName,
						lastSeen = v2,
						lastDistance = math.floor(Magnitude)
					}
					v3 = true
				end
			end
		end
	end

	if not v3 then
		return
	end

	broadcast()
end

function t.Init(p1) --[[ Init | Line: 78 | Upvalues: scan (copy) ]]
	if not p1._initialized then
		p1._initialized = true
		task.spawn(function() --[[ Line: 81 | Upvalues: scan (ref) ]]
			while true do
				task.wait(5)
				scan()
			end
		end)
	end
end

return t