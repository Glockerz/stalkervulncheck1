-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	Weld = function(p1, p2) --[[ Line: 5 ]]
		local Weld = Instance.new("Weld")

		Weld.Part0 = p1
		Weld.Part1 = p2
		Weld.C0 = p1.CFrame:ToObjectSpace(p2.CFrame)
		Weld.Name = p1.Name .. "_" .. p2.Name
		Weld.Parent = p1
		p2.Anchored = false

		return Weld
	end,
	M6D = function(p1, p2) --[[ Line: 17 ]]
		local Motor6D = Instance.new("Motor6D")

		Motor6D.Part0 = p1
		Motor6D.Part1 = p2
		Motor6D.C0 = p1.CFrame:ToObjectSpace(p2.CFrame)
		Motor6D.Name = p1.Name .. "_" .. p2.Name
		Motor6D.Parent = p1
		p2.Anchored = false

		return Motor6D
	end,
	BlankM6D = function(p1, p2) --[[ Line: 28 ]]
		local Motor6D = Instance.new("Motor6D")

		Motor6D.Part0 = p1
		Motor6D.Part1 = p2
		Motor6D.Name = p1.Name .. "_" .. p2.Name
		Motor6D.Parent = p1
		p2.Anchored = false

		return Motor6D
	end
}

function t.WeldModel(p1, p2, p3) --[[ Line: 39 | Upvalues: t (copy) ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("BasePart") and v ~= p2 then
			t.Weld(p2, v)
			v.CanCollide = p3
		end
	end
end
function t.WeldDescendants(p1, p2, p3) --[[ Line: 49 | Upvalues: t (copy) ]]
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") and v ~= p2 then
			t.Weld(p2, v)
			v.CanCollide = p3
		end
	end
end
function t.AutoWeldModel(p1, p2, p3, p4) --[[ Line: 59 | Upvalues: t (copy) ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("BasePart") and (v ~= p2 and not table.find(p4, v.Name)) then
			t.Weld(p2, v)

			if p3 then
				v.CanCollide = false
			end

			t.AutoWeldModel(v, v, p3)
		end
	end
end
function t.BlankWeld(p1, p2) --[[ Line: 87 ]]
	local Weld = Instance.new("Weld")

	Weld.Part0 = p1
	Weld.Part1 = p2
	Weld.Name = p1.Name .. "_" .. p2.Name
	Weld.Parent = p1
	p2.Anchored = false

	return Weld
end

return t