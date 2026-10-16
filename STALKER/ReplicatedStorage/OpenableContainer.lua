-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local GridPack = require(ReplicatedStorage:WaitForChild("GridPack"):WaitForChild("GridPack"));
require(ReplicatedStorage:WaitForChild("LootConfig"));
local UITheme = require(ReplicatedStorage:WaitForChild("InventoryController"):WaitForChild("UITheme"));
local C = UITheme.C;
local v1 = {};
local u2 = {};

local function pickSpawnPosition(p3, p4, p5) -- Line: 35
    -- upvalues: u2 (ref)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v6 = workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize or Vector2.new(1280, 720);
    local v7 = 0;

    for _ in pairs(u2) do
        v7 = v7 + 1;
    end;

    local v8 = v7 * 28;
    local MainFrame = p3:FindFirstChild("MainFrame");
    local v9, v10;

    if MainFrame and MainFrame.AbsoluteSize.X > 0 then
        local AbsolutePosition = MainFrame.AbsolutePosition;
        local AbsoluteSize = MainFrame.AbsoluteSize;

        if v6.X - (AbsolutePosition.X + AbsoluteSize.X) >= p4 + 32 then
            v9 = AbsolutePosition.X + AbsoluteSize.X + 16;
        elseif AbsolutePosition.X >= p4 + 32 then
            v9 = AbsolutePosition.X - p4 - 16;
        else
            v9 = v6.X - p4 - 16;
        end;

        v10 = AbsolutePosition.Y + 16;
    else
        v9 = v6.X - p4 - 16;
        v10 = 16;
    end;

    local math_max_ret = math.max(16, v6.X - p4 - 16);
    local math_clamp_ret = math.clamp(v9 + v8, 16, math_max_ret);
    local math_max_ret2 = math.max(16, v6.Y - p5 - 16);
    local math_clamp_ret2 = math.clamp(v10 + v8, 16, math_max_ret2);

    return UDim2.fromOffset(math_clamp_ret, math_clamp_ret2);
end;

function v1.Open(u11) -- Line: 67
    -- upvalues: Players (copy), u2 (ref), pickSpawnPosition (copy), C (copy), UITheme (copy), GridPack (copy), ReplicatedStorage (copy), UserInputService (copy)
    local tiedInstance = u11.tiedInstance;

    if not tiedInstance then
        return nil;
    end;

    local InventoryGui = Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("InventoryGui");

    if not InventoryGui then
        return nil;
    end;

    if u2[tiedInstance] then
        u2[tiedInstance]:Close();
    end;

    local v12 = u11.gridSize.X * 64;
    local v13 = u11.gridSize.Y * 64;
    local math_max_ret = math.max(v12 + 16, 290);
    local math_floor_ret = math.floor((math_max_ret - v12) / 2);
    local v14 = 42 + v13 + 8;
    local Frame = Instance.new("Frame");
    Frame.Name = "ContainerWindow_" .. tostring(tiedInstance);
    Frame.Size = UDim2.fromOffset(math_max_ret, v14);
    Frame.Position = pickSpawnPosition(InventoryGui, math_max_ret, v14);
    Frame.BackgroundColor3 = C.panel;
    Frame.BackgroundTransparency = 0.03;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 40;
    Frame.Active = true;
    Frame.Parent = InventoryGui;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = C.edge;
    UIStroke.Thickness = 1;
    UIStroke.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Inner";
    Frame2.BackgroundTransparency = 1;
    Frame2.BorderSizePixel = 0;
    Frame2.Active = false;
    Frame2.Position = UDim2.fromOffset(3, 3);
    Frame2.Size = UDim2.new(1, -6, 1, -6);
    Frame2.ZIndex = 40;
    Frame2.Parent = Frame;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = C.inner;
    UIStroke2.Thickness = 1;
    UIStroke2.Parent = Frame2;
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "TitleBar";
    TextButton.Size = UDim2.new(1, -38, 0, 34);
    TextButton.Position = UDim2.fromOffset(0, 0);
    TextButton.BackgroundColor3 = C.header;
    TextButton.BackgroundTransparency = 0;
    TextButton.BorderSizePixel = 0;
    TextButton.Text = "";
    TextButton.AutoButtonColor = false;
    TextButton.ZIndex = 41;
    TextButton.Parent = Frame;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "HeaderRule";
    Frame3.BackgroundColor3 = C.inner;
    Frame3.BorderSizePixel = 0;
    Frame3.Position = UDim2.fromOffset(0, 34);
    Frame3.Size = UDim2.new(1, 0, 0, 1);
    Frame3.ZIndex = 41;
    Frame3.Parent = Frame;
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "Mark";
    Frame4.BackgroundColor3 = C.amber;
    Frame4.BorderSizePixel = 0;
    Frame4.AnchorPoint = Vector2.new(0, 0.5);
    Frame4.Position = UDim2.new(0, 8, 0.5, 0);
    Frame4.Size = UDim2.new(0, 3, 0.55, 0);
    Frame4.ZIndex = 42;
    Frame4.Parent = TextButton;
    local string_format_ret = string.format("%d x %d", u11.gridSize.X, u11.gridSize.Y);
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Capacity";
    TextLabel.BackgroundTransparency = 1;
    TextLabel.AnchorPoint = Vector2.new(1, 0.5);
    TextLabel.Position = UDim2.new(1, -6, 0.5, 0);
    TextLabel.Size = UDim2.new(0, 52, 1, 0);
    TextLabel.FontFace = UITheme.BODY_FONT;
    TextLabel.TextSize = 15;
    TextLabel.TextColor3 = C.dim;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Right;
    TextLabel.Text = string_format_ret;
    TextLabel.ZIndex = 42;
    TextLabel.Parent = TextButton;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Name = "Title";
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Position = UDim2.fromOffset(17, 0);
    TextLabel2.Size = UDim2.new(1, -77, 1, 0);
    TextLabel2.FontFace = UITheme.HEADER_FONT;
    TextLabel2.TextSize = 19;
    TextLabel2.TextColor3 = C.paper;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel2.Text = string.upper(u11.title or "Container");
    TextLabel2.ZIndex = 42;
    TextLabel2.Parent = TextButton;
    local TextButton2 = Instance.new("TextButton");
    TextButton2.Name = "CloseButton";
    TextButton2.Size = UDim2.fromOffset(34, 34);
    TextButton2.AnchorPoint = Vector2.new(1, 0);
    TextButton2.Position = UDim2.new(1, 0, 0, 0);
    TextButton2.BackgroundColor3 = C.blood;
    TextButton2.BorderSizePixel = 0;
    TextButton2.AutoButtonColor = false;
    TextButton2.Text = "X";
    TextButton2.FontFace = UITheme.HEADER_FONT;
    TextButton2.TextColor3 = C.paper;
    TextButton2.TextSize = 19;
    TextButton2.ZIndex = 42;
    TextButton2.Parent = Frame;
    local u15 = C.blood:Lerp(C.paper, 0.18);
    TextButton2.MouseEnter:Connect(function() -- Line: 220
        -- upvalues: TextButton2 (copy), u15 (copy)
        TextButton2.BackgroundColor3 = u15;
    end);
    TextButton2.MouseLeave:Connect(function() -- Line: 221
        -- upvalues: TextButton2 (copy), C (ref)
        TextButton2.BackgroundColor3 = C.blood;
    end);
    local Frame5 = Instance.new("Frame");
    Frame5.Name = "Well";
    Frame5.BackgroundColor3 = C.slot;
    Frame5.BackgroundTransparency = 0.2;
    Frame5.BorderSizePixel = 0;
    Frame5.Active = false;
    Frame5.Position = UDim2.fromOffset(math_floor_ret, 42);
    Frame5.Size = UDim2.fromOffset(v12, v13);
    Frame5.ZIndex = 40;
    Frame5.Parent = Frame;
    local UIStroke3 = Instance.new("UIStroke");
    UIStroke3.Color = C.inner;
    UIStroke3.Thickness = 1;
    UIStroke3.Parent = Frame5;
    local Frame6 = Instance.new("Frame");
    Frame6.Name = "GridFrame";
    Frame6.Size = UDim2.fromOffset(64, 64);
    Frame6.Position = UDim2.new(0, math_floor_ret, 0, 42);
    Frame6.BackgroundTransparency = 1;
    Frame6.ZIndex = 41;
    Frame6.Parent = Frame;
    local v16 = GridPack.createGrid({
        Visible = true,
        SlotAspectRatio = 1,
        Parent = Frame6,
        Assets = {
            Slot = ReplicatedStorage.GridPack.Slot
        },
        GridSize = u11.gridSize,
        Size = UDim2.fromScale(u11.gridSize.X, u11.gridSize.Y),
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Metadata = {
            TiedInstance = tiedInstance
        }
    });

    if u11.moveMiddleware then
        v16.MoveMiddleware = u11.moveMiddleware;
    end;

    local u17 = false;
    local u18 = nil;
    local u19 = nil;
    TextButton.MouseButton1Down:Connect(function() -- Line: 269
        -- upvalues: u17 (ref), u18 (ref), UserInputService (ref), u19 (ref), Frame (copy)
        u17 = true;
        u18 = UserInputService:GetMouseLocation();
        u19 = Frame.Position;
    end);
    local u23 = UserInputService.InputChanged:Connect(function(p20) -- Line: 280
        -- upvalues: u17 (ref), UserInputService (ref), u18 (ref), u19 (ref), math_max_ret (copy), Frame (copy)
        if not u17 then
            return;
        end;

        if p20.UserInputType ~= Enum.UserInputType.MouseMovement and p20.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        local v21 = UserInputService:GetMouseLocation() - u18;
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v22 = workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize or Vector2.new(1280, 720);
        local math_clamp_ret = math.clamp(u19.X.Offset + v21.X, -math_max_ret + 48, v22.X - 48);
        local math_clamp_ret2 = math.clamp(u19.Y.Offset + v21.Y, 0, v22.Y - 34);
        Frame.Position = UDim2.new(u19.X.Scale, math_clamp_ret, u19.Y.Scale, math_clamp_ret2);
    end);
    local u25 = UserInputService.InputEnded:Connect(function(p24) -- Line: 294
        -- upvalues: u17 (ref)
        if p24.UserInputType == Enum.UserInputType.MouseButton1 then
            u17 = false;
        end;
    end);
    local u27 = {
        Close = function(p26) -- Line: 301, Name: Close
            -- upvalues: u23 (ref), u25 (ref), Frame (copy), u2 (ref), tiedInstance (copy), u11 (copy)
            if u23 then
                u23:Disconnect();
                u23 = nil;
            end;

            if u25 then
                u25:Disconnect();
                u25 = nil;
            end;

            if Frame.Parent then
                Frame:Destroy();
            end;

            u2[tiedInstance] = nil;

            if u11.onClose then
                u11.onClose();
            end;
        end
    };
    TextButton2.MouseButton1Click:Connect(function() -- Line: 308
        -- upvalues: u27 (copy)
        u27:Close();
    end);
    u27.Grid = v16;
    u27.TiedInstance = tiedInstance;
    u27.ParentTied = u11.parentTied;
    u2[tiedInstance] = u27;

    return u27, v16;
end;

function v1.CloseAll() -- Line: 331
    -- upvalues: u2 (ref)
    local v28 = {};

    for _, v in pairs(u2) do
        v28[#v28 + 1] = v;
    end;

    for _, v in ipairs(v28) do
        v:Close();
    end;

    u2 = {};
end;

function v1.CloseForParent(p29) -- Line: 353
    -- upvalues: u2 (ref)
    if p29 == nil then
        return;
    end;

    local v30 = {};

    for _, v in pairs(u2) do
        if v.ParentTied ~= nil and v.ParentTied == p29 then
            v30[#v30 + 1] = v;
        end;
    end;

    for _, v in ipairs(v30) do
        v:Close();
    end;
end;

function v1.Close(p31) -- Line: 365
    -- upvalues: u2 (ref)
    local v32 = u2[p31];

    if v32 then
        v32:Close();
    end;
end;

function v1.GetOpen() -- Line: 371
    -- upvalues: u2 (ref)
    return u2;
end;

return v1;