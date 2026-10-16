-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
local isArray = require(script.Parent:WaitForChild("isArray"));
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

local function flat(p1: any, p2: number?) -- Line: 5
    -- upvalues: _G___DEV__ (copy), isArray (copy), flat (copy)
    if _G___DEV__ then
        if typeof(p1) ~= "table" then
            error(string.format("Array.flat called on %s", (typeof(p1))));
        end;

        if p2 ~= nil and typeof(p2) ~= "number" then
            error("depth is not a number or nil");
        end;
    end;

    local v3 = p2 or 1;
    local v4 = {};

    for _, v in p1 do
        if isArray(v) then
            local v5;

            if v3 > 1 then
                v5 = flat(v, v3 - 1);
            else
                v5 = v;
            end;

            for _, v2 in v5 do
                table.insert(v4, v2);
            end;
        else
            table.insert(v4, v);
        end;
    end;

    return v4;
end;

return flat;