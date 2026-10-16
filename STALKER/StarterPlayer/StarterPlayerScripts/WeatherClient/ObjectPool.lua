-- Decompiled with Potassium's decompiler.

local CFrame_new_ret = CFrame.new(0, 0, 1000000);

return {
    new = function(p1: userdata, p2: number?) -- Line: 13, Name: new
        -- upvalues: CFrame_new_ret (copy)
        local u3 = {
            Object = p1:Clone(),
            Available = {}
        };

        for i = 1, p2 or 1 do
            u3.Available[i] = u3.Object:Clone();
            local _ = i;
        end;

        function u3.Get(p4) -- Line: 23
            -- upvalues: u3 (copy)
            local v5 = #u3.Available;
            local v6 = u3.Available[v5];

            if not v6 then
                return u3.Object:Clone();
            end;

            table.remove(u3.Available, v5);

            return v6;
        end;

        function u3.Return(p7: table, p8: userdata) -- Line: 34
            -- upvalues: CFrame_new_ret (ref), u3 (copy)
            p8.CFrame = CFrame_new_ret;
            table.insert(u3.Available, p8);
        end;

        return u3;
    end
};