-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local script_Parent = require(script.Parent);
local signal = require(script.Parent.Parent.Parent.signal);
require(script.Parent.Parent.Types);
local u1 = setmetatable({}, script_Parent);
u1.__index = u1;

function u1.new(p2) -- Line: 48
    -- upvalues: script_Parent (copy), u1 (copy), signal (copy), RunService (copy)
    local v3 = script_Parent.new(p2);
    local u4 = setmetatable(v3, u1);
    u4.GuiElement = u4:_createGuiElement(p2);
    u4.Item = nil;
    u4.ItemChanged = signal.new();
    u4._trove:Add(RunService.RenderStepped:Connect(function() -- Line: 55
        -- upvalues: u4 (copy)
        u4.GuiElement.GroupColor3 = Color3.new(0.105882, 0.105882, 0.105882);

        for _, v in u4.Highlights do
            u4.GuiElement.GroupColor3 = v.Color;
        end;
    end));

    return u4;
end;

function u1._createGuiElement(p5, p6) -- Line: 72
    local v7 = p5._trove:Add(p5.Assets.Slot:Clone());
    v7.Name = "SingleSlot";
    v7.AnchorPoint = p6.AnchorPoint;
    v7.Position = p6.Position;
    v7.Size = p6.Size;
    v7.Visible = p5.Visible;
    v7.Parent = p6.Parent;

    return v7;
end;

function u1.GetOffset(p8: table, p9: number) -- Line: 93
    local Vector2_zero = Vector2.zero;

    if p9 % 2 == 1 then
        Vector2_zero = Vector2.new(p8.GuiElement.AbsoluteSize.Y, p8.GuiElement.AbsoluteSize.X) / 2 - p8.GuiElement.AbsoluteSize / 2;
    end;

    return p8.GuiElement.AbsolutePosition - Vector2_zero;
end;

function u1.GetSizeScale(p10) -- Line: 108
    return p10.GuiElement.AbsoluteSize;
end;

function u1.GetAbsoluteSizeFromItemSize(p11: table, p12, p13: number) -- Line: 118
    if p13 % 2 == 1 then
        return Vector2.new(p11.GuiElement.AbsoluteSize.Y, p11.GuiElement.AbsoluteSize.X);
    end;

    return p11.GuiElement.AbsoluteSize;
end;

function u1.GetItemManagerPositionFromAbsolutePosition(p14: table, p15, p16, p17: number) -- Line: 132
    local Vector2_zero = Vector2.zero;

    if p17 % 2 == 1 then
        Vector2_zero = Vector2.new(p16.Y, p16.X) / 2 - p16 / 2;
    end;

    return -Vector2_zero;
end;

function u1.IsColliding(p18: table, p19: any, p20: table, p21) -- Line: 147
    if table.find(p20, p18.Item) then
        return false;
    end;

    return p18.Item ~= nil;
end;

function u1.ChangeItem(p22, p23) -- Line: 161
    assert(p23.ItemManager == nil, "Could not add item: Item is already in another ItemManager");

    if p22.Item then
        p22:RemoveItem();
    end;

    p22.Item = p23;
    p22.ItemChanged:Fire(p23);
    p23.ItemManagerChanged:Fire(p22, true);
end;

function u1.RemoveItem(p24) -- Line: 180
    if p24.Item then
        p24.Item.ItemManagerChanged:Fire(nil);
    end;

    p24.Item = nil;
    p24.ItemChanged:Fire(nil);
end;

return u1;