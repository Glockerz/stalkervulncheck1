-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local t2 = {}

function t.Weld(p1, p2, p3, p4, p5) --[[ Weld | Line: 4 ]]
	local WeldConstraint = Instance.new("WeldConstraint")

	WeldConstraint.Part0 = p1
	WeldConstraint.Part1 = p2

	local v1, v2

	if p4 then
		v1 = WeldConstraint
		v2 = p4
	else
		v2 = WeldConstraint.Name
		v1 = WeldConstraint
	end

	v1.Name = v2
	v1.Parent = p3 or p1
end
function t.LoadAnimation(p1, p2) --[[ LoadAnimation | Line: 12 ]]
	local Animation = Instance.new("Animation")

	Animation.AnimationId = p1

	return p2:LoadAnimation(Animation)
end
function t.PlayAnimation(p1, p2) --[[ PlayAnimation | Line: 19 | Upvalues: t2 (copy) ]]
	p1:Play()
	p1.Priority = p2.AnimationPriority
	p1:AdjustSpeed(p2.AnimationSpeed)
	p1.Looped = p2.Looped

	if t2[p1] then
		return
	end

	t2[p1] = true

	for k, v in pairs(p2.AnimationEvents) do
		p1:GetPropertyChangedSignal(v.AnimationEventName):Connect(function() --[[ Line: 27 | Upvalues: v (copy) ]]
			v.Function()
		end)
	end
end
function t.Random(p1, p2) --[[ Random | Line: 33 ]]
	return Random.new():NextNumber(p1, p2)
end
function t.ReturnRandom(p1) --[[ ReturnRandom | Line: 36 ]]
	return p1[math.random(#p1)]
end
function t.ReturnChildren(p1) --[[ ReturnChildren | Line: 39 ]]
	return p1:GetChildren()
end
function t.ReturnFolderChild(p1) --[[ ReturnFolderChild | Line: 42 | Upvalues: t (copy) ]]
	return t.ReturnRandom(t.ReturnChildren(p1))
end
function t.PlaySound(p1, p2) --[[ PlaySound | Line: 45 ]]
	local v1 = p1:Clone()

	v1.Parent = p2
	v1:Play()
	v1.Ended:Connect(function() --[[ Line: 49 | Upvalues: v1 (copy) ]]
		v1:Destroy()
	end)
end

return t