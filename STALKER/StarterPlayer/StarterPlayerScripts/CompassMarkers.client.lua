-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Workspace = game:GetService("Workspace");
local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"));
local SquadController = require(ReplicatedStorage:WaitForChild("SquadController"));
local TaskTargetResolver = require(ReplicatedStorage:WaitForChild("TaskTargetResolver"));
local SquadMapResolver = require(ReplicatedStorage:WaitForChild("SquadMapResolver"));
local PdaMapData = require(ReplicatedStorage:WaitForChild("PdaMapData"));
local DeathMarkerResolver = require(ReplicatedStorage:WaitForChild("DeathMarkerResolver"));
local SquadMarkerResolver = require(ReplicatedStorage:WaitForChild("SquadMarkerResolver"));
TaskController:Init();
SquadController:Init();
local LocalPlayer = Players.LocalPlayer;
local Color3_fromRGB_ret = Color3.fromRGB(220, 50, 50);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 205, 60);
local Color3_fromRGB_ret3 = Color3.fromRGB(255, 150, 50);
local Color3_fromRGB_ret4 = Color3.fromRGB(220, 50, 50);
local u1 = nil;
local u2 = {};
local u3 = {};
local u4 = {};

local function makeTriangle(p5, p6) -- Line: 66
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p5;
    TextLabel.Size = UDim2.fromOffset(22, 18);
    TextLabel.AnchorPoint = Vector2.new(0.5, 1);
    TextLabel.Position = UDim2.new(0.5, 0, 0, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "▼";
    TextLabel.TextColor3 = p6;
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

    return TextLabel;
end;

local function attach() -- Line: 90
    -- upvalues: LocalPlayer (copy), u2 (ref), u3 (ref), u4 (ref), makeTriangle (copy), Color3_fromRGB_ret (copy), DeathMarkerResolver (copy), SquadMarkerResolver (copy), u1 (ref)
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");

    if PlayerGui then
        PlayerGui = PlayerGui:FindFirstChild("CompassAndTime");
    end;

    if PlayerGui then
        PlayerGui = PlayerGui:FindFirstChild("MainFrame");
    end;

    if PlayerGui then
        PlayerGui = PlayerGui:FindFirstChild("CompassFrame");
    end;

    if not PlayerGui then
        return false;
    end;

    local QuestMarkers = PlayerGui:FindFirstChild("QuestMarkers");

    if QuestMarkers then
        QuestMarkers:Destroy();
    end;

    for _, child in ipairs(PlayerGui:GetChildren()) do
        if child.Name:match("^QuestMarker%d+$") then
            child:Destroy();
        end;
    end;

    u2 = {};
    u3 = {};
    u4 = {};

    for i = 1, 32 do
        local v7 = makeTriangle("CompassMarker" .. i, Color3_fromRGB_ret);
        v7.Parent = PlayerGui;
        u2[i] = v7;
        local _ = i;
    end;

    for i = 1, 8 do
        local v8 = makeTriangle("DeathMarker" .. i, DeathMarkerResolver.COLOR);
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "Info";
        TextLabel.AnchorPoint = Vector2.new(0.5, 1);
        TextLabel.Position = UDim2.new(0.5, 0, 0, -1);
        TextLabel.Size = UDim2.fromOffset(90, 14);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.TextSize = 12;
        TextLabel.Font = Enum.Font.GothamBold;
        TextLabel.TextColor3 = DeathMarkerResolver.COLOR;
        TextLabel.TextStrokeTransparency = 0.25;
        TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
        TextLabel.ZIndex = 10;
        TextLabel.Parent = v8;
        v8.Parent = PlayerGui;
        u3[i] = v8;
        local _ = i;
    end;

    for i = 1, 4 do
        local v9 = makeTriangle("SquadMark" .. i, SquadMarkerResolver.COLORS[1]);
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "Info";
        TextLabel.AnchorPoint = Vector2.new(0.5, 1);
        TextLabel.Position = UDim2.new(0.5, 0, 0, -1);
        TextLabel.Size = UDim2.fromOffset(60, 14);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.TextSize = 12;
        TextLabel.Font = Enum.Font.GothamBold;
        TextLabel.TextStrokeTransparency = 0.25;
        TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
        TextLabel.ZIndex = 10;
        TextLabel.Parent = v9;
        v9.Parent = PlayerGui;
        u4[i] = v9;
        local _ = i;
    end;

    u1 = PlayerGui;

    return true;
end;

local function getAlwaysOnTargets() -- Line: 149
    -- upvalues: Workspace (copy), SquadMapResolver (copy), LocalPlayer (copy), PdaMapData (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret4 (copy)
    local u10 = {};

    local function add(p11, p12, p13) -- Line: 151
        -- upvalues: u10 (copy)
        if p11 then
            u10[#u10 + 1] = {
                pos = p11,
                color = p12,
                transparency = p13 or 0
            };
        end;
    end;

    local v14 = Workspace.CurrentCamera and Workspace.CurrentCamera.CFrame.Position or Vector3.new();

    for _, v in ipairs(SquadMapResolver.Resolve()) do
        local pos = v.pos;
        local COLOR_SQUAD = SquadMapResolver.COLOR_SQUAD;

        if pos then
            u10[#u10 + 1] = {
                transparency = 0,
                pos = pos,
                color = COLOR_SQUAD
            };
        end;
    end;

    if LocalPlayer:GetAttribute("_TutorialPending") then
        local Region = PdaMapData.GetRegion(LocalPlayer:GetAttribute("Zone") or "Cordon");

        if Region and Region.Traders then
            for _, v in ipairs(Region.Traders) do
                if v.Id == "Crow" then
                    local WorldPos = v.WorldPos;
                    local v15 = Color3_fromRGB_ret2;

                    if WorldPos then
                        u10[#u10 + 1] = {
                            transparency = 0,
                            pos = WorldPos,
                            color = v15
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
                local v16 = child:FindFirstChildOfClass("Humanoid");
                local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");

                if v16 and (v16.Health > 0 and HumanoidRootPart) then
                    local Magnitude = (HumanoidRootPart.Position - v14).Magnitude;
                    local Attribute = child:GetAttribute("Faction");
                    local Attribute2 = child:GetAttribute("PassiveToPlayers");

                    if Attribute2 == nil then
                        Attribute2 = Attribute == "Loner";
                    end;

                    if Attribute2 then
                        if Magnitude <= 250 then
                            local Position = HumanoidRootPart.Position;
                            local v17 = Color3_fromRGB_ret3;

                            if Position then
                                u10[#u10 + 1] = {
                                    transparency = 0,
                                    pos = Position,
                                    color = v17
                                };
                            end;
                        end;
                    elseif Attribute and Magnitude <= 250 then
                        local Position = HumanoidRootPart.Position;
                        local v18 = Color3_fromRGB_ret4;

                        if Position then
                            u10[#u10 + 1] = {
                                transparency = 0.55,
                                pos = Position,
                                color = v18
                            };
                        end;
                    end;
                end;
            end;
        end;
    end;

    return u10;
end;

local function bearingPx(p19, p20) -- Line: 215
    local v21 = p20 - p19.CFrame.Position;
    local Vector3_new_ret = Vector3.new(v21.X, 0, v21.Z);

    if Vector3_new_ret.Magnitude < 0.01 then
        return nil;
    end;

    local v22 = p19.CFrame:VectorToObjectSpace(Vector3_new_ret.Unit);
    local v23 = math.atan2(v22.X, -v22.Z) * 238.09579486547543;

    return math.clamp(v23, -237, 237);
end;

RunService.Heartbeat:Connect(function() -- Line: 225
    -- upvalues: u1 (ref), attach (copy), TaskTargetResolver (copy), getAlwaysOnTargets (copy), Workspace (copy), u2 (ref), u3 (ref), u4 (ref), LocalPlayer (copy), DeathMarkerResolver (copy), SquadMarkerResolver (copy)
    if not (u1 and u1.Parent or attach()) then
        return;
    end;

    local TrackedTask = TaskTargetResolver.GetTrackedTask();
    local v24 = TaskTargetResolver.Resolve(TrackedTask);
    local v25 = getAlwaysOnTargets();
    local v26 = {};

    for _, v in ipairs(v24) do
        v26[#v26 + 1] = v;
    end;

    for _, v in ipairs(v25) do
        v26[#v26 + 1] = v;
    end;

    local CurrentCamera = Workspace.CurrentCamera;

    if not CurrentCamera then
        for i = 1, 32 do
            local v27;

            if u2[i].Visible then
                u2[i].Visible = false;
                v27 = i;
            else
                v27 = i;
            end;
        end;

        for i = 1, 8 do
            local v28;

            if u3[i].Visible then
                u3[i].Visible = false;
                v28 = i;
            else
                v28 = i;
            end;
        end;

        if u4[1].Visible then
            u4[1].Visible = false;
        end;

        if u4[2].Visible then
            u4[2].Visible = false;
        end;

        if u4[3].Visible then
            u4[3].Visible = false;
        end;

        if u4[4].Visible then
            u4[4].Visible = false;
        end;

        return;
    end;

    for i = 1, 32 do
        local v29 = v26[i];
        local v30 = u2[i];
        local v31;

        if v29 then
            local v32 = v29.pos - CurrentCamera.CFrame.Position;
            local Vector3_new_ret = Vector3.new(v32.X, 0, v32.Z);

            if Vector3_new_ret.Magnitude < 0.01 then
                v31 = nil;
            else
                local v33 = CurrentCamera.CFrame:VectorToObjectSpace(Vector3_new_ret.Unit);
                local v34 = math.atan2(v33.X, -v33.Z) * 238.09579486547543;
                v31 = math.clamp(v34, -237, 237);
            end;
        else
            v31 = v29;
        end;

        local v35;

        if v31 then
            v30.Position = UDim2.new(0.5, v31, 0, 0);

            if v30.TextColor3 ~= v29.color then
                v30.TextColor3 = v29.color;
            end;

            local v36 = v29.transparency or 0;

            if v30.TextTransparency ~= v36 then
                v30.TextTransparency = v36;
            end;

            local Stroke = v30:FindFirstChild("Stroke");

            if Stroke then
                local math_min_ret = math.min(1, 0.25 + v36 * 0.5);

                if Stroke.Transparency ~= math_min_ret then
                    Stroke.Transparency = math_min_ret;
                end;
            end;

            if v30.Visible then
                v35 = i;
            else
                v30.Visible = true;
                v35 = i;
            end;
        elseif v30.Visible then
            v30.Visible = false;
            v35 = i;
        else
            v35 = i;
        end;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    local v37 = Character and Character.Position or CurrentCamera.CFrame.Position;
    local v38 = DeathMarkerResolver.Resolve();
    local v39 = {};

    for i = 1, 8 do
        local v40 = v38[i];
        local v41 = u3[i];
        local v42;

        if v40 then
            local v43 = v40.pos - CurrentCamera.CFrame.Position;
            local Vector3_new_ret = Vector3.new(v43.X, 0, v43.Z);

            if Vector3_new_ret.Magnitude < 0.01 then
                v42 = nil;
            else
                local v44 = CurrentCamera.CFrame:VectorToObjectSpace(Vector3_new_ret.Unit);
                local v45 = math.atan2(v44.X, -v44.Z) * 238.09579486547543;
                v42 = math.clamp(v45, -237, 237);
            end;
        else
            v42 = v40;
        end;

        local v46;

        if v42 then
            v41.Position = UDim2.new(0.5, v42, 0, 0);
            local Info = v41:FindFirstChild("Info");

            if Info then
                v46 = i;
                local v47 = 0;

                for _, v in ipairs(v39) do
                    if math.abs(v - v42) < 90 then
                        v47 = v47 + 1;
                    end;
                end;

                table.insert(v39, v42);
                Info.Position = UDim2.new(0.5, 0, 0, -1 - v47 * 14);
                Info.Text = string.format("%s  %dm", DeathMarkerResolver.FormatTime(v40.secondsLeft), (math.floor((v40.pos - v37).Magnitude + 0.5)));
                local v48 = v40.secondsLeft <= DeathMarkerResolver.URGENT_SECONDS and DeathMarkerResolver.COLOR_URGENT or DeathMarkerResolver.COLOR;

                if Info.TextColor3 ~= v48 then
                    Info.TextColor3 = v48;
                end;
            else
                v46 = i;
            end;

            if not v41.Visible then
                v41.Visible = true;
            end;
        elseif v41.Visible then
            v41.Visible = false;
            v46 = i;
        else
            v46 = i;
        end;
    end;

    local v49 = SquadMarkerResolver.Resolve();

    for i = 1, 4 do
        local v50 = v49[i];
        local v51 = u4[i];
        local v52;

        if v50 then
            local v53 = v50.pos - CurrentCamera.CFrame.Position;
            local Vector3_new_ret = Vector3.new(v53.X, 0, v53.Z);

            if Vector3_new_ret.Magnitude < 0.01 then
                v52 = nil;
            else
                local v54 = CurrentCamera.CFrame:VectorToObjectSpace(Vector3_new_ret.Unit);
                local v55 = math.atan2(v54.X, -v54.Z) * 238.09579486547543;
                v52 = math.clamp(v55, -237, 237);
            end;
        else
            v52 = v50;
        end;

        local v56;

        if v52 then
            v51.Position = UDim2.new(0.5, v52, 0, 0);

            if v51.TextColor3 ~= v50.color then
                v51.TextColor3 = v50.color;
            end;

            local v57 = 1 + 0.8 * v50.pulse;
            v51.Size = UDim2.fromOffset(math.floor(22 * v57 + 0.5), (math.floor(18 * v57 + 0.5)));
            local Info = v51:FindFirstChild("Info");

            if Info then
                v56 = i;
                local v58 = 0;

                for _, v in ipairs(v39) do
                    if math.abs(v - v52) < 90 then
                        v58 = v58 + 1;
                    end;
                end;

                table.insert(v39, v52);
                Info.Position = UDim2.new(0.5, 0, 0, -1 - v58 * 14);
                Info.Text = string.format("%dm", (math.floor((v50.pos - v37).Magnitude + 0.5)));

                if Info.TextColor3 ~= v50.color then
                    Info.TextColor3 = v50.color;
                end;
            else
                v56 = i;
            end;

            if not v51.Visible then
                v51.Visible = true;
            end;
        elseif v51.Visible then
            v51.Visible = false;
            v56 = i;
        else
            v56 = i;
        end;
    end;
end);