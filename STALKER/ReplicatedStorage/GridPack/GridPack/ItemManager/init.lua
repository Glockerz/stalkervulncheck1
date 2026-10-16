-- Decompiled with Potassium's decompiler.

local signal = require(script.Parent.Parent.signal);
local trove = require(script.Parent.Parent.trove);
local Highlight = require(script.Parent.Highlight);
require(script.Parent.Types);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 77
    -- upvalues: u1 (copy), trove (copy), signal (copy)
    local v3 = setmetatable({}, u1);
    v3._trove = trove.new();
    v3.Assets = p2.Assets or {};

    if v3.Assets.Slot == nil then
        v3.Assets.Slot = v3:_createDefaultSlotAsset();
    end;

    v3.Visible = p2.Visible or false;
    v3.VisibilityChanged = signal.new();
    v3.Highlights = {};
    v3.ConnectedTransferLinks = {};
    v3.TransferLinkConnected = signal.new();
    v3.TransferLinkDisconnected = signal.new();
    v3.Metadata = p2.Metadata or {};

    return v3;
end;

function u1._createDefaultSlotAsset(p4) -- Line: 100
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "SlotElement";
    CanvasGroup.GroupColor3 = Color3.fromRGB(0, 0, 0);
    CanvasGroup.GroupTransparency = 0.5;
    CanvasGroup.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    CanvasGroup.BackgroundTransparency = 1;
    CanvasGroup.BorderSizePixel = 0;
    CanvasGroup.Size = UDim2.fromOffset(10, 10);
    local Frame = Instance.new("Frame");
    Frame.Name = "Frame";
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame.BorderSizePixel = 0;
    Frame.Position = UDim2.fromScale(0.5, 0.5);
    Frame.Size = UDim2.fromScale(0.9, 0.9);
    Frame.Parent = CanvasGroup;
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";
    UICorner.Parent = Frame;

    return CanvasGroup;
end;

function u1.GetOffset(p5: table, p6: number) -- Line: 131
    return p5.GuiElement.AbsolutePosition;
end;

function u1.GetSizeScale(p7) -- Line: 140
    return Vector2.zero;
end;

function u1.GetAbsoluteSizeFromItemSize(p8: table, p9, p10: number) -- Line: 149
    return Vector2.zero;
end;

function u1.GetItemManagerPositionFromAbsolutePosition(p11: table, p12, p13, p14: number) -- Line: 158
    return Vector2.zero;
end;

function u1.IsColliding(p15: table, p16: any, p17: table, p18) -- Line: 167
    return true;
end;

function u1.RemoveItem(p19, p20) -- Line: 176
end;

function u1.SetVisibility(p21: table, p22: boolean) -- Line: 183
    if p22 ~= p21.Visible then
        p21.Visible = p22;

        if p21.GuiElement then
            p21.GuiElement.Visible = p21.Visible;
        end;

        p21.VisibilityChanged:Fire(p21.Visible);
    end;
end;

function u1.ConnectTransferLink(p23, p24) -- Line: 200
    table.insert(p23.ConnectedTransferLinks, p24);
    p23.TransferLinkConnected:Fire(p24);
    p24:AddItemManager(p23);
end;

function u1.DisconnectTransferLink(p25, p26) -- Line: 212
    p26:RemoveItemManager(p25);
    local table_find_ret = table.find(p25.ConnectedTransferLinks, p26);
    assert(table_find_ret, "Failed to disconnect TransferLink: Could not find a matching TransferLink that was connected");
    table.remove(p25.ConnectedTransferLinks, table_find_ret);
    p25.TransferLinkDisconnected:Fire(p26);
end;

function u1.CreateHighlight(u27: table, p28: number, p29, p30, p31) -- Line: 229
    -- upvalues: Highlight (copy)
    local v32 = Highlight.new({
        Position = p29,
        Size = p30,
        Color = p31
    });
    local u33 = p28 or 1;

    while u27.Highlights[u33] ~= nil do
        u33 = u33 + 1;
    end;

    local u34 = nil;
    u34 = v32.ItemManagerChanged:Connect(function() -- Line: 243
        -- upvalues: u27 (copy), u33 (ref), u34 (ref)
        u27.Highlights[u33] = nil;
        u34:Disconnect();
        u34 = nil;
    end);
    u27.Highlights[u33] = v32;

    return v32;
end;

function u1.AddHighlight(u35: table, p36: number, p37: any) -- Line: 260
    local u38 = p36 or 1;

    while u35.Highlights[u38] ~= nil do
        u38 = u38 + 1;
    end;

    local u39 = nil;
    u39 = p37.ItemManagerChanged:Connect(function() -- Line: 267
        -- upvalues: u35 (copy), u38 (ref), u39 (ref)
        u35.Highlights[u38] = nil;
        u39:Disconnect();
        u39 = nil;
    end);
    u35.Highlights[u38] = p37;
end;

function u1.RemoveHighlight(p40, p41) -- Line: 282
    local table_find_ret = table.find(p40.Highlights, p41);

    if table_find_ret then
        p40.Highlights[table_find_ret] = nil;
        p41.ItemManagerChanged:Fire(nil);
    end;
end;

function u1.Destroy(p42) -- Line: 296
    p42._trove:Destroy();
end;

return u1;