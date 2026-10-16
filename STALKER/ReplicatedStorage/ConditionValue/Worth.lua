-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local script_Parent = require(script.Parent);
local u1 = {};
local u2 = nil;

local function itemDb() -- Line: 18
    -- upvalues: u2 (ref), ReplicatedStorage (copy)
    if u2 == nil then
        local success, result = pcall(function() -- Line: 20
            -- upvalues: ReplicatedStorage (ref)
            return require(ReplicatedStorage:WaitForChild("ItemDatabase"));
        end);
        u2 = success and result and result or false;
    end;

    return u2 or nil;
end;

function u1.Scale(p3, p4, p5) -- Line: 27
    -- upvalues: script_Parent (copy), u2 (ref), ReplicatedStorage (copy)
    if not (p5 and p3) then
        return p5;
    end;

    if p3.ItemType == "AmmoPack" and (p3.stackSize and p3.stackSize > 0) then
        return p5 * (math.clamp(p4 and p4.CurrentRounds or p3.stackSize, 0, p3.stackSize) / p3.stackSize);
    end;

    if p3.MaxUses and p3.MaxUses > 1 then
        return p5 * script_Parent.UsesMultiplier(p4, p3);
    end;

    local Multiplier = script_Parent.Multiplier;

    if u2 == nil then
        local success, result = pcall(function() -- Line: 20
            -- upvalues: ReplicatedStorage (ref)
            return require(ReplicatedStorage:WaitForChild("ItemDatabase"));
        end);
        u2 = success and result and result or false;
    end;

    return p5 * Multiplier(p4, p3, u2 or nil);
end;

function u1.Of(p6, p7) -- Line: 59
    -- upvalues: u1 (copy)
    if type(p6) ~= "table" or type(p6.BaseSellValue) ~= "number" then
        return 0;
    end;

    local v8 = u1.Scale(p6, p7, p6.BaseSellValue) + 0.5;

    return math.floor(v8);
end;

return u1;