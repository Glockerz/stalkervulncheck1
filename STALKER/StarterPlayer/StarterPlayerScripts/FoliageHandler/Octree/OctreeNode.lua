-- Decompiled with Potassium's decompiler.

local u1 = {
    ClassName = "OctreeNode"
};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 7
    -- upvalues: u1 (copy)
    local v4 = {
        CurrentLowestRegion = nil,
        Position = nil,
        PositionX = nil,
        PositionY = nil,
        PositionZ = nil,
        Octree = p2 or error("No octree"),
        Object = p3 or error("No object")
    };

    return setmetatable(v4, u1);
end;

function u1.KNearestNeighborsSearch(p5: table, p6: number, p7: number) -- Line: 20
    return p5.Octree:KNearestNeighborsSearch(p5.Position, p6, p7);
end;

function u1.GetObject(p8) -- Line: 24
    warn("OctreeNode:GetObject is deprecated.");

    return p8.Object;
end;

function u1.RadiusSearch(p9: table, p10: number) -- Line: 29
    return p9.Octree:RadiusSearch(p9.Position, p10);
end;

function u1.GetPosition(p11) -- Line: 33
    warn("OctreeNode:GetPosition is deprecated.");

    return p11.Position;
end;

function u1.GetRawPosition(p12) -- Line: 38
    return p12.PositionX, p12.PositionY, p12.PositionZ;
end;

function u1.SetPosition(p13: table, p14: vector) -- Line: 42
    if p13.Position == p14 then
        return;
    end;

    local X = p14.X;
    local Y = p14.Y;
    local Z = p14.Z;
    p13.PositionX = X;
    p13.PositionY = Y;
    p13.PositionZ = Z;
    p13.Position = p14;

    if p13.CurrentLowestRegion then
        local CurrentLowestRegion = p13.CurrentLowestRegion;
        local LowerBounds = CurrentLowestRegion.LowerBounds;
        local UpperBounds = CurrentLowestRegion.UpperBounds;

        if LowerBounds[1] <= X and (X <= UpperBounds[1] and (LowerBounds[2] <= Y and (Y <= UpperBounds[2] and (LowerBounds[3] <= Z and Z <= UpperBounds[3])))) then
            return;
        end;
    end;

    local OrCreateLowestSubRegion = p13.Octree:GetOrCreateLowestSubRegion(X, Y, Z);
    local v15;

    if p13.CurrentLowestRegion then
        local CurrentLowestRegion = p13.CurrentLowestRegion;

        if CurrentLowestRegion.Depth ~= OrCreateLowestSubRegion.Depth then
            error("fromLowest.Depth ~= toLowest.Depth");
        end;

        if CurrentLowestRegion == OrCreateLowestSubRegion then
            error("fromLowest == toLowest");
            v15 = OrCreateLowestSubRegion;
        else
            v15 = OrCreateLowestSubRegion;
        end;

        while CurrentLowestRegion ~= OrCreateLowestSubRegion do
            local Nodes = CurrentLowestRegion.Nodes;

            if not Nodes[p13] then
                error("CurrentFrom.Nodes doesn\'t have a node here.");
            end;

            local NodeCount = CurrentLowestRegion.NodeCount;

            if NodeCount <= 0 then
                error("NodeCount is <= 0.");
            end;

            local v16 = NodeCount - 1;
            Nodes[p13] = nil;
            CurrentLowestRegion.NodeCount = v16;
            local ParentIndex = CurrentLowestRegion.ParentIndex;

            if v16 <= 0 and ParentIndex then
                local Parent = CurrentLowestRegion.Parent;

                if not Parent then
                    error("CurrentFrom.Parent doesn\'t exist.");
                end;

                local SubRegions = Parent.SubRegions;

                if SubRegions[ParentIndex] ~= CurrentLowestRegion then
                    error("Failed equality check.");
                end;

                SubRegions[ParentIndex] = nil;
            end;

            local Nodes2 = OrCreateLowestSubRegion.Nodes;

            if Nodes2[p13] then
                error("CurrentTo.Nodes already has a node here.");
            end;

            Nodes2[p13] = p13;
            OrCreateLowestSubRegion.NodeCount = OrCreateLowestSubRegion.NodeCount + 1;
            CurrentLowestRegion = CurrentLowestRegion.Parent;
            OrCreateLowestSubRegion = OrCreateLowestSubRegion.Parent;
        end;
    else
        v15 = OrCreateLowestSubRegion;

        while OrCreateLowestSubRegion do
            local Nodes = OrCreateLowestSubRegion.Nodes;

            if not Nodes[p13] then
                Nodes[p13] = p13;
                OrCreateLowestSubRegion.NodeCount = OrCreateLowestSubRegion.NodeCount + 1;
            end;

            OrCreateLowestSubRegion = OrCreateLowestSubRegion.Parent;
        end;
    end;

    p13.CurrentLowestRegion = v15;
end;

function u1.Destroy(p17) -- Line: 144
    local CurrentLowestRegion = p17.CurrentLowestRegion;

    if CurrentLowestRegion then
        while CurrentLowestRegion do
            local Nodes = CurrentLowestRegion.Nodes;

            if not Nodes[p17] then
                error("CurrentFrom.Nodes doesn\'t have a node here.");
            end;

            local NodeCount = CurrentLowestRegion.NodeCount;

            if NodeCount <= 0 then
                error("NodeCount is <= 0.");
            end;

            local v18 = NodeCount - 1;
            Nodes[p17] = nil;
            CurrentLowestRegion.NodeCount = v18;
            local Parent = CurrentLowestRegion.Parent;
            local ParentIndex = CurrentLowestRegion.ParentIndex;

            if v18 <= 0 and ParentIndex then
                if not Parent then
                    error("Current.Parent doesn\'t exist.");
                end;

                local SubRegions = Parent.SubRegions;

                if SubRegions[ParentIndex] ~= CurrentLowestRegion then
                    error("Failed equality check.");
                end;

                SubRegions[ParentIndex] = nil;
                CurrentLowestRegion = Parent;
            else
                CurrentLowestRegion = Parent;
            end;
        end;
    end;
end;

return u1;