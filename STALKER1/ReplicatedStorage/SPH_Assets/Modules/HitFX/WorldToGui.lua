-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	_DESCRIPTION = "\t\tWorldPositionToGuiPosition by orange451\n\t\t\n\t\tThis script can take a part and a world position, and output Surface Gui data.\n\t\tUseful for clippable bulletholes.\n\t\t\n\t\tUsage:\n\t\t\tWorldPositionToGuiPosition( Part, WorldPosition )\n\t\t\n\t\tReturns:\n\t\t\t- Surface\n\t\t\t- Width of surface\n\t\t\t- Height of surface\n\t\t\t- Relative X Position WorldPosition\n\t\t\t- Relative Y Position WorldPosition\n\t",
	_LICENSE = "\t\tMIT LICENSE\n\n\t\tCopyright (c) 2017 Andrew Hamilton\n\n\t\tPermission is hereby granted, free of charge, to any person obtaining a\n\t\tcopy of this software and associated documentation files (the\n\t\t\"Software\"), to deal in the Software without restriction, including\n\t\twithout limitation the rights to use, copy, modify, merge, publish,\n\t\tdistribute, sublicense, and/or sell copies of the Software, and to\n\t\tpermit persons to whom the Software is furnished to do so, subject to\n\t\tthe following conditions:\n\n\t\tThe above copyright notice and this permission notice shall be included\n\t\tin all copies or substantial portions of the Software.\n\n\t\tTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS\n\t\tOR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\n\t\tMERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\n\t\tIN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY\n\t\tCLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,\n\t\tTORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE\n\t\tSOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n\t"
}
local t2 = {
	[Enum.NormalId.Right] = { Vector3.new(0.5, 0.5, 0.5), Vector3.new(0.5, 0.5, -0.5), Vector3.new(0.5, -0.5, -0.5) },
	[Enum.NormalId.Left] = { Vector3.new(-0.5, 0.5, -0.5), Vector3.new(-0.5, 0.5, 0.5), Vector3.new(-0.5, -0.5, 0.5) },
	[Enum.NormalId.Front] = { Vector3.new(0.5, 0.5, -0.5), Vector3.new(-0.5, 0.5, -0.5), Vector3.new(-0.5, -0.5, -0.5) },
	[Enum.NormalId.Back] = { Vector3.new(-0.5, 0.5, 0.5), Vector3.new(0.5, 0.5, 0.5), Vector3.new(0.5, -0.5, 0.5) },
	[Enum.NormalId.Top] = { Vector3.new(-0.5, 0.5, 0.5), Vector3.new(-0.5, 0.5, -0.5), Vector3.new(0.5, 0.5, -0.5) },
	[Enum.NormalId.Bottom] = { Vector3.new(0.5, -0.5, 0.5), Vector3.new(0.5, -0.5, -0.5), Vector3.new(-0.5, -0.5, -0.5) }
}

function t.GetSurfaceClosestToPoint(p1, p2, p3) --[[ GetSurfaceClosestToPoint | Line: 79 ]]
	local v1 = p2.CFrame:pointToObjectSpace(p3) / p2.Size
	local X = v1.X
	local Y = v1.Y
	local Z = v1.Z
	local v2 = math.abs(X)
	local v3 = math.abs(Y)
	local v4 = math.abs(Z)

	if v3 < v4 and v2 < v4 then
		if Z > 0 then
			return Enum.NormalId.Back
		end

		return Enum.NormalId.Front
	end

	if v4 < v3 and v2 < v3 then
		if Y > 0 then
			return Enum.NormalId.Top
		end

		return Enum.NormalId.Bottom
	end

	if not (v4 < v2 and v3 < v2) then
		return nil
	end

	if X > 0 then
		return Enum.NormalId.Right
	end

	return Enum.NormalId.Left
end
function t.NearestPointOnLine(p1, p2, p3, p4) --[[ NearestPointOnLine | Line: 112 ]]
	local unit = p3.unit

	return p2 + unit * (p4 - p2):Dot(unit)
end
function t.WorldPositionToGuiPosition(p1, p2, p3) --[[ WorldPositionToGuiPosition | Line: 120 | Upvalues: t2 (copy) ]]
	local v1 = p1:GetSurfaceClosestToPoint(p2, p3)

	if v1 == nil then
		return nil, nil, nil, nil, nil
	end

	local v2 = t2[v1]

	if v2 == nil then
		return nil, nil, nil, nil, nil
	end

	local p = (p2.CFrame * CFrame.new(v2[1] * p2.Size)).p
	local p4 = (p2.CFrame * CFrame.new(v2[2] * p2.Size)).p
	local p5 = (p2.CFrame * CFrame.new(v2[3] * p2.Size)).p
	local v3 = p1:NearestPointOnLine(p, p4 - p, p3)
	local v4 = p1:NearestPointOnLine(p4, p5 - p4, p3)
	local Magnitude = (p4 - p).Magnitude
	local Magnitude2 = (p5 - p4).Magnitude

	return v1, Magnitude, Magnitude2, (v3 - p).Magnitude / Magnitude, (v4 - p4).Magnitude / Magnitude2
end

return t