-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local anim = require(script.Parent.Parent.Parent.util.anim);
local theme = require(script.Parent.Parent.Parent.util.theme);
local typography = require(script.Parent.Parent.display.typography);
local padding = require(script.Parent.Parent.util.padding);
local create = vide.create;
local source = vide.source;
local changed = vide.changed;
local show = vide.show;
local read = vide.read;

return function(u1: table) -- Line: 43
    -- upvalues: source (copy), read (copy), theme (copy), create (copy), anim (copy), typography (copy), show (copy), padding (copy), changed (copy)
    local u2 = source(Enum.GuiState.Idle);

    local function bg() -- Line: 47
        -- upvalues: read (ref), u1 (copy), u2 (copy), theme (ref)
        local v3 = read(u1.accent);
        local v4 = u2();

        if v3 then
            if v4 == Enum.GuiState.NonInteractable then
                return theme.acc[-5]();
            end;

            if v4 == Enum.GuiState.Idle then
                return theme.acc[0]();
            end;

            if v4 == Enum.GuiState.Hover then
                return theme.acc[3]();
            end;

            if v4 == Enum.GuiState.Press then
                return theme.acc[-8]();
            end;

            return theme.acc[0]();
        end;

        if v4 == Enum.GuiState.NonInteractable then
            return theme.bg[-2]();
        end;

        if v4 == Enum.GuiState.Idle then
            return theme.bg[3]();
        end;

        if v4 == Enum.GuiState.Hover then
            return theme.bg[6]();
        end;

        if v4 == Enum.GuiState.Press then
            return theme.bg[0]();
        end;

        return theme.acc[0]();
    end;

    local function stroke() -- Line: 65
        -- upvalues: read (ref), u1 (copy), u2 (copy), theme (ref)
        local v5 = read(u1.accent);
        local v6 = u2();

        if v5 then
            if v6 == Enum.GuiState.NonInteractable then
                return theme.acc[-7]();
            end;

            return theme.acc[-7]();
        end;

        if v6 == Enum.GuiState.NonInteractable then
            return theme.bg[-3]();
        end;

        return theme.bg[-3]();
    end;

    return create("TextButton")({
        Name = u1.text,
        AutoLocalize = false,
        Size = u1.size or UDim2.fromOffset(100, 30),
        Position = u1.position,
        AnchorPoint = u1.anchorpoint,
        AutomaticSize = u1.automaticsize,

        Interactable = function() -- Line: 87, Name: Interactable
            -- upvalues: read (ref), u1 (copy)
            return not read(u1.disabled);
        end,

        BackgroundColor3 = anim(bg),
        Activated = u1.activated,
        MouseButton2Click = u1.mouse2,
        MouseButton1Down = u1.down,
        MouseButton1Up = u1.up,
        typography({
            position = UDim2.fromScale(0.5, 0.5),
            anchorpoint = Vector2.new(0.5, 0.5),
            size = UDim2.fromScale(1, 1),
            automaticsize = Enum.AutomaticSize.Y,
            text = u1.text,
            truncate = Enum.TextTruncate.SplitWord,
            xalignment = u1.xalignment,
            accent = u1.accent,
            disabled = u1.disabled,

            visible = function() -- Line: 112, Name: visible
                -- upvalues: read (ref), u1 (copy)
                return read(u1.text) ~= "";
            end,

            code = u1.code,
            create("UIFlexItem")({
                FlexMode = Enum.UIFlexMode.Fill
            })
        }),
        show(function() -- Line: 125
            -- upvalues: read (ref), u1 (copy)
            return read(u1.stroke) ~= false;
        end, source(create("UIStroke")({
            Thickness = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = anim(stroke),
            Enabled = u1.stroke
        }))),
        show(function() -- Line: 140
            -- upvalues: read (ref), u1 (copy)
            return read(u1.corner) ~= false;
        end, source(create("UICorner")({
            CornerRadius = UDim.new(0, 4)
        }))),
        padding({
            x = UDim.new(0, 8),
            y = UDim.new(0, 2)
        }),
        changed("GuiState", u2),
        unpack(u1)
    });
end;