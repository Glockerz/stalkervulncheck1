-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local SquadController = require(ReplicatedStorage:WaitForChild("SquadController"));
local Color3_fromRGB_ret = Color3.fromRGB(140, 220, 120);
local Color3_fromRGB_ret2 = Color3.fromRGB(160, 160, 160);
local Color3_fromRGB_ret3 = Color3.fromRGB(140, 220, 120);
local Color3_fromRGB_ret4 = Color3.fromRGB(235, 200, 90);
local Color3_fromRGB_ret5 = Color3.fromRGB(225, 95, 95);
local Color3_fromRGB_ret6 = Color3.fromRGB(150, 150, 150);

local function toHex(p1) -- Line: 22
    return string.format("#%02X%02X%02X", math.floor(p1.R * 255 + 0.5), math.floor(p1.G * 255 + 0.5), (math.floor(p1.B * 255 + 0.5)));
end;

local function statusFor(p2) -- Line: 29
    -- upvalues: Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret4 (copy)
    if not p2 then
        return "Healthy", Color3_fromRGB_ret3;
    end;

    if p2.Health <= 0 then
        return "Dead", Color3_fromRGB_ret6;
    end;

    local MaxHealth = p2.MaxHealth;
    local v3 = MaxHealth and (MaxHealth > 0 and p2.Health / MaxHealth) or 1;

    if v3 <= 0.25 then
        return "Critical", Color3_fromRGB_ret5;
    end;

    if v3 <= 0.6 then
        return "Injured", Color3_fromRGB_ret4;
    end;

    return "Healthy", Color3_fromRGB_ret3;
end;

local u4 = {
    _squadIds = {},
    _initialized = false
};

local function ensureIndicator(u5) -- Line: 43
    -- upvalues: Players (copy), u4 (copy), LocalPlayer (copy), ensureIndicator (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret2 (copy), RunService (copy)
    if not u5 then
        return;
    end;

    local HumanoidRootPart = u5:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        task.spawn(function() -- Line: 51
            -- upvalues: u5 (copy), Players (ref), u4 (ref), LocalPlayer (ref), ensureIndicator (ref)
            if not u5:WaitForChild("HumanoidRootPart", 10) then
                return;
            end;

            local PlayerFromCharacter = Players:GetPlayerFromCharacter(u5);

            if not PlayerFromCharacter or PlayerFromCharacter.Character ~= u5 then
                return;
            end;

            if not u4._squadIds[PlayerFromCharacter.UserId] or PlayerFromCharacter == LocalPlayer then
                return;
            end;

            ensureIndicator(u5);
        end);

        return;
    end;

    local v6 = u5:FindFirstChildOfClass("Humanoid") or u5:WaitForChild("Humanoid", 2);

    if v6 then
        v6.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    end;

    if HumanoidRootPart:FindFirstChild("SquadNametag") then
        return;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u5);
    local v7 = PlayerFromCharacter and PlayerFromCharacter.DisplayName or "Squadmate";
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "SquadNametag";
    BillboardGui.Size = UDim2.fromOffset(140, 36);
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, 3.5, 0);
    BillboardGui.AlwaysOnTop = true;
    BillboardGui.LightInfluence = 0;
    BillboardGui.MaxDistance = 200;
    BillboardGui.Adornee = HumanoidRootPart;
    BillboardGui.Parent = HumanoidRootPart;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Name";
    TextLabel.Size = UDim2.fromScale(1, 0.58);
    TextLabel.Position = UDim2.fromScale(0, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Font = Enum.Font.GothamBold;
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3_fromRGB_ret;
    TextLabel.TextStrokeTransparency = 0.5;
    TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center;
    TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom;
    TextLabel.Text = v7;
    TextLabel.Parent = BillboardGui;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Name = "Status";
    TextLabel2.Size = UDim2.fromScale(1, 0.34);
    TextLabel2.Position = UDim2.fromScale(0, 0.62);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Font = Enum.Font.GothamMedium;
    TextLabel2.TextScaled = true;
    TextLabel2.RichText = true;
    TextLabel2.TextStrokeTransparency = 0.6;
    TextLabel2.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
    TextLabel2.TextColor3 = Color3.fromRGB(220, 220, 220);
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Center;
    TextLabel2.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel2.Text = "";
    TextLabel2.Parent = BillboardGui;
    task.spawn(function() -- Line: 128
        -- upvalues: BillboardGui (copy), LocalPlayer (ref), HumanoidRootPart (copy), u5 (copy), Color3_fromRGB_ret3 (ref), Color3_fromRGB_ret6 (ref), Color3_fromRGB_ret5 (ref), Color3_fromRGB_ret4 (ref), TextLabel2 (copy), Color3_fromRGB_ret2 (ref), RunService (ref)
        local v8 = (1 / 0);

        while BillboardGui.Parent do
            local v9 = nil;
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            if Character and HumanoidRootPart.Parent then
                v9 = (Character.Position - HumanoidRootPart.Position).Magnitude;
            end;

            if v9 then
                local v10 = 340 / math.max(v9, 1);
                local math_clamp_ret = math.clamp(v10, 15, 38);
                BillboardGui.Size = UDim2.fromOffset(math.floor(math_clamp_ret * 4), (math.floor(math_clamp_ret)));
            end;

            if v8 >= 0.2 then
                v8 = 0;
                local v11 = u5:FindFirstChildOfClass("Humanoid");
                local v12, v13;

                if v11 then
                    if v11.Health <= 0 then
                        v12 = Color3_fromRGB_ret6;
                        v13 = "Dead";
                    else
                        local MaxHealth = v11.MaxHealth;
                        local v14 = MaxHealth and (MaxHealth > 0 and v11.Health / MaxHealth) or 1;

                        if v14 <= 0.25 then
                            v12 = Color3_fromRGB_ret5;
                            v13 = "Critical";
                        elseif v14 <= 0.6 then
                            v12 = Color3_fromRGB_ret4;
                            v13 = "Injured";
                        else
                            v12 = Color3_fromRGB_ret3;
                            v13 = "Healthy";
                        end;
                    end;
                else
                    v12 = Color3_fromRGB_ret3;
                    v13 = "Healthy";
                end;

                local v15 = v9 and string.format("%dm", (math.floor(v9 + 0.5))) or "";

                if v15 == "" then
                    TextLabel2.Text = string.format("<font color=\"%s\">%s</font>", string.format("#%02X%02X%02X", math.floor(v12.R * 255 + 0.5), math.floor(v12.G * 255 + 0.5), (math.floor(v12.B * 255 + 0.5))), v13);
                else
                    local v16 = Color3_fromRGB_ret2;
                    TextLabel2.Text = string.format("<font color=\"%s\">%s</font>  <font color=\"%s\">%s</font>", string.format("#%02X%02X%02X", math.floor(v12.R * 255 + 0.5), math.floor(v12.G * 255 + 0.5), (math.floor(v12.B * 255 + 0.5))), v13, string.format("#%02X%02X%02X", math.floor(v16.R * 255 + 0.5), math.floor(v16.G * 255 + 0.5), (math.floor(v16.B * 255 + 0.5))), v15);
                end;
            end;

            v8 = v8 + RunService.Heartbeat:Wait();
        end;
    end);
end;

local function removeIndicator(p17) -- Line: 161
    if not p17 then
        return;
    end;

    local v18 = p17:FindFirstChildOfClass("Humanoid");

    if v18 then
        v18.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer;
    end;

    local function removeFrom(p19) -- Line: 171
        if not p19 then
            return;
        end;

        local SquadNametag = p19:FindFirstChild("SquadNametag");

        if SquadNametag then
            SquadNametag:Destroy();
        end;
    end;

    local HumanoidRootPart = p17:FindFirstChild("HumanoidRootPart");
    local v20 = HumanoidRootPart and HumanoidRootPart:FindFirstChild("SquadNametag");

    if v20 then
        v20:Destroy();
    end;

    local Head = p17:FindFirstChild("Head");
    local v21 = Head and Head:FindFirstChild("SquadNametag");

    if v21 then
        v21:Destroy();
    end;

    local PrimaryPart = p17.PrimaryPart;

    if not PrimaryPart then
        return;
    end;

    local SquadNametag = PrimaryPart:FindFirstChild("SquadNametag");

    if SquadNametag then
        SquadNametag:Destroy();
    end;
end;

local function refreshPlayer(p22) -- Line: 181
    -- upvalues: u4 (copy), LocalPlayer (copy), ensureIndicator (copy), removeIndicator (copy)
    if not p22.Character then
        return;
    end;

    if u4._squadIds[p22.UserId] and p22 ~= LocalPlayer then
        ensureIndicator(p22.Character);

        return;
    end;

    removeIndicator(p22.Character);
end;

local function refreshAll() -- Line: 190
    -- upvalues: Players (copy), u4 (copy), LocalPlayer (copy), ensureIndicator (copy), removeIndicator (copy)
    for _, v in ipairs(Players:GetPlayers()) do
        if v.Character then
            if u4._squadIds[v.UserId] and v ~= LocalPlayer then
                ensureIndicator(v.Character);
            else
                removeIndicator(v.Character);
            end;
        end;
    end;
end;

function u4.Init(u23) -- Line: 196
    -- upvalues: SquadController (copy), LocalPlayer (copy), Players (copy), u4 (copy), ensureIndicator (copy), removeIndicator (copy)
    if u23._initialized then
        return;
    end;

    u23._initialized = true;
    SquadController:OnChanged(function(p24) -- Line: 200
        -- upvalues: u23 (copy), LocalPlayer (ref), Players (ref), u4 (ref), ensureIndicator (ref), removeIndicator (ref)
        u23._squadIds = {};

        if p24 then
            for i in pairs(p24.members) do
                local v25 = tonumber(i);

                if v25 and v25 ~= LocalPlayer.UserId then
                    u23._squadIds[v25] = true;
                end;
            end;
        end;

        for _, v in ipairs(Players:GetPlayers()) do
            if v.Character then
                if u4._squadIds[v.UserId] and v ~= LocalPlayer then
                    ensureIndicator(v.Character);
                else
                    removeIndicator(v.Character);
                end;
            end;
        end;
    end);
    Players.PlayerAdded:Connect(function(u26) -- Line: 214
        -- upvalues: u4 (ref), LocalPlayer (ref), ensureIndicator (ref), removeIndicator (ref)
        u26.CharacterAdded:Connect(function() -- Line: 215
            -- upvalues: u26 (copy), u4 (ref), LocalPlayer (ref), ensureIndicator (ref), removeIndicator (ref)
            local v27 = u26;

            if not v27.Character then
                return;
            end;

            if u4._squadIds[v27.UserId] and v27 ~= LocalPlayer then
                ensureIndicator(v27.Character);

                return;
            end;

            removeIndicator(v27.Character);
        end);
    end);

    for _, v in ipairs(Players:GetPlayers()) do
        v.CharacterAdded:Connect(function() -- Line: 218
            -- upvalues: v (copy), u4 (ref), LocalPlayer (ref), ensureIndicator (ref), removeIndicator (ref)
            local v28 = v;

            if not v28.Character then
                return;
            end;

            if u4._squadIds[v28.UserId] and v28 ~= LocalPlayer then
                ensureIndicator(v28.Character);

                return;
            end;

            removeIndicator(v28.Character);
        end);

        if v.Character then
            if v.Character then
                if u4._squadIds[v.UserId] and v ~= LocalPlayer then
                    ensureIndicator(v.Character);
                else
                    removeIndicator(v.Character);
                end;
            end;
        end;
    end;
end;

return u4;