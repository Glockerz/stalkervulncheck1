-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Color3_fromRGB_ret = Color3.fromRGB(25, 27, 24);
local v1 = {};
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"));

local function resolveModelName(p2) -- Line: 20
    -- upvalues: ItemDatabase (copy)
    if not p2 then
        return nil;
    end;

    local ItemData = ItemDatabase.GetItemData(p2);

    if ItemData then
        p2 = ItemData.Model or p2;
    end;

    return p2;
end;

local function resolveViewAngle(p3) -- Line: 28
    -- upvalues: ItemDatabase (copy)
    if not p3 then
        return "headon";
    end;

    local ItemData = ItemDatabase.GetItemData(p3);

    return ItemData and ItemData.ItemType == "Uniform" and "angled" or "headon";
end;

local u4 = {};
local u5 = {};
local u6 = nil;

local function findTemplateRig() -- Line: 46
    -- upvalues: u6 (ref), ReplicatedStorage (copy)
    if u6 and u6.Parent then
        return u6;
    end;

    local Clothing = ReplicatedStorage:FindFirstChild("Clothing");

    if not Clothing then
        return nil;
    end;

    local v7 = nil;

    for _, descendant in ipairs(Clothing:GetDescendants()) do
        if descendant:IsA("Model") and (descendant:FindFirstChildWhichIsA("Humanoid") and (descendant:FindFirstChildWhichIsA("Shirt") and descendant:FindFirstChildWhichIsA("Pants"))) then
            if descendant.Name == "Player Scale" then
                u6 = descendant;

                return descendant;
            end;

            v7 = v7 or descendant;
        end;
    end;

    u6 = v7;

    return v7;
end;

local function dressedDummy(p8) -- Line: 61
    -- upvalues: u5 (copy), ItemDatabase (copy), findTemplateRig (copy)
    if u5[p8] then
        return u5[p8];
    end;

    local v9 = ItemDatabase[p8];

    if type(v9) ~= "table" or (v9.ItemType ~= "Uniform" or not (v9.ShirtID or v9.PantsID)) then
        return nil;
    end;

    local v10 = findTemplateRig();

    if not v10 then
        return nil;
    end;

    local v11 = v10:Clone();
    v11.Name = v9.Model or p8;

    for _, child in ipairs(v11:GetChildren()) do
        if child:IsA("Accessory") or child:IsA("Model") and not child:FindFirstChildWhichIsA("Humanoid") then
            child:Destroy();
        end;
    end;

    local v12 = v11:FindFirstChildWhichIsA("Shirt");
    local v13 = v11:FindFirstChildWhichIsA("Pants");

    if v12 and v9.ShirtID then
        v12.ShirtTemplate = v9.ShirtID;
    end;

    if v13 and v9.PantsID then
        v13.PantsTemplate = v9.PantsID;
    end;

    u5[p8] = v11;

    return v11;
end;

local function findSourceModel(p14) -- Line: 85
    -- upvalues: ReplicatedStorage (copy), u4 (copy), dressedDummy (copy)
    if not p14 or p14 == "" then
        return nil;
    end;

    local ViewportFrameModels = ReplicatedStorage:FindFirstChild("ViewportFrameModels");
    local v15 = ViewportFrameModels and ViewportFrameModels:FindFirstChild(p14);

    if v15 then
        return v15;
    end;

    local Clothing = ReplicatedStorage:FindFirstChild("Clothing");

    if Clothing then
        for _, child in ipairs(Clothing:GetChildren()) do
            if child:IsA("Folder") then
                local v16 = child:FindFirstChild(p14);

                if v16 then
                    return v16;
                end;
            end;
        end;
    end;

    local v17 = u4[p14] and dressedDummy(u4[p14]);

    if v17 then
        return v17;
    end;

    local PlayerItems = ReplicatedStorage:FindFirstChild("PlayerItems");

    if PlayerItems then
        for _, child in ipairs(PlayerItems:GetChildren()) do
            if child:IsA("Folder") then
                local v18 = child:FindFirstChild(p14);

                if v18 then
                    return v18;
                end;
            end;
        end;
    end;

    return nil;
end;

local function resolveSourceModel(p19) -- Line: 119
    -- upvalues: findSourceModel (copy)
    if type(p19) == "string" then
        return findSourceModel(p19);
    end;

    if type(p19) == "table" then
        for _, v in ipairs(p19) do
            local v20 = findSourceModel(v);

            if v20 then
                return v20;
            end;
        end;
    end;

    return nil;
end;

local u21 = { Vector3.new(0, 0, 1.6), Vector3.new(-3, 0, -1.2), Vector3.new(3, 0, -1.2) };

local function createViewportForModel(p22, p23, p24, p25) -- Line: 151
    -- upvalues: Color3_fromRGB_ret (copy), u21 (copy), findSourceModel (copy), RunService (copy)
    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.Name = "ItemViewport";
    ViewportFrame.Size = UDim2.fromScale(1, 1);
    ViewportFrame.BackgroundColor3 = Color3_fromRGB_ret;
    ViewportFrame.BorderSizePixel = 0;
    ViewportFrame.LightColor = Color3.fromRGB(220, 210, 180);
    ViewportFrame.LightDirection = (Vector3.new(-0.4, -1, -0.3)).Unit;
    ViewportFrame.Ambient = Color3.fromRGB(90, 90, 95);
    ViewportFrame.Parent = p22;
    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 40;
    ViewportFrame.CurrentCamera = Camera;
    Camera.Parent = ViewportFrame;
    local u26 = Vector3.new(0, 0, 0);
    local u27 = Vector3.new(0, 0, 5);

    local function prep(p28) -- Line: 172
        -- upvalues: ViewportFrame (copy)
        local v29 = p28:Clone();

        for _, descendant in ipairs(v29:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
                descendant.CanCollide = false;
            end;
        end;

        v29.Parent = ViewportFrame;
        local v30 = nil;
        local v31 = nil;

        if v29:IsA("Model") then
            local BoundingBox, v32 = v29:GetBoundingBox();

            return v29, BoundingBox, v32;
        end;

        local v33 = v29:FindFirstChildWhichIsA("BasePart", true);

        if v33 then
            v30 = v33.CFrame;
            v31 = v33.Size;
        end;

        return v29, v30, v31;
    end;

    if not (p25 and (#p25 > 0 and p25)) then
        p25 = nil;
    end;

    local v34 = false;

    if p25 then
        local v35 = {};

        for i, v in ipairs(p25) do
            if #u21 < i then
                break;
            end;

            local v36 = findSourceModel(v);

            if v36 then
                local v37, v38, v39 = prep(v36);

                if v38 then
                    v37:PivotTo(CFrame.new(u21[i]));

                    if v39 then
                        table.insert(v35, {
                            pos = u21[i],
                            size = v39
                        });
                    end;

                    v34 = true;
                end;
            end;
        end;

        if v34 then
            local v40 = Vector3.new(inf, inf, inf);
            local v41 = Vector3.new(-inf, -inf, -inf);

            for _, v in ipairs(v35) do
                local v42 = v.size / 2;
                local math_min_ret = math.min(v40.X, v.pos.X - v42.X);
                local math_min_ret2 = math.min(v40.Y, v.pos.Y - v42.Y);
                local math_min_ret3 = math.min(v40.Z, v.pos.Z - v42.Z);
                v40 = Vector3.new(math_min_ret, math_min_ret2, math_min_ret3);
                local math_max_ret = math.max(v41.X, v.pos.X + v42.X);
                local math_max_ret2 = math.max(v41.Y, v.pos.Y + v42.Y);
                local math_max_ret3 = math.max(v41.Z, v.pos.Z + v42.Z);
                v41 = Vector3.new(math_max_ret, math_max_ret2, math_max_ret3);
            end;

            local v43 = v41 - v40;
            u26 = (v40 + v41) / 2;
            local v44 = math.max(v43.X, v43.Y, v43.Z, 1) * 1.35;
            u27 = Vector3.new(0, 0, v44);
        end;
    else
        local v45 = {};

        if type(p23) == "string" then
            table.insert(v45, p23);
        elseif type(p23) == "table" then
            for _, v in ipairs(p23) do
                table.insert(v45, v);
            end;
        end;

        for _, v in ipairs(v45) do
            local v46 = findSourceModel(v);

            if v46 then
                local _, v47, v48 = prep(v46);

                if v47 and v48 then
                    local math_max_ret = math.max(v48.X, v48.Y, v48.Z, 1);
                    u26 = v47.Position;
                    u27 = Vector3.new(0, 0, math_max_ret * 1.35);
                end;

                v34 = true;
                break;
            end;
        end;
    end;

    if not v34 then
        Camera.CFrame = CFrame.new(0, 0, 5);

        return ViewportFrame;
    end;

    local u49 = 0;
    local u50 = nil;
    u50 = RunService.Heartbeat:Connect(function(p51) -- Line: 255
        -- upvalues: ViewportFrame (copy), u50 (ref), u49 (ref), u27 (ref), Camera (copy), u26 (ref)
        if not ViewportFrame.Parent then
            u50:Disconnect();

            return;
        end;

        u49 = u49 + 0.6108652381980153 * p51;
        local v52 = CFrame.Angles(0, u49, 0) * u27;
        Camera.CFrame = CFrame.new(u26 + v52, u26);
    end);

    return ViewportFrame;
end;

function v1.Mount(p53, p54, p55) -- Line: 270
    -- upvalues: u4 (copy), ItemDatabase (copy), createViewportForModel (copy)
    if not (p53 and p54) then
        return nil;
    end;

    if p54.id == "stash" then
        return nil;
    end;

    for _, v in ipairs(p54.previewSkins or {}) do
        local v56 = p55[v];

        if type(v56) == "table" and v56.ItemType == "Uniform" then
            local v57;

            if v then
                local ItemData = ItemDatabase.GetItemData(v);

                if ItemData then
                    v57 = ItemData.Model or v;
                else
                    v57 = v;
                end;
            else
                v57 = nil;
            end;

            u4[v57] = v;
        end;
    end;

    local v58 = p54.previewSkins and p54.previewSkins[1];
    local v59 = {};

    if p54.previewPack then
        table.insert(v59, p54.previewPack);
    end;

    if v58 then
        local v60;

        if v58 then
            local ItemData = ItemDatabase.GetItemData(v58);

            if ItemData then
                v60 = ItemData.Model or v58;
            else
                v60 = v58;
            end;
        else
            v60 = nil;
        end;

        table.insert(v59, v60);
    end;

    local v61;

    if p54.tab == "Faction" and (p54.previewSkins and #p54.previewSkins > 1) then
        v61 = {};

        for _, v in ipairs(p54.previewSkins) do
            local v62;

            if v then
                local ItemData = ItemDatabase.GetItemData(v);

                if ItemData then
                    v62 = ItemData.Model or v;
                else
                    v62 = v;
                end;
            else
                v62 = nil;
            end;

            if v62 then
                table.insert(v61, v62);
            end;
        end;
    else
        v61 = nil;
    end;

    local v63;

    if v58 then
        local ItemData = ItemDatabase.GetItemData(v58);
        v63 = ItemData and ItemData.ItemType == "Uniform" and "angled" or "headon";
    else
        v63 = "headon";
    end;

    return createViewportForModel(p53, v59, v63, v61);
end;

return v1;