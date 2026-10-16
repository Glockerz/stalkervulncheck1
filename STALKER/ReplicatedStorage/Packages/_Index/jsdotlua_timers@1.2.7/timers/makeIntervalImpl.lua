-- Decompiled with Potassium's decompiler.

local u1 = newproxy(false);

return function(u2) -- Line: 9
    -- upvalues: u1 (copy)
    return {
        setInterval = function(u3: any, p4: number, ...) -- Line: 10, Name: setInterval
            -- upvalues: u1 (ref), u2 (copy)
            local u5 = { ... };
            local u6 = {
                [u1] = 1
            };
            local u7 = (p4 == nil and 0 or p4) / 1000;

            local function u8() -- Line: 24
                -- upvalues: u2 (ref), u7 (copy), u6 (copy), u1 (ref), u3 (copy), u5 (copy), u8 (ref)
                u2(u7, function() -- Line: 25
                    -- upvalues: u6 (ref), u1 (ref), u3 (ref), u5 (ref), u8 (ref)
                    if u6[u1] == 1 then
                        u3(unpack(u5));
                        u8();
                    end;
                end);
            end;

            u8();

            return u6;
        end,

        clearInterval = function(p9: table) -- Line: 38, Name: clearInterval
            -- upvalues: u1 (ref)
            if p9 == nil then
                return;
            end;

            if p9[u1] == 1 then
                p9[u1] = 3;
            end;
        end
    };
end;