-- Decompiled with Potassium's decompiler.

local source = require(script.Parent.Parent.Parent.vide).source;
local u1 = newproxy();

return {
    new = function(p2: any, p3: function) -- Line: 22, Name: new
        -- upvalues: source (copy), u1 (copy)
        local u4 = {};

        for i, v in p2 do
            local v5;

            if v == u1 or not v then
                v5 = nil;
            else
                v5 = v;
            end;

            u4[i] = source(v5);
        end;

        local v6 = {};
        setmetatable(v6, {
            __index = function(p7, p8) -- Line: 36, Name: __index
                -- upvalues: u4 (copy)
                return u4[p8]();
            end,

            __newindex = function(p9, p10, p11) -- Line: 39, Name: __newindex
                -- upvalues: u4 (copy)
                u4[p10](p11);
            end
        });
        local v12 = {};
        setmetatable(v12, {
            __index = function(p13, p14) -- Line: 47, Name: __index
                -- upvalues: u4 (copy)
                local v15 = u4[p14];

                if v15 == nil then
                    error(`invalid index {p14}`, 2);
                end;

                return v15();
            end,

            __newindex = function(p16, p17, p18) -- Line: 53, Name: __newindex
                -- upvalues: u4 (copy)
                u4[p17](p18);
            end
        });

        for i, v in next, p3(v6) do
            if rawget(v12, i) then
                error(`duplicate field "{i}"`, 2);
            end;

            rawset(v12, i, v);
        end;

        return v12;
    end,

    null = u1
};