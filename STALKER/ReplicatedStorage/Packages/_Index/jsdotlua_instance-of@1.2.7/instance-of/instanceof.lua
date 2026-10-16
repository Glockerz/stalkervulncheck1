-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;

return function(u1, u2) -- Line: 5, Name: instanceof
    -- upvalues: _G___DEV__ (copy)
    if _G___DEV__ then
        local v3 = typeof(u2) == "table";
        assert(v3, "Received a non-table as the second argument for instanceof");
    end;

    if typeof(u1) ~= "table" then
        return false;
    end;

    local success, result = pcall(function() -- Line: 14
        -- upvalues: u2 (copy), u1 (ref)
        local v4;

        if u2.new == nil then
            v4 = false;
        else
            v4 = u1.new == u2.new;
        end;

        return v4;
    end);

    if success and result then
        return true;
    end;

    local v5 = {
        [u1] = true
    };

    while u1 and typeof(u1) == "table" do
        u1 = getmetatable(u1);

        if typeof(u1) == "table" then
            u1 = u1.__index;

            if u1 == u2 then
                return true;
            end;
        end;

        if typeof(u1) == "table" then
            if v5[u1] then
                return false;
            end;

            v5[u1] = true;
        end;
    end;

    return false;
end;