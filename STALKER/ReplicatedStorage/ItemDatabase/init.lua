-- Decompiled with Potassium's decompiler.

local Categories = script:WaitForChild("Categories");
local u1 = {};

for _, child in ipairs(Categories:GetChildren()) do
    if child:IsA("ModuleScript") then
        local v2 = require(child);

        if v2.RoundTypes then
            u1.RoundTypes = v2.RoundTypes;
        end;

        if v2.MagFamilies then
            u1.MagFamilies = v2.MagFamilies;
        end;

        local v3 = child;

        for i, v in pairs(v2) do
            if i ~= "RoundTypes" and i ~= "MagFamilies" then
                if u1[i] then
                    warn(string.format("[ItemDatabase] duplicate item ID \'%s\' in module \'%s\' (overwriting)", i, v3.Name));
                end;

                u1[i] = v;
            end;
        end;
    end;
end;

u1.UpgradeRecipes = {};
local v4 = 0;

for i, v in pairs(u1) do
    if type(v) == "table" and v.ItemType == "UpgradeKit" then
        local AppliesTo = v.AppliesTo;
        local Produces = v.Produces;
        local RequiresTool = v.RequiresTool;
        local v5;

        if type(AppliesTo) == "string" then
            v5 = rawget(u1, AppliesTo) or nil;
        else
            v5 = nil;
        end;

        local v6;

        if type(Produces) == "string" then
            v6 = rawget(u1, Produces) or nil;
        else
            v6 = nil;
        end;

        local v7;

        if type(RequiresTool) == "string" then
            v7 = rawget(u1, RequiresTool) or nil;
        else
            v7 = nil;
        end;

        if v5 then
            if v6 then
                if v7 then
                    if v5.MagType == v6.MagType then
                        u1.UpgradeRecipes[i] = {
                            base = AppliesTo,
                            result = Produces,
                            tool = RequiresTool
                        };
                    else
                        v4 = v4 + 1;
                        warn(string.format("[ItemDatabase] upgrade kit \'%s\' would change MagType (%s -> %s) -- recipe dropped, see the transmutation note in docs/contracts.md", i, tostring(v5.MagType), (tostring(v6.MagType))));
                    end;
                else
                    v4 = v4 + 1;
                    warn(string.format("[ItemDatabase] upgrade kit \'%s\' names a nonexistent RequiresTool \'%s\' -- recipe dropped", i, (tostring(RequiresTool))));
                end;
            else
                v4 = v4 + 1;
                warn(string.format("[ItemDatabase] upgrade kit \'%s\' names a nonexistent Produces \'%s\' -- recipe dropped", i, (tostring(Produces))));
            end;
        else
            v4 = v4 + 1;
            warn(string.format("[ItemDatabase] upgrade kit \'%s\' names a nonexistent AppliesTo \'%s\' -- recipe dropped", i, (tostring(AppliesTo))));
        end;
    end;
end;

if v4 > 0 then
    warn(string.format("[ItemDatabase] %d upgrade recipe(s) dropped as invalid", v4));
end;

function u1.GetItemData(p8: string) -- Line: 95
    -- upvalues: u1 (copy)
    local v9 = u1[p8];

    if v9 then
        return v9;
    end;

    warn("Item ID not found in database: " .. tostring(p8));

    return {
        Name = "Unknown",
        ItemType = "General",
        ImageID = "",
        Size = Vector2.new(1, 1),
        BackgroundColor = Color3.fromRGB(100, 100, 100)
    };
end;

function u1.MagFits(p10, p11) -- Line: 120
    -- upvalues: u1 (copy)
    if p10 == nil or p11 == nil then
        return false;
    end;

    if p10 == p11 then
        return true;
    end;

    local MagFamilies = u1.MagFamilies;

    if not MagFamilies then
        return false;
    end;

    local v12 = MagFamilies[p10];
    local v13;

    if v12 == nil then
        v13 = false;
    else
        v13 = v12 == MagFamilies[p11];
    end;

    return v13;
end;

function u1.WidthCapFor(p14, p15) -- Line: 144
    -- upvalues: u1 (copy)
    if p15 == nil or p14 == nil then
        return p15;
    end;

    local v16 = type(p14) == "table" and p14 and p14 or u1[p14];

    if type(v16) == "table" and v16.IgnoresPouchWidth then
        return nil;
    end;

    return p15;
end;

return u1;