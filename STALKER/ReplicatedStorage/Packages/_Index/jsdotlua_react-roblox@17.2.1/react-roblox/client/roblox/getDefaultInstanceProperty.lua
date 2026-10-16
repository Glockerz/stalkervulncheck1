-- Decompiled with Potassium's decompiler.

local u1 = require(script.Parent.Parent.Parent.Parent:WaitForChild("shared")).Symbol.named("Nil");
local u2 = {};

local function tryPropertyName(p3, p4) -- Line: 32
    return p3[p4];
end;

return function(p5, p6) -- Line: 36, Name: getDefaultInstanceProperty
    -- upvalues: u2 (copy), u1 (copy), tryPropertyName (copy)
    local v7 = u2[p5];

    if v7 then
        local v8 = v7[p6];

        if v8 == u1 then
            return true, nil;
        end;

        if v8 ~= nil then
            return true, v8;
        end;
    else
        v7 = {};
        u2[p5] = v7;
    end;

    local Instance_new_ret = Instance.new(p5);
    local success, result = pcall(tryPropertyName, Instance_new_ret, p6);
    Instance_new_ret:Destroy();

    if success then
        if result == nil then
            v7[p6] = u1;

            return success, result;
        end;

        v7[p6] = result;
    end;

    return success, result;
end;