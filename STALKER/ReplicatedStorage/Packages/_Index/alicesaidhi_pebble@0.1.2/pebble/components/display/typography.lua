-- Decompiled with Potassium's decompiler.

local vide = require(script.Parent.Parent.Parent.Parent.vide);
local anim = require(script.Parent.Parent.Parent.util.anim);
local theme = require(script.Parent.Parent.Parent.util.theme);
local create = vide.create;
local read = vide.read;

return function(u1: table) -- Line: 36
    -- upvalues: read (copy), theme (copy), create (copy), anim (copy)
    local function font() -- Line: 38
        -- upvalues: read (ref), u1 (copy), theme (ref)
        if read(u1.code) then
            return theme.code;
        end;

        return theme.font;
    end;

    local function fg() -- Line: 42
        -- upvalues: read (ref), u1 (copy), theme (ref)
        local v2 = read(u1.accent);
        local v3 = read(u1.disabled);

        if v2 then
            if v3 then
                return theme.fg_on_acc_low[0]();
            end;

            return theme.fg_on_acc_high[0]();
        end;

        if v3 then
            return theme.fg_on_bg_low[0]();
        end;

        return theme.fg_on_bg_high[0]();
    end;

    return create("TextLabel")({
        Size = u1.size,
        Position = u1.position,
        AnchorPoint = u1.anchorpoint,
        AutomaticSize = u1.automaticsize or Enum.AutomaticSize.XY,
        AutoLocalize = false,
        TextXAlignment = u1.xalignment,
        TextYAlignment = u1.yalignment,
        TextTruncate = u1.truncate,
        BackgroundTransparency = 1,
        Text = u1.text,
        TextSize = u1.textsize or function() -- Line: 70
            -- upvalues: read (ref), u1 (copy), theme (ref)
            if read(u1.header) then
                return theme.header;
            end;

            return theme.body;
        end,
        TextWrapped = u1.wrapped,

        FontFace = function() -- Line: 74, Name: FontFace
            -- upvalues: read (ref), u1 (copy), theme (ref)
            if not read(u1.header) then
                if read(u1.code) then
                    return theme.code;
                end;

                return theme.font;
            end;

            local Font_new = Font.new;
            local v4;

            if read(u1.code) then
                v4 = theme.code;
            else
                v4 = theme.font;
            end;

            return Font_new(v4.Family, Enum.FontWeight.Bold);
        end,

        TextColor3 = anim(fg),
        Visible = u1.visible,
        unpack(u1)
    });
end;