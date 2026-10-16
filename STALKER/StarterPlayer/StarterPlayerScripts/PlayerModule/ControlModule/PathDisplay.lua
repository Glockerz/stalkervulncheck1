-- Decompiled with Potassium's decompiler.

local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local UserFlag = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserRaycastUpdateAPI2");
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
local u1 = {
    spacing = 8,
    image = "rbxasset://textures/Cursors/Gamepad/Pointer.png",
    imageSize = Vector2.new(2, 2)
};
local Model = Instance.new("Model");
Model.Name = "PathDisplayPoints";
local Part = Instance.new("Part");
Part.Anchored = true;
Part.CanCollide = false;
Part.Transparency = 1;
Part.Name = "PathDisplayAdornee";
Part.CFrame = CFrame.new(0, 0, 0);
Part.Parent = Model;
local u2 = 30;
local u3 = {};
local u4 = {};
local u5 = {};

for i = 1, u2 do
    local ImageHandleAdornment = Instance.new("ImageHandleAdornment");
    ImageHandleAdornment.Archivable = false;
    ImageHandleAdornment.Adornee = Part;
    ImageHandleAdornment.Image = u1.image;
    ImageHandleAdornment.Size = u1.imageSize;
    u3[i] = ImageHandleAdornment;
    local _ = i;
end;

local function retrieveFromPool() -- Line: 41
    -- upvalues: u3 (copy), u2 (ref)
    local v6 = u3[1];

    if not v6 then
        return nil;
    end;

    u3[1] = u3[u2];
    u3[u2] = nil;
    u2 = u2 - 1;

    return v6;
end;

local function returnToPool(p7: userdata) -- Line: 52
    -- upvalues: u2 (ref), u3 (copy)
    u2 = u2 + 1;
    u3[u2] = p7;
end;

local function renderPoint(p8: vector, p9: any) -- Line: 57
    -- upvalues: u2 (ref), u3 (copy), UserFlag (copy), RaycastParams_new_ret (copy), Model (copy)
    if u2 == 0 then
        return nil;
    end;

    local v10 = u3[1];

    if v10 then
        u3[1] = u3[u2];
        u3[u2] = nil;
        u2 = u2 - 1;
    else
        v10 = nil;
    end;

    if UserFlag then
        RaycastParams_new_ret.FilterDescendantsInstances = { game.Players.LocalPlayer.Character, workspace.CurrentCamera };
        local v11 = workspace:Raycast(p8 + Vector3.new(0, 2, 0), Vector3.new(0, -8, 0), RaycastParams_new_ret);

        if not v11 then
            return nil;
        end;

        v10.CFrame = CFrame.lookAlong(v11.Position, v11.Normal);
        v10.Parent = Model;

        return v10;
    end;

    local Ray_new_ret = Ray.new(p8 + Vector3.new(0, 2, 0), Vector3.new(0, -8, 0));
    local v12, v13, v14 = workspace:FindPartOnRayWithIgnoreList(Ray_new_ret, { game.Players.LocalPlayer.Character, workspace.CurrentCamera });

    if not v12 then
        return nil;
    end;

    v10.CFrame = CFrame.new(v13, v13 + v14);
    v10.Parent = Model;

    return v10;
end;

function u1.setCurrentPoints(p15) -- Line: 89
    -- upvalues: u4 (ref)
    if typeof(p15) == "table" then
        u4 = p15;

        return;
    end;

    u4 = {};
end;

function u1.clearRenderedPath() -- Line: 97
    -- upvalues: u5 (ref), u2 (ref), u3 (copy), Model (copy)
    for _, v in ipairs(u5) do
        v.Parent = nil;
        u2 = u2 + 1;
        u3[u2] = v;
    end;

    u5 = {};
    Model.Parent = nil;
end;

function u1.renderPath() -- Line: 106
    -- upvalues: u1 (copy), u4 (ref), u5 (ref), renderPoint (copy), Model (copy)
    u1.clearRenderedPath();

    if not u4 or #u4 == 0 then
        return;
    end;

    local v16 = #u4;
    u5[1] = renderPoint(u4[v16], true);

    if not u5[1] then
        return;
    end;

    local v17 = 0;

    while true do
        local v18 = u4[v16];

        if v16 < 2 then
            break;
        end;

        local v19 = u4[v16 - 1] - v18;
        local magnitude = v19.magnitude;

        if magnitude < v17 then
            v17 = v17 - magnitude;
            v16 = v16 - 1;
        else
            local v20 = renderPoint(v18 + v19.unit * v17, false);

            if v20 then
                u5[#u5 + 1] = v20;
            end;

            v17 = v17 + u1.spacing;
        end;
    end;

    Model.Parent = workspace.CurrentCamera;
end;

return u1;