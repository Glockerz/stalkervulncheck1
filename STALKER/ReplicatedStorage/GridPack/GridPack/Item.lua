-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local GuiService = game:GetService("GuiService");
local signal = require(script.Parent.Parent.signal);
local trove = require(script.Parent.Parent.trove);
local GuiInset = GuiService:GetGuiInset();
require(script.Parent.Types);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 99
    -- upvalues: u1 (copy), trove (copy), signal (copy), UserInputService (copy), GuiInset (copy), TweenService (copy)
    local u3 = setmetatable({}, u1);
    u3._trove = trove.new();
    u3._itemManagerTrove = u3._trove:Add(trove.new());
    u3._draggingTrove = u3._trove:Add(trove.new());
    u3.Assets = p2.Assets or {};

    if u3.Assets.Item == nil then
        u3.Assets.Item = u3:_createDefaultItemAsset();
    end;

    u3.Position = p2.Position or Vector2.zero;
    u3.LastItemManagerParentAbsolutePosition = Vector2.zero;
    u3.PositionChanged = signal.new();
    u3.Size = p2.Size or Vector2.new(2, 2);
    u3.Rotation = p2.Rotation or 0;
    u3.PotentialRotation = u3.Rotation;
    u3.ItemElement = u3:_generateItemElement();
    u3.ItemManager = nil;
    u3.ItemManagerChanged = signal.new();
    u3.HoveringItemManager = nil;
    u3.HoveringItemManagerChanged = signal.new();
    u3.MoveMiddleware = p2.MoveMiddleware;
    u3.RenderMiddleware = p2.RenderMiddleware;
    u3.IsDraggable = true;
    u3.IsDragging = false;
    u3.MouseDraggingPivot = Vector2.zero;
    u3.RotateKeyCode = Enum.KeyCode.R;
    u3.Metadata = p2.Metadata or {};
    u3._trove:Add(function() -- Line: 136
        -- upvalues: u3 (copy)
        if u3.ItemManager then
            u3.ItemManager:RemoveItem(u3);
        end;
    end);
    u3._trove:Add(u3.ItemManagerChanged:Connect(function(p4: any, p5: boolean?) -- Line: 143
        -- upvalues: u3 (copy)
        u3._itemManagerTrove:Clean();

        if u3.ItemManager then
            u3.LastItemManagerParentAbsolutePosition = u3.ItemManager.GuiElement.Parent.AbsolutePosition;
        end;

        u3.ItemManager = p4;

        if u3.ItemManager == nil then
            u3.ItemElement.Parent = nil;

            return;
        end;

        u3.ItemElement.Visible = u3.ItemManager.Visible;
        local v6 = u3.ItemManager.GuiElement.Parent.AbsolutePosition - u3.LastItemManagerParentAbsolutePosition;
        u3.ItemElement.Position = UDim2.fromOffset(u3.ItemElement.Position.X.Offset - v6.X, u3.ItemElement.Position.Y.Offset - v6.Y);
        u3:_updateItemToItemManagerDimentions(true, true, p5, p5);
        u3._itemManagerTrove:Add(u3.ItemManager.GuiElement:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 160
            -- upvalues: u3 (ref)
            u3:_updateItemToItemManagerDimentions(true, false, false, false);
        end));
        u3._itemManagerTrove:Add(u3.ItemManager.GuiElement:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 163
            -- upvalues: u3 (ref)
            u3:_updateItemToItemManagerDimentions(true, true, false, false);
        end));
        u3._itemManagerTrove:Add(u3.ItemManager.VisibilityChanged:Connect(function(p7) -- Line: 167
            -- upvalues: u3 (ref)
            u3.ItemElement.Visible = p7;
        end));
        u3.ItemElement.Parent = u3.ItemManager.GuiElement.Parent;
    end));
    u3._trove:Add(u3.ItemElement:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 178
        -- upvalues: u3 (copy)
        if u3.IsDragging then
            u3:_updateDraggingPosition();
        end;
    end));
    local InteractionButton = u3.ItemElement:FindFirstChild("InteractionButton");
    assert(InteractionButton, "Couldn\'t find a button named \"InteractionButton\" in the ItemElement");
    u3._highlight = nil;
    u3._trove:Add(InteractionButton.MouseButton1Down:Connect(function() -- Line: 188
        -- upvalues: u3 (copy), UserInputService (ref), GuiInset (ref), TweenService (ref)
        if u3.ItemManager ~= nil and u3.IsDraggable then
            u3.IsDraggable = false;
            u3.IsDragging = true;
            local v8 = UserInputService:GetMouseLocation() - GuiInset;
            local AbsolutePosition = u3.ItemElement.AbsolutePosition;
            u3.MouseDraggingPivot = (v8 - AbsolutePosition) / (AbsolutePosition + u3.ItemElement.AbsoluteSize - AbsolutePosition);
            TweenService:Create(u3.ItemElement, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                GroupTransparency = 0.5
            }):Play();
            local ItemElement = u3.ItemElement;
            ItemElement.ZIndex = ItemElement.ZIndex + 1;
            u3._draggingTrove:Add(UserInputService.InputBegan:Connect(function(p9: userdata, p10: boolean) -- Line: 203
                -- upvalues: u3 (ref)
                if p10 == false and (p9.KeyCode == u3.RotateKeyCode and u3.IsDragging) then
                    if not (u3.ItemManager and not u3.ItemManager.GridSize) then
                        u3:Rotate(1);
                    end;
                end;
            end));
            local Size = u3.Size;

            if u3.PotentialRotation % 2 == 1 then
                Size = Vector2.new(u3.Size.Y, u3.Size.X);
            end;

            local ItemManagerPositionFromAbsolutePosition = u3.ItemManager:GetItemManagerPositionFromAbsolutePosition(u3.ItemElement.AbsolutePosition, u3.Size, u3.PotentialRotation);
            u3._highlight = u3._draggingTrove:Add(u3.ItemManager:CreateHighlight(100, ItemManagerPositionFromAbsolutePosition, Size, Color3.new(0, 0.666667, 0)));
            u3:_updateDraggingPosition();
        end;
    end));
    u3._trove:Add(UserInputService.InputChanged:Connect(function(p11) -- Line: 235
        -- upvalues: u3 (copy)
        if p11.UserInputType == Enum.UserInputType.MouseMovement and (u3.IsDragging == true and u3.ItemManager ~= nil) then
            if next(u3.ItemManager.ConnectedTransferLinks) ~= nil then
                for _, v in pairs(u3.ItemManager.ConnectedTransferLinks) do
                    local v12 = v:GetClosestItemOverlappingItemManagers(u3)[1];

                    if v12 ~= nil and u3.HoveringItemManager ~= v12 then
                        u3.HoveringItemManager = v12;
                        u3.HoveringItemManagerChanged:Fire(u3.HoveringItemManager);
                        u3._highlight:SetItemManager(100, u3.HoveringItemManager);
                        u3:_updateItemToItemManagerDimentions(false, true, false, true, u3.HoveringItemManager);
                        break;
                    end;
                end;
            end;

            if u3.HoveringItemManager or u3.ItemManager then
                u3:_updateDraggingPosition();
            end;
        end;
    end));
    u3._trove:Add(UserInputService.InputEnded:Connect(function(p13) -- Line: 261
        -- upvalues: u3 (copy), TweenService (ref)
        if p13.UserInputType == Enum.UserInputType.MouseButton1 and (u3.IsDragging == true and u3.ItemManager ~= nil) then
            u3.IsDragging = false;
            u3.IsDropping = true;
            local v14 = u3.HoveringItemManager or u3.ItemManager;
            local ItemManagerPositionFromAbsolutePosition = v14:GetItemManagerPositionFromAbsolutePosition(u3.ItemElement.AbsolutePosition, u3.Size, u3.PotentialRotation);

            if v14:IsColliding(u3, { u3 }, ItemManagerPositionFromAbsolutePosition, u3.PotentialRotation) == false then
                local v15;

                if u3.HoveringItemManager and u3.HoveringItemManager ~= u3.ItemManager then
                    v15 = u3.HoveringItemManager;
                else
                    v15 = nil;
                end;

                local v16;

                if u3.MoveMiddleware then
                    v16 = u3.MoveMiddleware(u3, ItemManagerPositionFromAbsolutePosition, u3.PotentialRotation, u3.ItemManager, v15);
                else
                    v16 = nil;
                end;

                if v16 == true or v16 == nil then
                    u3.Position = ItemManagerPositionFromAbsolutePosition;
                    u3.PositionChanged:Fire(ItemManagerPositionFromAbsolutePosition);
                    u3.Rotation = u3.PotentialRotation;

                    if v15 then
                        u3:SetItemManager(u3.HoveringItemManager);
                    end;
                end;
            end;

            u3.PotentialRotation = u3.Rotation;
            u3.HoveringItemManager = nil;
            u3.HoveringItemManagerChanged:Fire(u3.HoveringItemManager);
            u3:_updateItemToItemManagerDimentions(true, true, true, true);
            TweenService:Create(u3.ItemElement, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                GroupTransparency = 0
            }):Play();
            local ItemElement = u3.ItemElement;
            ItemElement.ZIndex = ItemElement.ZIndex - 1;
            u3._draggingTrove:Clean();
            u3.IsDropping = false;
            u3.IsDraggable = true;
        end;
    end));

    if u3.RenderMiddleware then
        u3.RenderMiddleware(u3.ItemElement);
    end;

    return u3;
end;

function u1._createDefaultItemAsset(p17) -- Line: 333
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "ItemElement";
    CanvasGroup.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
    CanvasGroup.BorderSizePixel = 0;
    CanvasGroup.Size = UDim2.fromOffset(140, 140);
    CanvasGroup.ZIndex = 2;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Image";
    ImageLabel.Image = "";
    ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.BorderSizePixel = 0;
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.Parent = CanvasGroup;
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "InteractionButton";
    TextButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json");
    TextButton.Text = "";
    TextButton.TextColor3 = Color3.fromRGB(0, 0, 0);
    TextButton.TextSize = 14;
    TextButton.TextTransparency = 1;
    TextButton.AutoButtonColor = false;
    TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    TextButton.BackgroundTransparency = 1;
    TextButton.Size = UDim2.fromScale(1, 1);
    TextButton.Parent = CanvasGroup;
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "UICorner";
    UICorner.CornerRadius = UDim.new(0, 10);
    UICorner.Parent = CanvasGroup;

    return CanvasGroup;
end;

function u1._generateItemElement(p18) -- Line: 377
    local v19 = p18._trove:Add(p18.Assets.Item:Clone());

    if p18.ItemManager then
        v19.Visible = p18.ItemManager.Visible;
    end;

    return v19;
end;

function u1._updateDraggingPosition(p20) -- Line: 392
    -- upvalues: UserInputService (copy), GuiInset (copy)
    local v21 = UserInputService:GetMouseLocation() - GuiInset;
    local AbsolutePosition = p20.ItemManager.GuiElement.Parent.AbsolutePosition;

    if p20.HoveringItemManager then
        local _ = p20.ItemManager == p20.HoveringItemManager;
    end;

    p20.ItemElement.Position = UDim2.fromOffset(v21.X - p20.MouseDraggingPivot.X * p20.ItemElement.AbsoluteSize.X - AbsolutePosition.X, v21.Y - p20.MouseDraggingPivot.Y * p20.ItemElement.AbsoluteSize.Y - AbsolutePosition.Y);

    if not p20._highlight then
        return;
    end;

    local v22 = p20.HoveringItemManager or p20.ItemManager;
    local ItemManagerPositionFromAbsolutePosition = v22:GetItemManagerPositionFromAbsolutePosition(p20.ItemElement.AbsolutePosition, p20.Size, p20.PotentialRotation);
    p20._highlight.Position = ItemManagerPositionFromAbsolutePosition;

    if v22:IsColliding(p20, { p20 }, ItemManagerPositionFromAbsolutePosition, p20.PotentialRotation) == true then
        p20._highlight.Color = Color3.new(1, 0, 0);

        return;
    end;

    p20._highlight.Color = Color3.new(0, 0.666667, 0);
end;

function u1._updateItemToItemManagerDimentions(p23: table, p24: boolean?, p25: boolean?, p26: boolean?, p27: boolean?, p28: any) -- Line: 430
    -- upvalues: TweenService (copy)
    local v29 = p28 or p23.ItemManager;

    if p24 then
        local Vector2_zero = Vector2.zero;

        if p23.Rotation % 2 == 1 then
            Vector2_zero = Vector2.new(p23.Size.Y, p23.Size.X) / 2 - p23.Size / 2;
        end;

        local Offset = v29:GetOffset(p23.Rotation);
        local SizeScale = v29:GetSizeScale();
        local UDim2_fromOffset_ret = UDim2.fromOffset((p23.Position.X + Vector2_zero.X) * SizeScale.X + Offset.X - p23.ItemManager.GuiElement.Parent.AbsolutePosition.X, (p23.Position.Y + Vector2_zero.Y) * SizeScale.Y + Offset.Y - p23.ItemManager.GuiElement.Parent.AbsolutePosition.Y);

        if p26 then
            TweenService:Create(p23.ItemElement, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Position = UDim2_fromOffset_ret,
                Rotation = p23.Rotation * 90
            }):Play();
        else
            p23.ItemElement.Position = UDim2_fromOffset_ret;
            p23.ItemElement.Rotation = p23.Rotation * 90;
        end;
    end;

    if p25 then
        local AbsoluteSizeFromItemSize = v29:GetAbsoluteSizeFromItemSize(p23.Size, p23.Rotation);
        local UDim2_fromOffset_ret = UDim2.fromOffset(AbsoluteSizeFromItemSize.X, AbsoluteSizeFromItemSize.Y);

        if p27 then
            TweenService:Create(p23.ItemElement, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Size = UDim2_fromOffset_ret
            }):Play();

            return;
        end;

        p23.ItemElement.Size = UDim2_fromOffset_ret;
    end;
end;

function u1.Rotate(p30: table, p31: number) -- Line: 466
    -- upvalues: TweenService (copy)
    assert(p30.IsDragging, "Must be dragging to rotate an item!");
    p30.PotentialRotation = p30.PotentialRotation + p31;

    if p30.PotentialRotation > 3 then
        p30.ItemElement.Rotation = -90;
        p30.PotentialRotation = p30.PotentialRotation - 4;
    elseif p30.PotentialRotation < 0 then
        p30.ItemElement.Rotation = 360;
        p30.PotentialRotation = p30.PotentialRotation + 4;
    end;

    if p30._highlight then
        local ItemManagerPositionFromAbsolutePosition = (p30.HoveringItemManager or p30.ItemManager):GetItemManagerPositionFromAbsolutePosition(p30.ItemElement.AbsolutePosition, p30.Size, p30.PotentialRotation);
        p30._highlight.Position = ItemManagerPositionFromAbsolutePosition;

        if p30.PotentialRotation % 2 == 1 then
            p30._highlight.Size = Vector2.new(p30.Size.Y, p30.Size.X);
        else
            p30._highlight.Size = p30.Size;
        end;
    end;

    TweenService:Create(p30.ItemElement, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Rotation = p30.PotentialRotation * 90
    }):Play();
end;

function u1.SetItemManager(p32, p33) -- Line: 498
    if p32.ItemManager ~= nil then
        p32.ItemManager:RemoveItem(p32);
    end;

    repeat
        task.wait();
    until p32.ItemManager == nil;

    if p33.Items then
        p33:AddItem(p32, nil, true);

        return;
    end;

    p33:ChangeItem(p32, nil, true);
end;

function u1.Destroy(p34) -- Line: 519
    p34._trove:Destroy();
end;

return u1;