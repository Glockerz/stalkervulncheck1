-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

function t.new(p1) --[[ new | Line: 3 | Upvalues: t (copy) ]]
	local t2 = {
		swaySpring = p1.new(),
		recoilSpring = p1.new(),
		gunRecoilSpring = p1.new()
	}

	t2.recoilSpring.Damping = 9
	t2.gunRecoilSpring.Damping = 9

	return setmetatable(t2, {
		__index = t
	})
end
function t.applyBreathing(p1, p2, p3, p4, p5) --[[ applyBreathing | Line: 15 ]]
	local v1 = tick() * 0.15
	local breathingDist = p5.breathingDist

	if p4 then
		breathingDist = breathingDist * p5.breathingAimMultiplier
	end

	p2.CFrame = p2.CFrame * CFrame.new(breathingDist * math.sin(v1 * p5.breathingSpeed / 2), breathingDist * math.sin(v1 * p5.breathingSpeed), 0)
end
function t.applyRattle(p1, p2, p3, p4, p5) --[[ applyRattle | Line: 27 ]]
	p4.rattle = math.max(p4.rattle - p3 * 3, 0)

	if not (p4.rattle > 0) then
		return
	end

	local v2 = p4.rattle * 0.035
	local v3 = if p5 then 0.3 else 1

	p2.CFrame = p2.CFrame * (CFrame.new((math.random() - 0.5) * v2 * v3, (math.random() - 0.5) * v2 * v3, (math.random() - 0.5) * v2 * v3) * CFrame.Angles((math.random() - 0.5) * v2 * 0.6 * v3, (math.random() - 0.5) * v2 * 0.6 * v3, (math.random() - 0.5) * v2 * 0.6 * v3))
end
function t.applyGunRecoil(p1, p2, p3, p4) --[[ applyGunRecoil | Line: 45 ]]
	local v1 = p1.gunRecoilSpring:update(p3)
	local v3 = Vector3.new(math.max(0, v1.X), v1.Y, v1.Z)
	local v4 = p4.gripPivotOffset or Vector3.new(0, -0.3, 0.5)
	local v6 = CFrame.new(v4)
	local Angles = CFrame.Angles
	local v7 = math.rad(v3.X)

	p2.CFrame = p2.CFrame * (v6 * Angles(v7, math.rad(v3.Y), 0) * CFrame.new(-v4))
	p2.CFrame = p2.CFrame * CFrame.new(0, 0, v3.Z)
end
function t.applyCameraRecoil(p1, p2, p3, p4) --[[ applyCameraRecoil | Line: 56 ]]
	p4.accum = p4.accum + p3

	if not (p4.accum >= 0.015384615384615385) then
		return
	end

	local v1 = p1.recoilSpring:update(p4.accum)
	local v3 = Vector3.new(math.max(0, v1.X), v1.Y, v1.Z)

	p4.camRecoil = CFrame.Angles(math.rad(v3.X), math.rad(v3.Y), (math.rad(v3.Z)))
	p2.CFrame = p2.CFrame * p4.camRecoil
	p4.accum = 0
end
function t.applyLowReady(p1, p2, p3, p4, p5, p6) --[[ applyLowReady | Line: 68 ]]
	local v1 = tick()

	if p5 then
		p4.lastActive = v1
	end

	local v2 = if v1 - p4.lastActive > 3 and not p5 then 1 else 0

	p4.lowReady = p4.lowReady + (v2 - p4.lowReady) * (1 - (1 - (if p4.lowReady < v2 then 0.03 else 0.15)) ^ (p3 * 60))
	p6:SetAttribute("LowReady", p4.lowReady)

	if not (p4.lowReady > 0.001) then
		return
	end

	local Angles = CFrame.Angles

	p2.CFrame = p2.CFrame * (Angles(math.rad(-8 * p4.lowReady), 0, 0) * CFrame.new(0, -0.1 * p4.lowReady, 0))
end
function t.applySway(p1, p2, p3, p4) --[[ applySway | Line: 83 ]]
	p1.swaySpring:shove((Vector3.new(-p4.X / 300, p4.Y / 160, 0)))

	local v3 = p1.swaySpring:update(p3)

	p2.CFrame = p2.CFrame * CFrame.new(v3.X, v3.Y, 0)
end

return t