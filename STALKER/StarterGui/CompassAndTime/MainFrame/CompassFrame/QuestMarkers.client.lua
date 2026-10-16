-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Workspace = game:GetService("Workspace");
local script_Parent = script.Parent;
local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"));
local SquadController = require(ReplicatedStorage:WaitForChild("SquadController"));
local TaskTargetResolver = require(ReplicatedStorage:WaitForChild("TaskTargetResolver"));
local SquadMapResolver = require(ReplicatedStorage:WaitForChild("SquadMapResolver"));
local PdaMapData = require(ReplicatedStorage:WaitForChild("PdaMapData"));
TaskController:Init();
SquadController:Init();
local Color3_fromRGB_ret = Color3.fromRGB(220, 50, 50);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 205, 60);
local Color3_fromRGB_ret3 = Color3.fromRGB(255, 150, 50);
local Color3_fromRGB_ret4 = Color3.fromRGB(220, 50, 50);
local u1 = {};

for i = 1, 32 do
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "QuestMarker" .. i;
    TextLabel.Size = UDim2.fromOffset(22, 18);
    TextLabel.AnchorPoint = Vector2.new(0.5, 1);
    TextLabel.Position = UDim2.new(0.5, 0, 0, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "▼";
    TextLabel.TextColor3 = Color3_fromRGB_ret;
    TextLabel.TextScaled = true;
    TextLabel.Font = Enum.Font.GothamBold;
    TextLabel.ZIndex = 10;
    TextLabel.Visible = false;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "Stroke";
    UIStroke.Color = Color3.fromRGB(0, 0, 0);
    UIStroke.Thickness = 1;
    UIStroke.Transparency = 0.25;
    UIStroke.Parent = TextLabel;
    TextLabel.Parent = script_Parent;
    u1[i] = TextLabel;
    local _ = i;
end;

local function getAlwaysOnTargets() -- Line: 62
    -- upvalues: Players (copy), Workspace (copy), SquadMapResolver (copy), PdaMapData (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy)
    local u2 = {};

    local function add(p3, p4, p5) -- Line: 64
        -- upvalues: u2 (copy)
        if p3 then
            u2[#u2 + 1] = {
                pos = p3,
                color = p4,
                transparency = p5 or 0
            };
        end;
    end;

    local _ = Players.LocalPlayer;
    local v6 = Workspace.CurrentCamera and Workspace.CurrentCamera.CFrame.Position or Vector3.new();

    for _, v in ipairs(SquadMapResolver.Resolve()) do
        local pos = v.pos;
        local COLOR_SQUAD = SquadMapResolver.COLOR_SQUAD;

        if pos then
            u2[#u2 + 1] = {
                transparency = 0,
                pos = pos,
                color = COLOR_SQUAD
            };
        end;
    end;

    if Players.LocalPlayer:GetAttribute("_TutorialPending") then
        local Region = PdaMapData.GetRegion(Players.LocalPlayer:GetAttribute("Zone") or "Cordon");

        if Region and Region.Traders then
            for _, v in ipairs(Region.Traders) do
                if v.Id == "Crow" then
                    local WorldPos = v.WorldPos;
                    local v7 = Color3_fromRGB_ret2;

                    if WorldPos then
                        u2[#u2 + 1] = {
                            transparency = 0,
                            pos = WorldPos,
                            color = v7
                        };
                    end;
                end;
            end;
        end;
    end;

    local PlayerCharacters = Workspace:FindFirstChild("PlayerCharacters");

    if PlayerCharacters then
        PlayerCharacters = PlayerCharacters:FindFirstChild("HostileNPCs");
    end;

    if PlayerCharacters then
        for _, child in ipairs(PlayerCharacters:GetChildren()) do
            if child:IsA("Model") then
                local v8 = child:FindFirstChildOfClass("Humanoid");
                local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");

                if v8 and (v8.Health > 0 and HumanoidRootPart) then
                    local Magnitude = (HumanoidRootPart.Position - v6).Magnitude;
                    local Attribute = child:GetAttribute("Faction");

                    if Attribute == "Loner" then
                        if Magnitude <= 250 then
                            local Position = HumanoidRootPart.Position;
                            local v9 = Color3_fromRGB_ret3;

                            if Position then
                                u2[#u2 + 1] = {
                                    transparency = 0,
                                    pos = Position,
                                    color = v9
                                };
                            end;
                        end;
                    elseif Attribute and Magnitude <= 250 then
                        local Position = HumanoidRootPart.Position;
                        local v10 = Color3_fromRGB_ret4;

                        if Position then
                            u2[#u2 + 1] = {
                                transparency = 0.55,
                                pos = Position,
                                color = v10
                            };
                        end;
                    end;
                end;
            end;
        end;
    end;

    return u2;
end;

RunService.Heartbeat:Connect(function() -- Line: 120
    -- upvalues: TaskTargetResolver (copy), getAlwaysOnTargets (copy), Workspace (copy), u1 (copy)
    local TrackedTask = TaskTargetResolver.GetTrackedTask();
    local v11 = TaskTargetResolver.Resolve(TrackedTask);
    local v12 = getAlwaysOnTargets();
    local v13 = {};

    for _, v in ipairs(v11) do
        v13[#v13 + 1] = v;
    end;

    for _, v in ipairs(v12) do
        v13[#v13 + 1] = v;
    end;

    local CurrentCamera = Workspace.CurrentCamera;

    if not CurrentCamera then
        for i = 1, 32 do
            local v14;

            if u1[i].Visible then
                u1[i].Visible = false;
                v14 = i;
            else
                v14 = i;
            end;
        end;

        return;
    end;

    local Position = CurrentCamera.CFrame.Position;

    for i = 1, 32 do
        local v15 = v13[i];
        local v16 = u1[i];
        local v17;

        if v15 then
            local v18 = v15.pos - Position;
            local Vector3_new_ret = Vector3.new(v18.X, 0, v18.Z);

            if Vector3_new_ret.Magnitude < 0.01 then
                if v16.Visible then
                    v16.Visible = false;
                    v17 = i;
                else
                    v17 = i;
                end;
            else
                local v19 = CurrentCamera.CFrame:VectorToObjectSpace(Vector3_new_ret.Unit);
                local v20 = math.atan2(v19.X, -v19.Z) * 238.09579486547543;
                v16.Position = UDim2.new(0.5, v20 > 237 and 237 or (v20 < -237 and -237 or v20), 0, 0);

                if v16.TextColor3 ~= v15.color then
                    v16.TextColor3 = v15.color;
                end;

                local v21 = v15.transparency or 0;

                if v16.TextTransparency ~= v21 then
                    v16.TextTransparency = v21;
                end;

                local Stroke = v16:FindFirstChild("Stroke");

                if Stroke then
                    local math_min_ret = math.min(1, 0.25 + v21 * 0.5);

                    if Stroke.Transparency ~= math_min_ret then
                        Stroke.Transparency = math_min_ret;
                    end;
                end;

                if v16.Visible then
                    v17 = i;
                else
                    v16.Visible = true;
                    v17 = i;
                end;
            end;
        elseif v16.Visible then
            v16.Visible = false;
            v17 = i;
        else
            v17 = i;
        end;
    end;
end);