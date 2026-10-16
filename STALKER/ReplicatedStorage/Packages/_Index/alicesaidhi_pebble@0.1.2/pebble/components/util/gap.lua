-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local container = require(script.Parent.container);
local read = vide.read;

return function(u1: table) -- Line: 14
    -- upvalues: read (copy), container (copy)
    local function direction() -- Line: 16
        -- upvalues: read (ref), u1 (copy)
        return read(u1.direction) or "x";
    end;

    return container({
        Size = function() -- Line: 22, Name: Size
            -- upvalues: read (ref), u1 (copy)
            if (read(u1.direction) or "x") == "x" then
                return UDim2.new(0, read(u1.gap), 1, 0);
            end;

            return UDim2.new(1, 0, 0, read(u1.gap));
        end
    });
end;