-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local signal = require(script.Parent.Parent.Parent.signal);
local script_Parent = require(script.Parent);
require(script.Parent.Parent.Types);
local u1 = setmetatable({}, script_Parent);
u1.__index = u1;

function u1.new(p2) -- Line: 67
    -- upvalues: script_Parent (copy), u1 (copy), signal (copy), RunService (copy)
    local v3 = script_Parent.new(p2);
    local u4 = setmetatable(v3, u1);
    local v5, v6 = u4:_createGuiElement(p2);
    u4.GuiElement = v5;
    u4.SlotElements = v6;
    u4.GridSize = p2.GridSize;
    u4.SlotAspectRatio = p2.SlotAspectRatio;
    u4.Items = {};
    u4.ItemAdded = signal.new();
    u4.ItemRemoved = signal.new();
    u4:_updateGuiGrid();
    u4._trove:Add(RunService.RenderStepped:Connect(function() -- Line: 80
        -- upvalues: u4 (copy)
        for _, v in pairs(u4.SlotElements) do
            v.GroupColor3 = Color3.new(0.105882, 0.105882, 0.105882);
        end;

        for _, v in u4.Highlights do
            local v7 = v;

            for i = v.Position.X + 1, v.Position.X + v.Size.X do
                local v8 = i;

                for i2 = v7.Position.Y + 1, v7.Position.Y + v7.Size.Y do
                    local v9 = u4.SlotElements[v8 .. ", " .. i2];
                    local v10;

                    if v9 then
                        v9.GroupColor3 = v7.Color;
                        v10 = i2;
                    else
                        v10 = i2;
                    end;
                end;
            end;
        end;
    end));

    return u4;
end;

function u1._createGuiElement(p11, p12) -- Line: 106
    local v13 = p11._trove:Add(Instance.new("CanvasGroup"));
    v13.Name = "GridContainer";
    v13.BackgroundTransparency = 1;
    v13.AnchorPoint = p12.AnchorPoint;
    v13.Position = p12.Position;
    v13.Size = p12.Size;
    local v14 = p11._trove:Add(Instance.new("UIGridLayout"));
    v14.CellPadding = UDim2.fromOffset(0, 0);
    v14.SortOrder = Enum.SortOrder.LayoutOrder;
    local v15 = 1;
    local v16 = {};

    for i = 1, p12.GridSize.Y do
        local v17 = i;

        for i2 = 1, p12.GridSize.X do
            local v18 = p11._trove:Add(p11.Assets.Slot:Clone());
            v18.Name = v15;
            v18.LayoutOrder = v15;
            v16[i2 .. ", " .. v17] = v18;
            v18.Parent = v13;
            v15 = v15 + 1;
            local _ = i2;
        end;
    end;

    v13.Visible = p11.Visible;
    v14.Parent = v13;
    v13.Parent = p12.Parent;

    return v13, v16;
end;

function u1._updateGuiGrid(p19) -- Line: 151
    p19.GuiElement.UIGridLayout.CellSize = UDim2.fromScale(1 / p19.GridSize.X, 1 / p19.GridSize.Y);

    if not p19.SlotAspectRatio then
        local v20 = p19.GuiElement:FindFirstChildOfClass("UIAspectRatioConstraint");

        if v20 then
            v20:Destroy();
        end;

        return;
    end;

    local v21 = p19.GuiElement:FindFirstChildOfClass("UIAspectRatioConstraint");

    if v21 then
        v21.AspectRatio = p19.GridSize.X / p19.GridSize.Y * p19.SlotAspectRatio;

        return;
    end;

    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.AspectRatio = p19.GridSize.X / p19.GridSize.Y * p19.SlotAspectRatio;
    UIAspectRatioConstraint.Parent = p19.GuiElement;
end;

function u1.GetSizeScale(p22) -- Line: 178
    return p22.GuiElement.UIGridLayout.AbsoluteCellSize;
end;

function u1.GetAbsoluteSizeFromItemSize(p23: table, p24, p25: number) -- Line: 188
    local SizeScale = p23:GetSizeScale();

    return Vector2.new(math.round(SizeScale.X), (math.round(SizeScale.Y))) * p24;
end;

function u1.GetItemManagerPositionFromAbsolutePosition(p26: table, p27, p28, p29: number) -- Line: 200
    local AbsolutePosition = p26.GuiElement.AbsolutePosition;
    local SizeScale = p26:GetSizeScale();
    local Vector2_zero = Vector2.zero;

    if p29 % 2 == 1 then
        Vector2_zero = Vector2.new(p28.Y, p28.X) / 2 - p28 / 2;
        p28 = Vector2.new(p28.Y, p28.X);
    end;

    local math_floor_ret = math.floor((p27.X - AbsolutePosition.X) / SizeScale.X - Vector2_zero.X + 0.5);
    local math_floor_ret2 = math.floor((p27.Y - AbsolutePosition.Y) / SizeScale.Y - Vector2_zero.Y + 0.5);
    local math_clamp_ret = math.clamp(math_floor_ret, 0, p26.GridSize.X - p28.X);
    local math_clamp_ret2 = math.clamp(math_floor_ret2, 0, p26.GridSize.Y - p28.Y);

    return Vector2.new(math_clamp_ret, math_clamp_ret2);
end;

function u1.GetNextFreePositionForItem(p30, p31) -- Line: 224
    for i = 0, p30.GridSize.Y - 1 do
        local v32 = i;

        for i2 = 0, p30.GridSize.X - 1 do
            local Vector2_new_ret = Vector2.new(i2, v32);
            local v33 = p30:IsRegionInBounds(Vector2_new_ret, p31.Size, p31.Rotation);

            if #p30:GetItemsInRegion(Vector2_new_ret, p31.Size, p31.Rotation, { p31 }) == 0 and v33 then
                return Vector2_new_ret;
            end;

            local _ = i2;
        end;
    end;

    return nil;
end;

function u1.GetItemsInRegion(p34: table, p35, p36, p37: number, p38: table) -- Line: 244
    local v39 = p35 + p36;

    if p37 % 2 == 1 then
        v39 = p35 + Vector2.new(p36.Y, p36.X);
    end;

    local v40 = {};

    for _, v in ipairs(p34.Items) do
        if table.find(p38, v) == nil then
            local Position = v.Position;
            local Size = v.Size;

            if v.Rotation % 2 == 1 then
                Size = Vector2.new(v.Size.Y, v.Size.X);
            end;

            local v41 = Position + Size;
            local v42;

            if p35.X < v41.X then
                v42 = v39.X > Position.X;
            else
                v42 = false;
            end;

            local v43;

            if p35.Y < v41.Y then
                v43 = v39.Y > Position.Y;
            else
                v43 = false;
            end;

            if v42 and v43 then
                table.insert(v40, v);
            end;
        end;
    end;

    return v40;
end;

function u1.IsColliding(p44: table, p45: any, p46: table, p47, p48: number?) -- Line: 278
    return #p44:GetItemsInRegion(p47 or p45.Position, p45.Size, p48 or p45.Rotation, p46) > 0;
end;

function u1.IsRegionInBounds(p49: table, p50, p51, p52: number) -- Line: 288
    local v53 = p50 + p51;

    if p52 % 2 == 1 then
        v53 = p50 + Vector2.new(p51.Y, p51.X);
    end;

    return not (p50.X < 0 and true or v53.X > p49.GridSize.X or (p50.Y < 0 and true or v53.Y > p49.GridSize.Y));
end;

function u1.SortItemsByVolume(p54) -- Line: 308
    local table_clone_ret = table.clone(p54.Items);
    table.sort(table_clone_ret, function(p55, p56) -- Line: 310
        return p55.Size.X * p55.Size.Y > p56.Size.X * p56.Size.Y;
    end);

    for _, v in ipairs(table_clone_ret) do
        p54:RemoveItem(v);
    end;

    task.wait();

    for _, v in ipairs(table_clone_ret) do
        p54:AddItem(v, p54:GetNextFreePositionForItem(v), true);
    end;
end;

function u1.AddItem(p57: table, p58: any, p59, p60: boolean?) -- Line: 334
    local v61 = p59 or p58.Position;
    assert(p58.ItemManager == nil, "Could not add item: Item is already in another ItemManager");
    local v62 = p57:IsColliding(p58, { p58 }, v61) == false;
    assert(v62, "Could not add item: Item is colliding with an already added item");
    local v63 = p57:IsRegionInBounds(v61, p58.Size, p58.Rotation) == true;
    assert(v63, "Could not add item: Item is out of the grid\'s bounds");
    p58.Position = v61;
    table.insert(p57.Items, p58);
    p57.ItemAdded:Fire(p58);
    p58.ItemManagerChanged:Fire(p57, p60);
end;

function u1.RemoveItem(p64, p65) -- Line: 353
    local table_find_ret = table.find(p64.Items, p65);

    if not table_find_ret then
        error("Unable to remove item: Item could not be found in ItemManager");

        return;
    end;

    table.remove(p64.Items, table_find_ret);
    p64.ItemRemoved:Fire(p65);
    p65.ItemManagerChanged:Fire(nil);
end;

function u1.ClearItems(p66: table, p67: boolean?) -- Line: 370
    for i, v in ipairs(p66.Items) do
        if p67 then
            v:Destroy();
        end;

        p66.Items[i] = nil;
        p66.ItemRemoved:Fire(v);
        v.ItemManagerChanged:Fire(nil);
    end;
end;

return u1;