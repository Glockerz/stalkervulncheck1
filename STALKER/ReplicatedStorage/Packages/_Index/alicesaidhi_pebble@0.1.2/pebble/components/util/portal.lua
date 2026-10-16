-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local create = vide.create;
local source = vide.source;
local effect = vide.effect;
local cleanup = vide.cleanup;
local action = vide.action;
local read = vide.read;
local u1 = 100000;

return function(u2: table) -- Line: 28, Name: portal
    -- upvalues: source (copy), effect (copy), cleanup (copy), vide (copy), create (copy), u1 (ref), read (copy), action (copy)
    local inherit_layout = u2.inherit_layout;
    local u3 = source(nil);
    local u4 = source(nil);
    local u5 = source(UDim2.fromScale(1, 1));
    local u6 = source(UDim2.fromScale(0, 0));
    local u7 = source(nil);
    effect(function() -- Line: 40
        -- upvalues: u3 (copy), u5 (copy), u6 (copy), cleanup (ref)
        local u8 = u3();

        if not u8 then
            return;
        end;

        local function update() -- Line: 44
            -- upvalues: u5 (ref), u8 (copy), u6 (ref)
            u5(UDim2.fromOffset(u8.AbsoluteSize.X, u8.AbsoluteSize.Y));
            u6(UDim2.fromOffset(u8.AbsolutePosition.X, u8.AbsolutePosition.Y));
        end;

        cleanup(u8:GetPropertyChangedSignal("AbsoluteSize"):Connect(update));
        cleanup(u8:GetPropertyChangedSignal("AbsolutePosition"):Connect(update));
    end);
    cleanup(vide.mount(function() -- Line: 54
        -- upvalues: cleanup (ref), create (ref), u1 (ref), u4 (copy), read (ref), inherit_layout (copy), u5 (copy), u6 (copy), u2 (copy)
        cleanup(create("Frame")({
            Name = `Portal:{u1}`,
            Parent = u4,
            AutoLocalize = false,
            ZIndex = u1,

            Size = function() -- Line: 62, Name: Size
                -- upvalues: read (ref), inherit_layout (ref), u5 (ref)
                if read(inherit_layout) == true then
                    return u5();
                end;

                return UDim2.fromScale(1, 1);
            end,

            Position = function() -- Line: 66, Name: Position
                -- upvalues: read (ref), inherit_layout (ref), u6 (ref)
                if read(inherit_layout) == true then
                    return u6();
                end;

                return UDim2.fromScale(0, 0);
            end,

            BackgroundTransparency = 1,
            unpack(u2)
        }));
    end));

    return create("Configuration")({
        Name = `PortalAnchor:{u1}`,

        AncestryChanged = function() -- Line: 82, Name: AncestryChanged
            -- upvalues: u7 (copy), u3 (copy), u4 (copy)
            local v9 = u7();

            if not v9 then
                u3(nil);

                return;
            end;

            u3(v9:FindFirstAncestorWhichIsA("GuiBase2d"));
            u4(v9:FindFirstAncestorWhichIsA("LayerCollector"));
        end,

        action(function(p10) -- Line: 92
            -- upvalues: u1 (ref), u7 (copy), u3 (copy), u4 (copy)
            u1 = u1 + 1;
            u7(p10);
            u3(p10:FindFirstAncestorWhichIsA("GuiBase2d"));
            u4(p10:FindFirstAncestorWhichIsA("LayerCollector"));
        end)
    });
end;