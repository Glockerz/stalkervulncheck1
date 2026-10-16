-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local v1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local Color3_fromRGB_ret = Color3.fromRGB(255, 200, 90);

function v1.Enter(p5, p6) -- Line: 33
    -- upvalues: u3 (ref), Players (copy), u2 (ref), Color3_fromRGB_ret (copy), u4 (ref)
    u3 = Players.LocalPlayer:GetMouse();
    u2 = Instance.new("Highlight");
    u2.Name = "CinematicHoverHighlight";
    u2.FillTransparency = 1;
    u2.OutlineColor = Color3_fromRGB_ret;
    u2.OutlineTransparency = 0.4;
    u2.DepthMode = Enum.HighlightDepthMode.Occluded;
    u2.Enabled = false;
    u2.Parent = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui") or Players.LocalPlayer;
    u4 = nil;
end;

function v1.Tick(p7, p8, p9) -- Line: 50
    -- upvalues: u2 (ref), u4 (ref), u3 (ref), Players (copy)
    if not u2 then
        return;
    end;

    if p8.hudHidden or not p8.overlays.hoverHighlight then
        if u4 then
            u2.Adornee = nil;
            u2.Enabled = false;
            u4 = nil;
        end;

        return;
    end;

    local UnitRay = u3.UnitRay;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    local v10 = {};
    local Character = Players.LocalPlayer.Character;

    if Character then
        table.insert(v10, Character);
    end;

    if p8.lockTarget then
        table.insert(v10, p8.lockTarget);
    end;

    if p8.focus.target then
        table.insert(v10, p8.focus.target);
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = v10;
    local v11 = workspace:Raycast(workspace.CurrentCamera.CFrame.Position, UnitRay.Direction * 500, RaycastParams_new_ret);

    if v11 then
        v11 = v11.Instance;
    end;

    if v11 and not v11:IsA("BasePart") then
        v11 = nil;
    end;

    if v11 ~= u4 then
        u4 = v11;

        if v11 then
            u2.Adornee = v11;
            u2.Enabled = true;

            return;
        end;

        u2.Adornee = nil;
        u2.Enabled = false;
    end;
end;

function v1.Exit(p12) -- Line: 90
    -- upvalues: u2 (ref), u4 (ref)
    if u2 then
        u2:Destroy();
        u2 = nil;
    end;

    u4 = nil;
end;

return v1;