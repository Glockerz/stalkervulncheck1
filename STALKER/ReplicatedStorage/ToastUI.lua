-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TextService = game:GetService("TextService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local UITheme = require(ReplicatedStorage:WaitForChild("InventoryController"):WaitForChild("UITheme"));
local C = UITheme.C;
local u1 = {};
local success, result = pcall(function() -- Line: 37
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage:WaitForChild("PdaSound"));
end);
local u2 = {
    success = {
        label = "DONE",
        accent = C.money
    },
    info = {
        label = "NOTICE",
        accent = C.amber
    },
    warning = {
        label = "WARNING",
        accent = C.blood
    }
};

function u1.InferType(p3) -- Line: 48
    local string_lower_ret = string.lower((tostring(p3 or "")));

    return (string_lower_ret:find("fail") or (string_lower_ret:find("couldn") or (string_lower_ret:find("cannot") or (string_lower_ret:find("can\'t") or (string_lower_ret:find("no space") or (string_lower_ret:find("too many") or (string_lower_ret:find("expired") or (string_lower_ret:find("no squadmate") or string_lower_ret:find("not available"))))))))) and "warning" or ((string_lower_ret:find("accepted") or (string_lower_ret:find("completed") or (string_lower_ret:find("shared with") or (string_lower_ret:find("picked up") or (string_lower_ret:find("equipped") or (string_lower_ret:find("₽") or string_lower_ret:find("✓"))))))) and "success" or "info");
end;

local u4 = (-1 / 0);

local function playSound() -- Line: 62
    -- upvalues: u4 (ref), success (copy), result (copy)
    local os_clock_ret = os.clock();

    if os_clock_ret - u4 < 0.15 then
        return;
    end;

    u4 = os_clock_ret;

    if success and result then
        result.Play("pda_tip", 0.5);
    end;
end;

local u5 = {};

local function ensureStack(p6) -- Line: 71
    -- upvalues: u5 (copy), LocalPlayer (copy)
    local v7 = u5[p6];

    if v7 and (v7.gui and v7.gui.Parent) then
        return v7;
    end;

    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "ToastUI_" .. p6;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.DisplayOrder = 60;
    ScreenGui.Parent = PlayerGui;
    local v8 = {
        gui = ScreenGui,
        toasts = {}
    };
    u5[p6] = v8;

    return v8;
end;

local function targetPosition(p9, p10) -- Line: 87
    if p9 == "bottom-center" then
        return UDim2.new(0.5, 0, 1, -110 - p10);
    end;

    return UDim2.new(1, -16, 0, 200 + p10);
end;

local function reflow(p11, p12) -- Line: 94
    -- upvalues: TweenService (copy)
    local v13 = 0;

    for _, v in ipairs(p11.toasts) do
        local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local v14 = {};
        local v15;

        if p12 == "bottom-center" then
            v15 = UDim2.new(0.5, 0, 1, -110 - v13);
        else
            v15 = UDim2.new(1, -16, 0, 200 + v13);
        end;

        v14.Position = v15;
        TweenService:Create(v, TweenInfo_new_ret, v14):Play();
        v13 = v13 + (v.Size.Y.Offset + 8);
    end;
end;

local function bodyHeight(p16) -- Line: 103
    -- upvalues: TextService (copy)
    local Y = TextService:GetTextSize(p16, 17, Enum.Font.RobotoCondensed, Vector2.new(348, 1000)).Y;

    return math.max(20, Y);
end;

local success2, result2 = pcall(function() -- Line: 111
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage:WaitForChild("ClientSettings", 5));
end);

function u1.Show(p17, p18, p19) -- Line: 113
    -- upvalues: success2 (copy), result2 (copy), u1 (copy), u2 (copy), ensureStack (copy), TextService (copy), C (copy), UITheme (copy), reflow (copy), TweenService (copy), u4 (ref), success (copy), result (copy)
    local v20 = success2 and result2 and result2.Get("toastPosition");

    if v20 ~= "top-right" and v20 ~= "bottom-center" then
        v20 = p19;
    end;

    local u21 = v20 == "bottom-center" and "bottom-center" or "top-right";
    local v22 = u2[p18 or u1.InferType(p17)] or u2.info;
    local u23 = ensureStack(u21);
    local v24 = tostring(p17);
    local Y = TextService:GetTextSize(v24, 17, Enum.Font.RobotoCondensed, Vector2.new(348, 1000)).Y;
    local v25 = 26 + math.max(20, Y) + 9;
    local Frame = Instance.new("Frame");
    Frame.Name = "Toast";
    Frame.Size = UDim2.fromOffset(380, v25);
    Frame.BackgroundColor3 = C.panel;
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 60;
    Frame.AnchorPoint = u21 == "bottom-center" and Vector2.new(0.5, 1) or Vector2.new(1, 0);
    local v26;

    if u21 == "bottom-center" then
        v26 = UDim2.new(0.5, 0, 1, -110);
    else
        v26 = UDim2.new(1, -16, 0, 200);
    end;

    Frame.Position = u21 == "bottom-center" and v26 + UDim2.fromOffset(0, 14) or v26 + UDim2.fromOffset(14, 0);
    Frame.Parent = u23.gui;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 2);
    UICorner.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = C.edge;
    UIStroke.Thickness = 1;
    UIStroke.Transparency = 1;
    UIStroke.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.BackgroundTransparency = 1;
    Frame2.BorderSizePixel = 0;
    Frame2.Position = UDim2.fromOffset(3, 3);
    Frame2.Size = UDim2.new(1, -6, 1, -6);
    Frame2.ZIndex = 61;
    Frame2.Parent = Frame;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = C.inner;
    UIStroke2.Thickness = 1;
    UIStroke2.Transparency = 1;
    UIStroke2.Parent = Frame2;
    local Frame3 = Instance.new("Frame");
    Frame3.BackgroundColor3 = v22.accent;
    Frame3.BackgroundTransparency = 1;
    Frame3.BorderSizePixel = 0;
    Frame3.Position = UDim2.fromOffset(6, 9);
    Frame3.Size = UDim2.new(0, 3, 1, -18);
    Frame3.ZIndex = 62;
    Frame3.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Position = UDim2.fromOffset(16, 9);
    TextLabel.Size = UDim2.new(1, -32, 0, 15);
    TextLabel.FontFace = UITheme.HEADER_FONT;
    TextLabel.TextSize = 13;
    TextLabel.TextColor3 = v22.accent;
    TextLabel.TextTransparency = 1;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Text = v22.label;
    TextLabel.ZIndex = 62;
    TextLabel.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Position = UDim2.fromOffset(16, 26);
    TextLabel2.Size = UDim2.new(1, -32, 1, -35);
    TextLabel2.FontFace = UITheme.BODY_FONT;
    TextLabel2.TextSize = 17;
    TextLabel2.TextColor3 = C.paper;
    TextLabel2.TextTransparency = 1;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel2.TextWrapped = true;
    TextLabel2.Text = v24;
    TextLabel2.ZIndex = 62;
    TextLabel2.Parent = Frame;
    table.insert(u23.toasts, 1, Frame);
    reflow(u23, u21);
    local TweenInfo_new_ret = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    TweenService:Create(Frame, TweenInfo_new_ret, {
        BackgroundTransparency = 0.06
    }):Play();
    TweenService:Create(UIStroke, TweenInfo_new_ret, {
        Transparency = 0
    }):Play();
    TweenService:Create(UIStroke2, TweenInfo_new_ret, {
        Transparency = 0
    }):Play();
    TweenService:Create(Frame3, TweenInfo_new_ret, {
        BackgroundTransparency = 0
    }):Play();
    TweenService:Create(TextLabel, TweenInfo_new_ret, {
        TextTransparency = 0
    }):Play();
    TweenService:Create(TextLabel2, TweenInfo_new_ret, {
        TextTransparency = 0
    }):Play();
    local os_clock_ret = os.clock();

    if os_clock_ret - u4 >= 0.15 then
        u4 = os_clock_ret;

        if success and result then
            result.Play("pda_tip", 0.5);
        end;
    end;

    local math_min_ret = math.min(10, #v24 * 0.03 + 6);
    task.delay(math_min_ret, function() -- Line: 206
        -- upvalues: Frame (copy), u23 (copy), reflow (ref), u21 (ref), TweenService (ref), UIStroke (copy), UIStroke2 (copy), Frame3 (copy), TextLabel (copy), TextLabel2 (copy)
        if not Frame.Parent then
            return;
        end;

        for i, v in ipairs(u23.toasts) do
            if v == Frame then
                table.remove(u23.toasts, i);
                break;
            end;
        end;

        reflow(u23, u21);
        local TweenInfo_new_ret2 = TweenInfo.new(0.3, Enum.EasingStyle.Quad);
        TweenService:Create(Frame, TweenInfo_new_ret2, {
            BackgroundTransparency = 1
        }):Play();
        TweenService:Create(UIStroke, TweenInfo_new_ret2, {
            Transparency = 1
        }):Play();
        TweenService:Create(UIStroke2, TweenInfo_new_ret2, {
            Transparency = 1
        }):Play();
        TweenService:Create(Frame3, TweenInfo_new_ret2, {
            BackgroundTransparency = 1
        }):Play();
        TweenService:Create(TextLabel, TweenInfo_new_ret2, {
            TextTransparency = 1
        }):Play();
        TweenService:Create(TextLabel2, TweenInfo_new_ret2, {
            TextTransparency = 1
        }):Play();
        task.delay(0.4, function() -- Line: 217
            -- upvalues: Frame (ref)
            if Frame then
                Frame:Destroy();
            end;
        end);
    end);
end;

return u1;