-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.vide);
local action = vide.action;
local cleanup = vide.cleanup;

return function(u1) -- Line: 14, Name: cascade
    -- upvalues: action (copy), cleanup (copy)
    local v2 = {};
    local u3 = {};

    local function get_cascaded_value(p4: userdata?) -- Line: 19
        -- upvalues: u3 (copy), u1 (copy)
        while p4 ~= nil do
            local v5 = u3[p4];

            if v5 ~= nil then
                return v5;
            end;

            p4 = p4.Parent;
        end;

        return u1;
    end;

    function v2.send(u6: userdata) -- Line: 31
        -- upvalues: action (ref), cleanup (ref), u3 (copy)
        return action(function(u7) -- Line: 32
            -- upvalues: cleanup (ref), u3 (ref), u6 (copy)
            cleanup(function() -- Line: 33
                -- upvalues: u3 (ref), u7 (copy)
                u3[u7] = nil;
            end);
            u3[u7] = u6;
        end);
    end;

    function v2.receive(u8: function) -- Line: 41
        -- upvalues: action (ref), u3 (copy), u1 (copy), cleanup (ref)
        return action(function(u9) -- Line: 42
            -- upvalues: u8 (copy), u3 (ref), u1 (ref), cleanup (ref)
            local function recalculate() -- Line: 43
                -- upvalues: u8 (ref), u9 (copy), u3 (ref), u1 (ref)
                local Parent = u9.Parent;
                local v10;

                while true do
                    if Parent == nil then
                        v10 = u1;
                        break;
                    end;

                    v10 = u3[Parent];

                    if v10 ~= nil then
                        break;
                    end;

                    Parent = Parent.Parent;
                end;

                u8(v10);
            end;

            local Parent = u9.Parent;
            local v11;

            while true do
                if Parent == nil then
                    v11 = u1;
                    break;
                end;

                v11 = u3[Parent];

                if v11 ~= nil then
                    break;
                end;

                Parent = Parent.Parent;
            end;

            u8(v11);
            cleanup(u9.AncestryChanged:Connect(recalculate));
            cleanup(function() -- Line: 52
                -- upvalues: u8 (ref), u1 (ref)
                u8(u1);
            end);
        end);
    end;

    return v2;
end;