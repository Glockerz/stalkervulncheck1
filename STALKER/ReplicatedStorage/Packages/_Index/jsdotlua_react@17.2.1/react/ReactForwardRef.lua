-- Decompiled with Potassium's decompiler.

local console = require(script.Parent.Parent:WaitForChild("shared")).console;
local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols;
require(script.Parent.Parent:WaitForChild("shared"));
local REACT_FORWARD_REF_TYPE = ReactSymbols.REACT_FORWARD_REF_TYPE;
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE;

return {
    forwardRef = function(p1: function) -- Line: 27
        -- upvalues: REACT_MEMO_TYPE (copy), console (copy), REACT_FORWARD_REF_TYPE (copy)
        if _G.__DEV__ then
            if typeof(p1) == "table" and p1["$$typeof"] == REACT_MEMO_TYPE then
                console.error("forwardRef requires a render function but received a `memo` component. Instead of forwardRef(memo(...)), use memo(forwardRef(...)).");
            elseif typeof(p1) == "function" then
                local debug_info_ret, _ = debug.info(p1, "a");

                if debug_info_ret ~= 0 and debug_info_ret ~= 2 then
                    console.error("forwardRef render functions accept exactly two parameters: props and ref. %s", debug_info_ret == 1 and "Did you forget to use the ref parameter?" or "Any additional parameter will be undefined.");
                end;
            else
                console.error("forwardRef requires a render function but was given %s.", (typeof(p1)));
            end;
        end;

        local v2 = {
            ["$$typeof"] = REACT_FORWARD_REF_TYPE,
            render = p1
        };

        if _G.__DEV__ then
            local u3 = nil;
            setmetatable(v2, {
                __index = function(p4, p5) -- Line: 84, Name: __index
                    -- upvalues: u3 (ref)
                    if p5 == "displayName" then
                        return u3;
                    end;

                    return rawget(p4, p5);
                end,

                __newindex = function(p6, p7, p8) -- Line: 90, Name: __newindex
                    -- upvalues: u3 (ref)
                    if p7 == "displayName" then
                        u3 = p8;

                        return;
                    end;

                    rawset(p6, p7, p8);
                end
            });
        end;

        return v2;
    end
};