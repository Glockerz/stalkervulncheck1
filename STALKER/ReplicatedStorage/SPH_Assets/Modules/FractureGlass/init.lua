-- Decompiled with Potassium's decompiler.

local glassShardDespawnTime = require(game.ReplicatedStorage.SPH_Assets.GameConfig).glassShardDespawnTime;
local Terrain = game.Workspace.Terrain;
local u1 = nil;
local WedgePart = Instance.new("WedgePart");
WedgePart.Name = "GlassFragment";
WedgePart.Anchored = true;
WedgePart.CanCollide = true;
WedgePart.CanTouch = false;
WedgePart.TopSurface = Enum.SurfaceType.Smooth;
WedgePart.BottomSurface = Enum.SurfaceType.Smooth;

local function DrawTriangle(p2, p3, p4, p5, p6) -- Line: 63
    -- upvalues: WedgePart (copy), Terrain (copy)
    local v7 = p3 - p2;
    local v8 = p4 - p2;
    local v9 = p4 - p3;
    local v10 = v7:Dot(v7);
    local v11 = v8:Dot(v8);
    local v12 = v9:Dot(v9);

    if v11 < v10 and v12 < v10 then
        local v13 = p4;
        p4 = p2;
        p2 = p3;
        p3 = v13;
    elseif v12 < v11 then
        if v10 >= v11 then
            local v14 = p3;
            p3 = p2;
            p2 = v14;
        end;
    else
        local v15 = p3;
        p3 = p2;
        p2 = v15;
    end;

    local v16 = p2 - p3;
    local v17 = p4 - p3;
    local v18 = p4 - p2;
    local unit = v17:Cross(v16).unit;
    local unit2 = v18:Cross(unit).unit;
    local unit3 = v18.unit;
    local v19 = v16:Dot(unit2);
    local math_abs_ret = math.abs(v19);
    local v20 = WedgePart:Clone();
    local Z = p5.Size.Z;
    local v21 = v16:Dot(unit3);
    local math_abs_ret2 = math.abs(v21);
    v20.Size = Vector3.new(Z, math_abs_ret, math_abs_ret2);
    v20.CFrame = p5.CFrame * CFrame.new((p3 + p2) * 0.5 - p5.Position) * CFrame.fromMatrix(Vector3.new(), unit, unit2, unit3);
    v20.Color = p5.Color;
    v20.Material = p5.Material;
    v20.Transparency = p5.Transparency;
    v20.CastShadow = p5.CastShadow;
    v20.Velocity = p6;
    v20.Parent = Terrain;
    local v22 = WedgePart:Clone();
    local Z2 = p5.Size.Z;
    local v23 = v17:Dot(unit3);
    local math_abs_ret3 = math.abs(v23);
    v22.Size = Vector3.new(Z2, math_abs_ret, math_abs_ret3);
    v22.CFrame = p5.CFrame * CFrame.new((p3 + p4) * 0.5 - p5.Position) * CFrame.fromMatrix(Vector3.new(), -unit, unit2, -unit3);
    v22.Color = p5.Color;
    v22.Material = p5.Material;
    v22.Transparency = p5.Transparency;
    v22.CastShadow = p5.CastShadow;
    v22.Velocity = p6;
    v22.Parent = Terrain;

    return v20, v22;
end;

local function FindIntersectionV(p24, p25, p26) -- Line: 111
    return p24:Lerp(p25, (p24.X - p26) / (p24.X - p25.X));
end;

local function FindIntersectionH(p27, p28, p29) -- Line: 115
    return p27:Lerp(p28, (p27.Y - p29) / (p27.Y - p28.Y));
end;

local function FindIntersectionD(p30, p31, p32, p33) -- Line: 119
    local v34 = (p31.Y - p30.Y) / (p31.X - p30.X);
    local v35 = (p33 - (p30.Y - p30.X * v34)) / (v34 - p32);

    return Vector3.new(v35, v35 * p32 + p33, p30.Z);
end;

local function CreatePolygon(p36, p37, p38) -- Line: 126
    -- upvalues: FindIntersectionV (copy), FindIntersectionH (copy), DrawTriangle (copy)
    local v39 = p37.Size * 0.5;
    local v40 = {};
    local v41 = p37.Position.Y + v39.Y;
    local v42 = p37.Position.Y - v39.Y;
    local v43 = p37.Position.X - v39.X;
    local v44 = p37.Position.X + v39.X;
    local v45;

    if p37.Shape == Enum.PartType.Wedge then
        local Vector2_new_ret = Vector2.new(p37.Position.X - v39.X, p37.Position.Y + v39.Y);
        local Vector2_new_ret2 = Vector2.new(p37.Position.X + v39.X, p37.Position.Y - v39.Y);
        local v46 = (Vector2_new_ret2.Y - Vector2_new_ret.Y) / (Vector2_new_ret2.X - Vector2_new_ret.X);
        local v47 = Vector2_new_ret.Y - Vector2_new_ret.X * v46;
        v45 = v40;

        for i, v in ipairs(p36) do
            local v48 = p36[i % #p36 + 1];
            local v49 = v.Y <= v.X * v46 + v47;
            local v50 = v48.Y <= v48.X * v46 + v47;

            if v49 and v50 then
                table.insert(v45, v48);
                v40 = v45;
            elseif v49 or not v50 then
                if v49 and not v50 then
                    local v51 = (v48.Y - v.Y) / (v48.X - v.X);
                    local v52 = (v47 - (v.Y - v.X * v51)) / (v51 - v46);
                    local Vector3_new_ret = Vector3.new(v52, v52 * v46 + v47, v.Z);
                    table.insert(v45, Vector3_new_ret);
                    v40 = v45;
                else
                    v40 = v45;
                end;
            else
                local v53 = (v48.Y - v.Y) / (v48.X - v.X);
                local v54 = (v47 - (v.Y - v.X * v53)) / (v53 - v46);
                local Vector3_new_ret = Vector3.new(v54, v54 * v46 + v47, v.Z);
                table.insert(v45, Vector3_new_ret);
                table.insert(v45, v48);
                v40 = v45;
            end;

            v45 = v40;
        end;
    else
        for i, v in ipairs(p36) do
            local v55 = p36[i % #p36 + 1];
            local v56 = v.X <= v44;
            local v57 = v55.X <= v44;

            if v56 and v57 then
                table.insert(v40, v55);
            elseif v56 or not v57 then
                if v56 and not v57 then
                    table.insert(v40, FindIntersectionV(v, v55, v44));
                end;
            else
                table.insert(v40, FindIntersectionV(v, v55, v44));
                table.insert(v40, v55);
            end;
        end;

        v45 = {};

        for i, v in ipairs(v40) do
            local v58 = v40[i % #v40 + 1];
            local v59 = v.Y <= v41;
            local v60 = v58.Y <= v41;

            if v59 and v60 then
                table.insert(v45, v58);
            elseif v59 or not v60 then
                if v59 and not v60 then
                    table.insert(v45, FindIntersectionH(v, v58, v41));
                end;
            else
                table.insert(v45, FindIntersectionH(v, v58, v41));
                table.insert(v45, v58);
            end;
        end;
    end;

    local v61 = {};

    for i, v in ipairs(v45) do
        local v62 = v45[i % #v45 + 1];
        local v63 = v43 <= v.X;
        local v64 = v43 <= v62.X;

        if v63 and v64 then
            table.insert(v61, v62);
        elseif v63 or not v64 then
            if v63 and not v64 then
                table.insert(v61, FindIntersectionV(v, v62, v43));
            end;
        else
            table.insert(v61, FindIntersectionV(v, v62, v43));
            table.insert(v61, v62);
        end;
    end;

    local v65 = {};

    for i, v in ipairs(v61) do
        local v66 = v61[i % #v61 + 1];
        local v67 = v42 <= v.Y;
        local v68 = v42 <= v66.Y;

        if v67 and v68 then
            table.insert(v65, v66);
        elseif v67 or not v68 then
            if v67 and not v68 then
                table.insert(v65, FindIntersectionH(v, v66, v42));
            end;
        else
            table.insert(v65, FindIntersectionH(v, v66, v42));
            table.insert(v65, v66);
        end;
    end;

    local v69 = {};

    for i = 3, #v65 do
        local v70, v71 = DrawTriangle(v65[1], v65[i - 1], v65[i], p37, p38);
        table.insert(v69, v70);
        table.insert(v69, v71);
        local _ = i;
    end;

    return v69;
end;

local function IsInCircle(p72, p73, p74) -- Line: 238
    return (p72.X - p73.X) ^ 2 + (p72.Y - p73.Y) ^ 2 < p74 * p74;
end;

local function CreateCracks(p75, p76, p77) -- Line: 242
    -- upvalues: CreatePolygon (copy)
    local v78 = p75.Size * 0.5;
    local Magnitude = (Vector2.new(6.123233995736766e-17, 1) * 0.5 + Vector2.new(0.5, 0)).Magnitude;
    local v79 = 1;
    local v80 = 1;
    local v81 = {};
    local v82 = {};

    while true do
        local v83, v84;

        repeat
            v79 = v79 + 1;
            v80 = v80 * 2;
            v83 = p75.Position + Vector3.new(-v78.X, -v78, 0);
            v84 = v80 * Magnitude;
        until (v83.X - p76.X) ^ 2 + (v83.Y - p76.Y) ^ 2 < v84 * v84;

        local v85 = p75.Position + Vector3.new(-v78.X, v78.Y, 0);
        local v86 = v80 * Magnitude;

        if (v85.X - p76.X) ^ 2 + (v85.Y - p76.Y) ^ 2 < v86 * v86 then
            local v87 = p75.Position + Vector3.new(v78.X, v78.Y, 0);
            local v88 = v80 * Magnitude;

            if (v87.X - p76.X) ^ 2 + (v87.Y - p76.Y) ^ 2 < v88 * v88 then
                local v89 = p75.Position + Vector3.new(v78.X, -v78.Y, 0);
                local v90 = v80 * Magnitude;

                if (v89.X - p76.X) ^ 2 + (v89.Y - p76.Y) ^ 2 < v90 * v90 then
                    for i = 1, 6 do
                        v81[i] = {};
                        local v91 = i;

                        for i2 = 1, v79 do
                            local v92 = 1.0471975511965976 * (v91 + (math.random() - 0.5) * 0.5);
                            v81[v91][i2] = v92;
                            local _ = i2;
                        end;
                    end;

                    for i = 1, 6 do
                        local v93 = i;

                        for i2 = 1, v79 do
                            local v94 = (v93 + 6 - 2) % 6 + 1;
                            local v95;

                            if i2 == 1 then
                                local v96 = { p76, (CFrame.new(p76) * CFrame.Angles(0, 0, v81[v93][i2]) * CFrame.new(0, 1, 0)).Position, (CFrame.new(p76) * CFrame.Angles(0, 0, v81[v94][i2]) * CFrame.new(0, 1, 0)).Position };
                                v95 = i2;

                                for _, v in ipairs((CreatePolygon(v96, p75, p77))) do
                                    table.insert(v82, v);
                                    v.Anchored = false;
                                end;
                            else
                                local u97 = CreatePolygon({
                                    (CFrame.new(p76) * CFrame.Angles(0, 0, v81[v93][i2]) * CFrame.new(0, 2 ^ (i2 - 1) * 1, 0)).Position,
                                    (CFrame.new(p76) * CFrame.Angles(0, 0, v81[v93][i2 - 1]) * CFrame.new(0, 2 ^ (i2 - 2) * 1, 0)).Position,
                                    (CFrame.new(p76) * CFrame.Angles(0, 0, v81[v94][i2 - 1]) * CFrame.new(0, 2 ^ (i2 - 2) * 1, 0)).Position,
                                    (CFrame.new(p76) * CFrame.Angles(0, 0, v81[v94][i2]) * CFrame.new(0, 2 ^ (i2 - 1) * 1, 0)).Position
                                }, p75, p77);
                                v95 = i2;

                                for _, v in ipairs(u97) do
                                    table.insert(v82, v);
                                end;

                                task.delay((v93 - 1) * 0.015 + v95 * 0.005, function() -- Line: 300
                                    -- upvalues: u97 (copy)
                                    for _, v in ipairs(u97) do
                                        v.Anchored = false;
                                    end;
                                end);
                            end;
                        end;
                    end;

                    return v82, v79 * 0.005 + 0.075;
                end;
            end;
        end;
    end;
end;

return function(p98, p99, p100, ...) -- Line: 312
    -- upvalues: u1 (ref), CreateCracks (copy), glassShardDespawnTime (copy)
    if not ... then
        assert(p98, "Parameter \'part\' was nil, expected BasePart.");
        local v101 = p99 or p98.Position;
        p100 = p100 or Vector3.new();

        if p98.Shape == Enum.PartType.Wedge then
            p98.Size = Vector3.new(p98.Size.Z, p98.Size.Y, p98.Size.X);
            p98.CFrame = p98.CFrame * CFrame.Angles(0, 1.5707963267948966, 0);
        else
            local math_min_ret = math.min(p98.Size.X, p98.Size.Y, p98.Size.Z);

            if math_min_ret == p98.Size.X then
                p98.Size = Vector3.new(p98.Size.Z, p98.Size.Y, p98.Size.X);
                p98.CFrame = p98.CFrame * CFrame.Angles(0, 1.5707963267948966, 0);
            elseif math_min_ret == p98.Size.Y then
                p98.Size = Vector3.new(p98.Size.X, p98.Size.Z, p98.Size.Y);
                p98.CFrame = p98.CFrame * CFrame.Angles(1.5707963267948966, 0, 0);
            end;
        end;

        local v102 = p98.CFrame:ToObjectSpace(CFrame.new(v101)).Position + p98.Position;
        p99 = Vector3.new(v102.X, v102.Y, p98.Position.Z);

        if u1 then
            u1:Clone().Parent = p98;
        end;
    end;

    if not (game.Players.LocalPlayer or ...) then
        script:WaitForChild("RenderGlass"):FireAllClients({
            Position = p98.Position,
            CFrame = p98.CFrame,
            Size = p98.Size,
            Color = p98.Color,
            Material = p98.Material,
            Transparency = p98.Transparency,
            CastShadow = p98.CastShadow,
            Shape = p98.Shape
        }, p99, p100);
        p98:Destroy();

        return;
    end;

    local u103, v104 = CreateCracks(p98, p99, p100);
    local u105 = false;
    task.delay(glassShardDespawnTime, function() -- Line: 359
        -- upvalues: u103 (copy), u105 (ref)
        for _, v in ipairs(u103) do
            v:Destroy();
        end;

        u105 = true;
    end);
    task.delay(v104 + 0.1, function() -- Line: 374
        -- upvalues: u103 (copy), u105 (ref)
        local table_clone_ret = table.clone(u103);

        while not u105 do
            for i = #table_clone_ret, 1, -1 do
                local v106 = table_clone_ret[i];
                local v107;

                if v106.Velocity.Y < math.min(-1 + (v106.Size.X + v106.Size.Y) * 0.1, 0) and not v106.Anchored then
                    v107 = i;
                else
                    v106.Anchored = true;
                    v106.CanCollide = false;
                    table.remove(table_clone_ret, i);
                    v107 = i;
                end;
            end;

            task.wait(0.1);
        end;
    end);

    if typeof(p98) ~= "table" then
        p98:Destroy();
    end;
end;