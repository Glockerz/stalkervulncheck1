-- Decompiled with Potassium's decompiler.

local inspect = require(script.Parent.Parent:WaitForChild("collections")).inspect;

return function() -- Line: 5
    -- upvalues: inspect (copy)
    local v1 = {};
    local u2 = 0;

    local function indent() -- Line: 9
        -- upvalues: u2 (ref)
        return string.rep("  ", u2);
    end;

    function v1.log(p3, ...) -- Line: 13
        -- upvalues: inspect (ref), u2 (ref)
        local v4;

        if typeof(p3) == "string" then
            v4 = string.format(p3, ...);
        else
            v4 = inspect(p3);
        end;

        print(string.rep("  ", u2) .. v4);
    end;

    function v1.debug(p5, ...) -- Line: 23
        -- upvalues: inspect (ref), u2 (ref)
        local v6;

        if typeof(p5) == "string" then
            v6 = string.format(p5, ...);
        else
            v6 = inspect(p5);
        end;

        print(string.rep("  ", u2) .. v6);
    end;

    function v1.info(p7, ...) -- Line: 33
        -- upvalues: inspect (ref), u2 (ref)
        local v8;

        if typeof(p7) == "string" then
            v8 = string.format(p7, ...);
        else
            v8 = inspect(p7);
        end;

        print(string.rep("  ", u2) .. v8);
    end;

    function v1.warn(p9, ...) -- Line: 43
        -- upvalues: inspect (ref), u2 (ref)
        local v10;

        if typeof(p9) == "string" then
            v10 = string.format(p9, ...);
        else
            v10 = inspect(p9);
        end;

        warn(string.rep("  ", u2) .. v10);
    end;

    function v1.error(p11, ...) -- Line: 53
        -- upvalues: inspect (ref), u2 (ref)
        local v12;

        if typeof(p11) == "string" then
            v12 = string.format(p11, ...);
        else
            v12 = inspect(p11);
        end;

        warn(string.rep("  ", u2) .. v12);
    end;

    function v1.group(p13, ...) -- Line: 65
        -- upvalues: inspect (ref), u2 (ref)
        local v14;

        if typeof(p13) == "string" then
            v14 = string.format(p13, ...);
        else
            v14 = inspect(p13);
        end;

        print(string.rep("  ", u2) .. v14);
        u2 = u2 + 1;
    end;

    function v1.groupCollapsed(p15, ...) -- Line: 76
        -- upvalues: inspect (ref), u2 (ref)
        local v16;

        if typeof(p15) == "string" then
            v16 = string.format(p15, ...);
        else
            v16 = inspect(p15);
        end;

        print(string.rep("  ", u2) .. v16);
        u2 = u2 + 1;
    end;

    function v1.groupEnd() -- Line: 88
        -- upvalues: u2 (ref)
        if u2 > 0 then
            u2 = u2 - 1;
        end;
    end;

    return v1;
end;