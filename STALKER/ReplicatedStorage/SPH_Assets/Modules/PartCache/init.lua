-- Decompiled with Potassium's decompiler.

local Table = require(script:WaitForChild("Table"));
local u1 = {};
u1.__index = u1;
u1.__type = "PartCache";
local CFrame_new_ret = CFrame.new(0, 1000000000, 0);

local function assertwarn(p2: boolean, p3: string) -- Line: 60
    if p2 == false then
        warn(p3);
    end;
end;

local function MakeFromTemplate(p4: userdata, p5: userdata) -- Line: 67
    -- upvalues: CFrame_new_ret (copy)
    local v6 = p4:Clone();
    v6.CFrame = CFrame_new_ret;
    v6.Anchored = true;
    v6.Parent = p5;

    return v6;
end;

function u1.new(p7: userdata, p8: number?, p9: userdata?) -- Line: 77
    -- upvalues: u1 (copy), Table (copy), CFrame_new_ret (copy)
    local v10 = p9 or workspace;
    assert(p8 > 0, "PrecreatedParts can not be negative!");

    if p8 ~= 0 == false then
        warn("PrecreatedParts is 0! This may have adverse effects when initially using the cache.");
    end;

    if p7.Archivable == false then
        warn("The template\'s Archivable property has been set to false, which prevents it from being cloned. It will temporarily be set to true.");
    end;

    local Archivable = p7.Archivable;
    p7.Archivable = true;
    local v11 = p7:Clone();
    p7.Archivable = Archivable;
    local v12 = {
        ExpansionSize = 10,
        Open = {},
        InUse = {},
        CurrentCacheParent = v10,
        Template = v11
    };
    setmetatable(v12, u1);

    for i = 1, p8 or 5 do
        local insert = Table.insert;
        local Open = v12.Open;
        local CurrentCacheParent = v12.CurrentCacheParent;
        local v13 = v11:Clone();
        v13.CFrame = CFrame_new_ret;
        v13.Anchored = true;
        v13.Parent = CurrentCacheParent;
        insert(Open, v13);
        local _ = i;
    end;

    v12.Template.Parent = nil;

    return v12;
end;

function u1.GetPart(p14) -- Line: 115
    -- upvalues: u1 (copy), Table (copy), CFrame_new_ret (copy)
    local v15 = getmetatable(p14) == u1;
    assert(v15, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("GetPart", "PartCache.new"));

    if #p14.Open == 0 then
        warn("No parts available in the cache! Creating [" .. p14.ExpansionSize .. "] new part instance(s) - this amount can be edited by changing the ExpansionSize property of the PartCache instance... (This cache now contains a grand total of " .. tostring(#p14.Open + #p14.InUse + p14.ExpansionSize) .. " parts.)");

        for i = 1, p14.ExpansionSize do
            local insert = Table.insert;
            local Open = p14.Open;
            local CurrentCacheParent = p14.CurrentCacheParent;
            local v16 = p14.Template:Clone();
            v16.CFrame = CFrame_new_ret;
            v16.Anchored = true;
            v16.Parent = CurrentCacheParent;
            insert(Open, v16);
            local _ = i;
        end;
    end;

    local v17 = p14.Open[#p14.Open];
    p14.Open[#p14.Open] = nil;
    Table.insert(p14.InUse, v17);

    return v17;
end;

function u1.ReturnPart(p18: table, p19: userdata) -- Line: 131
    -- upvalues: u1 (copy), Table (copy), CFrame_new_ret (copy)
    local v20 = getmetatable(p18) == u1;
    assert(v20, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("ReturnPart", "PartCache.new"));
    local v21 = Table.indexOf(p18.InUse, p19);

    if v21 == nil then
        error("Attempted to return part \"" .. p19.Name .. "\" (" .. p19:GetFullName() .. ") to the cache, but it\'s not in-use! Did you call this on the wrong part?");

        return;
    end;

    Table.remove(p18.InUse, v21);
    Table.insert(p18.Open, p19);
    p19.CFrame = CFrame_new_ret;
    p19.Anchored = true;
end;

function u1.SetCacheParent(p22: table, p23: userdata) -- Line: 146
    -- upvalues: u1 (copy)
    local v24 = getmetatable(p22) == u1;
    assert(v24, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("SetCacheParent", "PartCache.new"));
    local v25 = p23:IsDescendantOf(workspace) or p23 == workspace;
    assert(v25, "Cache parent is not a descendant of Workspace! Parts should be kept where they will remain in the visible world.");
    p22.CurrentCacheParent = p23;

    for i = 1, #p22.Open do
        p22.Open[i].Parent = p23;
        local _ = i;
    end;

    for i = 1, #p22.InUse do
        p22.InUse[i].Parent = p23;
        local _ = i;
    end;
end;

function u1.Expand(p26: table, p27: number) -- Line: 160
    -- upvalues: u1 (copy), Table (copy), CFrame_new_ret (copy)
    local v28 = getmetatable(p26) == u1;
    assert(v28, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Expand", "PartCache.new"));

    if p27 == nil then
        p27 = p26.ExpansionSize;
    end;

    for i = 1, p27 do
        local insert = Table.insert;
        local Open = p26.Open;
        local CurrentCacheParent = p26.CurrentCacheParent;
        local v29 = p26.Template:Clone();
        v29.CFrame = CFrame_new_ret;
        v29.Anchored = true;
        v29.Parent = CurrentCacheParent;
        insert(Open, v29);
        local _ = i;
    end;
end;

function u1.Dispose(p30) -- Line: 172
    -- upvalues: u1 (copy)
    local v31 = getmetatable(p30) == u1;
    assert(v31, ("Cannot statically invoke method \'%s\' - It is an instance method. Call it on an instance of this class created via %s"):format("Dispose", "PartCache.new"));

    for i = 1, #p30.Open do
        p30.Open[i]:Destroy();
        local _ = i;
    end;

    for i = 1, #p30.InUse do
        p30.InUse[i]:Destroy();
        local _ = i;
    end;

    p30.Template:Destroy();
    p30.Open = {};
    p30.InUse = {};
    p30.CurrentCacheParent = nil;
    p30.GetPart = nil;
    p30.ReturnPart = nil;
    p30.SetCacheParent = nil;
    p30.Expand = nil;
    p30.Dispose = nil;
end;

return u1;