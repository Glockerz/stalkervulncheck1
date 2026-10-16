-- Decompiled with Potassium's decompiler.

return function() -- Line: 36, Name: createSignal
    local u1 = {};
    local u2 = {};
    local u3 = false;

    return function(u4) -- Line: 41, Name: subscribe
        -- upvalues: u3 (ref), u1 (copy), u2 (copy)
        local v5 = typeof(u4) == "function";
        assert(v5, "Can only subscribe to signals with a function.");
        local u6 = {
            disconnected = false,
            callback = u4
        };

        if u3 and not u1[u4] then
            u2[u4] = u6;
        end;

        u1[u4] = u6;

        return function() -- Line: 60, Name: disconnect
            -- upvalues: u6 (copy), u1 (ref), u4 (copy), u2 (ref)
            assert(not u6.disconnected, "Listeners can only be disconnected once.");
            u6.disconnected = true;
            u1[u4] = nil;
            u2[u4] = nil;
        end;
    end, function(...) -- Line: 74, Name: fire
        -- upvalues: u3 (ref), u1 (copy), u2 (copy)
        u3 = true;

        for i, v in u1 do
            if not (v.disconnected or u2[i]) then
                i(...);
            end;
        end;

        u3 = false;
        table.clear(u2);
    end;
end;