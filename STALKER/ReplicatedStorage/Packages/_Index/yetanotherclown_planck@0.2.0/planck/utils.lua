-- Decompiled with Potassium's decompiler.

local u1 = { "Connect", "On", "on", "connect" };
local u2 = { "disconnect", "Disconnect", "destroy", "Destroy" };

local function getConnectFunction(p3, u4) -- Line: 135
    -- upvalues: u1 (copy)
    local u5 = p3;

    if typeof(u4) == "RBXScriptSignal" or type(u4) == "table" then
        u5 = u4;
    elseif type(u4) == "string" then
        u5 = p3[u4];
    end;

    if type(u5) == "function" then
        return u5;
    end;

    if typeof(u5) == "RBXScriptSignal" then
        return function(p6) -- Line: 147
            -- upvalues: u5 (ref)
            return u5:Connect(p6);
        end;
    end;

    if type(u5) == "table" then
        if type(u4) == "function" then
            return function(p7) -- Line: 154
                -- upvalues: u4 (copy), u5 (ref)
                return u4(u5, p7);
            end;
        end;

        for _, v in u1 do
            if type(u5[v]) == "function" then
                return function(p8) -- Line: 164
                    -- upvalues: u5 (ref), v (copy)
                    return u5[v](u5, p8);
                end;
            end;
        end;
    end;

    return nil;
end;

return {
    getSystem = function(p9) -- Line: 14, Name: getSystem
        if type(p9) == "function" then
            return p9;
        end;

        if type(p9) == "table" and p9.system then
            return p9.system;
        end;

        return nil;
    end,

    getSystemName = function(p10) -- Line: 24, Name: getSystemName
        local debug_info_ret = debug.info(p10, "n");

        if not debug_info_ret or string.len(debug_info_ret) == 0 then
            local debug_info_ret2, v11 = debug.info(p10, "sl");
            debug_info_ret = `{debug_info_ret2}:{v11}`;
        end;

        return debug_info_ret;
    end,

    isPhase = function(p12) -- Line: 34, Name: isPhase
        if type(p12) == "table" and p12._type == "phase" then
            return p12;
        end;

        return nil;
    end,

    isPipeline = function(p13) -- Line: 42, Name: isPipeline
        if type(p13) == "table" and p13._type == "pipeline" then
            return p13;
        end;

        return nil;
    end,

    getEventIdentifier = function(p14, p15) -- Line: 50, Name: getEventIdentifier
        return `{p14}{p15 and `@{p15}` or ""}`;
    end,

    isValidEvent = function(p16, p17) -- Line: 173, Name: isValidEvent
        -- upvalues: getConnectFunction (copy)
        return getConnectFunction(p16, p17) ~= nil;
    end,

    getConnectFunction = getConnectFunction,

    disconnectEvent = function(p18) -- Line: 73, Name: disconnectEvent
        -- upvalues: u2 (copy)
        if type(p18) == "function" then
            p18();

            return;
        end;

        if typeof(p18) == "RBXScriptConnection" then
            p18:Disconnect();

            return;
        end;

        if type(p18) == "table" then
            for _, v in u2 do
                if p18[v] and type(p18[v]) == "function" then
                    p18[v](p18);

                    return;
                end;
            end;
        end;
    end
};