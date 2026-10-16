-- Decompiled with Potassium's decompiler.

local u1 = {
    Version = "3.3",
    AttachmentName = "DmgPoint",
    DebugMode = false,
    WarningMessage = false
};
local script_MainHandler = require(script.MainHandler);
local script_HitboxObject = require(script.HitboxObject);

function u1.Initialize(p2, p3, p4) -- Line: 15
    -- upvalues: script_MainHandler (copy), script_HitboxObject (copy), u1 (copy)
    assert(p3, "You must provide an object instance.");
    local v5 = script_MainHandler:check(p3);

    if not v5 then
        v5 = script_HitboxObject:new();
        v5:config(p3, p4);
        v5:seekAttachments(u1.AttachmentName, u1.WarningMessage);
        v5.debugMode = u1.DebugMode;
        script_MainHandler:add(v5);
    end;

    return v5;
end;

function u1.Deinitialize(p6, p7) -- Line: 29
    -- upvalues: script_MainHandler (copy)
    script_MainHandler:remove(p7);
end;

function u1.GetHitbox(p8, p9) -- Line: 33
    -- upvalues: script_MainHandler (copy)
    return script_MainHandler:check(p9);
end;

return u1;