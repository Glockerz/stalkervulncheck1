-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local CK_OpticProfiles = require(script.Parent:WaitForChild("CK_OpticProfiles"));
local u1 = {};
local u2 = { "BulletStrip", "TurretDisplay", "Solution", "FireFlash" };
local u3 = { "Vignette", "ScopeShadow", "ScopeEdges", "CK_EyeBox", "ChromaticAbberation" };
local u4 = { "LeftBar", "RightBar", "TopBar", "BottomBar" };
local u5 = {};
local u6 = nil;

local function authFor(p7) -- Line: 123
    -- upvalues: u6 (ref), u5 (ref)
    if u6 ~= p7 then
        u5 = {};
        u6 = p7;
    end;
end;

local function auth(p8, p9, p10) -- Line: 132
    -- upvalues: u5 (ref)
    local v11 = u5[p8];

    if not v11 then
        v11 = {};
        u5[p8] = v11;
    end;

    if v11[p9] == nil then
        v11[p9] = p10(p8);
    end;

    return v11[p9];
end;

local function authSizeX(p12) -- Line: 139
    -- upvalues: u5 (ref)
    local function _(p13) -- Line: 139
        return p13.Size.X.Scale;
    end;

    local v14 = u5[p12];

    if not v14 then
        v14 = {};
        u5[p12] = v14;
    end;

    if v14.sx == nil then
        v14.sx = p12.Size.X.Scale;
    end;

    return v14.sx;
end;

local function authSizeY(p15) -- Line: 140
    -- upvalues: u5 (ref)
    local function _(p16) -- Line: 140
        return p16.Size.Y.Scale;
    end;

    local v17 = u5[p15];

    if not v17 then
        v17 = {};
        u5[p15] = v17;
    end;

    if v17.sy == nil then
        v17.sy = p15.Size.Y.Scale;
    end;

    return v17.sy;
end;

local u18 = CK_OpticProfiles[CK_OpticProfiles.DEFAULT] or {};

local function gui() -- Line: 148
    -- upvalues: Players (copy)
    local v19 = Players.LocalPlayer and Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");

    return v19 and v19:FindFirstChild("CK_ScopeOverlay") or nil;
end;

local function setDeepVisible(p20, p21, p22) -- Line: 153
    local v23 = p20:FindFirstChild(p21, true);

    if v23 and v23:IsA("GuiObject") then
        v23.Visible = p22;
    end;
end;

function u1.layout() -- Line: 165
    -- upvalues: Players (copy), u6 (ref), u5 (ref), u18 (ref), u3 (copy)
    local v24 = Players.LocalPlayer and Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");
    local v25 = v24 and v24:FindFirstChild("CK_ScopeOverlay") or nil;

    if not v25 then
        return;
    end;

    if u6 ~= v25 then
        u5 = {};
        u6 = v25;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.ViewportSize;
    end;

    if not (workspace_CurrentCamera and (workspace_CurrentCamera.X > 0 and workspace_CurrentCamera.Y > 0)) then
        return;
    end;

    local v26 = 1.941747572815534 / (workspace_CurrentCamera.X / workspace_CurrentCamera.Y);
    local v27 = u18.tubeScale or 1;
    local v28 = 0;

    for _, v in ipairs(u3) do
        local v29 = v25:FindFirstChild(v, true);

        if v29 and v29:IsA("GuiObject") then
            local function _(p30) -- Line: 139
                return p30.Size.X.Scale;
            end;

            local v31 = u5[v29];

            if not v31 then
                v31 = {};
                u5[v29] = v31;
            end;

            if v31.sx == nil then
                v31.sx = v29.Size.X.Scale;
            end;

            local sx = v31.sx;

            local function _(p32) -- Line: 140
                return p32.Size.Y.Scale;
            end;

            local v33 = u5[v29];

            if not v33 then
                v33 = {};
                u5[v29] = v33;
            end;

            if v33.sy == nil then
                v33.sy = v29.Size.Y.Scale;
            end;

            v29.Size = UDim2.new(sx * v26 * v27, 0, v33.sy * v27, v29.Size.Y.Offset);

            if v == "ScopeEdges" then
                v28 = sx * v26 * v27;
            end;
        end;
    end;

    local Reticle = v25:FindFirstChild("Reticle");

    if Reticle then
        local function _(p34) -- Line: 139
            return p34.Size.X.Scale;
        end;

        local v35 = u5[Reticle];

        if not v35 then
            v35 = {};
            u5[Reticle] = v35;
        end;

        if v35.sx == nil then
            v35.sx = Reticle.Size.X.Scale;
        end;

        Reticle.Size = UDim2.new(v35.sx * v26 * v27 * (u18.reticleScale or 1), 0, Reticle.Size.Y.Scale, Reticle.Size.Y.Offset);
    end;

    local math_max_ret = math.max(0, 0.5 - (v28 > 0 and v28 and v28 or 0.515 * v26) / 2 + 0.02);
    local LeftBar = v25:FindFirstChild("LeftBar");
    local RightBar = v25:FindFirstChild("RightBar");
    local TopBar = v25:FindFirstChild("TopBar");
    local BottomBar = v25:FindFirstChild("BottomBar");

    if LeftBar then
        LeftBar.AnchorPoint = Vector2.new(0, 0.5);
        LeftBar.Position = UDim2.fromScale(0, 0.5);
        LeftBar.Size = UDim2.fromScale(math_max_ret, 1);
    end;

    if RightBar then
        RightBar.AnchorPoint = Vector2.new(1, 0.5);
        RightBar.Position = UDim2.fromScale(1, 0.5);
        RightBar.Size = UDim2.fromScale(math_max_ret, 1);
    end;

    local math_max_ret2 = math.max(0, (1 - v27) / 2 + 0.02);

    if TopBar then
        TopBar.AnchorPoint = Vector2.new(0.5, 0);
        TopBar.Position = UDim2.fromScale(0.5, 0);
        local UDim2_new = UDim2.new;
        local Scale = TopBar.Size.X.Scale;
        local Offset = TopBar.Size.X.Offset;

        local function _(p36) -- Line: 140
            return p36.Size.Y.Scale;
        end;

        local v37 = u5[TopBar];

        if not v37 then
            v37 = {};
            u5[TopBar] = v37;
        end;

        if v37.sy == nil then
            v37.sy = TopBar.Size.Y.Scale;
        end;

        TopBar.Size = UDim2_new(Scale, Offset, math.max(v37.sy, math_max_ret2), 0);
    end;

    if BottomBar then
        BottomBar.AnchorPoint = Vector2.new(0.5, 1);
        BottomBar.Position = UDim2.fromScale(0.5, 1);
        local UDim2_new = UDim2.new;
        local Scale = BottomBar.Size.X.Scale;
        local Offset = BottomBar.Size.X.Offset;

        local function _(p38) -- Line: 140
            return p38.Size.Y.Scale;
        end;

        local v39 = u5[BottomBar];

        if not v39 then
            v39 = {};
            u5[BottomBar] = v39;
        end;

        if v39.sy == nil then
            v39.sy = BottomBar.Size.Y.Scale;
        end;

        BottomBar.Size = UDim2_new(Scale, Offset, math.max(v39.sy, math_max_ret2), 0);
    end;
end;

local u40 = { {
        name = "Vignette",
        key = "vignette",
        tint = true
    }, {
        name = "CK_EyeBox",
        key = "eyebox",
        tint = true
    }, {
        name = "ChromaticAbberation",
        key = "fringe",
        tint = false
    }, {
        name = "ScopeShadow",
        key = "shadow",
        tint = false
    } };

local function applyChrome(p41) -- Line: 269
    -- upvalues: u6 (ref), u5 (ref), u40 (copy), u18 (ref)
    if u6 ~= p41 then
        u5 = {};
        u6 = p41;
    end;

    for _, v in ipairs(u40) do
        local v42 = p41:FindFirstChild(v.name, true);

        if v42 and v42:IsA("ImageLabel") then
            local function _(p43) -- Line: 274
                return p43.ImageTransparency;
            end;

            local v44 = u5[v42];

            if not v44 then
                v44 = {};
                u5[v42] = v44;
            end;

            if v44.imgT == nil then
                v44.imgT = v42.ImageTransparency;
            end;

            v42.ImageTransparency = u18[v.key] or v44.imgT;

            local function _(p45) -- Line: 276
                return p45.ImageColor3;
            end;

            local v46 = u5[v42];

            if not v46 then
                v46 = {};
                u5[v42] = v46;
            end;

            if v46.color == nil then
                v46.color = v42.ImageColor3;
            end;

            local color = v46.color;

            if v.tint then
                v42.ImageColor3 = u18.tint or color;
            else
                v42.ImageColor3 = color;
            end;
        end;
    end;

    local reticleColor = u18.reticleColor;
    local Reticle = p41:FindFirstChild("Reticle");

    if Reticle and Reticle:IsA("ImageLabel") then
        local reticleTint = u18.reticleTint;

        if not reticleTint then
            local function _(p47) -- Line: 306
                return p47.ImageColor3;
            end;

            local v48 = u5[Reticle];

            if not v48 then
                v48 = {};
                u5[Reticle] = v48;
            end;

            if v48.color == nil then
                v48.color = Reticle.ImageColor3;
            end;

            reticleTint = v48.color;
        end;

        Reticle.ImageColor3 = reticleTint;
    end;

    local CenterMark = p41:FindFirstChild("CenterMark");

    if CenterMark then
        for _, child in ipairs(CenterMark:GetChildren()) do
            if child:IsA("Frame") then
                local v49;

                if reticleColor then
                    v49 = reticleColor;
                else
                    local function _(p50) -- Line: 321
                        return p50.BackgroundColor3;
                    end;

                    local v51 = u5[child];

                    if not v51 then
                        v51 = {};
                        u5[child] = v51;
                    end;

                    if v51.bg == nil then
                        v51.bg = child.BackgroundColor3;
                    end;

                    v49 = v51.bg;
                end;

                child.BackgroundColor3 = v49;
            end;
        end;
    end;
end;

local u52 = nil;

function u1.setProfile(p53) -- Line: 336
    -- upvalues: u52 (ref), u18 (ref), CK_OpticProfiles (copy), Players (copy), u3 (copy), u4 (copy), u2 (copy), applyChrome (copy), u1 (copy)
    if p53 ~= nil then
        u52 = p53;
    end;

    u18 = CK_OpticProfiles[u52] or CK_OpticProfiles[CK_OpticProfiles.DEFAULT] or {};
    local v54 = Players.LocalPlayer and Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");
    local v55 = v54 and v54:FindFirstChild("CK_ScopeOverlay") or nil;

    if not v55 then
        return;
    end;

    local v56 = u18.cleanView == true;

    for _, v in ipairs(u3) do
        local v57 = not v56;
        local v58 = v55:FindFirstChild(v, true);

        if v58 and v58:IsA("GuiObject") then
            v58.Visible = v57;
        end;
    end;

    for _, v in ipairs(u4) do
        local v59 = not v56;
        local v60 = v55:FindFirstChild(v, true);

        if v60 and v60:IsA("GuiObject") then
            v60.Visible = v59;
        end;
    end;

    for _, v in ipairs(u2) do
        local v61 = v55:FindFirstChild(v, true);

        if v61 and v61:IsA("GuiObject") then
            v61.Visible = false;
        end;
    end;

    applyChrome(v55);
    u1.layout();
    local v62 = u18.showBreath == true;
    local BreathBar = v55:FindFirstChild("BreathBar", true);

    if BreathBar and BreathBar:IsA("GuiObject") then
        BreathBar.Visible = v62;
    end;

    local v63 = v55:FindFirstChild("ZoomDot" .. 1, true);

    if v63 and v63:IsA("GuiObject") then
        v63.Visible = false;
    end;

    local v64 = v55:FindFirstChild("ZoomDot" .. 2, true);

    if v64 and v64:IsA("GuiObject") then
        v64.Visible = false;
    end;

    local v65 = v55:FindFirstChild("ZoomDot" .. 3, true);

    if v65 and v65:IsA("GuiObject") then
        v65.Visible = false;
    end;

    local v66 = v55:FindFirstChild("ZoomDot" .. 4, true);

    if v66 and v66:IsA("GuiObject") then
        v66.Visible = false;
    end;
end;

local u67 = nil;

function u1.setOptic(p68) -- Line: 361
    -- upvalues: u67 (ref)
    u67 = p68;
end;

function u1.updateReticle(p69, p70) -- Line: 372
    -- upvalues: Players (copy), u18 (ref)
    local v71 = Players.LocalPlayer and Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");
    local v72 = v71 and v71:FindFirstChild("CK_ScopeOverlay") or nil;

    if not v72 then
        return;
    end;

    local Reticle = v72:FindFirstChild("Reticle");
    local CenterMark = v72:FindFirstChild("CenterMark");
    local v73 = "center";
    local v74 = nil;
    local v75 = p69 and p69.reticles or u18.reticles;

    if v75 and v75[1] then
        v73 = v75[1].style or "center";
        v74 = v75[1].image;
    elseif u18.reticleStyle then
        v73 = u18.reticleStyle;
        v74 = u18.reticle;
    end;

    if p69 and (p69.magDecals and (p70 and (p69.magDecals[p70] and p69.magDecals[p70] ~= ""))) then
        v74 = p69.magDecals[p70];
        v73 = "image";
    end;

    if Reticle then
        local v76;

        if v73 == "image" and v74 ~= nil then
            v76 = v74 ~= "";
        else
            v76 = false;
        end;

        Reticle.Visible = v76;

        if Reticle.Visible then
            Reticle.Image = v74;
        end;
    end;

    if CenterMark then
        CenterMark.Visible = v73 ~= "image";
    end;
end;

function u1.setReticle(p77, p78) -- Line: 402
    -- upvalues: u1 (copy)
    u1.updateReticle({
        reticles = {
            {
                style = p77,
                image = p78
            }
        }
    }, nil);
end;

local u79 = 0;
local u80 = 0;
local u81 = 0;
local u82 = 0;
local u83 = nil;
local u84 = {};

local function kickElements(p85) -- Line: 465
    -- upvalues: u3 (copy)
    local v86 = {};

    for _, v in ipairs(u3) do
        local v87 = p85:FindFirstChild(v, true);

        if v87 and v87:IsA("GuiObject") then
            v86[#v86 + 1] = v87;
        end;
    end;

    local Reticle = p85:FindFirstChild("Reticle");

    if Reticle then
        v86[#v86 + 1] = Reticle;
    end;

    local CenterMark = p85:FindFirstChild("CenterMark");

    if CenterMark then
        v86[#v86 + 1] = CenterMark;
    end;

    return v86;
end;

local function captureKickBase() -- Line: 484
    -- upvalues: Players (copy), u84 (ref), kickElements (copy)
    local v88 = Players.LocalPlayer and Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");
    local v89 = v88 and v88:FindFirstChild("CK_ScopeOverlay") or nil;

    if not v89 then
        return;
    end;

    u84 = {};

    for _, v in ipairs((kickElements(v89))) do
        u84[v] = {
            x = v.Position.X.Scale,
            y = v.Position.Y.Scale
        };
    end;
end;

local function applyKick() -- Line: 505
    -- upvalues: Players (copy), u79 (ref), kickElements (copy), u84 (ref), u80 (ref)
    local v90 = Players.LocalPlayer and Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");
    local v91 = v90 and v90:FindFirstChild("CK_ScopeOverlay") or nil;

    if not v91 then
        return;
    end;

    local v92 = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize;
    local v93 = u79 / (v92 and (v92.Y > 0 and v92.X / v92.Y) or 1.78);

    for _, v in ipairs((kickElements(v91))) do
        local v94 = u84[v];

        if v94 then
            v.Position = UDim2.new(v94.x + v93, v.Position.X.Offset, v94.y - u80, v.Position.Y.Offset);
        end;
    end;
end;

function u1.addKick(p95) -- Line: 530
    -- upvalues: u82 (ref), u81 (ref), u83 (ref), u80 (ref), u79 (ref), applyKick (copy)
    local v96 = p95 or 1;
    u82 = u82 + 1.45 * v96;
    u81 = u81 + 0.29 * v96 * (math.random() < 0.5 and -1 or 1);
    u82 = math.clamp(u82, -3.6, 3.6);
    u81 = math.clamp(u81, -0.9, 0.9);

    if u83 then
        return;
    end;

    u83 = game:GetService("RunService").RenderStepped:Connect(function(p97) -- Line: 541
        -- upvalues: u80 (ref), u82 (ref), u79 (ref), u81 (ref), applyKick (ref), u83 (ref)
        local math_min_ret = math.min(p97, 0.1);

        while math_min_ret > 0 do
            local math_min_ret2 = math.min(math_min_ret, 0.008333333333333333);
            math_min_ret = math_min_ret - math_min_ret2;
            u82 = u82 + (u80 * -620 - u82 * 17) * math_min_ret2;
            u81 = u81 + (u79 * -620 - u81 * 17) * math_min_ret2;
            u80 = u80 + u82 * math_min_ret2;
            u79 = u79 + u81 * math_min_ret2;
        end;

        if math.abs(u80) >= 0.0004 or (math.abs(u82) >= 0.0004 or (math.abs(u79) >= 0.0004 or math.abs(u81) >= 0.0004)) then
            applyKick();

            return;
        end;

        u79 = 0;
        u80 = 0;
        u81 = 0;
        u82 = 0;
        applyKick();
        u83:Disconnect();
        u83 = nil;
    end);
end;

function u1.resetKick() -- Line: 575
    -- upvalues: u83 (ref), u79 (ref), u80 (ref), u81 (ref), u82 (ref), Players (copy), u84 (ref)
    if u83 then
        u83:Disconnect();
        u83 = nil;
    end;

    u79 = 0;
    u80 = 0;
    u81 = 0;
    u82 = 0;
    local v98 = Players.LocalPlayer and Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if v98 and v98:FindFirstChild("CK_ScopeOverlay") or nil then
        for i, v in pairs(u84) do
            if i.Parent then
                i.Position = UDim2.new(v.x, i.Position.X.Offset, v.y, i.Position.Y.Offset);
            end;
        end;
    end;

    u84 = {};
end;

function u1.setMag(p99) -- Line: 590
    -- upvalues: Players (copy)
    local v100 = Players.LocalPlayer and Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");
    local v101 = v100 and v100:FindFirstChild("CK_ScopeOverlay") or nil;

    if not v101 then
        return;
    end;

    local MagLabel = v101:FindFirstChild("MagLabel", true);

    if MagLabel and MagLabel:IsA("TextLabel") then
        MagLabel.Visible = true;
        MagLabel.Text = string.format("%gx", p99 or 1);
    end;
end;

function u1.setVisible(p102) -- Line: 604
    -- upvalues: Players (copy), u1 (copy), u67 (ref), captureKickBase (copy)
    local v103 = Players.LocalPlayer and Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");
    local v104 = v103 and v103:FindFirstChild("CK_ScopeOverlay") or nil;

    if not v104 then
        return;
    end;

    v104.Enabled = p102 and true or false;

    if not p102 then
        u1.resetKick();
    end;

    if p102 then
        u1.setProfile(nil);

        if u67 then
            u1.setOptic(u67);
        end;

        local FadeCover = v104:FindFirstChild("FadeCover");

        if FadeCover and FadeCover:IsA("GuiObject") then
            FadeCover.Visible = false;
        end;

        u1.layout();
        captureKickBase();
    end;
end;

local workspace_CurrentCamera = workspace.CurrentCamera;

if workspace_CurrentCamera then
    workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 635
        -- upvalues: u1 (copy)
        u1.layout();
    end);
end;

local function noop() -- Line: 645
end;

u1.setBars = noop;
u1.setEdgeSize = noop;
u1.setSolution = noop;
u1.setFade = noop;
u1.setReticleScale = noop;
u1.setReticleAlpha = noop;
u1.setFireFlash = noop;
u1.setElevation = noop;
u1.setZero = noop;
u1.setWindage = noop;
u1.setWind = noop;
u1.setBreath = noop;
u1.setTurretDisplay = noop;
u1.setAmmo = noop;
u1.setRange = noop;

return u1;