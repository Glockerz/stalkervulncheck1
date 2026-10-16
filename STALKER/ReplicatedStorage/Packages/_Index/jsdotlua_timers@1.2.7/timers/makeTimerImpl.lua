-- Decompiled with Potassium's decompiler.

local u1 = newproxy(false);

return function(u2) -- Line: 10
    -- upvalues: u1 (copy)
    return {
        setTimeout = function(u3: any, p4: number?, ...) -- Line: 11, Name: setTimeout
            -- upvalues: u1 (ref), u2 (copy)
            local u5 = { ... };
            local u6 = {
                [u1] = 1
            };
            u2((p4 == nil and 0 or p4) / 1000, function() -- Line: 24
                -- upvalues: u6 (copy), u1 (ref), u3 (copy), u5 (copy)
                if u6[u1] == 1 then
                    u3(unpack(u5));
                    u6[u1] = 2;
                end;
            end);

            return u6;
        end,

        clearTimeout = function(p7: table) -- Line: 34, Name: clearTimeout
            -- upvalues: u1 (ref)
            if p7 == nil then
                return;
            end;

            if p7[u1] == 1 then
                p7[u1] = 3;
            end;
        end
    };
end;