-- Decompiled with Potassium's decompiler.

local u7 = {
    Weld = function(p1, p2) -- Line: 5
        local Weld = Instance.new("Weld");
        Weld.Part0 = p1;
        Weld.Part1 = p2;
        Weld.C0 = p1.CFrame:ToObjectSpace(p2.CFrame);
        Weld.Name = p1.Name .. "_" .. p2.Name;
        Weld.Parent = p1;
        p2.Anchored = false;

        return Weld;
    end,

    M6D = function(p3, p4) -- Line: 17
        local Motor6D = Instance.new("Motor6D");
        Motor6D.Part0 = p3;
        Motor6D.Part1 = p4;
        Motor6D.C0 = p3.CFrame:ToObjectSpace(p4.CFrame);
        Motor6D.Name = p3.Name .. "_" .. p4.Name;
        Motor6D.Parent = p3;
        p4.Anchored = false;

        return Motor6D;
    end,

    BlankM6D = function(p5, p6) -- Line: 28
        local Motor6D = Instance.new("Motor6D");
        Motor6D.Part0 = p5;
        Motor6D.Part1 = p6;
        Motor6D.Name = p5.Name .. "_" .. p6.Name;
        Motor6D.Parent = p5;
        p6.Anchored = false;

        return Motor6D;
    end
};

function u7.WeldModel(p8, p9, p10) -- Line: 39
    -- upvalues: u7 (copy)
    for _, child in ipairs(p8:GetChildren()) do
        if child:IsA("BasePart") and child ~= p9 then
            u7.Weld(p9, child);
            child.CanCollide = p10;
        end;
    end;
end;

function u7.WeldDescendants(p11, p12, p13) -- Line: 49
    -- upvalues: u7 (copy)
    for _, descendant in ipairs(p11:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant ~= p12 then
            u7.Weld(p12, descendant);
            descendant.CanCollide = p13;
        end;
    end;
end;

function u7.AutoWeldModel(p14, p15, p16, p17) -- Line: 59
    -- upvalues: u7 (copy)
    for _, child in ipairs(p14:GetChildren()) do
        if child:IsA("BasePart") and (child ~= p15 and not table.find(p17, child.Name)) then
            u7.Weld(p15, child);

            if p16 then
                child.CanCollide = false;
            end;

            u7.AutoWeldModel(child, child, p16);
        end;
    end;
end;

function u7.BlankWeld(p18, p19) -- Line: 87
    local Weld = Instance.new("Weld");
    Weld.Part0 = p18;
    Weld.Part1 = p19;
    Weld.Name = p18.Name .. "_" .. p19.Name;
    Weld.Parent = p18;
    p19.Anchored = false;

    return Weld;
end;

return u7;