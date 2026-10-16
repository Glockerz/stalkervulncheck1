-- Decompiled with Potassium's decompiler.

local v1 = {};

local function GetNeighborsWithinRadius(p2, p3, p4, p5, p6, p7, p8, p9, p10, p11) -- Line: 23
    -- upvalues: GetNeighborsWithinRadius (copy)
    if not p9 then
        error("Missing MaxDepth.");
    end;

    local v12 = p3 + 0.8660254037844386 * (p2.Size[1] / 2);
    local v13 = v12 * v12 + 1e-6;
    local v14 = p3 * p3;

    for _, v in next, p2.SubRegions do
        local Position = v.Position;
        local v15 = p4 - Position[1];
        local v16 = p5 - Position[2];
        local v17 = p6 - Position[3];

        if v15 * v15 + v16 * v16 + v17 * v17 <= v13 then
            if v.Depth == p9 then
                for i in next, v.Nodes do
                    local v18 = i.PositionX - p4;
                    local v19 = i.PositionY - p5;
                    local v20 = i.PositionZ - p6;
                    local v21 = v18 * v18 + v19 * v19 + v20 * v20;

                    if v21 <= v14 then
                        p10 = p10 + 1;
                        p11 = p11 + 1;
                        p7[p10] = i.Object;
                        p8[p11] = v21;
                    end;
                end;
            else
                p10, p11 = GetNeighborsWithinRadius(v, p3, p4, p5, p6, p7, p8, p9, p10, p11);
            end;
        end;
    end;

    return p10, p11;
end;

v1.GetNeighborsWithinRadius = GetNeighborsWithinRadius;

return v1;