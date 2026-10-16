-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local v1 = {};
local u2 = nil;

local function rule() -- Line: 17
    -- upvalues: u2 (ref)
    if u2 == nil then
        local NpcHearing = script.Parent:FindFirstChild("NpcHearing");
        local v3, v4;

        if NpcHearing then
            v3, v4 = pcall(require, NpcHearing);
        else
            v3 = false;
            v4 = nil;
        end;

        u2 = v3 and (type(v4) == "table" and v4.IsAlly) or false;
    end;

    return u2;
end;

local function victimOf(p5) -- Line: 28
    while p5 and p5 ~= workspace do
        if p5:IsA("Model") and p5:FindFirstChildOfClass("Humanoid") then
            return p5;
        end;

        p5 = p5.Parent;
    end;

    return nil;
end;

function v1.IsAllyHit(p6, p7) -- Line: 38
    -- upvalues: victimOf (copy), Players (copy), u2 (ref)
    if typeof(p6) ~= "Instance" or typeof(p7) ~= "Instance" then
        return false;
    end;

    local v8 = victimOf(p7);

    if not v8 or v8 == p6 then
        return false;
    end;

    if Players:GetPlayerFromCharacter(v8) then
        return false;
    end;

    local Target = p6:FindFirstChild("Target");

    if Target and (Target:IsA("ObjectValue") and Target.Value == v8) then
        return false;
    end;

    if u2 == nil then
        local NpcHearing = script.Parent:FindFirstChild("NpcHearing");
        local v9, v10;

        if NpcHearing then
            v9, v10 = pcall(require, NpcHearing);
        else
            v9 = false;
            v10 = nil;
        end;

        local v11;

        if v9 and type(v10) == "table" then
            v11 = v10.IsAlly or false;
        else
            v11 = false;
        end;

        u2 = v11;
    end;

    local v12 = u2;
    local v13;

    if v12 == false then
        v13 = false;
    else
        v13 = v12(v8, p6) == true;
    end;

    return v13;
end;

return v1;