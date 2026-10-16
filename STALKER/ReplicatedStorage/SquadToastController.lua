-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local ContextActionService = game:GetService("ContextActionService");
local LocalPlayer = Players.LocalPlayer;
local SquadController = require(ReplicatedStorage:WaitForChild("SquadController"));
local ToastUI = require(ReplicatedStorage:WaitForChild("ToastUI"));
local success, result = pcall(function() -- Line: 10
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage:WaitForChild("PdaSound"));
end);
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
local Color3_fromRGB_ret = Color3.fromRGB(255, 200, 90);
local Color3_fromRGB_ret2 = Color3.fromRGB(28, 30, 28);
local Color3_fromRGB_ret3 = Color3.fromRGB(220, 220, 220);
local u1 = {
    _gui = nil,
    _inviteCard = nil,
    _shareCard = nil
};

local function destroyInviteCard() -- Line: 30
    -- upvalues: ContextActionService (copy), u1 (copy)
    pcall(function() -- Line: 31
        -- upvalues: ContextActionService (ref)
        ContextActionService:UnbindAction("SquadInviteAccept");
    end);
    pcall(function() -- Line: 32
        -- upvalues: ContextActionService (ref)
        ContextActionService:UnbindAction("SquadInviteDecline");
    end);

    if u1._inviteCard then
        u1._inviteCard:Destroy();
        u1._inviteCard = nil;
    end;
end;

local function ensureGui() -- Line: 39
    -- upvalues: u1 (copy), LocalPlayer (copy)
    if u1._gui then
        return u1._gui;
    end;

    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    local SquadToasts = PlayerGui:FindFirstChild("SquadToasts");

    if SquadToasts then
        SquadToasts:Destroy();
    end;

    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "SquadToasts";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.DisplayOrder = 50;
    ScreenGui.Parent = PlayerGui;
    u1._gui = ScreenGui;

    return ScreenGui;
end;

local function buildInviteCard(p2) -- Line: 54
    -- upvalues: success (copy), result (copy), ensureGui (copy), destroyInviteCard (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), Font_new_ret (copy), Font_new_ret3 (copy), Color3_fromRGB_ret3 (copy), Font_new_ret2 (copy), SquadController (copy), u1 (copy), ContextActionService (copy)
    if success and result then
        result.Play("pda_beep_1");
    end;

    local v3 = ensureGui();
    destroyInviteCard();
    local Frame = Instance.new("Frame");
    Frame.Name = "InviteCard";
    Frame.AnchorPoint = Vector2.new(1, 0);
    Frame.Position = UDim2.new(1, -16, 0, 80);
    Frame.Size = UDim2.fromOffset(280, 110);
    Frame.BackgroundColor3 = Color3_fromRGB_ret2;
    Frame.BackgroundTransparency = 0.1;
    Frame.BorderSizePixel = 0;
    Frame.Parent = v3;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret;
    UIStroke.Thickness = 1;
    UIStroke.Transparency = 0.4;
    UIStroke.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Position = UDim2.fromOffset(12, 8);
    TextLabel.Size = UDim2.new(1, -24, 0, 20);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = 14;
    TextLabel.TextColor3 = Color3_fromRGB_ret;
    TextLabel.Text = "SQUAD INVITE";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Position = UDim2.fromOffset(12, 30);
    TextLabel2.Size = UDim2.new(1, -24, 0, 36);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret3;
    TextLabel2.TextSize = 15;
    TextLabel2.TextColor3 = Color3_fromRGB_ret3;
    TextLabel2.TextWrapped = true;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel2.Text = (p2.fromName or "Someone") .. " invited you to their squad.";
    TextLabel2.Parent = Frame;
    local TextButton = Instance.new("TextButton");
    TextButton.Position = UDim2.new(0, 12, 1, -38);
    TextButton.Size = UDim2.fromOffset(110, 28);
    TextButton.BackgroundColor3 = Color3_fromRGB_ret;
    TextButton.BackgroundTransparency = 0;
    TextButton.BorderSizePixel = 0;
    TextButton.AutoButtonColor = true;
    TextButton.FontFace = Font_new_ret2;
    TextButton.TextSize = 14;
    TextButton.TextColor3 = Color3.fromRGB(20, 20, 22);
    TextButton.Text = "[Y] ACCEPT";
    TextButton.Parent = Frame;
    TextButton.MouseButton1Click:Connect(function() -- Line: 111
        -- upvalues: SquadController (ref)
        SquadController:AcceptInvite();
    end);
    local TextButton2 = Instance.new("TextButton");
    TextButton2.AnchorPoint = Vector2.new(1, 0);
    TextButton2.Position = UDim2.new(1, -12, 1, -38);
    TextButton2.Size = UDim2.fromOffset(110, 28);
    TextButton2.BackgroundColor3 = Color3.fromRGB(45, 45, 45);
    TextButton2.BackgroundTransparency = 0.2;
    TextButton2.BorderSizePixel = 0;
    TextButton2.AutoButtonColor = true;
    TextButton2.FontFace = Font_new_ret2;
    TextButton2.TextSize = 14;
    TextButton2.TextColor3 = Color3_fromRGB_ret3;
    TextButton2.Text = "[N] DECLINE";
    TextButton2.Parent = Frame;
    TextButton2.MouseButton1Click:Connect(function() -- Line: 128
        -- upvalues: SquadController (ref)
        SquadController:DeclineInvite();
    end);
    u1._inviteCard = Frame;
    ContextActionService:BindActionAtPriority("SquadInviteAccept", function(p4, p5) -- Line: 136
        -- upvalues: SquadController (ref)
        if p5 ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass;
        end;

        SquadController:AcceptInvite();

        return Enum.ContextActionResult.Sink;
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Y);
    ContextActionService:BindActionAtPriority("SquadInviteDecline", function(p6, p7) -- Line: 149
        -- upvalues: SquadController (ref)
        if p7 ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass;
        end;

        SquadController:DeclineInvite();

        return Enum.ContextActionResult.Sink;
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.N);
end;

local function showToast(p8) -- Line: 165
    -- upvalues: ToastUI (copy)
    ToastUI.Show(p8, nil, "top-right");
end;

local function destroyShareCard() -- Line: 169
    -- upvalues: ContextActionService (copy), u1 (copy)
    pcall(function() -- Line: 170
        -- upvalues: ContextActionService (ref)
        ContextActionService:UnbindAction("TaskShareAccept");
    end);
    pcall(function() -- Line: 171
        -- upvalues: ContextActionService (ref)
        ContextActionService:UnbindAction("TaskShareDecline");
    end);

    if u1._shareCard then
        u1._shareCard:Destroy();
        u1._shareCard = nil;
    end;
end;

local function buildShareCard(p9) -- Line: 180
    -- upvalues: ensureGui (copy), destroyShareCard (copy), Color3_fromRGB_ret2 (copy), Font_new_ret (copy), Font_new_ret3 (copy), Color3_fromRGB_ret3 (copy), Font_new_ret2 (copy), ReplicatedStorage (copy), ContextActionService (copy), u1 (copy)
    local v10 = ensureGui();
    destroyShareCard();
    local u11 = p9.task and p9.task.id;
    local Color3_fromRGB_ret4 = Color3.fromRGB(140, 200, 120);
    local Frame = Instance.new("Frame");
    Frame.Name = "ShareCard";
    Frame.AnchorPoint = Vector2.new(1, 0);
    Frame.Position = UDim2.new(1, -16, 0, 200);
    Frame.Size = UDim2.fromOffset(280, 110);
    Frame.BackgroundColor3 = Color3_fromRGB_ret2;
    Frame.BackgroundTransparency = 0.1;
    Frame.BorderSizePixel = 0;
    Frame.Parent = v10;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret4;
    UIStroke.Thickness = 1;
    UIStroke.Transparency = 0.4;
    UIStroke.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Position = UDim2.fromOffset(12, 8);
    TextLabel.Size = UDim2.new(1, -24, 0, 20);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = 14;
    TextLabel.TextColor3 = Color3_fromRGB_ret4;
    TextLabel.Text = "TASK SHARED";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Position = UDim2.fromOffset(12, 30);
    TextLabel2.Size = UDim2.new(1, -24, 0, 36);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font_new_ret3;
    TextLabel2.TextSize = 15;
    TextLabel2.TextColor3 = Color3_fromRGB_ret3;
    TextLabel2.TextWrapped = true;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel2.Text = (p9.fromName or "Squadmate") .. " shared: " .. (p9.task and (p9.task.title or "a task") or "a task");
    TextLabel2.Parent = Frame;
    local TextButton = Instance.new("TextButton");
    TextButton.Position = UDim2.new(0, 12, 1, -38);
    TextButton.Size = UDim2.fromOffset(110, 28);
    TextButton.BackgroundColor3 = Color3_fromRGB_ret4;
    TextButton.BorderSizePixel = 0;
    TextButton.AutoButtonColor = true;
    TextButton.FontFace = Font_new_ret2;
    TextButton.TextSize = 14;
    TextButton.TextColor3 = Color3.fromRGB(20, 22, 20);
    TextButton.Text = "[Y] ACCEPT";
    TextButton.Parent = Frame;
    TextButton.MouseButton1Click:Connect(function() -- Line: 237
        -- upvalues: ReplicatedStorage (ref), destroyShareCard (ref), u11 (copy)
        local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"));
        destroyShareCard();
        TaskController:AcceptShare(u11);
    end);
    local TextButton2 = Instance.new("TextButton");
    TextButton2.AnchorPoint = Vector2.new(1, 0);
    TextButton2.Position = UDim2.new(1, -12, 1, -38);
    TextButton2.Size = UDim2.fromOffset(110, 28);
    TextButton2.BackgroundColor3 = Color3.fromRGB(45, 45, 45);
    TextButton2.BackgroundTransparency = 0.2;
    TextButton2.BorderSizePixel = 0;
    TextButton2.AutoButtonColor = true;
    TextButton2.FontFace = Font_new_ret2;
    TextButton2.TextSize = 14;
    TextButton2.TextColor3 = Color3_fromRGB_ret3;
    TextButton2.Text = "[N] DECLINE";
    TextButton2.Parent = Frame;
    TextButton2.MouseButton1Click:Connect(function() -- Line: 256
        -- upvalues: ReplicatedStorage (ref), destroyShareCard (ref), u11 (copy)
        local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"));
        destroyShareCard();
        TaskController:DeclineShare(u11);
    end);
    ContextActionService:BindActionAtPriority("TaskShareAccept", function(p12, p13) -- Line: 264
        -- upvalues: destroyShareCard (ref), ReplicatedStorage (ref), u11 (copy)
        if p13 ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass;
        end;

        destroyShareCard();
        require(ReplicatedStorage:WaitForChild("TaskController")):AcceptShare(u11);

        return Enum.ContextActionResult.Sink;
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Y);
    ContextActionService:BindActionAtPriority("TaskShareDecline", function(p14, p15) -- Line: 278
        -- upvalues: destroyShareCard (ref), ReplicatedStorage (ref), u11 (copy)
        if p15 ~= Enum.UserInputState.Begin then
            return Enum.ContextActionResult.Pass;
        end;

        destroyShareCard();
        require(ReplicatedStorage:WaitForChild("TaskController")):DeclineShare(u11);

        return Enum.ContextActionResult.Sink;
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.N);
    u1._shareCard = Frame;
    task.delay(20, function() -- Line: 296
        -- upvalues: u1 (ref), Frame (copy), destroyShareCard (ref)
        if u1._shareCard == Frame then
            destroyShareCard();
        end;
    end);
end;

function u1.Init(p16) -- Line: 303
    -- upvalues: ensureGui (copy), SquadController (copy), buildInviteCard (copy), destroyInviteCard (copy), showToast (copy), ReplicatedStorage (copy), buildShareCard (copy)
    ensureGui();
    SquadController:OnInviteChanged(function(p17) -- Line: 305
        -- upvalues: buildInviteCard (ref), destroyInviteCard (ref)
        if p17 then
            buildInviteCard(p17);

            return;
        end;

        destroyInviteCard();
    end);
    SquadController:SetToastHandler(showToast);
    require(ReplicatedStorage:WaitForChild("ContactController")):SetToastHandler(showToast);
    local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"));
    TaskController:SetToastHandler(showToast);
    TaskController:OnShareToast(function(p18) -- Line: 324
        -- upvalues: buildShareCard (ref)
        if p18 then
            buildShareCard(p18);
        end;
    end);
end;

return u1;