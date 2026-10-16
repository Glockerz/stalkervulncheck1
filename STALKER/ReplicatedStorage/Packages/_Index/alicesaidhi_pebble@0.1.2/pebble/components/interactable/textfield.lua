-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local anim = require(script.Parent.Parent.Parent.util.anim);
local theme = require(script.Parent.Parent.Parent.util.theme);
require(script.Parent.Parent.display.typography);
local padding = require(script.Parent.Parent.util.padding);
local create = vide.create;
local source = vide.source;
local changed = vide.changed;
local effect = vide.effect;
local action = vide.action;
local read = vide.read;

return function(u1: table) -- Line: 41
    -- upvalues: source (copy), effect (copy), read (copy), theme (copy), create (copy), anim (copy), action (copy), changed (copy), padding (copy)
    local u2 = source(Enum.GuiState.Idle);
    local u3 = source(false);
    local u4 = source();
    local u5 = source("");
    effect(function() -- Line: 48
        -- upvalues: u5 (copy), read (ref), u1 (copy)
        u5(read(u1.text) or "");
    end);

    local function bg() -- Line: 52
        -- upvalues: u2 (copy), theme (ref), u3 (copy)
        if u2() == Enum.GuiState.NonInteractable then
            return theme.bg[0]();
        end;

        if u3() then
            return theme.bg[-3]();
        end;

        return theme.bg[-2]();
    end;

    local function fg() -- Line: 60
        -- upvalues: read (ref), u1 (copy), theme (ref)
        if read(u1.disabled) then
            return theme.fg_on_bg_low[0]();
        end;

        return theme.fg_on_bg_high[0]();
    end;

    local function stroke() -- Line: 67
        -- upvalues: u2 (copy), theme (ref), u3 (copy)
        local v6 = u2();

        if v6 == Enum.GuiState.NonInteractable then
            return theme.bg[-3]();
        end;

        if u3() then
            return theme.acc[5]();
        end;

        if v6 == Enum.GuiState.Idle then
            return theme.bg[-3]();
        end;

        if v6 == Enum.GuiState.Hover then
            return theme.bg[3]();
        end;

        return theme.bg[-3]();
    end;

    effect(function() -- Line: 78
        -- upvalues: u3 (copy), u4 (copy)
        if u3() == true and u4() then
            u4():CaptureFocus();
        end;
    end);
    local v7 = create("TextButton");
    local v8 = {
        Name = u1.placeholder or "Textbox",
        AutoLocalize = false,
        Size = u1.size or UDim2.fromOffset(300, 30),
        Position = u1.position,
        AnchorPoint = u1.anchorpoint,

        Activated = function() -- Line: 93, Name: Activated
            -- upvalues: u3 (copy)
            u3(true);
        end,

        Interactable = function() -- Line: 97, Name: Interactable
            -- upvalues: u1 (copy)
            return not u1.disabled;
        end,

        BackgroundColor3 = anim(bg),
        ClipsDescendants = true
    };
    local v9 = create("TextBox");
    local v11 = {
        Size = UDim2.fromScale(1, 1),
        AutoLocalize = false,
        MultiLine = u1.multiline,
        BackgroundTransparency = 1,

        Focused = function() -- Line: 114, Name: Focused
            -- upvalues: u3 (copy)
            u3(true);
        end,

        FocusLost = function(p10) -- Line: 118, Name: FocusLost
            -- upvalues: u3 (copy), u1 (copy), u5 (copy)
            u3(false);

            if u1.focuslost then
                u1.focuslost(u5(), p10);
            end;

            if u1.enter then
                u1.enter(u5());
            end;
        end,

        TextSize = theme.body,

        FontFace = function() -- Line: 130, Name: FontFace
            -- upvalues: read (ref), u1 (copy), theme (ref)
            if read(u1.code) then
                return theme.code;
            end;

            return theme.font;
        end,

        TextColor3 = anim(fg),
        PlaceholderColor3 = theme.fg_on_bg_low[0],
        PlaceholderText = u1.placeholder,
        Text = u1.text,
        ClipsDescendants = true,
        TextXAlignment = Enum.TextXAlignment.Left,

        TextYAlignment = function() -- Line: 142, Name: TextYAlignment
            -- upvalues: read (ref), u1 (copy)
            if read(u1.multiline) then
                return Enum.TextYAlignment.Top;
            end;

            return Enum.TextYAlignment.Center;
        end
    };
    local v12 = action(u4);
    local v13 = changed("Text", u5);
    local v14;

    if u1.oninput then
        v14 = changed("Text", u1.oninput);
    else
        v14 = nil;
    end;

    v11[1], v11[2], v11[3] = v12, v13, v14;
    v8[1], v8[2], v8[3], v8[4], v8[5] = v9(v11), create("UIStroke")({
    Thickness = 1,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    Color = anim(stroke),
    Enabled = u1.stroke
}), create("UICorner")({
    CornerRadius = function() -- Line: 161, Name: CornerRadius
        -- upvalues: read (ref), u1 (copy)
        if read(u1.corner) == false then
            return UDim.new();
        end;

        return UDim.new(0, 4);
    end
}), padding({
    x = UDim.new(0, 8),
    y = UDim.new(0, 2)
}), changed("GuiState", u2);

    return v7(v8);
end;