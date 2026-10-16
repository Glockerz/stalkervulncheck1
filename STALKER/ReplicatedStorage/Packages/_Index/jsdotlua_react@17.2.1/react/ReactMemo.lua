-- Decompiled with Potassium's decompiler.

local shared = require(script.Parent.Parent:WaitForChild("shared"));
local console = shared.console;
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local Array = v1.Array;
local Object = v1.Object;
local inspect = v1.util.inspect;
local ReactSymbols = shared.ReactSymbols;
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE;
local REACT_ELEMENT_TYPE = ReactSymbols.REACT_ELEMENT_TYPE;
local isValidElementType = shared.isValidElementType;
local getComponentName = shared.getComponentName;

return {
    memo = function(u2: any, p3: function?) -- Line: 37
        -- upvalues: isValidElementType (copy), Object (copy), Array (copy), REACT_ELEMENT_TYPE (copy), getComponentName (copy), inspect (copy), console (copy), REACT_MEMO_TYPE (copy)
        if _G.__DEV__ and not isValidElementType(u2) then
            local v4 = "";

            if u2 == nil or typeof(u2) == "table" and #Object.keys(u2) == 0 then
                v4 = v4 .. " You likely forgot to export your component from the file it\'s defined in, or you might have mixed up default and named imports.";
            end;

            local v5;

            if u2 == nil then
                v5 = "nil";
            elseif Array.isArray(u2) then
                v5 = "array";
            elseif u2 == nil or (typeof(u2) ~= "table" or u2["$$typeof"] ~= REACT_ELEMENT_TYPE) then
                v5 = typeof(u2);

                if u2 ~= nil then
                    v4 = "\n" .. inspect(u2);
                end;
            else
                v5 = string.format("<%s />", getComponentName(u2.type) or "UNKNOWN");
                v4 = " Did you accidentally export a JSX literal or Element instead of a component?";
            end;

            console.error("memo: The first argument must be a component. Instead received: `%s`.%s", v5, v4);
        end;

        local v6 = {
            ["$$typeof"] = REACT_MEMO_TYPE,
            type = u2,
            compare = p3 or nil
        };

        if _G.__DEV__ then
            local u7 = nil;
            setmetatable(v6, {
                __index = function(p8, p9) -- Line: 103, Name: __index
                    -- upvalues: u7 (ref)
                    if p9 == "displayName" then
                        return u7;
                    end;

                    return rawget(p8, p9);
                end,

                __newindex = function(p10, p11, p12) -- Line: 109, Name: __newindex
                    -- upvalues: u7 (ref), u2 (copy)
                    if p11 == "displayName" then
                        u7 = p12;

                        if typeof(u2) == "table" and u2.displayName == nil then
                            u2.displayName = u7;
                        end;
                    else
                        rawset(p10, p11, p12);
                    end;
                end
            });
        end;

        return v6;
    end
};