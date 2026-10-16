-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Workspace = game:GetService("Workspace");
local _ = Players.LocalPlayer;
local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"));
pcall(function() -- Line: 35
    -- upvalues: TaskController (copy)
    TaskController:Init();
end);
local Color3_fromRGB_ret = Color3.fromRGB(220, 60, 60);
local Font_new_ret = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
local u1 = {};

local function buildPlate(p2, p3) -- Line: 52
    -- upvalues: Font_new_ret (copy), Color3_fromRGB_ret (copy)
    local v4 = p2:FindFirstChild("Head") or p2:FindFirstChild("HumanoidRootPart");

    if not v4 then
        return nil;
    end;

    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "ContractTargetPlate";
    BillboardGui.Adornee = v4;
    BillboardGui.AlwaysOnTop = true;
    BillboardGui.Size = UDim2.fromOffset(220, 26);
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, 2.4, 0);
    BillboardGui.MaxDistance = 300;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.FontFace = Font_new_ret;
    TextLabel.TextSize = 16;
    TextLabel.TextColor3 = Color3_fromRGB_ret;
    TextLabel.TextStrokeTransparency = 0.4;
    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
    TextLabel.Text = p3;
    TextLabel.Parent = BillboardGui;
    BillboardGui.Parent = v4;

    return BillboardGui;
end;

local function clearPlate(p5) -- Line: 81
    -- upvalues: u1 (copy)
    local u6 = u1[p5];
    u1[p5] = nil;

    if u6 then
        pcall(function() -- Line: 84
            -- upvalues: u6 (copy)
            u6:Destroy();
        end);
    end;
end;

local function wantedTargets() -- Line: 89
    -- upvalues: TaskController (copy)
    local v7 = {};
    local success, result = pcall(function() -- Line: 91
        -- upvalues: TaskController (ref)
        return TaskController:GetActiveTasks();
    end);

    if not (success and result) then
        return v7;
    end;

    for _, v in ipairs(result) do
        if v.type == "kill_contract" and (v.state == "active" and (v.params and v.params.target_id)) then
            local v8 = v;
            local v9 = false;

            for _, v2 in ipairs(v.objectives or {}) do
                if v2.id == "kill" and v2.complete then
                    v9 = true;
                    break;
                end;
            end;

            if not v9 then
                v7[v8.params.target_id] = v8.params.target_name or "Contract Target";
            end;
        end;
    end;

    return v7;
end;

task.spawn(function() -- Line: 110
    -- upvalues: wantedTargets (copy), Workspace (copy), u1 (copy), buildPlate (copy)
    while true do
        task.wait(1);
        local v10 = wantedTargets();
        local v11 = {};
        local PlayerCharacters = Workspace:FindFirstChild("PlayerCharacters");

        if PlayerCharacters then
            PlayerCharacters = PlayerCharacters:FindFirstChild("HostileNPCs");
        end;

        if PlayerCharacters and next(v10) ~= nil then
            for _, child in ipairs(PlayerCharacters:GetChildren()) do
                if child:IsA("Model") then
                    local Attribute = child:GetAttribute("ContractTarget");

                    if Attribute then
                        Attribute = v10[Attribute];
                    end;

                    if Attribute then
                        local v12 = child:FindFirstChildOfClass("Humanoid");

                        if v12 and (v12.Health > 0 and v12.MaxHealth > 0) then
                            v11[child] = true;

                            if not u1[child] then
                                u1[child] = buildPlate(child, Attribute);
                            end;
                        end;
                    end;
                end;
            end;
        end;

        for i in pairs(u1) do
            if not v11[i] then
                local u13 = u1[i];
                u1[i] = nil;

                if u13 then
                    pcall(function() -- Line: 84
                        -- upvalues: u13 (copy)
                        u13:Destroy();
                    end);
                end;
            end;
        end;
    end;
end);