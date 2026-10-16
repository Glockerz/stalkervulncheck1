-- Decompiled with Potassium's decompiler.

local None = require(script.Parent.Parent:WaitForChild("Object"):WaitForChild("None"));
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));

local function u3(p1, p2) -- Line: 5
    return type(p1) .. tostring(p1) < type(p2) .. tostring(p2);
end;

return function(p4: any, u5: function?) -- Line: 9
    -- upvalues: u3 (copy), None (copy)
    local v6 = u3;

    if u5 ~= nil and u5 ~= None then
        if typeof(u5) == "function" then
            v6 = function(p7, p8) -- Line: 16
                -- upvalues: u5 (copy)
                local v9 = u5(p7, p8);

                if typeof(v9) ~= "number" then
                    error(("invalid result from compare function, expected number but got %s"):format((typeof(v9))));
                end;

                return v9 < 0;
            end;
        else
            error("invalid argument to Array.sort: compareFunction must be a function");

            v6 = function(p7, p8) -- Line: 16
                -- upvalues: u5 (copy)
                local v9 = u5(p7, p8);

                if typeof(v9) ~= "number" then
                    error(("invalid result from compare function, expected number but got %s"):format((typeof(v9))));
                end;

                return v9 < 0;
            end;
        end;
    end;

    table.sort(p4, v6);

    return p4;
end;