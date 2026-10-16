-- Decompiled with Potassium's decompiler.

local u9 = {
    Seconds = function(p1) -- Line: 13, Name: Seconds
        local v2;

        if type(p1) == "table" then
            v2 = p1.timing;
        else
            v2 = false;
        end;

        if type(v2) ~= "table" then
            return nil;
        end;

        local v3 = tonumber(v2.duration);

        if not v3 then
            local v4 = tonumber(v2.accepted_at);
            local v5 = tonumber(v2.deadline_at);
            v3 = v4 and (v5 and v5 - v4) or nil;
        end;

        if v3 and (v3 == v3 and v3 > 0) then
            return v3;
        end;

        return nil;
    end,

    Format = function(p6: number?) -- Line: 27, Name: Format
        if type(p6) ~= "number" then
            return nil;
        end;

        local math_ceil_ret = math.ceil(p6 / 60);
        local math_max_ret = math.max(1, math_ceil_ret);
        local v7 = math_max_ret // 60;
        local v8 = math_max_ret % 60;

        if v7 > 0 and v8 > 0 then
            return ("%dh %dm"):format(v7, v8);
        end;

        if v7 > 0 then
            return ("%dh"):format(v7);
        end;

        return ("%dm"):format(v8);
    end
};

function u9.Label(p10) -- Line: 37
    -- upvalues: u9 (copy)
    local v11 = u9.Format(u9.Seconds(p10));

    return v11 and "Time limit: " .. v11 or "No time limit";
end;

return u9;