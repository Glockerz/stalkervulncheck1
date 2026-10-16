-- Decompiled with Potassium's decompiler.

local console = require(script.Parent.Parent:WaitForChild("shared")).console;
require(script.Parent:WaitForChild("ReactInternalTypes"));
local u1 = {};
local u2 = {};
local u3 = _G.__DEV__ and {} or nil;
local u4 = 0;

return {
    createCursor = function(p5) -- Line: 34, Name: createCursor
        return {
            current = p5
        };
    end,

    isEmpty = function() -- Line: 40, Name: isEmpty
        -- upvalues: u4 (ref)
        return u4 == 0;
    end,

    pop = function(p6: table, p7: any) -- Line: 44, Name: pop
        -- upvalues: u4 (ref), console (copy), u3 (ref), u2 (copy), u1 (copy)
        if u4 < 1 then
            if _G.__DEV__ then
                console.error("Unexpected pop.");
            end;

            return;
        end;

        if _G.__DEV__ and p7 ~= u3[u4] then
            console.error("Unexpected Fiber popped.");
        end;

        local v8 = u2[u4];

        if v8 == u1 then
            p6.current = nil;
        else
            p6.current = v8;
        end;

        u2[u4] = nil;

        if _G.__DEV__ then
            u3[u4] = nil;
        end;

        u4 = u4 - 1;
    end,

    push = function(p9: table, p10: any, p11: any) -- Line: 76, Name: push
        -- upvalues: u4 (ref), u2 (copy), u1 (copy), u3 (ref)
        u4 = u4 + 1;
        local current = p9.current;

        if current == nil then
            u2[u4] = u1;
        else
            u2[u4] = current;
        end;

        if _G.__DEV__ then
            u3[u4] = p11;
        end;

        p9.current = p10;
    end,

    checkThatStackIsEmpty = function() -- Line: 93, Name: checkThatStackIsEmpty
        -- upvalues: u4 (ref), console (copy)
        if _G.__DEV__ and u4 ~= 0 then
            console.error("Expected an empty stack. Something was not reset properly.");
        end;
    end,

    resetStackAfterFatalErrorInDev = function() -- Line: 101, Name: resetStackAfterFatalErrorInDev
        -- upvalues: u4 (ref), u2 (copy), u3 (ref)
        if _G.__DEV__ then
            u4 = 0;
            table.clear(u2);
            table.clear(u3);
        end;
    end
};