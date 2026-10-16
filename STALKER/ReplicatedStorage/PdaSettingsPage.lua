-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local ClientSettings = require(ReplicatedStorage:WaitForChild("ClientSettings"));
local success, result = pcall(function() -- Line: 16
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage:WaitForChild("PdaSound"));
end);
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local Font_new_ret2 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
local Font_new_ret3 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
local Color3_fromRGB_ret = Color3.fromRGB(255, 200, 90);
local Color3_fromRGB_ret2 = Color3.fromRGB(220, 220, 220);
local Color3_fromRGB_ret3 = Color3.fromRGB(170, 170, 170);
local Color3_fromRGB_ret4 = Color3.fromRGB(120, 120, 120);
local Color3_fromRGB_ret5 = Color3.fromRGB(28, 30, 28);
local Color3_fromRGB_ret6 = Color3.fromRGB(38, 40, 38);
local Color3_fromRGB_ret7 = Color3.fromRGB(60, 70, 50);
local Color3_fromRGB_ret8 = Color3.fromRGB(40, 42, 45);
local Color3_fromRGB_ret9 = Color3.fromRGB(60, 60, 60);
local Color3_fromRGB_ret10 = Color3.fromRGB(225, 95, 95);
local Color3_fromRGB_ret11 = Color3.fromRGB(140, 210, 120);
local u1 = {
    default = "AS NOW",
    ["top-right"] = "TOP RIGHT",
    ["bottom-center"] = "BOTTOM"
};
local u2 = { "default", "top-right", "bottom-center" };
local v3 = {};

local function label(p4: userdata, p5: any) -- Line: 44
    -- upvalues: Font_new_ret3 (copy), Color3_fromRGB_ret2 (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = p5.font or Font_new_ret3;
    TextLabel.TextSize = p5.size or 20;
    TextLabel.TextColor3 = p5.color or Color3_fromRGB_ret2;
    TextLabel.Text = p5.text or "";
    TextLabel.TextXAlignment = p5.align or Enum.TextXAlignment.Left;
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
    TextLabel.Size = p5.sizeU or UDim2.new(1, 0, 0, 22);
    TextLabel.Position = p5.pos or UDim2.new();
    TextLabel.Parent = p4;

    return TextLabel;
end;

local function button(p6: userdata, p7: string, p8, p9) -- Line: 59
    -- upvalues: Color3_fromRGB_ret8 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret2 (copy)
    local TextButton = Instance.new("TextButton");
    TextButton.AutoButtonColor = true;
    TextButton.BackgroundColor3 = Color3_fromRGB_ret8;
    TextButton.BorderSizePixel = 0;
    TextButton.FontFace = Font_new_ret2;
    TextButton.TextSize = 17;
    TextButton.TextColor3 = Color3_fromRGB_ret2;
    TextButton.Text = p7;
    TextButton.Size = p8;
    TextButton.Position = p9;
    TextButton.Parent = p6;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 4);
    UICorner.Parent = TextButton;

    return TextButton;
end;

local function click() -- Line: 75
    -- upvalues: success (copy), result (copy)
    if success and result then
        result.PlayClick();
    end;
end;

local function section(p10: userdata, p11: number, p12: string) -- Line: 79
    -- upvalues: label (copy), Font_new_ret (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret9 (copy)
    local Frame = Instance.new("Frame");
    Frame.BackgroundTransparency = 1;
    Frame.Size = UDim2.new(1, 0, 0, 34);
    Frame.LayoutOrder = p11;
    Frame.Parent = p10;
    label(Frame, {
        size = 22,
        text = p12,
        font = Font_new_ret,
        color = Color3_fromRGB_ret,
        pos = UDim2.fromOffset(0, 4),
        sizeU = UDim2.new(1, 0, 0, 26)
    });
    local Frame2 = Instance.new("Frame");
    Frame2.BackgroundColor3 = Color3_fromRGB_ret9;
    Frame2.BorderSizePixel = 0;
    Frame2.Position = UDim2.new(0, 0, 1, -1);
    Frame2.Size = UDim2.new(1, 0, 0, 1);
    Frame2.Parent = Frame;
end;

local function row(p13: userdata, p14: number, p15: string, p16: string?) -- Line: 95
    -- upvalues: Color3_fromRGB_ret5 (copy), label (copy), Font_new_ret2 (copy), Color3_fromRGB_ret4 (copy)
    local Frame = Instance.new("Frame");
    Frame.BackgroundColor3 = Color3_fromRGB_ret5;
    Frame.BackgroundTransparency = 0.2;
    Frame.BorderSizePixel = 0;
    Frame.Size = UDim2.new(1, 0, 0, p16 and 58 or 44);
    Frame.LayoutOrder = p14;
    Frame.Parent = p13;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingLeft = UDim.new(0, 12);
    UIPadding.PaddingRight = UDim.new(0, 12);
    UIPadding.Parent = Frame;
    label(Frame, {
        text = p15,
        font = Font_new_ret2,
        pos = UDim2.fromOffset(0, p16 and 6 or 11),
        sizeU = UDim2.new(1, -202, 0, 22)
    });

    if p16 then
        label(Frame, {
            size = 15,
            text = p16,
            color = Color3_fromRGB_ret4,
            pos = UDim2.fromOffset(0, 30),
            sizeU = UDim2.new(1, -202, 0, 18)
        });
    end;

    return Frame;
end;

local function control(p17: userdata) -- Line: 115
    local Frame = Instance.new("Frame");
    Frame.BackgroundTransparency = 1;
    Frame.AnchorPoint = Vector2.new(1, 0.5);
    Frame.Position = UDim2.new(1, 0, 0.5, 0);
    Frame.Size = UDim2.fromOffset(190, 30);
    Frame.Parent = p17;

    return Frame;
end;

local function toggle(p18: userdata, p19: number, u20: string, p21: string, p22: string?) -- Line: 125
    -- upvalues: row (copy), button (copy), control (copy), ClientSettings (copy), Color3_fromRGB_ret7 (copy), Color3_fromRGB_ret8 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), success (copy), result (copy)
    local u23 = button(control((row(p18, p19, p21, p22))), "", UDim2.fromScale(1, 1), UDim2.new());
    ClientSettings.OnChanged(u20, function(p24) -- Line: 128
        -- upvalues: u23 (copy), Color3_fromRGB_ret7 (ref), Color3_fromRGB_ret8 (ref), Color3_fromRGB_ret2 (ref), Color3_fromRGB_ret3 (ref)
        u23.Text = p24 and "ON" or "OFF";
        u23.BackgroundColor3 = p24 and Color3_fromRGB_ret7 or Color3_fromRGB_ret8;
        u23.TextColor3 = p24 and Color3_fromRGB_ret2 or Color3_fromRGB_ret3;
    end);
    u23.MouseButton1Click:Connect(function() -- Line: 133
        -- upvalues: success (ref), result (ref), ClientSettings (ref), u20 (copy)
        if success and result then
            result.PlayClick();
        end;

        ClientSettings.Set(u20, not ClientSettings.Get(u20));
    end);
end;

local function volumeRow(p25: userdata, p26: number) -- Line: 139
    -- upvalues: row (copy), control (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret (copy), label (copy), button (copy), ClientSettings (copy), UserInputService (copy), success (copy), result (copy)
    local v27 = control((row(p25, p26, "PDA sounds", "Notifications, alerts, the radio chime. 0% mutes them.")));
    local Frame = Instance.new("Frame");
    Frame.Name = "Track";
    Frame.BackgroundColor3 = Color3_fromRGB_ret6;
    Frame.BorderSizePixel = 0;
    Frame.AnchorPoint = Vector2.new(0, 0.5);
    Frame.Position = UDim2.new(0, 0, 0.5, 0);
    Frame.Size = UDim2.new(1, -96, 0, 8);
    Frame.Active = true;
    Frame.Parent = v27;
    local Frame2 = Instance.new("Frame");
    Frame2.BackgroundColor3 = Color3_fromRGB_ret;
    Frame2.BorderSizePixel = 0;
    Frame2.Size = UDim2.fromScale(1, 1);
    Frame2.Parent = Frame;
    local u28 = label(v27, {
        text = "100%",
        size = 18,
        align = Enum.TextXAlignment.Right,
        pos = UDim2.new(1, -92, 0, 4),
        sizeU = UDim2.fromOffset(44, 22)
    });
    local v29 = button(v27, "TEST", UDim2.fromOffset(42, 26), UDim2.new(1, -42, 0, 2));
    v29.TextSize = 14;
    ClientSettings.OnChanged("pdaVolume", function(p30) -- Line: 161
        -- upvalues: Frame2 (copy), u28 (copy)
        Frame2.Size = UDim2.fromScale(p30, 1);
        u28.Text = string.format("%d%%", (math.floor(p30 * 100 + 0.5)));
    end);
    local u31 = false;

    local function setFrom(p32: number) -- Line: 166
        -- upvalues: Frame (copy), ClientSettings (ref)
        local X = Frame.AbsoluteSize.X;

        if X <= 0 then
            return;
        end;

        ClientSettings.Set("pdaVolume", (math.clamp((p32 - Frame.AbsolutePosition.X) / X, 0, 1)));
    end;

    Frame.InputBegan:Connect(function(p33) -- Line: 171
        -- upvalues: u31 (ref), Frame (copy), ClientSettings (ref)
        if p33.UserInputType == Enum.UserInputType.MouseButton1 or p33.UserInputType == Enum.UserInputType.Touch then
            u31 = true;
            local X = Frame.AbsoluteSize.X;

            if X <= 0 then
                return;
            end;

            ClientSettings.Set("pdaVolume", (math.clamp((p33.Position.X - Frame.AbsolutePosition.X) / X, 0, 1)));
        end;
    end);
    UserInputService.InputChanged:Connect(function(p34) -- Line: 177
        -- upvalues: u31 (ref), Frame (copy), ClientSettings (ref)
        if u31 and (p34.UserInputType == Enum.UserInputType.MouseMovement or p34.UserInputType == Enum.UserInputType.Touch) then
            local X = Frame.AbsoluteSize.X;

            if X <= 0 then
                return;
            end;

            ClientSettings.Set("pdaVolume", (math.clamp((p34.Position.X - Frame.AbsolutePosition.X) / X, 0, 1)));
        end;
    end);
    UserInputService.InputEnded:Connect(function(p35) -- Line: 182
        -- upvalues: u31 (ref)
        if p35.UserInputType == Enum.UserInputType.MouseButton1 or p35.UserInputType == Enum.UserInputType.Touch then
            u31 = false;
        end;
    end);
    v29.MouseButton1Click:Connect(function() -- Line: 187
        -- upvalues: success (ref), result (ref)
        if success and result then
            result.Play("pda_notify");
        end;
    end);
end;

local function toastRow(p36: userdata, p37: number) -- Line: 192
    -- upvalues: row (copy), button (copy), control (copy), ClientSettings (copy), u1 (copy), success (copy), result (copy), u2 (copy)
    local u38 = button(control((row(p36, p37, "Notification position", "Where toasts appear. \"As now\" keeps each where it was."))), "", UDim2.fromScale(1, 1), UDim2.new());
    ClientSettings.OnChanged("toastPosition", function(p39) -- Line: 195
        -- upvalues: u38 (copy), u1 (ref)
        u38.Text = u1[p39] or "AS NOW";
    end);
    u38.MouseButton1Click:Connect(function() -- Line: 198
        -- upvalues: success (ref), result (ref), u2 (ref), ClientSettings (ref)
        if success and result then
            result.PlayClick();
        end;

        local v40 = table.find(u2, ClientSettings.Get("toastPosition")) or 1;
        ClientSettings.Set("toastPosition", u2[v40 % #u2 + 1]);
    end);
end;

local function promoRow(p41: userdata, p42: number) -- Line: 205
    -- upvalues: row (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret4 (copy), Font_new_ret2 (copy), Color3_fromRGB_ret2 (copy), button (copy), label (copy), Color3_fromRGB_ret3 (copy), success (copy), result (copy), ReplicatedStorage (copy), Color3_fromRGB_ret11 (copy), Color3_fromRGB_ret10 (copy)
    local v43 = row(p41, p42, "Code", "Redeem a promotion code. Each code works once per account.");
    v43.Size = UDim2.new(1, 0, 0, 84);
    local TextBox = Instance.new("TextBox");
    TextBox.Name = "CodeBox";
    TextBox.BackgroundColor3 = Color3_fromRGB_ret6;
    TextBox.BorderSizePixel = 0;
    TextBox.ClearTextOnFocus = false;
    TextBox.PlaceholderText = "Enter code";
    TextBox.PlaceholderColor3 = Color3_fromRGB_ret4;
    TextBox.Text = "";
    TextBox.FontFace = Font_new_ret2;
    TextBox.TextSize = 18;
    TextBox.TextColor3 = Color3_fromRGB_ret2;
    TextBox.TextXAlignment = Enum.TextXAlignment.Left;
    TextBox.AnchorPoint = Vector2.new(1, 0);
    TextBox.Position = UDim2.new(1, -96, 0, 8);
    TextBox.Size = UDim2.fromOffset(220, 32);
    TextBox.Parent = v43;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingLeft = UDim.new(0, 8);
    UIPadding.Parent = TextBox;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 4);
    UICorner.Parent = TextBox;
    local v44 = button(v43, "REDEEM", UDim2.fromOffset(88, 32), UDim2.new(1, -88, 0, 8));
    local u45 = label(v43, {
        text = "",
        size = 17,
        color = Color3_fromRGB_ret3,
        align = Enum.TextXAlignment.Right,
        pos = UDim2.new(0, 0, 0, 50),
        sizeU = UDim2.new(1, 0, 0, 22)
    });
    local u46 = false;

    local function submit() -- Line: 231
        -- upvalues: u46 (ref), TextBox (copy), u45 (copy), Color3_fromRGB_ret3 (ref), success (ref), result (ref), ReplicatedStorage (ref), Color3_fromRGB_ret11 (ref), Color3_fromRGB_ret10 (ref)
        if u46 then
            return;
        end;

        local Text = TextBox.Text;

        if Text:gsub("%s", "") == "" then
            u45.Text = "Enter a code.";
            u45.TextColor3 = Color3_fromRGB_ret3;

            return;
        end;

        u46 = true;

        if success and result then
            result.PlayClick();
        end;

        u45.Text = "Checking...";
        u45.TextColor3 = Color3_fromRGB_ret3;
        local Remotes = ReplicatedStorage:FindFirstChild("Remotes");

        if Remotes then
            Remotes = Remotes:FindFirstChild("RedeemPromoCode");
        end;

        local v47 = "Codes are unavailable right now.";
        local v48;

        if Remotes and Remotes:IsA("RemoteFunction") then
            local v49;
            v49, v48 = pcall(function() -- Line: 247
                -- upvalues: Remotes (copy), Text (copy)
                return Remotes:InvokeServer(Text);
            end);

            if v49 then
                if type(v48) ~= "string" then
                    v48 = v47;
                end;
            else
                v48 = v47;
            end;
        else
            v48 = v47;
        end;

        local v50;

        if v48:find("redeemed%.") == nil then
            v50 = false;
        else
            v50 = v48:find("already") == nil;
        end;

        u45.Text = v48;
        u45.TextColor3 = v50 and Color3_fromRGB_ret11 or Color3_fromRGB_ret10;

        if v50 then
            TextBox.Text = "";
        end;

        u46 = false;
    end;

    v44.MouseButton1Click:Connect(submit);
    TextBox.FocusLost:Connect(function(p51) -- Line: 257
        -- upvalues: submit (copy)
        if p51 then
            submit();
        end;
    end);
end;

function v3.Build(p52: userdata) -- Line: 260
    -- upvalues: Color3_fromRGB_ret4 (copy), section (copy), volumeRow (copy), toggle (copy), toastRow (copy), promoRow (copy)
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "SettingsScroll";
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.Position = UDim2.fromScale(0.03, 0.03);
    ScrollingFrame.Size = UDim2.fromScale(0.94, 0.94);
    ScrollingFrame.CanvasSize = UDim2.new();
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    ScrollingFrame.ScrollBarThickness = 4;
    ScrollingFrame.ScrollBarImageColor3 = Color3_fromRGB_ret4;
    ScrollingFrame.Parent = p52;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 6);
    UIListLayout.Parent = ScrollingFrame;
    local u53 = 0;

    local function n() -- Line: 278
        -- upvalues: u53 (ref)
        u53 = u53 + 1;

        return u53;
    end;

    u53 = u53 + 1;
    section(ScrollingFrame, u53, "AUDIO");
    u53 = u53 + 1;
    volumeRow(ScrollingFrame, u53);
    u53 = u53 + 1;
    toggle(ScrollingFrame, u53, "npcRadio", "NPC radio chatter", "Nearby stalkers\' combat radio on your PDA.");
    u53 = u53 + 1;
    section(ScrollingFrame, u53, "GRAPHICS");
    u53 = u53 + 1;
    toggle(ScrollingFrame, u53, "shadows", "Shadows", "World shadows. Off can help on slower machines.");
    u53 = u53 + 1;
    toggle(ScrollingFrame, u53, "screenRain", "Rain on visor", "Raindrops on a gas mask\'s glass.");
    u53 = u53 + 1;
    toggle(ScrollingFrame, u53, "inventoryBlur", "Inventory blur", "The blur behind the open inventory.");
    u53 = u53 + 1;
    section(ScrollingFrame, u53, "INTERFACE");
    u53 = u53 + 1;
    toggle(ScrollingFrame, u53, "locationBanner", "Location banner", "The place name when you enter an area.");
    u53 = u53 + 1;
    toastRow(ScrollingFrame, u53);
    u53 = u53 + 1;
    section(ScrollingFrame, u53, "PROMOTION CODE");
    u53 = u53 + 1;
    promoRow(ScrollingFrame, u53);
end;

return v3;