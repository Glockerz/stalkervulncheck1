-- Decompiled with Potassium's decompiler.

local script_OctreeNode = require(script.OctreeNode);
local script_OctreeRegionUtils = require(script.OctreeRegionUtils);
local u1 = { { 0.25, 0.25, -0.25 }, { -0.25, 0.25, -0.25 }, { 0.25, 0.25, 0.25 }, { -0.25, 0.25, 0.25 }, { 0.25, -0.25, -0.25 }, { -0.25, -0.25, -0.25 }, { 0.25, -0.25, 0.25 }, { -0.25, -0.25, 0.25 } };
local u2 = {
    ClassName = "Octree"
};
u2.__index = u2;
local new = script_OctreeNode.new;
local GetNeighborsWithinRadius = script_OctreeRegionUtils.GetNeighborsWithinRadius;

function u2.new() -- Line: 28
    -- upvalues: u2 (copy)
    local v3 = {
        MaxDepth = 4,
        MaxRegionSize = table.create(3, 512),
        RegionHashMap = {}
    };

    return setmetatable(v3, u2);
end;

function u2.ClearNodes(p4) -- Line: 36
    p4.MaxDepth = 4;
    p4.MaxRegionSize = table.create(3, 512);
    table.clear(p4.RegionHashMap);
end;

function u2.GetAllNodes(p5) -- Line: 42
    local v6 = 0;
    local v7 = {};

    for _, v in next, p5.RegionHashMap do
        for _, v2 in ipairs(v) do
            for i in next, v2.Nodes do
                v6 = v6 + 1;
                v7[v6] = i;
            end;
        end;
    end;

    return v7;
end;

function u2.CreateNode(p8: table, p9: vector, p10: any) -- Line: 58
    -- upvalues: new (copy)
    if typeof(p9) ~= "Vector3" then
        error("Bad position value");
    end;

    if not p10 then
        error("Bad object value.");
    end;

    local v11 = new(p8, p10);
    v11:SetPosition(p9);

    return v11;
end;

function u2.RadiusSearch(p12: table, p13: vector, p14: number) -- Line: 72
    -- upvalues: GetNeighborsWithinRadius (copy)
    if typeof(p13) ~= "Vector3" then
        error("Bad position value");
    end;

    if type(p14) ~= "number" then
        error("Bad radius value");
    end;

    local X = p13.X;
    local Y = p13.Y;
    local Z = p13.Z;
    local v15 = p14 + 0.8660254037844386 * p12.MaxRegionSize[1];
    local v16 = v15 * v15 + 1e-9;
    local v17 = {};
    local v18 = 0;
    local v19 = 0;
    local v20 = {};

    for _, v in next, p12.RegionHashMap do
        for _, v2 in ipairs(v) do
            local Position = v2.Position;
            local v21 = X - Position[1];
            local v22 = Y - Position[2];
            local v23 = Z - Position[3];

            if v21 * v21 + v22 * v22 + v23 * v23 <= v16 then
                v18, v19 = GetNeighborsWithinRadius(v2, p14, X, Y, Z, v20, v17, p12.MaxDepth, v18, v19);
            end;
        end;
    end;

    return v20, v17;
end;

local function NearestNeighborSort(p24, p25) -- Line: 122
    return p24.Distance2 < p25.Distance2;
end;

function u2.KNearestNeighborsSearch(p26: table, p27: vector, p28: number, p29: number) -- Line: 126
    -- upvalues: GetNeighborsWithinRadius (copy), NearestNeighborSort (copy)
    if typeof(p27) ~= "Vector3" then
        error("Bad position value");
    end;

    if type(p29) ~= "number" then
        error("Bad radius value");
    end;

    local X = p27.X;
    local Y = p27.Y;
    local Z = p27.Z;
    local v30 = p29 + 0.8660254037844386 * p26.MaxRegionSize[1];
    local v31 = v30 * v30 + 1e-9;
    local v32 = 0;
    local v33 = {};
    local v34 = 0;
    local v35 = {};

    for _, v in next, p26.RegionHashMap do
        for _, v2 in ipairs(v) do
            local Position = v2.Position;
            local v36 = X - Position[1];
            local v37 = Y - Position[2];
            local v38 = Z - Position[3];

            if v36 * v36 + v37 * v37 + v38 * v38 <= v31 then
                v32, v34 = GetNeighborsWithinRadius(v2, p29, X, Y, Z, v35, v33, p26.MaxDepth, v32, v34);
            end;
        end;
    end;

    local table_create_ret = table.create(v34);

    for i, v in ipairs(v33) do
        table_create_ret[i] = {
            Distance2 = v,
            Index = i
        };
    end;

    table.sort(table_create_ret, NearestNeighborSort);
    local math_min_ret = math.min(v34, p28);
    local table_create_ret2 = table.create(math_min_ret);
    local table_create_ret3 = table.create(math_min_ret);

    for i = 1, math_min_ret do
        local v39 = table_create_ret[i];
        table_create_ret3[i] = v39.Distance2;
        table_create_ret2[i] = v35[v39.Index];
        local _ = i;
    end;

    return table_create_ret2, table_create_ret3;
end;

local function GetOrCreateRegion(p40: any, p41: number, p42: number, p43: number) -- Line: 195
    local RegionHashMap = p40.RegionHashMap;
    local MaxRegionSize = p40.MaxRegionSize;
    local v44 = MaxRegionSize[1];
    local v45 = MaxRegionSize[2];
    local v46 = MaxRegionSize[3];
    local math_floor_ret = math.floor(p41 / v44 + 0.5);
    local math_floor_ret2 = math.floor(p42 / v45 + 0.5);
    local math_floor_ret3 = math.floor(p43 / v46 + 0.5);
    local v47 = math_floor_ret * 73856093 + math_floor_ret2 * 19351301 + math_floor_ret3 * 83492791;
    local v48 = RegionHashMap[v47];

    if not v48 then
        v48 = {};
        RegionHashMap[v47] = v48;
    end;

    local v49 = v44 * math_floor_ret;
    local v50 = v45 * math_floor_ret2;
    local v51 = v46 * math_floor_ret3;

    for _, v in ipairs(v48) do
        local Position = v.Position;

        if Position[1] == v49 and (Position[2] == v50 and Position[3] == v51) then
            return v;
        end;
    end;

    local v52 = v44 / 2;
    local v53 = v45 / 2;
    local v54 = v46 / 2;
    local v55 = {
        Depth = 1,
        NodeCount = 0,
        Parent = nil,
        ParentIndex = nil,
        LowerBounds = { v49 - v52, v50 - v53, v51 - v54 },
        Nodes = {},
        Position = { v49, v50, v51 },
        Size = { v44, v45, v46 },
        SubRegions = {},
        UpperBounds = { v49 + v52, v50 + v53, v51 + v54 }
    };
    table.insert(v48, v55);

    return v55;
end;

function u2.GetOrCreateLowestSubRegion(p56: table, p57: number, p58: number, p59: number) -- Line: 240
    -- upvalues: GetOrCreateRegion (copy), u1 (copy)
    local v60 = GetOrCreateRegion(p56, p57, p58, p59);

    for i = v60.Depth, p56.MaxDepth do
        local Position = v60.Position;
        local v61 = Position[1] < p57 and 1 or 2;

        if p58 <= Position[2] then
            v61 = v61 + 4;
        end;

        if Position[3] <= p59 then
            v61 = v61 + 2;
        end;

        local SubRegions = v60.SubRegions;
        local v62 = SubRegions[v61];

        if v62 then
            v60 = v62;
        else
            local Size = v60.Size;
            local v63 = u1[v61];
            local v64 = Size[1];
            local v65 = Size[2];
            local v66 = Size[3];
            local v67 = Position[1] + v63[1] * v64;
            local v68 = Position[2] + v63[2] * v65;
            local v69 = Position[3] + v63[3] * v66;
            local v70 = v64 / 2;
            local v71 = v65 / 2;
            local v72 = v66 / 2;
            local v73 = v70 / 2;
            local v74 = v71 / 2;
            local v75 = v72 / 2;
            v60 = {
                NodeCount = 0,
                Depth = v60 and (v60.Depth + 1 or 1) or 1,
                LowerBounds = { v67 - v73, v68 - v74, v69 - v75 },
                Nodes = {},
                Parent = v60,
                ParentIndex = v61,
                Position = { v67, v68, v69 },
                Size = { v70, v71, v72 },
                SubRegions = {},
                UpperBounds = { v67 + v73, v68 + v74, v69 + v75 }
            };
            SubRegions[v61] = v60;
        end;

        local _ = i;
    end;

    return v60;
end;

return u2;