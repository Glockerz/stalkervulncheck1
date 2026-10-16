-- Decompiled with Potassium's decompiler.

local console = require(script.Parent.Parent:WaitForChild("shared")).console;
local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols;
local REACT_PROVIDER_TYPE = ReactSymbols.REACT_PROVIDER_TYPE;
local REACT_CONTEXT_TYPE = ReactSymbols.REACT_CONTEXT_TYPE;

return {
    createContext = function(p1: any, p2: function?) -- Line: 23
        -- upvalues: REACT_CONTEXT_TYPE (copy), REACT_PROVIDER_TYPE (copy), console (copy)
        local u3 = {
            ["$$typeof"] = REACT_CONTEXT_TYPE,
            _calculateChangedBits = p2,
            _currentValue = p1,
            _currentValue2 = p1,
            _threadCount = 0,
            Provider = nil,
            Consumer = nil,
            displayName = nil,
            _currentRenderer = nil,
            _currentRenderer2 = nil
        };
        u3.Provider = {
            ["$$typeof"] = REACT_PROVIDER_TYPE,
            _context = u3
        };
        local u4 = false;

        if _G.__DEV__ then
            local v5 = {
                ["$$typeof"] = REACT_CONTEXT_TYPE,
                _context = u3,
                _calculateChangedBits = u3._calculateChangedBits
            };
            setmetatable(v5, {
                __index = function(p6, p7) -- Line: 68, Name: __index
                    -- upvalues: u3 (copy)
                    if p7 == "_currentValue" then
                        return u3._currentValue;
                    end;

                    if p7 == "_currentValue2" then
                        return u3._currentValue2;
                    end;

                    if p7 == "_threadCount" then
                        return u3._threadCount;
                    end;

                    if p7 == "displayName" then
                        return u3.displayName;
                    end;

                    return nil;
                end,

                __newindex = function(p8, p9, p10) -- Line: 81, Name: __newindex
                    -- upvalues: u3 (copy), u4 (ref), console (ref)
                    if p9 == "_currentValue" then
                        u3._currentValue = p10;

                        return;
                    end;

                    if p9 == "_currentValue2" then
                        u3._currentValue2 = p10;

                        return;
                    end;

                    if p9 == "_threadCount" then
                        u3._threadCount = p10;

                        return;
                    end;

                    if p9 == "displayName" and not u4 then
                        console.warn("Setting `displayName` on Context.Consumer has no effect. " .. "You should set it directly on the context with Context.displayName = " .. p10 .. ".");
                        u4 = true;
                    end;
                end
            });
            u3.Consumer = v5;
        else
            u3.Consumer = u3;
        end;

        if _G.__DEV__ then
            u3._currentRenderer = nil;
            u3._currentRenderer2 = nil;
        end;

        return u3;
    end
};