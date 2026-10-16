-- Decompiled with Potassium's decompiler.

local AssetService = game:GetService("AssetService");
local RunService = game:GetService("RunService");
local u1 = AssetService:CreateEditableMeshAsync(workspace:WaitForChild("SoapBubble").MeshContent);
local v2 = AssetService:CreateMeshPartAsync(Content.fromObject(u1));
v2.Parent = workspace;
v2.Size = workspace.SoapBubble.Size;
v2.Position = workspace.SoapBubble.Position + Vector3.new(25, 0, 0);
v2.Material = Enum.Material.Glass;
v2.Transparency = 0.88;
v2.Reflectance = 0.6;
v2.CanCollide = false;
v2.Anchored = true;
v2.CastShadow = false;
workspace.SoapBubble.SurfaceAppearance:Clone().Parent = v2;
local Vertices = u1:GetVertices();
local u3 = {};

for _, v in ipairs(Vertices) do
    local Position = u1:GetPosition(v);
    local Magnitude = Position.Magnitude;
    local math_atan2_ret = math.atan2(Position.Z, Position.X);
    local v4;

    if Magnitude > 0 then
        local math_clamp_ret = math.clamp(Position.Y / Magnitude, -1, 1);
        v4 = math.acos(math_clamp_ret) or 0;
    else
        v4 = 0;
    end;

    u3[v] = {
        orig = Position,
        theta = math_atan2_ret,
        phi = v4,
        nId = u1:GetVertexNormals(v)[1]
    };
end;

local function fbm(p5, p6, p7, p8) -- Line: 50
    local v9 = 1;
    local v10 = 1;
    local v11 = 0;

    for i = 1, p8 or 3 do
        v11 = v11 + math.noise(p5 * v9, p6 * v9, p7 * v9) * v10;
        v10 = v10 * 0.5;
        v9 = v9 * 2.1;
        local _ = i;
    end;

    return v11;
end;

RunService.Heartbeat:Connect(function() -- Line: 62
    -- upvalues: u3 (copy), fbm (copy), u1 (copy)
    local v12 = os.clock() * 0.5;
    local v13 = math.sin(v12 * 0.7) * 0.15 + 1;

    for i, v in pairs(u3) do
        local orig = v.orig;
        local v14 = math.noise(orig.X * 0.8, orig.Y * 0.8, v12 * 0.4) * 0.9;
        local v15 = math.noise(orig.Y * 0.8, orig.Z * 0.8, v12 * 0.4 + 3.7) * 0.9;
        local v16 = math.noise(orig.Z * 0.8, orig.X * 0.8, v12 * 0.4 + 7.3) * 0.9;
        local v17 = orig + Vector3.new(v14, v15, v16);
        local v18 = fbm(v17.X * 5.2 * 0.5 + v12 * 0.9, v17.Y * 5.2 * 0.5 + v12 * 0.9 * 0.7, v17.Z * 5.2 * 0.5, 3) * 1.1;
        local v19 = math.noise(orig.X * 3.5 + v12 * 1.2, orig.Y * 3.5 - v12 * 0.9, orig.Z * 3.5 + v12 * 0.6) * 0.35;
        local v20 = math.noise(v.phi * 1.8 + v12 * 0.5, v.theta * 1.8 - v12 * 0.3, v12 * 0.2) * 0.49500000000000005;
        local Normal = u1:GetNormal(v.nId);

        if orig.Magnitude > 0 then
            Normal = orig.Unit or Normal;
        end;

        u1:SetPosition(i, orig * v13 + Normal * (v18 + v19 + v20));
    end;
end);