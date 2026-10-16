-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CinematicCameraConfig = require(ReplicatedStorage:WaitForChild("CinematicCameraConfig"));
local v1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = {};
local u17 = {};
local u18 = nil;
local u19 = {};
local u20 = {};
local u21 = {
    off = nil,
    ["16:9"] = 1.7777777777777777,
    ["2.35:1"] = 2.35,
    ["2.39:1"] = 2.39
};

local function buildThirds(p22) -- Line: 42
    local Frame = Instance.new("Frame");
    Frame.Name = "ThirdsGrid";
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = p22;

    local function line(p23, p24) -- Line: 49
        -- upvalues: Frame (copy)
        local Frame2 = Instance.new("Frame");
        Frame2.Position = p23;
        Frame2.Size = p24;
        Frame2.BackgroundColor3 = Color3.new(1, 1, 1);
        Frame2.BackgroundTransparency = 0.5;
        Frame2.BorderSizePixel = 0;
        Frame2.Parent = Frame;
    end;

    local UDim2_new_ret = UDim2.new(0, 0, 0.3333, 0);
    local UDim2_new_ret2 = UDim2.new(1, 0, 0, 1);
    local Frame2 = Instance.new("Frame");
    Frame2.Position = UDim2_new_ret;
    Frame2.Size = UDim2_new_ret2;
    Frame2.BackgroundColor3 = Color3.new(1, 1, 1);
    Frame2.BackgroundTransparency = 0.5;
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;
    local UDim2_new_ret3 = UDim2.new(0, 0, 0.6667, 0);
    local UDim2_new_ret4 = UDim2.new(1, 0, 0, 1);
    local Frame3 = Instance.new("Frame");
    Frame3.Position = UDim2_new_ret3;
    Frame3.Size = UDim2_new_ret4;
    Frame3.BackgroundColor3 = Color3.new(1, 1, 1);
    Frame3.BackgroundTransparency = 0.5;
    Frame3.BorderSizePixel = 0;
    Frame3.Parent = Frame;
    local UDim2_new_ret5 = UDim2.new(0.3333, 0, 0, 0);
    local UDim2_new_ret6 = UDim2.new(0, 1, 1, 0);
    local Frame4 = Instance.new("Frame");
    Frame4.Position = UDim2_new_ret5;
    Frame4.Size = UDim2_new_ret6;
    Frame4.BackgroundColor3 = Color3.new(1, 1, 1);
    Frame4.BackgroundTransparency = 0.5;
    Frame4.BorderSizePixel = 0;
    Frame4.Parent = Frame;
    local UDim2_new_ret7 = UDim2.new(0.6667, 0, 0, 0);
    local UDim2_new_ret8 = UDim2.new(0, 1, 1, 0);
    local Frame5 = Instance.new("Frame");
    Frame5.Position = UDim2_new_ret7;
    Frame5.Size = UDim2_new_ret8;
    Frame5.BackgroundColor3 = Color3.new(1, 1, 1);
    Frame5.BackgroundTransparency = 0.5;
    Frame5.BorderSizePixel = 0;
    Frame5.Parent = Frame;

    return Frame;
end;

local function buildCenterDot(p25) -- Line: 65
    local Frame = Instance.new("Frame");
    Frame.Name = "CenterDot";
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(0.5, 0.5);
    Frame.Size = UDim2.fromOffset(6, 6);
    Frame.BackgroundColor3 = Color3.new(1, 1, 1);
    Frame.BackgroundTransparency = 0.3;
    Frame.BorderSizePixel = 0;
    Frame.Parent = p25;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = Frame;

    return Frame;
end;

local function buildInfo(p26) -- Line: 81
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "InfoReadout";
    TextLabel.AnchorPoint = Vector2.new(0.5, 1);
    TextLabel.Position = UDim2.new(0.5, 0, 1, -46);
    TextLabel.Size = UDim2.new(0, 720, 0, 40);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Font = Enum.Font.Code;
    TextLabel.TextSize = 13;
    TextLabel.TextColor3 = Color3.fromRGB(255, 200, 90);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center;
    TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom;
    TextLabel.Text = "";
    TextLabel.Parent = p26;

    return TextLabel;
end;

local function buildLetterboxBars(u27) -- Line: 101
    local function bar(p28) -- Line: 102
        -- upvalues: u27 (copy)
        local Frame = Instance.new("Frame");
        Frame.Name = p28;
        Frame.BackgroundColor3 = Color3.new(0, 0, 0);
        Frame.BorderSizePixel = 0;
        Frame.Visible = false;
        Frame.Parent = u27;

        return Frame;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "LetterboxTop";
    Frame.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame.BorderSizePixel = 0;
    Frame.Visible = false;
    Frame.Parent = u27;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "LetterboxBottom";
    Frame2.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame2.BorderSizePixel = 0;
    Frame2.Visible = false;
    Frame2.Parent = u27;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "LetterboxLeft";
    Frame3.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame3.BorderSizePixel = 0;
    Frame3.Visible = false;
    Frame3.Parent = u27;
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "LetterboxRight";
    Frame4.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame4.BorderSizePixel = 0;
    Frame4.Visible = false;
    Frame4.Parent = u27;

    return Frame, Frame2, Frame3, Frame4;
end;

local function buildFocusRect(p29) -- Line: 114
    local Frame = Instance.new("Frame");
    Frame.Name = "FocusRect";
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Size = UDim2.fromOffset(24, 24);
    Frame.BackgroundTransparency = 1;
    Frame.Visible = false;
    Frame.Parent = p29;
    local Color3_fromRGB_ret = Color3.fromRGB(255, 200, 90);

    local function bracket(p30, p31, p32, p33) -- Line: 124
        -- upvalues: Color3_fromRGB_ret (copy), Frame (copy)
        local Frame2 = Instance.new("Frame");
        Frame2.AnchorPoint = Vector2.new(p32, p33);
        Frame2.Position = UDim2.fromScale(p30, p31);
        Frame2.Size = UDim2.fromOffset(8, 2);
        Frame2.BackgroundColor3 = Color3_fromRGB_ret;
        Frame2.BorderSizePixel = 0;
        Frame2.Parent = Frame;
        local Frame3 = Instance.new("Frame");
        Frame3.AnchorPoint = Vector2.new(p32, p33);
        Frame3.Position = UDim2.fromScale(p30, p31);
        Frame3.Size = UDim2.fromOffset(2, 8);
        Frame3.BackgroundColor3 = Color3_fromRGB_ret;
        Frame3.BorderSizePixel = 0;
        Frame3.Parent = Frame;
    end;

    bracket(0, 0, 0, 0);
    bracket(1, 0, 1, 0);
    bracket(0, 1, 0, 1);
    bracket(1, 1, 1, 1);

    return Frame;
end;

local function buildLevel(p34) -- Line: 143
    local Frame = Instance.new("Frame");
    Frame.Name = "LevelIndicator";
    Frame.AnchorPoint = Vector2.new(0.5, 1);
    Frame.Position = UDim2.new(0.5, 0, 1, -20);
    Frame.Size = UDim2.fromOffset(200, 20);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = p34;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Line";
    Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame2.Position = UDim2.fromScale(0.5, 0.5);
    Frame2.Size = UDim2.fromOffset(200, 2);
    Frame2.BackgroundColor3 = Color3.fromRGB(255, 200, 90);
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "Tick";
    Frame3.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame3.Position = UDim2.fromScale(0.5, 0.5);
    Frame3.Size = UDim2.fromOffset(6, 12);
    Frame3.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame3.BorderSizePixel = 0;
    Frame3.Parent = Frame;

    return Frame2, Frame3;
end;

local function makeSlider(p35, p36, p37, u38) -- Line: 178
    local UserInputService = game:GetService("UserInputService");
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.new(1, -12, 0, 40);
    Frame.Position = UDim2.new(0, 6, 0, p37);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = p35;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.new(1, 0, 0, 16);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Font = Enum.Font.Code;
    TextLabel.TextSize = 12;
    TextLabel.TextColor3 = Color3.fromRGB(255, 200, 90);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Text = u38.label;
    TextLabel.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Position = UDim2.new(0, 0, 0, 22);
    Frame2.Size = UDim2.new(1, 0, 0, 8);
    Frame2.BackgroundColor3 = Color3.fromRGB(60, 60, 60);
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;
    local TextButton = Instance.new("TextButton");
    TextButton.AnchorPoint = Vector2.new(0.5, 0.5);
    TextButton.Position = UDim2.new(0, 0, 0.5, 0);
    TextButton.Size = UDim2.fromOffset(12, 16);
    TextButton.BackgroundColor3 = Color3.fromRGB(255, 200, 90);
    TextButton.Text = "";
    TextButton.BorderSizePixel = 0;
    TextButton.AutoButtonColor = false;
    TextButton.Parent = Frame2;

    local function refresh() -- Line: 212
        -- upvalues: u38 (copy), TextButton (copy), TextLabel (copy)
        local Value = u38.getValue();
        local math_clamp_ret = math.clamp((Value - u38.min) / (u38.max - u38.min), 0, 1);
        TextButton.Position = UDim2.new(math_clamp_ret, 0, 0.5, 0);
        TextLabel.Text = string.format("%s  %.2f", u38.label, Value);
    end;

    refresh();
    local u39 = false;
    TextButton.MouseButton1Down:Connect(function() -- Line: 224
        -- upvalues: u39 (ref)
        u39 = true;
    end);
    table.insert(p36, UserInputService.InputEnded:Connect(function(p40) -- Line: 227
        -- upvalues: u39 (ref)
        if p40.UserInputType == Enum.UserInputType.MouseButton1 then
            u39 = false;
        end;
    end));
    table.insert(p36, UserInputService.InputChanged:Connect(function(p41) -- Line: 230
        -- upvalues: u39 (ref), Frame2 (copy), u38 (copy), refresh (copy)
        if not u39 or p41.UserInputType ~= Enum.UserInputType.MouseMovement then
            return;
        end;

        local X = Frame2.AbsoluteSize.X;

        if X <= 0 then
            return;
        end;

        local math_clamp_ret = math.clamp((p41.Position.X - Frame2.AbsolutePosition.X) / X, 0, 1);
        u38.setValue(u38.min + math_clamp_ret * (u38.max - u38.min));
        refresh();
    end));

    return refresh;
end;

local function makeToggle(p42, p43, u44, u45, u46) -- Line: 245
    local TextButton = Instance.new("TextButton");
    TextButton.Size = UDim2.new(1, -12, 0, 22);
    TextButton.Position = UDim2.new(0, 6, 0, p43);
    TextButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
    TextButton.BorderSizePixel = 0;
    TextButton.Font = Enum.Font.Code;
    TextButton.TextSize = 12;
    TextButton.TextColor3 = Color3.fromRGB(255, 200, 90);
    TextButton.Text = "";
    TextButton.Parent = p42;
    TextButton.Text = string.format("[%s] %s", u45() and "X" or " ", u44);
    TextButton.MouseButton1Click:Connect(function() -- Line: 259
        -- upvalues: u46 (copy), u45 (copy), TextButton (copy), u44 (copy)
        u46(not u45());
        TextButton.Text = string.format("[%s] %s", u45() and "X" or " ", u44);
    end);

    return function() -- Line: 255, Name: refresh
        -- upvalues: TextButton (copy), u45 (copy), u44 (copy)
        TextButton.Text = string.format("[%s] %s", u45() and "X" or " ", u44);
    end;
end;

local function makeControlRow(p47, p48, p49, u50) -- Line: 269
    local TextButton = Instance.new("TextButton");
    TextButton.Size = UDim2.new(1, -12, 0, 22);
    TextButton.Position = UDim2.new(0, 6, 0, p49);
    TextButton.BackgroundColor3 = Color3.fromRGB(28, 28, 30);
    TextButton.BorderSizePixel = 0;
    TextButton.Font = Enum.Font.Code;
    TextButton.TextSize = 12;
    TextButton.TextColor3 = Color3.fromRGB(255, 200, 90);
    TextButton.TextXAlignment = Enum.TextXAlignment.Left;
    TextButton.AutoButtonColor = true;
    TextButton.Text = "";
    TextButton.Parent = p47;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingLeft = UDim.new(0, 6);
    UIPadding.Parent = TextButton;

    local function v52() -- Line: 282
        -- upvalues: u50 (copy), TextButton (copy)
        local v51 = u50.getState and u50.getState() or "";

        if v51 and v51 ~= "" then
            TextButton.Text = string.format("[%s] %-15s %s", u50.hotkey, u50.name, v51);

            return;
        end;

        TextButton.Text = string.format("[%s] %s", u50.hotkey, u50.name);
    end;

    v52();
    table.insert(p48, TextButton.MouseButton1Click:Connect(u50.onClick));

    return v52;
end;

local function buildControlPanel(p53, u54) -- Line: 295
    -- upvalues: CinematicCameraConfig (copy), u19 (ref), makeControlRow (copy), u20 (ref)
    local Frame = Instance.new("Frame");
    Frame.Name = "ControlPanel";
    Frame.AnchorPoint = Vector2.new(0, 0);
    Frame.Position = UDim2.new(0, 12, 0, 64);
    Frame.Size = UDim2.fromOffset(260, 392);
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20);
    Frame.BackgroundTransparency = 0.15;
    Frame.BorderSizePixel = 0;
    Frame.Parent = p53;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.new(1, 0, 0, 24);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Font = Enum.Font.Code;
    TextLabel.TextSize = 13;
    TextLabel.TextColor3 = Color3.fromRGB(255, 200, 90);
    TextLabel.Text = "  CONTROLS  (C to hide)";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = Frame;
    local u55 = {
        Raw = "Smoothed",
        Smoothed = "Handheld",
        Handheld = "Raw"
    };
    local u56 = {
        off = "16:9",
        ["16:9"] = "2.35:1",
        ["2.35:1"] = "2.39:1",
        ["2.39:1"] = "off"
    };
    local v57 = 28;

    for _, v in ipairs({
        {
            hotkey = "M",
            name = "MOTION",

            getState = function() -- Line: 321, Name: getState
                -- upvalues: u54 (copy)
                return u54.mode;
            end,

            onClick = function() -- Line: 322, Name: onClick
                -- upvalues: u54 (copy), u55 (copy)
                u54.mode = u55[u54.mode] or "Raw";
            end
        },
        {
            hotkey = "L",
            name = "LETTERBOX",

            getState = function() -- Line: 323, Name: getState
                -- upvalues: u54 (copy)
                return u54.overlays.letterbox;
            end,

            onClick = function() -- Line: 324, Name: onClick
                -- upvalues: u54 (copy), u56 (copy)
                u54.overlays.letterbox = u56[u54.overlays.letterbox] or "off";
            end
        },
        {
            hotkey = "G",
            name = "THIRDS",

            getState = function() -- Line: 325, Name: getState
                -- upvalues: u54 (copy)
                return u54.overlays.thirds and "ON" or "off";
            end,

            onClick = function() -- Line: 326, Name: onClick
                -- upvalues: u54 (copy)
                u54.overlays.thirds = not u54.overlays.thirds;
            end
        },
        {
            hotkey = "H",
            name = "LEVEL",

            getState = function() -- Line: 327, Name: getState
                -- upvalues: u54 (copy)
                return u54.overlays.level and "ON" or "off";
            end,

            onClick = function() -- Line: 328, Name: onClick
                -- upvalues: u54 (copy)
                u54.overlays.level = not u54.overlays.level;
            end
        },
        {
            hotkey = "I",
            name = "INFO",

            getState = function() -- Line: 329, Name: getState
                -- upvalues: u54 (copy)
                return u54.overlays.info and "ON" or "off";
            end,

            onClick = function() -- Line: 330, Name: onClick
                -- upvalues: u54 (copy)
                u54.overlays.info = not u54.overlays.info;
            end
        },
        {
            hotkey = "F",
            name = "FOCUS RECT",

            getState = function() -- Line: 331, Name: getState
                -- upvalues: u54 (copy)
                return u54.overlays.focusRect and "ON" or "off";
            end,

            onClick = function() -- Line: 332, Name: onClick
                -- upvalues: u54 (copy)
                u54.overlays.focusRect = not u54.overlays.focusRect;
            end
        },
        {
            hotkey = "P",
            name = "LIGHTING",

            getState = function() -- Line: 333, Name: getState
                -- upvalues: u54 (copy)
                return u54.overlays.lightingPanel and "ON" or "off";
            end,

            onClick = function() -- Line: 334, Name: onClick
                -- upvalues: u54 (copy)
                u54.overlays.lightingPanel = not u54.overlays.lightingPanel;
            end
        },
        {
            hotkey = "V",
            name = "HIGHLIGHT",

            getState = function() -- Line: 335, Name: getState
                -- upvalues: u54 (copy)
                return u54.overlays.hoverHighlight and "ON" or "off";
            end,

            onClick = function() -- Line: 336, Name: onClick
                -- upvalues: u54 (copy)
                u54.overlays.hoverHighlight = not u54.overlays.hoverHighlight;
            end
        },
        {
            hotkey = "Home",
            name = "RESET",

            getState = function() -- Line: 337, Name: getState
                return "";
            end,

            onClick = function() -- Line: 338, Name: onClick
                -- upvalues: u54 (copy)
                u54.actions.resetRequested = true;
            end
        },
        {
            hotkey = "[/]",
            name = "FOV",

            getState = function() -- Line: 339, Name: getState
                -- upvalues: u54 (copy)
                return tostring(u54.fov);
            end,

            onClick = function() -- Line: 340, Name: onClick
                -- upvalues: u54 (copy), CinematicCameraConfig (ref)
                u54.fov = math.clamp(u54.fov + 5, CinematicCameraConfig.Camera.MinFOV, CinematicCameraConfig.Camera.MaxFOV);
            end
        },
        {
            hotkey = "F10",
            name = "EXIT",

            getState = function() -- Line: 341, Name: getState
                return "";
            end,

            onClick = function() -- Line: 342, Name: onClick
                -- upvalues: u54 (copy)
                u54.__exitRequested = true;
            end
        },
        {
            hotkey = "Tab",
            name = "CURSOR",

            getState = function() -- Line: 343, Name: getState
                -- upvalues: u54 (copy)
                return u54.cursorFree and "FREE" or "locked";
            end,

            onClick = function() -- Line: 344, Name: onClick
                -- upvalues: u54 (copy)
                u54.cursorFree = not u54.cursorFree;
            end
        },
        {
            hotkey = "Bksp",
            name = "HIDE UI",

            getState = function() -- Line: 345, Name: getState
                -- upvalues: u54 (copy)
                return u54.hudHidden and "HIDDEN" or "visible";
            end,

            onClick = function() -- Line: 346, Name: onClick
                -- upvalues: u54 (copy)
                u54.hudHidden = not u54.hudHidden;
            end
        }
    }) do
        local v58 = makeControlRow(Frame, u20, v57, v);
        table.insert(u19, v58);
        v57 = v57 + 26;
    end;

    return Frame;
end;

local function buildLightingPanel(p59, u60) -- Line: 355
    -- upvalues: u16 (ref), makeSlider (copy), u17 (ref), CinematicCameraConfig (copy), makeToggle (copy)
    local Frame = Instance.new("Frame");
    Frame.Name = "LightingPanel";
    Frame.AnchorPoint = Vector2.new(1, 0.5);
    Frame.Position = UDim2.new(1, -10, 0.5, 0);
    Frame.Size = UDim2.fromOffset(220, 788);
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20);
    Frame.BackgroundTransparency = 0.15;
    Frame.BorderSizePixel = 0;
    Frame.Visible = false;
    Frame.Parent = p59;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.new(1, 0, 0, 28);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Font = Enum.Font.Code;
    TextLabel.TextSize = 14;
    TextLabel.TextColor3 = Color3.fromRGB(255, 200, 90);
    TextLabel.Text = "  CAMERA + LIGHTING FX  (P)";
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Parent = Frame;
    local v61 = 32;
    local v63 = makeSlider(Frame, u17, v61, {
        label = "Exposure",
        min = -3,
        max = 3,

        getValue = function() -- Line: 380, Name: getValue
            -- upvalues: u60 (copy)
            return u60.lighting.exposure;
        end,

        setValue = function(p62) -- Line: 381, Name: setValue
            -- upvalues: u60 (copy)
            u60.lighting.exposure = p62;
        end
    });
    table.insert(u16, v63);
    local v64 = v61 + 44;
    local v66 = makeSlider(Frame, u17, v64, {
        label = "FOV",
        min = CinematicCameraConfig.Camera.MinFOV,
        max = CinematicCameraConfig.Camera.MaxFOV,

        getValue = function() -- Line: 386, Name: getValue
            -- upvalues: u60 (copy)
            return u60.fov;
        end,

        setValue = function(p65) -- Line: 387, Name: setValue
            -- upvalues: u60 (copy)
            u60.fov = math.floor(p65 + 0.5);
        end
    });
    table.insert(u16, v66);
    local v67 = v64 + 44;
    local v69 = makeToggle(Frame, v67, "Bloom", function() -- Line: 391
        -- upvalues: u60 (copy)
        return u60.lighting.bloom.on;
    end, function(p68) -- Line: 392
        -- upvalues: u60 (copy)
        u60.lighting.bloom.on = p68;
    end);
    table.insert(u16, v69);
    local v70 = v67 + 24;
    local v72 = makeSlider(Frame, u17, v70, {
        label = "  Intensity",
        min = 0,
        max = 3,

        getValue = function() -- Line: 395, Name: getValue
            -- upvalues: u60 (copy)
            return u60.lighting.bloom.intensity;
        end,

        setValue = function(p71) -- Line: 396, Name: setValue
            -- upvalues: u60 (copy)
            u60.lighting.bloom.intensity = p71;
        end
    });
    table.insert(u16, v72);
    local v73 = v70 + 44;
    local v75 = makeSlider(Frame, u17, v73, {
        label = "  Threshold",
        min = 0,
        max = 4,

        getValue = function() -- Line: 400, Name: getValue
            -- upvalues: u60 (copy)
            return u60.lighting.bloom.threshold;
        end,

        setValue = function(p74) -- Line: 401, Name: setValue
            -- upvalues: u60 (copy)
            u60.lighting.bloom.threshold = p74;
        end
    });
    table.insert(u16, v75);
    local v76 = v73 + 44;
    local v78 = makeSlider(Frame, u17, v76, {
        label = "  Size",
        min = 0,
        max = 56,

        getValue = function() -- Line: 405, Name: getValue
            -- upvalues: u60 (copy)
            return u60.lighting.bloom.size;
        end,

        setValue = function(p77) -- Line: 406, Name: setValue
            -- upvalues: u60 (copy)
            u60.lighting.bloom.size = p77;
        end
    });
    table.insert(u16, v78);
    local v79 = v76 + 44;
    local v81 = makeToggle(Frame, v79, "Color Correction", function() -- Line: 410
        -- upvalues: u60 (copy)
        return u60.lighting.colorCorrection.on;
    end, function(p80) -- Line: 411
        -- upvalues: u60 (copy)
        u60.lighting.colorCorrection.on = p80;
    end);
    table.insert(u16, v81);
    local v82 = v79 + 24;
    local v84 = makeSlider(Frame, u17, v82, {
        label = "  Brightness",
        min = -1,
        max = 1,

        getValue = function() -- Line: 414, Name: getValue
            -- upvalues: u60 (copy)
            return u60.lighting.colorCorrection.brightness;
        end,

        setValue = function(p83) -- Line: 415, Name: setValue
            -- upvalues: u60 (copy)
            u60.lighting.colorCorrection.brightness = p83;
        end
    });
    table.insert(u16, v84);
    local v85 = v82 + 44;
    local v87 = makeSlider(Frame, u17, v85, {
        label = "  Contrast",
        min = -1,
        max = 1,

        getValue = function() -- Line: 419, Name: getValue
            -- upvalues: u60 (copy)
            return u60.lighting.colorCorrection.contrast;
        end,

        setValue = function(p86) -- Line: 420, Name: setValue
            -- upvalues: u60 (copy)
            u60.lighting.colorCorrection.contrast = p86;
        end
    });
    table.insert(u16, v87);
    local v88 = v85 + 44;
    local v90 = makeSlider(Frame, u17, v88, {
        label = "  Saturation",
        min = -1,
        max = 1,

        getValue = function() -- Line: 424, Name: getValue
            -- upvalues: u60 (copy)
            return u60.lighting.colorCorrection.saturation;
        end,

        setValue = function(p89) -- Line: 425, Name: setValue
            -- upvalues: u60 (copy)
            u60.lighting.colorCorrection.saturation = p89;
        end
    });
    table.insert(u16, v90);
    local v91 = v88 + 44;
    local v93 = makeToggle(Frame, v91, "DOF", function() -- Line: 429
        -- upvalues: u60 (copy)
        return u60.lighting.dof.on;
    end, function(p92) -- Line: 430
        -- upvalues: u60 (copy)
        u60.lighting.dof.on = p92;
    end);
    table.insert(u16, v93);
    local v94 = v91 + 24;
    local v96 = makeSlider(Frame, u17, v94, {
        label = "  Focus Dist",
        min = 1,
        max = 100,

        getValue = function() -- Line: 433, Name: getValue
            -- upvalues: u60 (copy)
            return u60.lighting.dof.focusDistance;
        end,

        setValue = function(p95) -- Line: 434, Name: setValue
            -- upvalues: u60 (copy)
            u60.lighting.dof.focusDistance = p95;
        end
    });
    table.insert(u16, v96);
    local v97 = v94 + 44;
    local v99 = makeSlider(Frame, u17, v97, {
        label = "  Far",
        min = 0,
        max = 1,

        getValue = function() -- Line: 438, Name: getValue
            -- upvalues: u60 (copy)
            return u60.lighting.dof.farIntensity;
        end,

        setValue = function(p98) -- Line: 439, Name: setValue
            -- upvalues: u60 (copy)
            u60.lighting.dof.farIntensity = p98;
        end
    });
    table.insert(u16, v99);
    local v100 = v97 + 44;
    local v102 = makeSlider(Frame, u17, v100, {
        label = "  Near",
        min = 0,
        max = 1,

        getValue = function() -- Line: 443, Name: getValue
            -- upvalues: u60 (copy)
            return u60.lighting.dof.nearIntensity;
        end,

        setValue = function(p101) -- Line: 444, Name: setValue
            -- upvalues: u60 (copy)
            u60.lighting.dof.nearIntensity = p101;
        end
    });
    table.insert(u16, v102);
    local v103 = v100 + 44;
    local v105 = makeSlider(Frame, u17, v103, {
        label = "  Radius",
        min = 0,
        max = 50,

        getValue = function() -- Line: 448, Name: getValue
            -- upvalues: u60 (copy)
            return u60.lighting.dof.inFocusRadius;
        end,

        setValue = function(p104) -- Line: 449, Name: setValue
            -- upvalues: u60 (copy)
            u60.lighting.dof.inFocusRadius = p104;
        end
    });
    table.insert(u16, v105);
    local v106 = v103 + 44;
    local v108 = makeToggle(Frame, v106, "Blur", function() -- Line: 453
        -- upvalues: u60 (copy)
        return u60.lighting.blur.on;
    end, function(p107) -- Line: 454
        -- upvalues: u60 (copy)
        u60.lighting.blur.on = p107;
    end);
    table.insert(u16, v108);
    local v109 = v106 + 24;
    local v111 = makeSlider(Frame, u17, v109, {
        label = "  Size",
        min = 0,
        max = 56,

        getValue = function() -- Line: 457, Name: getValue
            -- upvalues: u60 (copy)
            return u60.lighting.blur.size;
        end,

        setValue = function(p110) -- Line: 458, Name: setValue
            -- upvalues: u60 (copy)
            u60.lighting.blur.size = p110;
        end
    });
    table.insert(u16, v111);
    local v113 = makeSlider(Frame, u17, v109 + 44, {
        label = "Look Sens",
        min = 0.25,
        max = 4,

        getValue = function() -- Line: 463, Name: getValue
            -- upvalues: u60 (copy)
            return u60.mouseSensitivityMult;
        end,

        setValue = function(p112) -- Line: 464, Name: setValue
            -- upvalues: u60 (copy)
            u60.mouseSensitivityMult = p112;
        end
    });
    table.insert(u16, v113);

    return Frame;
end;

local function reflowLetterbox(p114) -- Line: 470
    -- upvalues: u6 (ref), u21 (copy), u7 (ref), u8 (ref), u9 (ref)
    if not u6 then
        return;
    end;

    local v115 = u21[p114.overlays.letterbox];
    local ViewportSize = workspace.CurrentCamera.ViewportSize;

    if not (v115 and (ViewportSize.Y > 0 and ViewportSize.X > 0)) then
        u6.Visible = false;
        u7.Visible = false;
        u8.Visible = false;
        u9.Visible = false;

        return;
    end;

    if ViewportSize.X / ViewportSize.Y < v115 then
        local v116 = (ViewportSize.Y - ViewportSize.X / v115) / 2;
        u6.Position = UDim2.new(0, 0, 0, 0);
        u6.Size = UDim2.new(1, 0, 0, (math.max(0, v116)));
        u7.Position = UDim2.new(0, 0, 1, -math.max(0, v116));
        u7.Size = UDim2.new(1, 0, 0, (math.max(0, v116)));
        u6.Visible = true;
        u7.Visible = true;
        u8.Visible = false;
        u9.Visible = false;

        return;
    end;

    local v117 = (ViewportSize.X - ViewportSize.Y * v115) / 2;
    u8.Position = UDim2.new(0, 0, 0, 0);
    u8.Size = UDim2.new(0, math.max(0, v117), 1, 0);
    u9.Position = UDim2.new(1, -math.max(0, v117), 0, 0);
    u9.Size = UDim2.new(0, math.max(0, v117), 1, 0);
    u6.Visible = false;
    u7.Visible = false;
    u8.Visible = true;
    u9.Visible = true;
end;

function v1.Enter(p118, u119) -- Line: 499
    -- upvalues: Players (copy), u2 (ref), u3 (ref), buildThirds (copy), u4 (ref), buildCenterDot (copy), u5 (ref), buildInfo (copy), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), buildFocusRect (copy), u11 (ref), u12 (ref), buildLevel (copy), u13 (ref), reflowLetterbox (copy), u16 (ref), u17 (ref), u15 (ref), buildLightingPanel (copy), u19 (ref), u20 (ref), u18 (ref), buildControlPanel (copy)
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui", 5);

    if not PlayerGui then
        warn("[OverlayRenderer] no PlayerGui, skipping HUD");

        return;
    end;

    u2 = Instance.new("ScreenGui");
    u2.Name = "CinematicHUD";
    u2.IgnoreGuiInset = true;
    u2.DisplayOrder = 1000;
    u2.ResetOnSpawn = false;
    u2.Parent = PlayerGui;
    u3 = buildThirds(u2);
    u4 = buildCenterDot(u2);
    u5 = buildInfo(u2);
    local u120 = u2;

    local function _(p121) -- Line: 102
        -- upvalues: u120 (copy)
        local Frame = Instance.new("Frame");
        Frame.Name = p121;
        Frame.BackgroundColor3 = Color3.new(0, 0, 0);
        Frame.BorderSizePixel = 0;
        Frame.Visible = false;
        Frame.Parent = u120;

        return Frame;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "LetterboxTop";
    Frame.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame.BorderSizePixel = 0;
    Frame.Visible = false;
    Frame.Parent = u120;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "LetterboxBottom";
    Frame2.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame2.BorderSizePixel = 0;
    Frame2.Visible = false;
    Frame2.Parent = u120;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "LetterboxLeft";
    Frame3.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame3.BorderSizePixel = 0;
    Frame3.Visible = false;
    Frame3.Parent = u120;
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "LetterboxRight";
    Frame4.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame4.BorderSizePixel = 0;
    Frame4.Visible = false;
    Frame4.Parent = u120;
    u6 = Frame;
    u7 = Frame2;
    u8 = Frame3;
    u9 = Frame4;
    u10 = buildFocusRect(u2);
    local v122, v123 = buildLevel(u2);
    u11 = v122;
    u12 = v123;
    u13 = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 518
        -- upvalues: reflowLetterbox (ref), u119 (copy)
        reflowLetterbox(u119);
    end);
    reflowLetterbox(u119);
    u16 = {};
    u17 = {};
    u15 = buildLightingPanel(u2, u119);
    u19 = {};
    u20 = {};
    u18 = buildControlPanel(u2, u119);
end;

function v1.Tick(p124, p125, p126) -- Line: 534
    -- upvalues: u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u15 (ref), u18 (ref), CinematicCameraConfig (copy), u14 (ref), reflowLetterbox (copy), u12 (ref), u16 (ref), u19 (ref)
    if not u2 then
        return;
    end;

    if not p125.hudHidden then
        u3.Visible = p125.overlays.thirds;
        u4.Visible = p125.overlays.centerDot;

        if p125.overlays.info then
            u5.Visible = true;
            local Position = p125.cameraCFrame.Position;
            local v127 = p125.focus.locked and (string.format("FOCAL %.1f stud%s   TARGET %s", p125.focus.distance + p125.focus.distanceOffset, p125.focus.distanceOffset == 0 and "" or (string.format(" (%+.1f)", p125.focus.distanceOffset) or ""), p125.focus.target and (p125.focus.target.Name or "?") or "?") or "FOCAL --   TARGET none") or "FOCAL --   TARGET none";
            u5.Text = string.format("POS (%.1f, %.1f, %.1f)   FOV %d   MODE %s   %s%s\nCinematicCamera v%s", Position.X, Position.Y, Position.Z, p125.fov, p125.mode, v127, p125.lockTarget and p125.lockTarget.Parent and ("   LOCK " .. p125.lockTarget.Name or "") or "", CinematicCameraConfig.Version);
        else
            u5.Visible = false;
        end;

        if u14 ~= p125.overlays.letterbox then
            u14 = p125.overlays.letterbox;
            reflowLetterbox(p125);
        end;

        if p125.overlays.focusRect and (p125.focus.locked and p125.focus.target) then
            local v128, v129 = workspace.CurrentCamera:WorldToViewportPoint(p125.focus.target.Position);

            if v129 and v128.Z > 0 then
                u10.Visible = true;
                u10.Position = UDim2.fromOffset(v128.X, v128.Y);
            else
                u10.Visible = false;
            end;
        else
            u10.Visible = false;
        end;

        if p125.overlays.level then
            u11.Parent.Visible = true;
            local Y = p125.cameraCFrame.RightVector.Y;
            local v130 = math.clamp(Y, -1, 1) * 90;
            u12.Position = UDim2.new(0.5, v130, 0.5, 0);
            u11.BackgroundColor3 = math.abs(Y) > 0.17364817766693033 and Color3.fromRGB(230, 80, 80) or Color3.fromRGB(255, 200, 90);
        else
            u11.Parent.Visible = false;
        end;

        if u15 then
            u15.Visible = p125.overlays.lightingPanel;

            if u15.Visible then
                for _, v in ipairs(u16) do
                    v();
                end;
            end;
        end;

        if u18 then
            u18.Visible = p125.overlays.controlPanel;

            if u18.Visible then
                for _, v in ipairs(u19) do
                    v();
                end;
            end;
        end;

        return;
    end;

    u3.Visible = false;
    u4.Visible = false;
    u5.Visible = false;
    u6.Visible = false;
    u7.Visible = false;
    u8.Visible = false;
    u9.Visible = false;
    u10.Visible = false;

    if u11 and u11.Parent then
        u11.Parent.Visible = false;
    end;

    if u15 then
        u15.Visible = false;
    end;

    if u18 then
        u18.Visible = false;
    end;
end;

function v1.Exit(p131) -- Line: 627
    -- upvalues: u13 (ref), u17 (ref), u15 (ref), u16 (ref), u20 (ref), u18 (ref), u19 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u14 (ref)
    if u13 then
        u13:Disconnect();
        u13 = nil;
    end;

    for _, v in ipairs(u17) do
        v:Disconnect();
    end;

    u17 = {};
    u15 = nil;
    u16 = {};

    for _, v in ipairs(u20) do
        v:Disconnect();
    end;

    u20 = {};
    u18 = nil;
    u19 = {};

    if u2 then
        u2:Destroy();
        u2 = nil;
    end;

    u3 = nil;
    u4 = nil;
    u5 = nil;
    u6 = nil;
    u7 = nil;
    u8 = nil;
    u9 = nil;
    u10 = nil;
    u11 = nil;
    u12 = nil;
    u14 = nil;
end;

return v1;