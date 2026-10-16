-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Workspace = game:GetService("Workspace");
local LocalPlayer = Players.LocalPlayer;
local TaskTargetResolver = require(ReplicatedStorage:WaitForChild("TaskTargetResolver"));
local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"));
local PdaMapData = require(ReplicatedStorage:WaitForChild("PdaMapData"));
pcall(function() -- Line: 37
    -- upvalues: TaskController (copy)
    TaskController:Init();
end);
local COLOR_KILL = TaskTargetResolver.COLOR_KILL;
local COLOR_TURN_IN = TaskTargetResolver.COLOR_TURN_IN;
local COLOR_EXPLORE = TaskTargetResolver.COLOR_EXPLORE;
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);

local function colorForKind(p1) -- Line: 54
    -- upvalues: COLOR_TURN_IN (copy), COLOR_EXPLORE (copy), COLOR_KILL (copy)
    if p1 == "turnin" then
        return COLOR_TURN_IN;
    end;

    if p1 == "explore" or p1 == "deposit" then
        return COLOR_EXPLORE;
    end;

    return COLOR_KILL;
end;

local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "ObjectiveMarker";
ScreenGui.ResetOnSpawn = false;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.DisplayOrder = 6;
ScreenGui.Enabled = false;
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
local Frame = Instance.new("Frame");
Frame.Name = "Marker";
Frame.Size = UDim2.fromOffset(64, 64);
Frame.AnchorPoint = Vector2.new(0.5, 0.5);
Frame.BackgroundTransparency = 1;
Frame.Parent = ScreenGui;
local TextLabel = Instance.new("TextLabel");
TextLabel.Name = "Glyph";
TextLabel.Size = UDim2.fromOffset(30, 30);
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
TextLabel.Position = UDim2.fromScale(0.5, 0.4);
TextLabel.BackgroundTransparency = 1;
TextLabel.Text = "◆";
TextLabel.TextColor3 = COLOR_TURN_IN;
TextLabel.TextScaled = true;
TextLabel.FontFace = Font_new_ret;
TextLabel.Parent = Frame;
local UIStroke = Instance.new("UIStroke");
UIStroke.Color = Color3.fromRGB(0, 0, 0);
UIStroke.Thickness = 2;
UIStroke.Transparency = 0.25;
UIStroke.Parent = TextLabel;
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
local UIStroke2 = Instance.new("UIStroke");
UIStroke2.Color = Color3.fromRGB(0, 0, 0);
UIStroke2.Thickness = 2;
UIStroke2.Transparency = 0.25;
UIStroke2.Parent = TextLabel2;

local function crowPosition() -- Line: 121
    -- upvalues: LocalPlayer (copy), PdaMapData (copy)
    local v2 = LocalPlayer:GetAttribute("Zone") or PdaMapData.CurrentZone();
    local Region = PdaMapData.GetRegion(v2);

    if not (Region and Region.Traders) then
        return nil;
    end;

    for _, v in ipairs(Region.Traders) do
        if v.Id == "Crow" then
            return v.WorldPos;
        end;
    end;

    return nil;
end;

local function isPhase1() -- Line: 131
    -- upvalues: LocalPlayer (copy)
    local v3;

    if LocalPlayer:GetAttribute("_TutorialPending") == true then
        v3 = LocalPlayer:GetAttribute("_StarterPackGranted") ~= true;
    else
        v3 = false;
    end;

    return v3;
end;

local function guidedTask() -- Line: 138
    -- upvalues: TaskController (copy)
    local ActiveTasks = TaskController:GetActiveTasks();

    if ActiveTasks then
        for _, v in ipairs(ActiveTasks) do
            if v and (v.params and v.params.isTutorial) then
                return v;
            end;
        end;
    end;

    return TaskController:GetPinnedTask();
end;

local function resolveTarget(p4) -- Line: 149
    -- upvalues: LocalPlayer (copy), crowPosition (copy), COLOR_TURN_IN (copy), guidedTask (copy), TaskTargetResolver (copy), COLOR_EXPLORE (copy), COLOR_KILL (copy)
    local v5;

    if LocalPlayer:GetAttribute("_TutorialPending") == true then
        v5 = LocalPlayer:GetAttribute("_StarterPackGranted") ~= true;
    else
        v5 = false;
    end;

    local v6 = v5 and crowPosition();

    if v6 then
        return v6, COLOR_TURN_IN;
    end;

    local v7 = guidedTask();

    if not v7 then
        return nil;
    end;

    local v8 = TaskTargetResolver.Resolve(v7);

    if not v8 or #v8 == 0 then
        return nil;
    end;

    local v9 = nil;
    local v10 = nil;

    for _, v in ipairs(v8) do
        if v.pos then
            local Magnitude = (v.pos - p4).Magnitude;

            if not v9 or Magnitude < v9 then
                v10 = v;
                v9 = Magnitude;
            end;
        end;
    end;

    if not v10 then
        return nil;
    end;

    local pos = v10.pos;
    local kind = v10.kind;

    if kind == "turnin" then
        return pos, COLOR_TURN_IN;
    end;

    if kind == "explore" or kind == "deposit" then
        return pos, COLOR_EXPLORE;
    end;

    return pos, COLOR_KILL;
end;

local u11 = false;
local u12 = 0;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.IgnoreWater = true;

local function updateOcclusion(p13, p14) -- Line: 186
    -- upvalues: u12 (ref), LocalPlayer (copy), RaycastParams_new_ret (copy), u11 (ref), Workspace (copy)
    local os_clock_ret = os.clock();

    if os_clock_ret - u12 < 0.1 then
        return;
    end;

    u12 = os_clock_ret;
    local Character = LocalPlayer.Character;
    RaycastParams_new_ret.FilterDescendantsInstances = Character and { Character } or {};
    local v15 = p14 - p13;
    local Magnitude = v15.Magnitude;

    if Magnitude < 1 then
        u11 = false;

        return;
    end;

    u11 = Workspace:Raycast(p13, v15.Unit * (Magnitude - 4), RaycastParams_new_ret) ~= nil;
end;

RunService.RenderStepped:Connect(function() -- Line: 208
    -- upvalues: Workspace (copy), ScreenGui (copy), LocalPlayer (copy), resolveTarget (copy), updateOcclusion (copy), u11 (ref), Frame (copy), TextLabel (copy), TextLabel2 (copy), UIStroke (copy), UIStroke2 (copy)
    local CurrentCamera = Workspace.CurrentCamera;

    if not CurrentCamera then
        if ScreenGui.Enabled then
            ScreenGui.Enabled = false;
        end;

        return;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    local v16 = Character and Character.Position or CurrentCamera.CFrame.Position;
    local v17, v18 = resolveTarget(v16);

    if not v17 then
        if ScreenGui.Enabled then
            ScreenGui.Enabled = false;
        end;

        return;
    end;

    local Magnitude = (v17 - v16).Magnitude;
    local math_clamp_ret = math.clamp((Magnitude - 4) / 8, 0, 1);

    if math_clamp_ret <= 0 then
        if ScreenGui.Enabled then
            ScreenGui.Enabled = false;
        end;

        return;
    end;

    updateOcclusion(CurrentCamera.CFrame.Position, v17);
    local v19 = math_clamp_ret * (u11 and 0.5 or 1);
    local ViewportSize = CurrentCamera.ViewportSize;
    local Vector2_new_ret = Vector2.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.5);
    local v20, v21 = CurrentCamera:WorldToViewportPoint(v17);
    local v22, v23, v24, v25;

    if v21 and v20.Z > 0 then
        v22 = v20.X;
        v23 = v20.Y;
        v24 = false;
        v25 = 0;
    else
        local v26 = Vector2.new(v20.X, v20.Y) - Vector2_new_ret;

        if v20.Z < 0 then
            v26 = -v26;
        end;

        if v26.Magnitude < 0.001 then
            v26 = Vector2.new(0, -1);
        end;

        local Unit = v26.Unit;
        local math_max_ret = math.max(1, Vector2_new_ret.X - 60);
        local math_max_ret2 = math.max(1, Vector2_new_ret.Y - 60);
        local v27 = math.abs(Unit.X) > 0.00001 and (math_max_ret / math.abs(Unit.X) or (1 / 0)) or (1 / 0);
        local v28 = math.abs(Unit.Y) > 0.00001 and (math_max_ret2 / math.abs(Unit.Y) or (1 / 0)) or (1 / 0);
        local v29 = Vector2_new_ret + Unit * math.min(v27, v28);
        v22 = v29.X;
        v23 = v29.Y;
        local math_atan2_ret = math.atan2(Unit.X, -Unit.Y);
        v25 = math.deg(math_atan2_ret);
        v24 = true;
    end;

    Frame.Position = UDim2.fromOffset(v22, v23);
    local v30 = v24 and "▲" or "◆";

    if TextLabel.Text ~= v30 then
        TextLabel.Text = v30;
    end;

    if TextLabel.Rotation ~= v25 then
        TextLabel.Rotation = v25;
    end;

    if TextLabel.TextColor3 ~= v18 then
        TextLabel.TextColor3 = v18;
    end;

    local v31 = 1 - v19;

    if TextLabel.TextTransparency ~= v31 then
        TextLabel.TextTransparency = v31;
        TextLabel2.TextTransparency = v31;
        local math_min_ret = math.min(1, 0.25 + (1 - v19) * 0.75);
        UIStroke.Transparency = math_min_ret;
        UIStroke2.Transparency = math_min_ret;
    end;

    local string_format_ret = string.format("%dm", (math.floor(Magnitude + 0.5)));

    if TextLabel2.Text ~= string_format_ret then
        TextLabel2.Text = string_format_ret;
    end;

    if not ScreenGui.Enabled then
        ScreenGui.Enabled = true;
    end;
end);
print("[ObjectiveMarker] initialized");