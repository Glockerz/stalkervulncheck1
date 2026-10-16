-- Decompiled with Potassium's decompiler.

local v1 = {
    _DESCRIPTION = "\t\tWorldPositionToGuiPosition by orange451\n\t\t\n\t\tThis script can take a part and a world position, and output Surface Gui data.\n\t\tUseful for clippable bulletholes.\n\t\t\n\t\tUsage:\n\t\t\tWorldPositionToGuiPosition( Part, WorldPosition )\n\t\t\n\t\tReturns:\n\t\t\t- Surface\n\t\t\t- Width of surface\n\t\t\t- Height of surface\n\t\t\t- Relative X Position WorldPosition\n\t\t\t- Relative Y Position WorldPosition\n\t",
    _LICENSE = "\t\tMIT LICENSE\n\n\t\tCopyright (c) 2017 Andrew Hamilton\n\n\t\tPermission is hereby granted, free of charge, to any person obtaining a\n\t\tcopy of this software and associated documentation files (the\n\t\t\"Software\"), to deal in the Software without restriction, including\n\t\twithout limitation the rights to use, copy, modify, merge, publish,\n\t\tdistribute, sublicense, and/or sell copies of the Software, and to\n\t\tpermit persons to whom the Software is furnished to do so, subject to\n\t\tthe following conditions:\n\n\t\tThe above copyright notice and this permission notice shall be included\n\t\tin all copies or substantial portions of the Software.\n\n\t\tTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS\n\t\tOR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\n\t\tMERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\n\t\tIN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY\n\t\tCLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,\n\t\tTORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE\n\t\tSOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n\t"
};
local u2 = {
    [Enum.NormalId.Right] = { Vector3.new(0.5, 0.5, 0.5), Vector3.new(0.5, 0.5, -0.5), Vector3.new(0.5, -0.5, -0.5) },
    [Enum.NormalId.Left] = { Vector3.new(-0.5, 0.5, -0.5), Vector3.new(-0.5, 0.5, 0.5), Vector3.new(-0.5, -0.5, 0.5) },
    [Enum.NormalId.Front] = { Vector3.new(0.5, 0.5, -0.5), Vector3.new(-0.5, 0.5, -0.5), Vector3.new(-0.5, -0.5, -0.5) },
    [Enum.NormalId.Back] = { Vector3.new(-0.5, 0.5, 0.5), Vector3.new(0.5, 0.5, 0.5), Vector3.new(0.5, -0.5, 0.5) },
    [Enum.NormalId.Top] = { Vector3.new(-0.5, 0.5, 0.5), Vector3.new(-0.5, 0.5, -0.5), Vector3.new(0.5, 0.5, -0.5) },
    [Enum.NormalId.Bottom] = { Vector3.new(0.5, -0.5, 0.5), Vector3.new(0.5, -0.5, -0.5), Vector3.new(-0.5, -0.5, -0.5) }
};

function v1.GetSurfaceClosestToPoint(p3, p4, p5) -- Line: 79
    local v6 = p4.CFrame:pointToObjectSpace(p5) / p4.Size;
    local X = v6.X;
    local Y = v6.Y;
    local Z = v6.Z;
    local math_abs_ret = math.abs(X);
    local math_abs_ret2 = math.abs(Y);
    local math_abs_ret3 = math.abs(Z);

    if math_abs_ret2 < math_abs_ret3 and math_abs_ret < math_abs_ret3 then
        if Z > 0 then
            return Enum.NormalId.Back;
        end;

        return Enum.NormalId.Front;
    end;

    if math_abs_ret3 < math_abs_ret2 and math_abs_ret < math_abs_ret2 then
        if Y > 0 then
            return Enum.NormalId.Top;
        end;

        return Enum.NormalId.Bottom;
    end;

    if math_abs_ret3 >= math_abs_ret or math_abs_ret2 >= math_abs_ret then
        return nil;
    end;

    if X > 0 then
        return Enum.NormalId.Right;
    end;

    return Enum.NormalId.Left;
end;

function v1.NearestPointOnLine(p7, p8, p9, p10) -- Line: 112
    local unit = p9.unit;

    return p8 + unit * (p10 - p8):Dot(unit);
end;

function v1.WorldPositionToGuiPosition(p11, p12, p13) -- Line: 120
    -- upvalues: u2 (copy)
    local SurfaceClosestToPoint = p11:GetSurfaceClosestToPoint(p12, p13);

    if SurfaceClosestToPoint == nil then
        return nil, nil, nil, nil, nil;
    end;

    local v14 = u2[SurfaceClosestToPoint];

    if v14 == nil then
        return nil, nil, nil, nil, nil;
    end;

    local p = (p12.CFrame * CFrame.new(v14[1] * p12.Size)).p;
    local p2 = (p12.CFrame * CFrame.new(v14[2] * p12.Size)).p;
    local p3 = (p12.CFrame * CFrame.new(v14[3] * p12.Size)).p;
    local v15 = p11:NearestPointOnLine(p, p2 - p, p13);
    local v16 = p11:NearestPointOnLine(p2, p3 - p2, p13);
    local Magnitude = (p2 - p).Magnitude;
    local Magnitude2 = (p3 - p2).Magnitude;

    return SurfaceClosestToPoint, Magnitude, Magnitude2, (v15 - p).Magnitude / Magnitude, (v16 - p2).Magnitude / Magnitude2;
end;

return v1;