-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Workspace = game:GetService("Workspace");
local LocalPlayer = Players.LocalPlayer;
local SquadMarkerResolver = require(ReplicatedStorage:WaitForChild("SquadMarkerResolver"));
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "SquadWorldMarkers";
ScreenGui.ResetOnSpawn = false;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.DisplayOrder = 6;
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");

local function stroked(p1) -- Line: 51
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(0, 0, 0);
    UIStroke.Thickness = 2;
    UIStroke.Transparency = 0.25;
    UIStroke.Parent = p1;

    return UIStroke;
end;

local u2 = {};

for i = 1, 4 do
    local Frame = Instance.new("Frame");
    Frame.Name = "SquadMarker" .. i;
    Frame.Size = UDim2.fromOffset(64, 64);
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.BackgroundTransparency = 1;
    Frame.Visible = false;
    Frame.Parent = ScreenGui;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Glyph";
    TextLabel.Size = UDim2.fromOffset(30, 30);
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = UDim2.fromScale(0.5, 0.4);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "◆";
    TextLabel.TextScaled = true;
    TextLabel.FontFace = Font_new_ret;
    TextLabel.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Name = "Distance";
    TextLabel2.Size = UDim2.fromOffset(72, 18);
    TextLabel2.AnchorPoint = Vector2.new(0.5, 0);
    TextLabel2.Position = UDim2.fromScale(0.5, 0.62);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Text = "";
    TextLabel2.TextColor3 = Color3.fromRGB(235, 235, 235);
    TextLabel2.TextSize = 15;
    TextLabel2.FontFace = Font_new_ret;
    TextLabel2.Parent = Frame;
    local v3 = {
        root = Frame,
        glyph = TextLabel
    };
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(0, 0, 0);
    UIStroke.Thickness = 2;
    UIStroke.Transparency = 0.25;
    UIStroke.Parent = TextLabel;
    v3.glyphStroke = UIStroke;
    v3.dist = TextLabel2;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = Color3.fromRGB(0, 0, 0);
    UIStroke2.Thickness = 2;
    UIStroke2.Transparency = 0.25;
    UIStroke2.Parent = TextLabel2;
    v3.distStroke = UIStroke2;
    u2[i] = v3;
    local _ = i;
end;

local u4 = {};
local u5 = 0;
local u6 = 0;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.IgnoreWater = true;

local function updateOcclusion(p7, p8) -- Line: 108
    -- upvalues: u6 (ref), u5 (ref), LocalPlayer (copy), RaycastParams_new_ret (copy), u4 (copy), Workspace (copy)
    local os_clock_ret = os.clock();

    if #p8 == 0 or os_clock_ret - u6 < 0.1 then
        return;
    end;

    u6 = os_clock_ret;
    u5 = u5 % #p8 + 1;
    local v9 = p8[u5];
    local Character = LocalPlayer.Character;
    RaycastParams_new_ret.FilterDescendantsInstances = Character and { Character } or {};
    local v10 = v9.pos - p7;
    local Magnitude = v10.Magnitude;

    if Magnitude < 1 then
        u4[v9.owner] = false;

        return;
    end;

    u4[v9.owner] = Workspace:Raycast(p7, v10.Unit * (Magnitude - 4), RaycastParams_new_ret) ~= nil;
end;

local function hideFrom(p11) -- Line: 131
    -- upvalues: u2 (copy)
    for i = p11, 4 do
        local v12;

        if u2[i].root.Visible then
            u2[i].root.Visible = false;
            v12 = i;
        else
            v12 = i;
        end;
    end;
end;

RunService.RenderStepped:Connect(function() -- Line: 137
    -- upvalues: Workspace (copy), SquadMarkerResolver (copy), hideFrom (copy), LocalPlayer (copy), updateOcclusion (copy), u2 (copy), u4 (copy)
    local CurrentCamera = Workspace.CurrentCamera;
    local v13 = SquadMarkerResolver.Resolve();

    if not CurrentCamera or #v13 == 0 then
        hideFrom(1);

        return;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    local v14 = Character and Character.Position or CurrentCamera.CFrame.Position;
    updateOcclusion(CurrentCamera.CFrame.Position, v13);
    local ViewportSize = CurrentCamera.ViewportSize;
    local Vector2_new_ret = Vector2.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.5);
    local v15 = 0;

    for _, v in ipairs(v13) do
        if v15 >= 4 then
            break;
        end;

        local Magnitude = (v.pos - v14).Magnitude;
        local math_clamp_ret = math.clamp((Magnitude - 4) / 8, 0, 1);

        if math_clamp_ret > 0 then
            v15 = v15 + 1;
            local v16 = u2[v15];
            local v17 = math_clamp_ret * (u4[v.owner] and 0.5 or 1);
            local v18, v19 = CurrentCamera:WorldToViewportPoint(v.pos);
            local v20, v21, v22, v23;

            if v19 and v18.Z > 0 then
                v20 = v18.X;
                v21 = v18.Y;
                v22 = 0;
                v23 = false;
            else
                local v24 = Vector2.new(v18.X, v18.Y) - Vector2_new_ret;

                if v18.Z < 0 then
                    v24 = -v24;
                end;

                if v24.Magnitude < 0.001 then
                    v24 = Vector2.new(0, -1);
                end;

                local Unit = v24.Unit;
                local math_max_ret = math.max(1, Vector2_new_ret.X - 60);
                local math_max_ret2 = math.max(1, Vector2_new_ret.Y - 60);
                local v25 = math.abs(Unit.X) > 0.00001 and (math_max_ret / math.abs(Unit.X) or (1 / 0)) or (1 / 0);
                local v26 = math.abs(Unit.Y) > 0.00001 and (math_max_ret2 / math.abs(Unit.Y) or (1 / 0)) or (1 / 0);
                local v27 = Vector2_new_ret + Unit * math.min(v25, v26);
                v20 = v27.X;
                v21 = v27.Y;
                local math_atan2_ret = math.atan2(Unit.X, -Unit.Y);
                v22 = math.deg(math_atan2_ret);
                v23 = true;
            end;

            v16.root.Position = UDim2.fromOffset(v20, v21);
            local v28 = v23 and "▲" or "◆";

            if v16.glyph.Text ~= v28 then
                v16.glyph.Text = v28;
            end;

            if v16.glyph.Rotation ~= v22 then
                v16.glyph.Rotation = v22;
            end;

            if v16.glyph.TextColor3 ~= v.color then
                v16.glyph.TextColor3 = v.color;
            end;

            local math_floor_ret = math.floor(30 * (1 + 0.6 * v.pulse) + 0.5);

            if v16.glyph.Size.X.Offset ~= math_floor_ret then
                v16.glyph.Size = UDim2.fromOffset(math_floor_ret, math_floor_ret);
            end;

            local v29 = 1 - v17;

            if v16.glyph.TextTransparency ~= v29 then
                v16.glyph.TextTransparency = v29;
                v16.dist.TextTransparency = v29;
                local math_min_ret = math.min(1, 0.25 + (1 - v17) * 0.75);
                v16.glyphStroke.Transparency = math_min_ret;
                v16.distStroke.Transparency = math_min_ret;
            end;

            local string_format_ret = string.format("%dm", (math.floor(Magnitude + 0.5)));

            if v16.dist.Text ~= string_format_ret then
                v16.dist.Text = string_format_ret;
            end;

            if not v16.root.Visible then
                v16.root.Visible = true;
            end;
        end;
    end;

    for i = v15 + 1, 4 do
        local v30;

        if u2[i].root.Visible then
            u2[i].root.Visible = false;
            v30 = i;
        else
            v30 = i;
        end;
    end;
end);