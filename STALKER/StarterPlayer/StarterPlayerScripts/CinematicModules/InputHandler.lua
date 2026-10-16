-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CinematicCameraConfig = require(ReplicatedStorage:WaitForChild("CinematicCameraConfig"));
local v1 = {};
local Vector2_new_ret = Vector2.new();
local u2 = 0;
local u3 = false;
local u4 = false;
local u5 = false;
local u6 = false;
local u7 = CinematicCameraConfig.Mouse and (CinematicCameraConfig.Mouse.Sensitivity or 0.0025) or 0.0025;
local u8 = { "off", "16:9", "2.35:1", "2.39:1" };
local u9 = { "Raw", "Smoothed", "Handheld" };

local function cycle(p10, p11) -- Line: 41
    for i, v in ipairs(p10) do
        if v == p11 then
            return p10[i % #p10 + 1];
        end;
    end;

    return p10[1];
end;

local u12 = nil;
local u13 = nil;
local u14 = {};

function v1.Enter(p15, u16) -- Line: 52
    -- upvalues: u12 (ref), UserInputService (copy), u13 (ref), Vector2_new_ret (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u14 (ref), u7 (copy), CinematicCameraConfig (copy), u9 (copy), u8 (copy)
    u12 = UserInputService.MouseBehavior;
    u13 = UserInputService.MouseIconEnabled;
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter;
    UserInputService.MouseIconEnabled = false;
    Vector2_new_ret = Vector2.new();
    u2 = 0;
    u3 = false;
    u4 = false;
    u5 = false;
    u6 = false;
    table.insert(u14, UserInputService.InputChanged:Connect(function(p17) -- Line: 64
        -- upvalues: u16 (copy), u7 (ref), Vector2_new_ret (ref), u2 (ref)
        if p17.UserInputType ~= Enum.UserInputType.MouseMovement then
            if p17.UserInputType == Enum.UserInputType.MouseWheel then
                u2 = u2 + (p17.Position.Z > 0 and 1 or -1);
            end;

            return;
        end;

        if u16.cursorFree then
            return;
        end;

        local v18 = u7 * (u16.mouseSensitivityMult or 1);
        Vector2_new_ret = Vector2_new_ret + Vector2.new(-p17.Delta.X * v18, -p17.Delta.Y * v18);
    end));
    table.insert(u14, UserInputService.InputBegan:Connect(function(p19, p20) -- Line: 77
        -- upvalues: u3 (ref), u4 (ref), UserInputService (ref), u5 (ref), CinematicCameraConfig (ref), u16 (copy), u9 (ref), u8 (ref), u6 (ref)
        if p20 then
            return;
        end;

        if p19.UserInputType == Enum.UserInputType.MouseButton1 then
            u3 = true;
            u4 = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift);

            return;
        end;

        if p19.UserInputType == Enum.UserInputType.MouseButton2 then
            u5 = true;

            return;
        end;

        if p19.KeyCode == CinematicCameraConfig.Keys.CycleMotion then
            local v21 = u9;
            local mode = u16.mode;
            local v22;

            for i, v in ipairs(v21) do
                if v == mode then
                    v22 = v21[i % #v21 + 1];
                    break;
                end;
            end;

            v22 = v21[1];
            u16.mode = v22;

            return;
        end;

        if p19.KeyCode == CinematicCameraConfig.Keys.Overlays.Grid then
            u16.overlays.thirds = not u16.overlays.thirds;

            return;
        end;

        if p19.KeyCode ~= CinematicCameraConfig.Keys.Overlays.Letterbox then
            if p19.KeyCode == CinematicCameraConfig.Keys.Overlays.Level then
                u16.overlays.level = not u16.overlays.level;

                return;
            end;

            if p19.KeyCode == CinematicCameraConfig.Keys.Overlays.Info then
                u16.overlays.info = not u16.overlays.info;

                return;
            end;

            if p19.KeyCode == CinematicCameraConfig.Keys.Overlays.FocusRect then
                u16.overlays.focusRect = not u16.overlays.focusRect;

                return;
            end;

            if p19.KeyCode == CinematicCameraConfig.Keys.Overlays.LightingPanel then
                u16.overlays.lightingPanel = not u16.overlays.lightingPanel;

                return;
            end;

            if p19.KeyCode == CinematicCameraConfig.Keys.Overlays.ControlPanel then
                u16.overlays.controlPanel = not u16.overlays.controlPanel;

                return;
            end;

            if p19.KeyCode == CinematicCameraConfig.Keys.Overlays.HoverHighlight then
                u16.overlays.hoverHighlight = not u16.overlays.hoverHighlight;

                return;
            end;

            if p19.KeyCode == CinematicCameraConfig.Keys.HideUI then
                u16.hudHidden = not u16.hudHidden;

                return;
            end;

            if p19.KeyCode == CinematicCameraConfig.Keys.CursorFree then
                u16.cursorFree = not u16.cursorFree;

                return;
            end;

            if p19.KeyCode == CinematicCameraConfig.Keys.FovDown then
                u16.fov = math.clamp(u16.fov - 5, CinematicCameraConfig.Camera.MinFOV, CinematicCameraConfig.Camera.MaxFOV);

                return;
            end;

            if p19.KeyCode == CinematicCameraConfig.Keys.FovUp then
                u16.fov = math.clamp(u16.fov + 5, CinematicCameraConfig.Camera.MinFOV, CinematicCameraConfig.Camera.MaxFOV);

                return;
            end;

            if p19.KeyCode == CinematicCameraConfig.Keys.Reset then
                u6 = true;
            end;

            return;
        end;

        local overlays = u16.overlays;
        local v23 = u8;
        local letterbox = u16.overlays.letterbox;
        local v24;

        for i, v in ipairs(v23) do
            if v == letterbox then
                v24 = v23[i % #v23 + 1];
                break;
            end;
        end;

        v24 = v23[1];
        overlays.letterbox = v24;
    end));
end;

function v1.Tick(p25, p26, p27) -- Line: 121
    -- upvalues: UserInputService (copy), Vector2_new_ret (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), CinematicCameraConfig (copy)
    if p26.cursorFree then
        if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        end;

        if UserInputService.MouseIconEnabled ~= true then
            UserInputService.MouseIconEnabled = true;
        end;
    else
        if UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter;
        end;

        if UserInputService.MouseIconEnabled ~= false then
            UserInputService.MouseIconEnabled = false;
        end;
    end;

    local actions = p26.actions;
    local v28 = 0;
    local v29 = 0;
    local v30 = 0;

    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        v30 = v30 + 1;
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        v30 = v30 - 1;
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        v28 = v28 - 1;
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        v28 = v28 + 1;
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
        v29 = v29 - 1;
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.E) then
        v29 = v29 + 1;
    end;

    actions.move = Vector3.new(v28, v29, v30);
    actions.look = Vector2_new_ret;
    Vector2_new_ret = Vector2.new();
    actions.scroll = u2;
    u2 = 0;
    actions.boost = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift);
    actions.precise = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl);
    actions.focusPickThisFrame = u3;
    u3 = false;
    actions.focusPickShiftHeld = u4;

    if actions.focusPickThisFrame == false then
        u4 = false;
    end;

    actions.breakFocusThisFrame = u5;
    u5 = false;
    actions.resetRequested = actions.resetRequested or u6;
    u6 = false;

    if actions.scroll ~= 0 then
        local FovFineModifier = CinematicCameraConfig.Keys.FovFineModifier;
        local v31;

        if FovFineModifier then
            v31 = UserInputService:IsKeyDown(FovFineModifier);

            if not v31 then
                if FovFineModifier == Enum.KeyCode.LeftAlt then
                    v31 = UserInputService:IsKeyDown(Enum.KeyCode.RightAlt);
                else
                    v31 = false;
                end;
            end;
        else
            v31 = FovFineModifier;
        end;

        if v31 then
            p26.fov = math.clamp(p26.fov + actions.scroll, CinematicCameraConfig.Camera.MinFOV, CinematicCameraConfig.Camera.MaxFOV);
            actions.scroll = 0;

            return;
        end;

        if not p26.focus.locked then
            p26.speed = math.clamp(p26.speed * (1 + actions.scroll * CinematicCameraConfig.Speed.ScrollStep), 2, 400);
        end;
    end;
end;

function v1.Exit(p32) -- Line: 190
    -- upvalues: u14 (ref), u12 (ref), UserInputService (copy), u13 (ref)
    for _, v in ipairs(u14) do
        v:Disconnect();
    end;

    u14 = {};

    if u12 then
        UserInputService.MouseBehavior = u12;
    end;

    if u13 ~= nil then
        UserInputService.MouseIconEnabled = u13;
    end;
end;

return v1;