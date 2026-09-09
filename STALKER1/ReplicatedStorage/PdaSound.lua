-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = {}
local t2 = {}

(function() --[[ indexFolder | Line: 10 | Upvalues: ReplicatedStorage (copy), t2 (copy) ]]
	local v1 = nil

	for i, v in ipairs(ReplicatedStorage:GetChildren()) do
		if string.lower(v.Name) == "pdasounds" then
			v1 = v

			break
		end
	end

	if not v1 then
		warn("[PdaSound] Pdasounds folder not found in ReplicatedStorage")

		return
	end

	for i, v in ipairs(v1:GetDescendants()) do
		if v:IsA("Sound") then
			t2[string.lower(v.Name)] = v
		end
	end
end)()
function t.Play(p1, p2) --[[ Play | Line: 30 | Upvalues: t2 (copy), SoundService (copy) ]]
	if not p1 then
		return nil
	end

	local v1 = t2[string.lower(p1)]

	if not v1 then
		return nil
	end

	local v2 = v1:Clone()

	if p2 then
		v2.Volume = p2
	end

	v2.Looped = false
	v2.Parent = SoundService
	v2:Play()

	local v3 = nil

	v3 = v2.Ended:Connect(function() --[[ Line: 40 | Upvalues: v3 (ref), v2 (copy) ]]
		if v3 then
			v3:Disconnect()
			v3 = nil
		end

		v2:Destroy()
	end)

	local v4 = task.delay

	v4((v2.TimeLength > 0 and v2.TimeLength or 3) + 1, function() --[[ Line: 45 | Upvalues: v2 (copy), v3 (ref) ]]
		if not v2.Parent then
			return
		end

		if v3 then
			v3:Disconnect()
			v3 = nil
		end

		v2:Destroy()
	end)

	return v2
end

local v1 = nil

function t.PlayClick(p1) --[[ PlayClick | Line: 57 | Upvalues: t2 (copy), v1 (ref), SoundService (copy) ]]
	local pda_click = t2.pda_click

	if not pda_click then
		return
	end

	if not (v1 and v1.Parent) then
		v1 = pda_click:Clone()
		v1.Name = "PdaClickChannel"
		v1.Looped = false
		v1.Parent = SoundService
	end

	v1:Stop()
	v1.Volume = p1 or 5
	v1:Play()
end

return t