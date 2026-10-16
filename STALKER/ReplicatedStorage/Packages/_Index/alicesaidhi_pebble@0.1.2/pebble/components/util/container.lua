-- Decompiled with Potassium's decompiler.

local create = require(script.Parent.Parent.Parent.Parent.vide).create;

return function(p1) -- Line: 11, Name: container
    -- upvalues: create (copy)
    return create("Frame")({
        Name = "Container",
        AutoLocalize = false,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        p1
    });
end;