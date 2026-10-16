-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local u1 = {};
local u2 = {};
local v3, u4 = require(script.Parent.signal)();

function u1.can_use_jabby(p5: userdata) -- Line: 19
    return game:GetService("RunService"):IsStudio();
end;

local function communication_is_allowed(p6: any, p7: any, p8: boolean?) -- Line: 27
    -- upvalues: u2 (copy), u1 (copy)
    if p6 == "server" then
        return true;
    end;

    u2[p6] = u2[p6] or {};
    u2[p7] = u2[p7] or {};

    if not (u1.can_use_jabby(p6) or u2[p6][p7]) then
        return false;
    end;

    if p8 then
        return true;
    end;

    u2[p7][p6] = p6;

    return true;
end;

u1.communication_is_allowed = communication_is_allowed;

function u1.check_no_wl(p9) -- Line: 53
    -- upvalues: u1 (copy), u4 (copy)
    if p9 == "server" then
        return true;
    end;

    if u1.can_use_jabby(p9) then
        return true;
    end;

    u4(p9);

    return false;
end;

function u1.check(p10: any, p11: any, p12: boolean?) -- Line: 44
    -- upvalues: communication_is_allowed (copy), u4 (copy)
    if communication_is_allowed(p10, p11, p12) then
        return true;
    end;

    u4(p10);

    return false;
end;

function u1._whitelist(p13, p14) -- Line: 64
    -- upvalues: u2 (copy)
    u2[p13] = u2[p13] or {};
    u2[p14] = u2[p14] or {};
    u2[p13][p14] = p13;
end;

u1.on_fail = v3;
Players.PlayerRemoving:Connect(function(p15) -- Line: 78
    -- upvalues: u2 (copy)
    u2[p15] = nil;
end);

return u1;