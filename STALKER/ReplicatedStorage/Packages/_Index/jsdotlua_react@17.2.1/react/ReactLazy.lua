-- Decompiled with Potassium's decompiler.

local console = require(script.Parent.Parent:WaitForChild("shared")).console;
local inspect = require(script.Parent.Parent:WaitForChild("luau-polyfill")).util.inspect;
require(script.Parent.Parent:WaitForChild("shared"));
local REACT_LAZY_TYPE = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols.REACT_LAZY_TYPE;

function lazyInitializer(u1: table)
    -- upvalues: console (copy), inspect (copy)
    if u1._status == -1 then
        local v2 = u1._result();
        u1._status = 0;
        u1._result = v2;
        v2:andThen(function(p3) -- Line: 79
            -- upvalues: u1 (copy), console (ref), inspect (ref)
            if u1._status == 0 then
                local default = p3.default;

                if _G.__DEV__ and default == nil then
                    console.error("lazy: Expected the result of a dynamic import() call. Instead received: `%s`\n\nYour code should look like: \n  local MyComponent = lazy(function() return reqquire(script.Parent.MyComponent) end)", inspect(p3));
                end;

                local v4 = u1;
                v4._status = 1;
                v4._result = default;
            end;
        end, function(p5) -- Line: 100
            -- upvalues: u1 (copy)
            if u1._status == 0 then
                local v6 = u1;
                v6._status = 2;
                v6._result = p5;
            end;
        end);
    end;

    if u1._status == 1 then
        return u1._result;
    end;

    error(u1._result);
end;

return {
    lazy = function(p7: function) -- Line: 118
        -- upvalues: REACT_LAZY_TYPE (copy), console (copy)
        local v8 = {
            ["$$typeof"] = REACT_LAZY_TYPE,
            _payload = {
                _status = -1,
                _result = p7
            },
            _init = lazyInitializer
        };

        if _G.__DEV__ then
            local u9 = nil;
            local u10 = nil;
            setmetatable(v8, {
                __index = function(p11, p12) -- Line: 140, Name: __index
                    -- upvalues: u9 (ref), u10 (ref)
                    if p12 == "defaultProps" then
                        return u9;
                    end;

                    if p12 == "propTypes" then
                        return u10;
                    end;
                end,

                __newindex = function(p13, p14, p15) -- Line: 149, Name: __newindex
                    -- upvalues: console (ref), u9 (ref), u10 (ref)
                    if p14 == "defaultProps" then
                        console.error("React.lazy(...): It is not supported to assign `defaultProps` to a lazy component import. Either specify them where the component is defined, or create a wrapping component around it.");
                        u9 = p15;
                        setmetatable(p13, {
                            __index = function() -- Line: 160, Name: __index
                            end,

                            __newindex = function() -- Line: 161, Name: __newindex
                            end
                        });
                    end;

                    if p14 == "propTypes" then
                        console.error("React.lazy(...): It is not supported to assign `propTypes` to a lazy component import. Either specify them where the component is defined, or create a wrapping component around it.");
                        u10 = p15;
                        setmetatable(p13, {
                            __index = function() -- Line: 174, Name: __index
                            end,

                            __newindex = function() -- Line: 175, Name: __newindex
                            end
                        });
                    end;
                end
            });
        end;

        return v8;
    end
};