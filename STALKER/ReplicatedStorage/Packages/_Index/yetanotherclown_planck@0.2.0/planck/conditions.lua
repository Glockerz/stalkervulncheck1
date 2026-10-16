-- Decompiled with Potassium's decompiler.

local utils = require(script.Parent.utils);
local getConnectFunction = utils.getConnectFunction;
local u1 = {};

return {
    timePassed = function(u2: number) -- Line: 22, Name: timePassed
        local u3 = nil;

        return function() -- Line: 25
            -- upvalues: u3 (ref), u2 (copy)
            if u3 ~= nil and u2 > os.clock() - u3 then
                return false;
            end;

            u3 = os.clock();

            return true;
        end;
    end,

    runOnce = function() -- Line: 39, Name: runOnce
        local u4 = false;

        return function() -- Line: 42
            -- upvalues: u4 (ref)
            if u4 then
                return false;
            end;

            u4 = true;

            return true;
        end;
    end,

    onEvent = function(p5, p6) -- Line: 107, Name: onEvent
        -- upvalues: getConnectFunction (copy), utils (copy), u1 (copy)
        local v7 = getConnectFunction(p5, p6);
        assert(v7, "Event passed to .onEvent is not valid");
        local u8 = false;
        local u9 = {};
        local u10 = nil;

        local function disconnect() -- Line: 119
            -- upvalues: u10 (ref), utils (ref)
            if not u10 then
                return;
            end;

            utils.disconnectEvent(u10);
            u10 = nil;
        end;

        u10 = v7(function(...) -- Line: 128, Name: callback
            -- upvalues: u8 (ref), u9 (copy)
            u8 = true;
            table.insert(u9, { ... });
        end);

        local function hasNewEvent() -- Line: 135
            -- upvalues: u8 (ref), u9 (copy)
            if u8 then
                u8 = false;

                return true;
            end;

            table.clear(u9);

            return false;
        end;

        u1[hasNewEvent] = disconnect;

        return hasNewEvent, function() -- Line: 145, Name: collectEvents
            -- upvalues: u9 (copy)
            local u11 = 0;

            return function() -- Line: 147
                -- upvalues: u11 (ref), u9 (ref)
                u11 = u11 + 1;
                local table_remove_ret = table.remove(u9, 1);

                if table_remove_ret then
                    return u11, table.unpack(table_remove_ret);
                end;

                return nil;
            end;
        end, function() -- Line: 160, Name: getDisconnectFn
            -- upvalues: disconnect (copy)
            return disconnect;
        end;
    end,

    isNot = function(u12: function, ...) -- Line: 176, Name: isNot
        return function() -- Line: 177
            -- upvalues: u12 (copy)
            return not u12();
        end;
    end,

    cleanupCondition = function(p13: function) -- Line: 56, Name: cleanupCondition
        -- upvalues: u1 (copy)
        local v14 = u1[p13];

        if v14 then
            v14();
            u1[p13] = nil;
        end;
    end
};