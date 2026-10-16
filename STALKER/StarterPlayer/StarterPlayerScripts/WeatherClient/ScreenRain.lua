-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ObjectPool = require(script.Parent:WaitForChild("ObjectPool"));
local u1 = {
    Rate = 0,
    Size = 0.08,
    Fade = 1.5,
    UpdateFreq = 0.022222222222222223,
    MaxLookDown = -0.4,
    CoverRange = 120,
    Tint = Color3.fromRGB(226, 244, 255)
};
local LocalPlayer = Players.LocalPlayer;
local Random_new_ret = Random.new();
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = {};
local u6 = {};
local u7 = 0;
local u8 = false;
local u9 = false;
local u10 = 0;

local function ensureSetup() -- Line: 88
    -- upvalues: u2 (ref), u1 (copy), u3 (ref), ObjectPool (copy), u4 (ref)
    if u2 then
        return;
    end;

    u2 = Instance.new("Folder");
    u2.Name = "ScreenDroplets";
    u2.Parent = workspace.CurrentCamera;
    local Part = Instance.new("Part");
    Part.Name = "Droplet";
    Part.Material = Enum.Material.Glass;
    Part.CastShadow = false;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Anchored = true;
    Part.Transparency = 0.5;
    Part.Color = u1.Tint;
    Part.Size = Vector3.new(1, 1, 1);
    local SpecialMesh = Instance.new("SpecialMesh");
    SpecialMesh.Name = "Mesh";
    SpecialMesh.MeshType = Enum.MeshType.Sphere;
    SpecialMesh.Parent = Part;
    local new = ObjectPool.new;
    local v11 = math.max(u1.Rate, 1) * u1.Fade * 3;
    u3 = new(Part, (math.ceil(v11)));
    u4 = RaycastParams.new();
    u4.FilterType = Enum.RaycastFilterType.Exclude;
    u4.RespectCanCollide = true;
end;

local function onRender() -- Line: 127
    -- upvalues: u2 (ref), u6 (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return;
    end;

    if u2.Parent ~= workspace_CurrentCamera then
        u2.Parent = workspace_CurrentCamera;
    end;

    local CFrame2 = workspace_CurrentCamera.CFrame;
    local v12 = 0;
    local v13 = {};
    local v14 = {};

    for i, v in pairs(u6) do
        v12 = v12 + 1;
        v13[v12] = i;
        v14[v12] = CFrame2 * v;
    end;

    if v12 > 0 then
        workspace:BulkMoveTo(v13, v14, Enum.BulkMoveMode.FireCFrameChanged);
    end;
end;

local function bindIfNeeded() -- Line: 147
    -- upvalues: u8 (ref), u7 (ref), RunService (copy), onRender (copy)
    if not u8 and u7 > 0 then
        RunService:BindToRenderStep("WeatherScreenRain", Enum.RenderPriority.Camera.Value + 1, onRender);
        u8 = true;
    end;
end;

local function unbindIfIdle() -- Line: 154
    -- upvalues: u8 (ref), u7 (ref), RunService (copy)
    if u8 and u7 == 0 then
        RunService:UnbindFromRenderStep("WeatherScreenRain");
        u8 = false;
    end;
end;

local function release(p15) -- Line: 161
    -- upvalues: u5 (copy), u6 (copy), u7 (ref), u3 (ref), u8 (ref), RunService (copy)
    if u5[p15] == nil then
        return;
    end;

    u5[p15] = nil;
    u6[p15] = nil;
    u7 = u7 - 1;
    u3:Return(p15);

    if u8 and u7 == 0 then
        RunService:UnbindFromRenderStep("WeatherScreenRain");
        u8 = false;
    end;
end;

local function underCover(p16: vector) -- Line: 173
    -- upvalues: LocalPlayer (copy), u4 (ref), u1 (copy)
    local v17 = { workspace.CurrentCamera };

    if LocalPlayer.Character then
        table.insert(v17, LocalPlayer.Character);
    end;

    u4.FilterDescendantsInstances = v17;
    local CoverRange = u1.CoverRange;

    while CoverRange > 0 do
        local v18 = workspace:Raycast(p16, Vector3.new(0, 1, 0) * CoverRange, u4);

        if not v18 then
            return false;
        end;

        if v18.Instance.Transparency ~= 1 then
            return true;
        end;

        CoverRange = CoverRange - ((v18.Position - p16).Magnitude + 1);
        p16 = v18.Position + Vector3.new(0, 1, 0);
    end;

    return false;
end;

local function spawnPart(p19, p20) -- Line: 200
    -- upvalues: u3 (ref), u1 (copy), u6 (copy), u5 (copy), Random_new_ret (copy), u7 (ref), u2 (ref)
    local v21 = u3:Get();
    v21.Mesh.Scale = Vector3.new(p19, p19, p19);
    v21.Mesh.Offset = Vector3.new(0, 0, 0);
    v21.Color = u1.Tint;
    v21.Transparency = 0.7;
    u6[v21] = p20;
    u5[v21] = {
        start = os.clock(),
        scale = p19,
        stretch = Random_new_ret:NextNumber(0.5, 1) * p19,
        mesh = v21.Mesh
    };
    u7 = u7 + 1;
    v21.Parent = u2;
end;

local function createDroplet() -- Line: 223
    -- upvalues: u1 (copy), Random_new_ret (copy), spawnPart (copy), u8 (ref), u7 (ref), RunService (copy), onRender (copy)
    local Size = u1.Size;
    local v22 = Size + Random_new_ret:NextNumber(-Size / 3, Size / 3);
    local CFrame_new_ret = CFrame.new(Random_new_ret:NextNumber(-1.2, 1.2), Random_new_ret:NextNumber(-1, 1), -1);
    spawnPart(v22, CFrame_new_ret);

    for i = 1, Random_new_ret:NextInteger(1, 4) do
        local v23 = v22 / 1.5 + Random_new_ret:NextNumber(-v22 / 3, v22 / 3);
        local v24 = v23 * 0.6;
        spawnPart(v23, CFrame_new_ret * CFrame.new(Random_new_ret:NextNumber(-v24, v24), Random_new_ret:NextNumber(-v24, v24), 0));
        local _ = i;
    end;

    if not u8 and u7 > 0 then
        RunService:BindToRenderStep("WeatherScreenRain", Enum.RenderPriority.Camera.Value + 1, onRender);
        u8 = true;
    end;
end;

local function step(p25: number, p26: number) -- Line: 236
    -- upvalues: u5 (copy), u1 (copy), u6 (copy), u7 (ref), u3 (ref), u8 (ref), RunService (copy), underCover (copy), u10 (ref), createDroplet (copy)
    for i, v in pairs(u5) do
        local v27 = p25 - v.start;

        if u1.Fade <= v27 then
            if u5[i] ~= nil then
                u5[i] = nil;
                u6[i] = nil;
                u7 = u7 - 1;
                u3:Return(i);

                if u8 and u7 == 0 then
                    RunService:UnbindFromRenderStep("WeatherScreenRain");
                    u8 = false;
                end;
            end;
        else
            local v28 = v27 / u1.Fade;
            local v29 = v.scale + v.stretch * v28 * v28 * v28 * v28;
            i.Transparency = 0.7 + 0.3 * v28 * v28;
            v.mesh.Scale = Vector3.new(v.scale, v29, v.scale);
            v.mesh.Offset = Vector3.new(0, v29 / -2, 0);
        end;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if u1.Rate <= 0 or not (workspace_CurrentCamera and (workspace_CurrentCamera.CFrame.LookVector.Y > u1.MaxLookDown and not underCover(workspace_CurrentCamera.CFrame.Position))) then
        u10 = 0;

        return;
    end;

    u10 = u10 + p26 * u1.Rate;

    for i = 1, math.floor(u10) do
        createDroplet();
        local _ = i;
    end;

    u10 = u10 % 1;
end;

local function ensureUpdater() -- Line: 265
    -- upvalues: u9 (ref), u1 (copy), u7 (ref), step (copy)
    if u9 then
        return;
    end;

    u9 = true;
    task.spawn(function() -- Line: 268
        -- upvalues: u1 (ref), u7 (ref), step (ref), u9 (ref)
        local os_clock_ret = os.clock();

        while u1.Rate > 0 or u7 > 0 do
            task.wait(u1.UpdateFreq);
            local os_clock_ret2 = os.clock();
            step(os_clock_ret2, os_clock_ret2 - os_clock_ret);
            os_clock_ret = os_clock_ret2;
        end;

        u9 = false;
    end);
end;

return {
    Configure = function(p30) -- Line: 283, Name: Configure
        -- upvalues: u1 (copy)
        if type(p30) ~= "table" then
            return;
        end;

        for i, v in pairs(p30) do
            if u1[i] ~= nil and i ~= "Rate" then
                u1[i] = v;
            end;
        end;
    end,

    SetRate = function(p31: number) -- Line: 293, Name: SetRate
        -- upvalues: u1 (copy), ensureSetup (copy), u9 (ref), u7 (ref), step (copy)
        local v32 = tonumber(p31) or 0;
        u1.Rate = math.max(0, v32);

        if u1.Rate > 0 then
            ensureSetup();

            if u9 then
                return;
            end;

            u9 = true;
            task.spawn(function() -- Line: 268
                -- upvalues: u1 (ref), u7 (ref), step (ref), u9 (ref)
                local os_clock_ret = os.clock();

                while u1.Rate > 0 or u7 > 0 do
                    task.wait(u1.UpdateFreq);
                    local os_clock_ret2 = os.clock();
                    step(os_clock_ret2, os_clock_ret2 - os_clock_ret);
                    os_clock_ret = os_clock_ret2;
                end;

                u9 = false;
            end);
        end;
    end,

    Clear = function() -- Line: 302, Name: Clear
        -- upvalues: u5 (copy), u6 (copy), u7 (ref), u3 (ref), u8 (ref), RunService (copy), u10 (ref)
        for i in pairs(u5) do
            if u5[i] ~= nil then
                u5[i] = nil;
                u6[i] = nil;
                u7 = u7 - 1;
                u3:Return(i);

                if u8 and u7 == 0 then
                    RunService:UnbindFromRenderStep("WeatherScreenRain");
                    u8 = false;
                end;
            end;
        end;

        u10 = 0;
    end,

    LiveCount = function() -- Line: 310, Name: LiveCount
        -- upvalues: u7 (ref)
        return u7;
    end
};