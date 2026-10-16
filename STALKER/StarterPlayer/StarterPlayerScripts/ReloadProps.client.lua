-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

local function isOurs(p1: userdata) -- Line: 73
    -- upvalues: workspace_CurrentCamera (ref)
    local v2;

    if workspace_CurrentCamera == nil then
        v2 = false;
    else
        v2 = p1:IsDescendantOf(workspace_CurrentCamera);
    end;

    return v2;
end;

local function reloading() -- Line: 77
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return false;
    end;

    local Attribute = Character:GetAttribute("_ReloadingUntil");
    local v3;

    if type(Attribute) == "number" then
        v3 = os.clock() < Attribute + 0.35;
    else
        v3 = false;
    end;

    return v3;
end;

RunService.RenderStepped:Connect(function() -- Line: 89
    -- upvalues: workspace_CurrentCamera (ref), LocalPlayer (copy), CollectionService (copy)
    workspace_CurrentCamera = workspace.CurrentCamera;
    local Character = LocalPlayer.Character;
    local v4;

    if Character then
        local Attribute = Character:GetAttribute("_ReloadingUntil");

        if type(Attribute) == "number" then
            v4 = os.clock() < Attribute + 0.35;
        else
            v4 = false;
        end;
    else
        v4 = false;
    end;

    for _, v in ipairs(CollectionService:GetTagged("ReloadProp")) do
        if v:IsA("BasePart") then
            local v5;

            if workspace_CurrentCamera == nil then
                v5 = false;
            else
                v5 = v:IsDescendantOf(workspace_CurrentCamera);
            end;

            if v5 then
                v.LocalTransparencyModifier = v4 and 0 or 1;
            end;
        end;
    end;
end);